import os
import shutil
import subprocess
import tarfile
import functools
from pathlib import Path
from typing import Union, Callable

__MOUDLE_PATH = Path(os.path.dirname(os.path.abspath(__file__)))


def install_packages(packages: list[str]) -> None:
    subprocess.check_call(['sudo', 'pacman', '-Syu', '--needed', '--noconfirm'] + packages)


def install_aur_packages(packages: list[str]) -> None:
    subprocess.check_call(['pikaur', '-Syu', '--needed', '--noconfirm'] + packages)


def run_shell_command(command: Union[str, list[str]]) -> None:
    subprocess.check_call(command, shell=True, cwd=__MOUDLE_PATH)


def mkdir(path: Path) -> None:
    os.makedirs(path, exist_ok=True)


def symlink_relative(src_path: Path, dst_path: Path, hidden: bool = False) -> None:
    if dst_path.is_dir() and not dst_path.is_symlink():
        dst_path /= ('.' if hidden else '') + src_path.name
    rel_target_path = os.path.relpath(src_path, dst_path.parent)
    if dst_path.is_symlink() and dst_path.readlink() == rel_target_path:
        return
    if dst_path.exists() or dst_path.is_symlink():
        dst_path.unlink()
    dst_path.symlink_to(rel_target_path)


def symlink_dotfile(dotfile_path: Path, dst_path: Path, hidden: bool = False) -> None:
    symlink_relative(__MOUDLE_PATH / dotfile_path, dst_path, hidden)


def symlink_dotfile_with_root(dotfile_path: Path, dst_path: Path, hidden: bool = False) -> None:
    if dst_path.is_dir() and not dst_path.is_symlink():
        dst_path /= ('.' if hidden else '') + dotfile_path.name
    src_path = __MOUDLE_PATH / dotfile_path
    run_shell_command(' '.join(['sudo', 'ln', '-s', '-f', src_path.as_posix(), dst_path.as_posix()]))


def copy_dotfile(dotfile_path: Path, dst_path: Path, hidden: bool = False) -> None:
    if dst_path.is_dir():
        dst_path /= ('.' if hidden else '') + dotfile_path.name

    src_path = __MOUDLE_PATH / dotfile_path
    if dst_path.exists():
        src_stat = src_path.stat()
        dst_stat = dst_path.stat()
        if src_stat.st_mtime != dst_stat.st_mtime:
            dst_path.unlink()
    shutil.copy2(src_path, dst_path)


def extract_dotfile_tar(dotfile_tar_path: Path, dst_dir_path: Path):
    with tarfile.open(__MOUDLE_PATH / dotfile_tar_path) as tar_file:
        def is_within_directory(directory, target):
            
            abs_directory = os.path.abspath(directory)
            abs_target = os.path.abspath(target)
        
            prefix = os.path.commonprefix([abs_directory, abs_target])
            
            return prefix == abs_directory
        
        def safe_extract(tar, path=".", members=None, *, numeric_owner=False):
        
            for member in tar.getmembers():
                member_path = os.path.join(path, member.name)
                if not is_within_directory(path, member_path):
                    raise Exception("Attempted Path Traversal in Tar File")
        
            tar.extractall(path, members, numeric_owner=numeric_owner) 
            
        
        safe_extract(tar_file, dst_dir_path)


def avoid_reinstall(executable: str):
    def decorator(f: Callable) -> Callable:
        @functools.wraps(f)
        def wrapper(*args, **kwargs):
            if shutil.which(executable) is None:
                return f(*args, **kwargs)
        return wrapper
    return decorator
