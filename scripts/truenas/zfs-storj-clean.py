#! /usr/bin/env python3

import json
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
    for pool in pools.values():
        errlist = pool.get("errlist") or []
        for item in errlist:
            if item is None:
                continue
            paths.add(str(item))
    return sorted(paths)


def main():
    stdout, code = run_zpool_status()
    if stdout is None:
        return code

    try:
        data = json.loads(stdout)
    except json.JSONDecodeError as exc:
        print(f"Failed to parse JSON: {exc}", file=sys.stderr)
        return 1

    err_paths = extract_errlist(data)
    if not err_paths:
        print("No corrupted files reported.")
        return 0

    for path in err_paths:
        print(path)
    return 0


if __name__ == "__main__":
    sys.exit(main())
