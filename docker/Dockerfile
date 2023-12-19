FROM pytorch/pytorch:latest

RUN pip install torchelastic torchvision lightning deepspeed

COPY /application/train.py /workspace/train.py
#COPY /application/entry_script.py /workspace/entry_script.py
CMD ["python", "/workspace/train.py"]

