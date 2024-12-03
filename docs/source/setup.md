# Get Started with DeepDendrite

## Source code of DeepDendrite (built up based on CoreNeuron) and the demos in the paper.  
src: source code of DeepDendrite and the modified NEURON simulator.  
NOTICE: To perform AI tasks with DeepDendrite, we should use our modified NEURON simulator.  
Figure5: Model used in Figure5 in the paper, i.e. spine-level human pyramidal models.  
Figure6: Model used in Figure6 in the paper, i.e. image classification on MNIST dataset.  


## How to compile DeepDendrite

First, you need to clone or download this repo:
```bash
git clone https://github.com/DeepDendrite/DeepDendrite.git
```
Then, follow the instruction for your computer OS:

### If you are using Linux(Or WSL2 on Windows):

#### Way#1:Using docker(Recommended)
0.  Install Nvidia Driver(If you are using WSL2, installing driver on Windows should be enough)

1.  Install Docker(not Docker Desktop) and Nvidia Container toolkit:
    1.  **Arch users:**
       1. Just use pacman to install the packages you needed:
       ```bash
       sudo pacman -Sy docker nvidia-container-toolkit
       ```
    2. **Ubuntu and other Linux users:**
       1. Follow this instruction to install Docker-CE(DO NOT install Docker Desktop) 
       https://docs.docker.com/engine/install/
       2. Follow this guide to install Nvidia Container toolkit:
    https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

2. Configure docker and Nvidia Container toolkit:
   1.   Inorder to run docker, you might need to **enable docker service** and **reboot** your computer:
   ```bash
    sudo systemctl enable docker.service
   ```
   2.   If you want to run docker without sudo, you might want to add your user to `docker` group, you might need to `relogin` to take effect:
   ``` bash
    sudo usermod -aG docker $(whoami)
   ```
   3.   You need to configure the container runtime to use GPU:
    ``` bash
    sudo nvidia-ctk runtime configure --runtime=docker
    sudo systemctl restart docker
    ```
    4.  If you are having trouble connect to DockerHub or something, you can set Docker proxy following this guide(the configure file in linux is `/etc/docker/daemon.json`): 
        https://docs.docker.com/engine/daemon/proxy/#httphttps-proxy

    If everyting went well, you can run this command, it should show your GPU info:
    ```bash
    docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
    ```
3.  Build the docker image
    Assumed that you have already clone or download this repo, and the folder is called `DeepDendrite`:
    ```bash
    cd DeepDendrite
    ## you should now in DeepDendrite folder, and you can see the Dockerfile file 
    docker build -t deepdendrite_docker:1.0 .
    ``` 
    This command will build a docker image called `deepdendrite_docker:1.0`, based on Nvidia's NVHPC image.

