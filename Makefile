# Makefile for creating a new ML/AI project structure with uv and Git.
#
# Author: 
# Date: 2025-09-04
# Version: 1.0.0
#
# Usage:
#   make new-project PROJECT_NAME="your-project-name" [PACKAGES="package1 package2 ..."] LOCATION="C:/Users/singh/my-folder"
#
# Example:
#   make new-project PROJECT_NAME="image-classifier" PACKAGES="torch torchvision Pillow jupyter tqdm openai sentence-transformers" LOCATION=".."
#
# Variables:
#   PROJECT_NAME: (Required) The name of the new project directory.
#   PACKAGES:     (Optional) A space-separated list of Python packages to install.
#                 Defaults to a common set of ML/AI libraries.
#	LOCATION: 	  (Optional) The location where to create project. Can be relative to Makefile location

# Define default packages if the user doesn't provide any.
COLOR_GREEN  := $(shell tput setaf 2)
COLOR_RED    := $(shell tput setaf 1)
COLOR_YELLOW := $(shell tput setaf 3)
COLOR_RESET  := $(shell tput sgr0)
PACKAGES ?= jupyter numpy pandas matplotlib
LOCATION ?= ..

# Use .PHONY to ensure the target runs even if a file named "new-project" exists.
.PHONY: new-project

new-project:
# 1. Check if PROJECT_NAME is provided. If not, show usage instructions and exit.
	@if [ -z "$(PROJECT_NAME)" ]; then \
		echo "$(COLOR_RED)Error: PROJECT_NAME is not set.$(COLOR_RESET)"; \
		echo "$(COLOR_YELLOW)Usage: make new-project PROJECT_NAME=<your_project_name> PACKAGES=\"<list_of_packages>\" LOCATION=<path_to_location> $(COLOR_RESET)"; \
		exit 1; \
	fi
# 2. Check if LOCATION is provided. If not, show usage instructions and exit.
	@if [ "$(origin LOCATION)" == "file" ]; then \
		echo "$(COLOR_YELLOW)Note: LOCATION is not set. Using parent directory: $(realpath $(LOCATION))"; \
	fi

# 3. Check if project already exists. If it does, show usage instructions and exit.
	@if [ -d "$(LOCATION)/$(PROJECT_NAME)" ]; then \
		echo "$(COLOR_RED)Error: Project '$(realpath $(LOCATION))/$(PROJECT_NAME)' already exists. Please choose a different name or location. $(COLOR_RESET)"; \
		exit 1; \
	fi

# 4. Check if packages are provided. If not, install default packages.
	@if [ "$(origin PACKAGES)" == "file" ]; then \
		echo "$(COLOR_YELLOW)Note: PACKAGES are not provided. Will use default $(PACKAGES) $(COLOR_RESET)"; \
	fi

# 5. Announce the start of the process.
	@echo "$(COLOR_GREEN)Starting setup for new python project: $(realpath $(LOCATION))/$(PROJECT_NAME) $(COLOR_RESET)"; \

# 6. Create the project directory.
	mkdir -p $(LOCATION)/$(PROJECT_NAME)

# 7. Perform all subsequent actions inside the new project directory.
#    The 'cd ... &&' structure ensures that if any command fails, the script stops.
	@cd $(LOCATION)/$(PROJECT_NAME) && \
	echo "$(COLOR_GREEN)   - Initializing uv... $(COLOR_RESET)" && \
	uv init --quiet && \
	echo "$(COLOR_GREEN)   - Creating virtual environment... $(COLOR_RESET)" && \
	uv venv && \
	echo "$(COLOR_GREEN)   - Installing packages: $(PACKAGES)... $(COLOR_RESET)" && \
	uv add $(PACKAGES) && \
	echo "$(COLOR_GREEN)   - Initializing Git repository... $(COLOR_RESET)" && \
	git init && \
	echo ".venv/" > .gitignore && \
	echo "__pycache__/" >> .gitignore && \
	echo ".uv/" >> .gitignore && \
	git add . && \
	git commit -m "Initial commit: Setup project with uv and dependencies"

# 8. Print completion message and next steps for the user.
	@echo "$(COLOR_GREEN) Project '$(PROJECT_NAME)' created successfully! $(COLOR_RESET)"
	@echo "------------------------------------------------------"
	@echo "--------------------Next steps:-----------------------"
	@echo "------------------------------------------------------"
	@echo "1. Navigate into your new project:"
	@echo "   cd $(LOCATION)/$(PROJECT_NAME)"
	@echo "2. Activate the virtual environment:"
	@echo "   - On macOS/Linux: source .venv/bin/activate"
	@echo "   - On Windows (Cmd): .venv\\Scripts\\activate"
	@echo "   - On Windows (PowerShell): .venv\\Scripts\\Activate"
	@echo "   - On Windows (Bash): source .venv/bin/activate"
	@echo "3. Create a remote repository on GitHub, GitLab, etc."
	@echo "4. Link the remote and push your initial commit:"
	@echo "   git remote add origin <your-remote-repository-url>"
	@echo "   git branch -M main"
	@echo "   git push -u origin main"
	@echo "------------------------------------------------------"
