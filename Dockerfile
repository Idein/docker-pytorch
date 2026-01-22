ARG CUDA_VERSION=13.1.0
ARG IMGTYPE=runtime
ARG OS=ubuntu24.04
FROM nvidia/cuda:${CUDA_VERSION}-${IMGTYPE}-${OS}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    git gcc python3 python3-pip python3-venv python3.12 libpython3.12-dev zlib1g-dev libjpeg62-dev curl ca-certificates tree bash \
    libglib2.0-0 libsm6 libice6 libxrender1 libxext6 libx11-6 && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
COPY requirements.txt /requirements.txt
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3 && \
    pip --no-cache-dir install -r ./requirements.txt
# Use Agg backend for matplotlib
ENV DISPLAY 0
