FROM nvidia/cuda:12.3.1-runtime-ubuntu22.04
LABEL maintainer="leif@novusagi.com"
RUN apt-get -y update && apt-get -y install \
    python3-pip \ 
    python3-dev \
    git
RUN pip3 install --upgrade pip
RUN pip3 install torch torchvision torchaudio numpy pandas scikit-learn matplotlib jupyter
