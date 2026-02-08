#! /usr/bin/env python3

import json
import os
import subprocess
import sys


def run_zpool_status():
    try:
        result = subprocess.run(
            ["sudo", "zpool", "status", "-v", "--json"],
            check=True,
            capture_output=True,
            text=True,
        )
    except FileNotFoundError:
        print("zpool command not found.", file=sys.stderr)
        return None, 127
    except subprocess.CalledProcessError as exc:
        if exc.stdout:
            sys.stderr.write(exc.stdout)
        if exc.stderr:
            sys.stderr.write(exc.stderr)
        return None, exc.returncode
    return result.stdout, 0


def extract_errlist(data):
    pools = data.get("pools") or {}
    paths = set()
    pools_with_errors = set()
    for pool in pools.values():
        if errlist := pool.get("errlist") or []:
            # Parse pool
            pool_name = pool["name"]
            if pool_name in pools_with_errors:
                raise KeyError(f"Duplicate pool: {pool_name}")
            pools_with_errors.add(pool_name)

            # Parse all errors
            for error in errlist:
                if error is None:
                    continue
                corrupted_file_path = str(error)
                if not os.path.exists(corrupted_file_path):
                    print(f"Path {error} does not exist.")
                    continue
                if corrupted_file_path in paths:
                    raise KeyError(f"Duplicate path: {corrupted_file_path}")
                paths.add(corrupted_file_path)
    return sorted(paths), sorted(pools_with_errors)


def main():
    stdout, code = run_zpool_status()
    if stdout is None:
        return code

    try:
        data = json.loads(stdout)
    except json.JSONDecodeError as exc:
        print(f"Failed to parse JSON: {exc}", file=sys.stderr)
        return 1

    err_paths, pools_with_errors = extract_errlist(data)

    lines = ["#! /usr/bin/env bash\n", "# Clean up corrupted files\n"]
    for path in err_paths:
        cmd = "rm"
        if os.path.isdir(path):
            cmd += " -r"
        lines.append(f"{cmd} {path}")
    lines.append("\n# Clear pool errors\n")
    for pool in pools_with_errors:
        lines.append(f"zpool clear {pool}")
    lines.append("\n")

    script_path = "/tmp/clean-up.sh"
    with open(script_path, "w", encoding="utf-8") as handle:
        handle.write("\n".join(lines))

    print(f"Execute:\nsudo bash {script_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