4.  Run the docker, and compile

    1.  Start the container, this command will map current dir into the container's`/workdir`
        ```bash
        #assume you are in DeepDendrite folder now
        docker run --gpus all -itd --user $(id -u):$(id -g) --volume $(pwd):/workdir deepdendrite_docker:1.0
        ```
    2.  Attach to the container(or, you can use vscode's Dev Container plugin to attach, it has a better experince)
        ```bash
        docker ps ##check and remember your docker's name
        docker exec -it your_docker_name bash
        ```
    3.  Now, you should be inside docker `/workdir`, just run `compile_and_install.sh`
    ```bash
    ./compile_and_install.sh
    ```
That is it! DeepDendrite is now compiled!

#### Way#2:Manually compile

It's only tested on Ubuntu 22.04.3 LTS, DeepDendrite is based on NEURON 7.6, which, used a lot of outdated codes, some linux distros might have a new version of gcc which might break the compile.

1.  Install essential packages:
    ```bash
    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y --no-install-recommends \
    build-essential \
    python-is-python3 \
    python3-distutils \
    python3-dev \
    ncurses-bin \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    openmpi-bin \
    libopenmpi-dev \
    bison \
    cmake \
    pkg-config \
    flex \
    libtool \
    environment-modules \
    python3-numpy \
    python3-matplotlib \
    python3-progressbar 
    ```
2.  install CUDA: https://developer.nvidia.com/cuda-downloads(alternatively you can check the doc:https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
3.  install Nvidia's hpc sdk: https://developer.nvidia.com/hpc-sdk
    (or, simply follow:)
    ```bash
    wget https://developer.download.nvidia.com/hpc-sdk/24.7/nvhpc_2024_247_Linux_x86_64_cuda_12.5.tar.gz
    tar xpzf nvhpc_2024_247_Linux_x86_64_cuda_12.5.tar.gz
    sudo nvhpc_2024_247_Linux_x86_64_cuda_12.5/install
    ```
    We assume that you install nvhpc into`[/opt/nvidia/hpc_sdk]`
4.  clone this repo and edit the compile script:
    ```bash
    git clone https://github.com/DeepDendrite/DeepDendrite.git
    cd DeepDendrite
    vim src/DeepDendrite/compile_and_install.sh ## or, you can use any other editors you like
    ```
    You might see the code like:
    ```bash
    #change to your modulefile path
    #module load /opt/nvidia/hpc_sdk/modulefiles/nvhpc-hpcx-cuda12/24.7
    ```
    Uncomment the `module load` line, and change it to the modulefile path in your computer, it should be right in the install dir in step3:
    ```bash
    #change to your modulefile path
    module load /opt/nvidia/hpc_sdk/modulefiles/nvhpc-hpcx-cuda12/24.7
    ```
5.  run the compile script:
    ```bash
    ## you should be in./DeepDendrite right now
    ./compile_and_install.sh
    ```
If everything went well, DeepDendrite should be compiled right now!


### If you are using Windows10/11:

We are currently only supports running under wsl2, so, you might upgrade your system to the latest version.

Step0:
- Install wsl2 : https://learn.microsoft.com/en-us/windows/wsl/install
- Also, install the latest Nvidia driver: https://www.nvidia.com/en-us/drivers/

After installing wsl2, you there are two way to compile and use DeepDendrite. You can use Docker Desktop to run, or you can use Ubuntu in wsl.

#### Way#1 Using Docker Desktop

1.  Download and install Docker Desktop for Windows: https://www.docker.com/
    **Make Sure to use WSL2 as backend!**
    You can also follow the guide in: https://docs.docker.com/desktop/gpu/
2.  Build the Docker Image
    1.  Clone, or download this repo.
    2.  Go into the folder, hold shift and right click, you should see something like `Open Powershell here`, powershell and cmd are both fine.
    3.  You should now in the `DeepDendrite` dir(or `DeepDendrite-main` if you download a zip file), enter the command:
        ```bash
        docker build -t deepdendrite_docker:1.0 .
        ```
    4. Run the container
      If you are using powershell:
        ```powershell
        docker run --gpus all -itd --volume ${PWD}:/workdir deepdendrite_docker:1.0
        ```
        If you are using cmd:
        ```cmd
        docker run --gpus all -itd --volume %cd%:/workdir deepdendrite_docker:1.0 
        ```
    5.  Attach to the container(or, you can use vscode's Dev Container plugin to attach, it has a better experince)
        ```bash
        docker ps ##check and remember your docker's name
        docker exec -it your_docker_name bash
        ```
    6.  Now, you should be inside docker `/workdir`, just run `compile_and_install.sh`
        ```bash
        ./compile_and_install.sh
        ```

If everything went well, DeepDendrite should be compiled right now!


#### Way#2 Manually compile on Ubuntu 22.04 wsl2

1.  Open MicrosoftStore, and search for **Ubuntu**, download the **Ubuntu 22.04.3 LTS**
2.  The rest steps are almost the same as the Linux Method above :**Way#2:Manually compile**

  **BUT DO NOT** install Nvidia driver inside wsl2, **only install cuda-toolkit-12-x**

-----

## What to Do Next?

### 1. Evaluate the run time of solving equations with various methods:
Follow the README.md in "Figure_3_4"
	
### 2. Run the demo of spine-level model:
  Commands:
    
    cd Figure5/run_samples
    python3 run.py
  For more details please see Figure5/run_samples/README.md

### 3. Run the demo of image classification task:
  Commands:
    
    cd Figure6/run_samples
    python3 run.py (for training and testing)
    python3 run_test.py (only for testing, with pre-trained model weights) 
  For more details please see Figure6/run_samples/README.md