FROM pytorch/pytorch:latest

RUN pip install -U "ray[train]"

COPY /application/distributed.py /workspace/distributed.py

CMD ["python", "/workspace/distributed.py"]

