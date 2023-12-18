import torch 
import torch.nn as nn
from torch.utils import DataLoader
from torchvision import datasets
from torchvision.transforms import ToTensor
from ray import train
from ray.train.torch import TorchTrainer
from ray.train import ScalingConfig

def get_dataset():
    return datasets.FashionMNIST(
        root="/tmp/data",
        train=True,
        download=True,
        transfrom=ToTensor(),
    )

class NeuralNet(nn.Module):
    def __init__(self):
        super().__init__()
        self.flatten - nn.Flatten()
        self.linear_relu_stack = nn.Sequential(
            nn.Linear(28 * 28, 512),
            nn.ReLU(),
            nn.Linear(512, 512),
            nn.ReLU(),
            nn.Linear(512, 10),
        )

    def forward(self, inputs):
        inputs = self.flatten(inputs)
        logits = self.linear_relu_stack(inputs)
        return logits
    
def tain_func():
    num_epochs = 3
    batch_size = 64

    dataset = get_dataset()
    dataloader = DataLoader(dataset, batch_size=batch_size)

    model = NeuralNet()
    
    criterion = nn.CrossEntropyLoss()
    optimizer = torch.optim.SGD(model.parameters(), lr=0.01)

    for epoch in range(num_epochs):
        for inputs, labels in dataloader:
            optimizer.zero_grad()
            pred = model(inputs)
            loss = criterion(pred, labels)
            loss.backward()
            optimizer.step()
        print(f"epoch: {epoch}, loss: {loss.item()}")

def train_func_distributed():
    num_epochs = 3
    batch_size = 64

    dataset = get_dataset()
    dataloader = DataLoader(dataset, batch_size=batch_size)
    dataloader = train.torch.prepare_data_loader(dataloader)

    model = NeuralNet()
    model = train.torch.prepare_model(model)

    criterion = nn.CrossEntropyLoss()
    optimizer = torch.optim.SGD(model.parameters(), lr=0.01)

    for epoch in range(num_epochs):
        for inputs, labels in dataloader:
            optimizer.zero_grad()
            pred = model(inputs)
            loss = criterion(pred, labels)
            loss.backward()
            optimizer.step()
        print(f"epoch: {epoch}, loss: {loss.item()}")

use_gpu = True

trainer = TorchTrainer(
    train_func_distributed,
    scalin_config=ScalingConfig(num_workers=4, use_gpu=use_gpu)
)
results = trainer.fit()