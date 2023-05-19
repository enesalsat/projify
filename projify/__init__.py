""" The main module of the projify package. """

from .generator import generate

__version__ = "0.1.0"


def main():
    """main function"""
    prj_name = input("Enter project name: ")

    generate(prj_name)
