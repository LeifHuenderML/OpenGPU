FROM pytorch/pytorch:latest

RUN pip install torchx[dev]

COPY /application/train.py /workspace/train.py

CMD ["python", "/workspace/distributed.py"]

