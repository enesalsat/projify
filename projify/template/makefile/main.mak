OS := $(shell uname -m)
SHELL := /bin/bash
PROJECTNAME := $(subst -,_,$(shell basename ${PWD}))

exit:
	@echo -e "\x1B[31mcommand needed, like: \n \
	 >>> make install"
	@exit 0

clean clear:
	@find . -name ".DS_Store" -delete
	@find . -name "__pycache__" -exec rm -rf {} +
	@find . -name ".vscode" -exec rm -rf {} +
	@find . -name ".mypy_cache" -exec rm -rf {} +
	@find . -name ".spyderproject" -exec rm -rf {} +

delete: clean
	@find . -name "tempstorage" -exec rm -rf {} +
	@find . -name '.markdownlint.json' -maxdepth 1 -exec rm {} +

docker:
	@docker build . -t $(PROJECTNAME)

docker_run:
	@docker run -it $(PROJECTNAME)
