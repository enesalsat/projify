"""main generator module for projify"""

from pathlib import Path

from .utils import Template


def __generate_static_files(prj_name: str):
    """generate static files"""

    # create a new directory for the project
    Path(prj_name).mkdir()

    # copy Template.config's contents to the new directory
    for file in Template.config.iterdir():
        with open(f"{prj_name}/{file.name}", "w", encoding="utf-8") as config:
            config.write(file.read_text())


def __generate_dockerfile(prj_name: str):
    """generate dockerfile"""

    _base_text = (Template.dockerfile / "Dockerfile.base").read_text()
    _poetry_text = (Template.dockerfile / "Dockerfile.poetry").read_text()

    # create a new dockerfile with the base and poetry text
    with open(f"{prj_name}/Dockerfile", "w", encoding="utf-8") as dockerfile:
        _text = _base_text + _poetry_text
        dockerfile.write(_text)


def __generate_makefile(prj_name: str):
    """generate makefile"""

    _base_text = (Template.makefile / "main.mak").read_text()
    _poetry_text = (Template.makefile / "poetry.mak").read_text()

    # create a new makefile with the base and poetry text
    with open(f"{prj_name}/Makefile", "w", encoding="utf-8") as makefile:
        _text = _base_text + _poetry_text
        makefile.write(_text)


def __generate_python_modules(prj_name: str):
    """creates src/`prj_name` and tests/`prj_name` directories

    Args:
        prj_name (str): project name
    """
    # TODO project-name should be snake_case

    # create src/`prj_name` directory
    Path(f"{prj_name}/src/{prj_name}").mkdir(parents=True)

    # create tests/`prj_name` directory
    Path(f"{prj_name}/tests/{prj_name}").mkdir(parents=True)

    # copy Template.python_module's contents to src/`prj_name`
    for file in Template.python_module.iterdir():
        with open(
            f"{prj_name}/src/{prj_name}/{file.name}", "w", encoding="utf-8"
        ) as python_module:
            python_module.write(file.read_text())

    # copy Template.python_module's contents to tests/`prj_name`
    for file in Template.python_module.iterdir():
        with open(
            f"{prj_name}/tests/{prj_name}/{file.name}", "w", encoding="utf-8"
        ) as python_module:
            python_module.write(file.read_text())


def generate(prj_name: str):
    """generate project files"""

    __generate_static_files(prj_name)
    __generate_dockerfile(prj_name)
    __generate_makefile(prj_name)
