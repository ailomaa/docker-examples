FROM pytorch/pytorch:2.3.1-cuda12.1-cudnn8-runtime

RUN python -m pip install --upgrade pip

RUN conda install -y \
    transformers \
    datasets

RUN pip install \
    librosa \
    soundfile
