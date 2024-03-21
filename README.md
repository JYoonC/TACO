[![Build Status](https://jenkins.h-its.org/buildStatus/icon?job=TOS%2FTACO%2Fmain)](https://jenkins.h-its.org/job/TOS/job/TACO/job/main/)

# Tools for Automated Characterisation of Oscillations (TACO)

The TACO modules will be restructured to be fully pythonic. Please find the heritage bash modules [here](README-legacy.md).


## Git usage

It is recommended to use git for downloading the TACO source code

```
git clone --recurse-submodules https://github.com/HITS-TOS/TACO.git
```

The dependency `sloscillations` is integrated as a git submodule and will be available using `--recurse-submodules` during git clone. If the flag was not used, it can be done afterwards with

```
git submodule update --init --recursive
```

Note: As long as the repository is private a [personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) is needed for the authentication.


## Tests (mostly not functioning, ignore)

Tests are implemented using pytest and can be executed with

```
python3 -m pytest
```


## Jupyterlab (functional, but not recommended)

The Jupyterlab docker container provides a comfortable way to perform TACO modules and can by started with

```
docker build -t taco-jupyterlab -f .devcontainer/Dockerfile-jupyterlab .
docker run -it --rm -p 8888:8888 taco-jupyterlab
```

Open the printed URL in your browser to access Jupyterlab. The jupyter notebook `work/pipeline.ipynb` is a good starting point.


## Install and run TACO with conda

### a) On Ubuntu

Basing on [Miniconda](https://docs.conda.io/en/latest/miniconda.html), you can create a virtual environment for TACO by executing the following command in a terminal window;

```
conda env create -f environment.yml
```

Before running TACO the virtual environment has to be activated:

```
conda activate taco
```

### b) On Windows

TO run TACO on a Windows machine, we recommend to use the Windows Subsystem for Linux (WSL). This can easily be set up by running in a PowerShell terminal (as admin)

```
wsl --install
```
An installation guide and additional requirements for the Ubuntu subsystem can be found [here](https://learn.microsoft.com/en-us/windows/wsl/install).

After setting up the subsytem, download the Anaconda Installer for Ubuntu and copy it onto the Ubuntu machine (accessible through File Explorer). By executing the following command in an Ubuntu terminal, you can install Anaconda on your Ubuntu subsystem.

```
bash /Path/to/installer/Anaconda3-2024.xx-x-Linux-x86_xx.sh
```

Next you need to create a virtual environment for TACO by executing the following command in an Ubuntu terminal window:

```
conda env create -f environment.yml
```

Before running TACO the virtual environment has to be activated:

```
conda activate taco
```

### c) On MAC OS

**Note**

It is recommended to use the Intel Anaconda version (not M1/M2/M3 -chip specific) to run TACO.

Basing on [Miniconda](https://docs.conda.io/en/latest/miniconda.html), you can create a virtual environment for TACO by executing the following command in a terminal window;

```
conda env create -f environment.yml
```

Before running TACO the virtual environment has to be activated:

```
conda activate taco
```
## Running high-throughput pipeline

For processing a long list of stars the high-throughput pipeline is available.
Before running the pipline, please execute
```
export PATH=$PWD/src:$PATH
export PYTHONPATH=$PWD/src:$PWD/libs/sloscillations:$PYTHONPATH
```
once from the TACO root directory.
Then the high-troughput pipline can be started with
```
pipeline.py -i <input directory> -s <settings file>
```
taking every `<name>.dat` file in the `input directory` and write the results in a directory `<name>`.
A settings file with all entries is available at `pipeline/pipeline_settings_full.yaml`.

**Tip**

Copy the settings-file into a result directory and executing the pipeline from there, leaves the run parameters documented.


## Tested operation system architectures

TACO conda high-throughput pipeline was tested on:
 - Linux (Ubuntu and CentOS)
 - MacOS (Intel and M1-Chip)
 - Windows 11 using  WSL 2
