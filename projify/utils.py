"""utility functions and classes"""

from dataclasses import dataclass
from pathlib import Path


@dataclass
class Template:
    """template directory paths"""

    base: Path = Path(__file__).parent.parent / "template"
    dockerfile: Path = base / "dockerfile"
    makefile: Path = base / "makefile"
    config: Path = base / "config"
    python_module: Path = base / "python_module"
