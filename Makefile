# Makefile for creating a new ML/AI project structure with uv and Git.
#
# Author: Shubhdeep Singh
# Date: 2025-09-03
# Version: 1.0.0
#
# Usage:
#   make new-project PROJECT_NAME="your-project-name" [PACKAGES="package1 package2 ..."]
#
# Example:
#   make new-project PROJECT_NAME="image-classifier" PACKAGES="torch torchvision Pillow jupyter tqdm openai sentence-transformers"
#
# Variables:
#   PROJECT_NAME: (Required) The name of the new project directory.
#   PACKAGES:     (Optional) A space-separated list of Python packages to install.
#                 Defaults to a common set of ML/AI libraries.

# Define default packages if the user doesn't provide any.
PACKAGES ?= "numpy pandas scikit-learn matplotlib jupyterlab"

# Use .PHONY to ensure the target runs even if a file named "new-project" exists.
.PHONY: new-project

new-project:
# 1. Check if PROJECT_NAME is provided. If not, show usage instructions and exit.
	@if [ -z "$(PROJECT_NAME)" ]; then \
		echo "Error: PROJECT_NAME is not set."; \
		echo "Usage: make new-project PROJECT_NAME=\"your-project-name\" [PACKAGES=\"package1 package2\"]"; \
		exit 1; \
	fi
# 2. Check if project already exists. If it does, show usage instructions and exit.
	@if [ -d "$(PROJECT_NAME)" ]; then \
		echo "Error: Project $(PROJECT_NAME) already exists."; \
		echo "Usage: make new-project PROJECT_NAME=\"your-project-name\" [PACKAGES=\"package1 package2\"]"; \
		exit 1; \
	fi

# 3. Announce the start of the process.
	@echo "Starting setup for new project: $(PROJECT_NAME)"

# 4. Create the project directory.
	mkdir -p $(PROJECT_NAME)

# 5. Perform all subsequent actions inside the new project directory.
#    The 'cd ... &&' structure ensures that if any command fails, the script stops.
	@cd $(PROJECT_NAME) && \
	echo "   - Initializing uv..." && \
	uv init --quiet && \
	echo "   - Creating virtual environment..." && \
	uv venv && \
	echo "   - Installing packages: $(PACKAGES)..." && \
	uv add $(PACKAGES) && \
	echo "   - Initializing Git repository..." && \
	git init && \
	echo "   - Creating .gitignore..." && \
	echo ".venv/" > .gitignore && \
	echo "__pycache__/" >> .gitignore && \
	echo ".uv/" >> .gitignore && \
	git add . && \
	git commit -m "Initial commit: Setup project with uv and dependencies"

# 6. Print completion message and next steps for the user.
	@echo "Project '$(PROJECT_NAME)' created successfully!"
	@echo "Next steps:"
	@echo "1. Navigate into your new project:"
	@echo "   cd $(PROJECT_NAME)"
	@echo "2. Activate the virtual environment:"
	@echo "   - On macOS/Linux: source .venv/bin/activate"
	@echo "   - On Windows (Cmd): .venv\\Scripts\\activate.bat"
	@echo "   - On Windows (PowerShell): .venv\\Scripts\\Activate.ps1"
	@echo "3. Create a remote repository on GitHub, GitLab, etc."
	@echo "4. Link the remote and push your initial commit:"
	@echo "   git remote add origin <your-remote-repository-url>"
	@echo "   git branch -M main"
	@echo "   git push -u origin main"
