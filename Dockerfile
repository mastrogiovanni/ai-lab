# FROM 691684840569.dkr.ecr.eu-west-2.amazonaws.com/elerian/torch-cuda-11.3.0:1.0.0-prod

# Use a docker image as base image
FROM nvidia/cuda:11.8.0-base-ubuntu20.04

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Installation of some libraries / RUN some commands on the base image
RUN apt-get update && \
    apt-get install -y --no-install-recommends git wget swig build-essential libicu-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# INSTALLATION OF MINICONDA
ENV PATH /opt/conda/bin:$PATH

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

RUN /opt/conda/bin/conda install python=3.10.13
RUN /opt/conda/bin/conda update -n base -c defaults conda

RUN ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN conda install pytorch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 pytorch-cuda=11.8 -c pytorch -c nvidia

RUN conda install -y -c conda-forge numba==0.57.1

# RUN pip install transformers

# ASR
RUN pip install --upgrade git+https://github.com/huggingface/transformers.git accelerate datasets[audio] 
RUN pip install librosa nltk rouge jiwer tensorboardX

RUN pip install matplotlib
RUN pip install tiktoken

# Notebook
RUN pip install notebook
RUN pip install ipywidgets

EXPOSE 8888

WORKDIR /app

CMD ["jupyter", "notebook", "--ip", "0.0.0.0", "--allow-root", "--no-browser"]



