#! /usr/bin/env python3

import argparse
import dataclasses
import json
import logging
import os.path
import pathlib
from typing import List, Optional, Dict, Set

from gist import client
from gist import gist as gist_lib

logger = logging.getLogger("sync-gist")


@dataclasses.dataclass
class GistFile:
    filename: str
    type: str
    language: Optional[str]
    raw_url: str
    size: int
    truncated: bool
    content: str


def gist_files(gists: dict) -> List[GistFile]:
    return [GistFile(**gist_file) for _, gist_file in gists.items()]


def merge_content(a: Set[str], b: Set[str], sort: bool) -> List[str]:
    merged = list(a.union(b))
    if "" in merged:
        merged.remove("")
    if sort:
        merged.sort()
    return merged


class PatchingGistApi(gist_lib.GistAPI):
    @gist_lib.authenticate.post
    def patch(self, request, files, gist_id):
        request.data = json.dumps({"files": files})
        self.send(request, gist_id)


class Syncer:
    def __init__(self, config: argparse.Namespace):
        if not config.auth_token:
            gist_config = client.load_config_file()
            token = client.get_personal_access_token(config=gist_config)
        else:
            token = config.auth_token

        # Copy configuration
        self.gist_id: Optional[str] = config.gist_id
        self.file_path: pathlib.Path = pathlib.Path(config.file_path)
        self.public: bool = config.public
        self.sort: bool = config.sort

        self.gist_api = PatchingGistApi(token=token)
        self.gist_file_name = self.file_base_name = self.file_path.name

    def sync(self) -> gist_lib.GistInfo:
        gists: List[gist_lib.GistInfo] = self.gist_api.list()

        def gist_matches_id(gist_to_check: gist_lib.GistInfo) -> bool:
            return gist_to_check.id == self.gist_id

        def gist_matches_filename(gist_to_check: gist_lib.GistInfo) -> bool:
            for gist_file in gist_files(self.gist_api.files(gist_to_check.id)):
                if gist_file.filename == self.file_base_name:
                    return True
            return False

        target_gist: Optional[gist_lib.GistInfo]
        if self.gist_id is not None:
            target_gist = next(filter(gist_matches_id, gists), None)
            if not target_gist:
                raise RuntimeError(f"Gist with ID {self.gist_id} not found.")
        else:
            target_gist = next(filter(gist_matches_filename, gists), None)
            if target_gist:
                self.gist_id = target_gist.id
                logger.info(f"Using Gist {self.gist_id}")
            else:
                logger.info(
                    f"No Gist found containing a file "
                    f"{self.gist_file_name}. Creating new gist."
                )
                return self.upload_file()

        remote_up_to_date = self.merge_file(remote=target_gist)
        if not remote_up_to_date:
            self.patch_file(target_gist=target_gist)

    def _read_file(self) -> str:
        with self.file_path.open("r") as file:
            content = file.read()

        if not content:
            raise RuntimeError("Can't create a gist from an empty")
        return content

    def _generate_data(self) -> Dict[str, Dict[str, str]]:
        content = self._read_file()
        return {self.gist_file_name: {"content": content}}

    def patch_file(self, target_gist: gist_lib.GistInfo):
        data = self._generate_data()
        self.gist_api.patch(data, target_gist.id)

    def upload_file(self) -> gist_lib.GistInfo:
        description = "Synced with sync-gist."
        self.file_path.touch(exist_ok=True)
        data = self._generate_data()
        url = self.gist_api.create(description, data, self.public)
        logger.info(f"Local file uploaded to {url}")
        *_, gist_id = url.split("/")
        new_gist = gist_lib.GistInfo(id=gist_id, public=self.public, desc=description)
        return new_gist

    def merge_file(self, remote: gist_lib.GistInfo) -> bool:
        remote_content = set(
            self.gist_api.content(remote.id)[self.gist_file_name].splitlines()
        )

        self.file_path.touch(exist_ok=True)
        with self.file_path.open("r") as file:
            local_content = set(file.read().splitlines())

        new_content = merge_content(remote_content, local_content, sort=self.sort)

        remote_up_to_date = local_up_to_date = False

        if set(new_content) == remote_content:
            logger.info("Remote content is up to date.")
            remote_up_to_date = True

        if set(new_content) == local_content:
            logger.info("Local content is up to date.")
            local_up_to_date = True

        if not remote_up_to_date or not local_up_to_date:
            logger.info("New content merged.")

        new_content_text = "\n".join(new_content) + "\n"
        with self.file_path.open("w") as file:
            file.write(new_content_text)

        return remote_up_to_date


if __name__ == "__main__":
    logging.basicConfig()
    logger.setLevel(logging.INFO)
    parser = argparse.ArgumentParser("sync-gist")
    parser.add_argument(
        "--auth-token",
        type=str,
        default=None,
        required=False,
        help="The GitHub authentication token that can read and write gists. Defaults to reading the "
        "config like python-gist does. See https://pypi.org/project/python-gist/.",
    )
    parser.add_argument(
        "--gist-id", type=str, default=None, required=False, help="The Gist ID."
    )
    parser.add_argument(
        "--no-sort",
        default=True,
        action="store_false",
        dest="sort",
        help="Set this to disable sorting the file content.",
    )
    parser.add_argument(
        "--public",
        default=False,
        action="store_true",
        help="Set this to create public gists.",
    )
    parser.add_argument(
        "file_path",
        help="The absolute or relative path to the file that shall be synced.",
    )
    parsed_args = parser.parse_args()

    syncer = Syncer(config=parsed_args)
    syncer.sync()
