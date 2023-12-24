# Use the PyTorch base image
FROM pytorch/pytorch:latest

# Install additional dependencies
RUN pip install torchelastic torchvision lightning deepspeed

# Copy the minGPT directory to the image
COPY minGPT /workspace/minGPT

# Install minGPT in editable mode
RUN pip install -e /workspace/minGPT

# Copy the application scripts
COPY application/simple_model/train.py /workspace/simple_model/train.py
#COPY application/entry_script.py /workspace/entry_script.py

# Set the command to run the training script
CMD ["python", "/workspace/simple_model/train.py"]
