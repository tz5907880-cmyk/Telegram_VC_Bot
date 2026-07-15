#Python based docker image
FROM python:3.9-bullseye

RUN apt-get update && apt-get upgrade -y

# Installing Requirements & FFmpeg Compilation Libraries
RUN apt-get install -y ffmpeg opus-tools build-essential libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libswresample-dev libavfilter-dev pkg-config

# Updating pip and downgrading setuptools to fix distutils compilation error
RUN python3.9 -m pip install -U pip setuptools==59.6.0 wheel

COPY . .

# Install requirements and force NumPy to be 1.x (numpy<2) to fix ABI version error
RUN python3.9 -m pip install --no-build-isolation -U -r requirements.txt "numpy<2"

# Running VCBot
CMD ["python3.9", "main.py"]
