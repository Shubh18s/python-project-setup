# Automated ML/AI Project Setup

This project uses a Makefile to automate the setup of a new ML/AI project environment. It creates a new project directory, initializes a uv virtual environment, installs specified packages, and sets up a Git repository.

### Prerequisites

You must have the following tools installed on your system:

- make: A build automation tool, typically pre-installed on Unix-like systems.

  To install Make on Windows, you can use a package manager like Chocolatey. Run `choco install make` in an elevated command prompt.

  Alternatively, the `make` utility is included with Git Bash, which is recommended for running this `Makefile` on Windows.

  You can also download make Setup Program from `https://gnuwin32.sourceforge.net/packages/make.htm` and set the Path Variable to include location to bin folder (eg. `C:\Program Files (x86)\GnuWin32\bin.`).
  
- uv: A fast Python package installer and virtual environment creator. You can install it with pip: `pip install uv.`

- Git: The python-project-setup will setup the git repository and make initial commit which requires Git.
    
### Usage

1. Clone the repository and cd 

2. Once inside the cloned repo, run the `make new-project ...` command with three variables: PROJECT_NAME, PACKAGES and LOCATION to create a new project.

  #### Command Syntax:

  `make new-project PROJECT_NAME=<your_project_name> PACKAGES=<list_of_packages> LOCATION=<folder_path>`

- For Windows users, please use `git bash` or a similar Unix-like terminal.

- <your_project_name>: The name of the directory you want to create for your new project.
    
- <list_of_packages> (Optional): A space-separated list of Python packages to install in your virtual environment.

- <folder_path> (Optional): The location where to create new project. Defaults to the parent directory of `python-project-setup` folder. User can provide relative path to Makefile location (eg. - ../). 
  Note: For windows using git bash, use forward slash notation (eg. C:/Users/singh/repos)

#### Example:

To create a project named nlp-chatbot at location 'C:/Users/singh/repos'and install spacy and transformers using bash, run:

  `make new-project PROJECT_NAME=nlp-chatbot PACKAGES="spacy transformers" LOCATION="C:/Users/singh/repos"`
  
3. The command will create the directory, set up the environment, and initialize a local Git repository with an initial commit. If the directory already exists, the script will abort to prevent overwriting.

4. After the command finishes, you will need to activate the virtual environment manually. To do this, follow the Next Steps provided.

