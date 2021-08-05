### Instructions to replicate study 

------

This repository serves to replicate the SMAT project, which aims to detect semantic conflicts by generating and running test suites on merge scenarios.

#### Getting started

------

- Clone the project locally using the command in your prompt: `git clone https://github.com/ToniMaciel/SMAT-Dockerfile`

- After cloning, inside of directory SMAT-Dockerfile, use the following command to initiate the replication: `bash replicate.sh`

-  After this, the bash file will clone the dataset for the study and build a Docker container with the SMAT tool. Once all the steps are done, it will open the prompt of the container. 

- To better understand what is inside of the container, it follows a tree representation of his content:

  `|-- $PWD`

  `|	|-- SMAT-Dockerfile`

  `|	|	|-- mergedataset`

  `|	|		|-- (dataset files)`

  `|	|	|-- infra`

  `|	|	|   |-- (SMAT tool files)`

  `|	|	|-- output`			

  Where $PWD is the path in your computer to where you clone this project.

- Once the prompt of the container is open, you will be at the output directory. Be free to change files in the dataset or the SMAT tool, but if you want to analyze the output of the tool's execution after closing the container, you must do this execution in the output directory.

- To execute the tool, use the following command: `python3 $SMAT` 

- You can see the output in *output-test-dest* directory where you did the execution.

#### Attentions When Using Windows

------

If you use Windows as your operating system, when you execute the bash file, you will probably receive an error message due to the size of a few file names in the mergedataset repository. This problem will make it impossible for you to clone this repository.

To resolve this, you must install the Windows Subsystem for Linux (WSL); just follow the steps outlined in this [guide](https://docs.microsoft.com/pt-br/windows/wsl/install-win10). 

To execute the project, we advise you to use VSCode, because it has extensions to integrate with WSL. Once WSL is installed, when opening VSCode, a message will be displayed to download the Remote - WSL extension. With it, it is possible to edit all the files that are in WSL through VSCode and execute the project via terminal.