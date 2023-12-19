import os
import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import datasets, transforms
import pytorch_lightning as pl
from pytorch_lightning.plugins import DeepSpeedPlugin

# Define a simple neural network as a Lightning Module
class Net(pl.LightningModule):
    def __init__(self):
        super(Net, self).__init__()
        self.fc = nn.Linear(784, 10)

    def forward(self, x):
        x = x.view(-1, 784)
        return self.fc(x)

    def training_step(self, batch, batch_idx):
        data, target = batch
        output = self(data)
        loss = nn.functional.cross_entropy(output, target)
        return loss

    def configure_optimizers(self):
        optimizer = optim.Adam(self.parameters(), lr=0.001)
        return optimizer

    def train_dataloader(self):
        # Set up the data loader for the MNIST dataset
        transform = transforms.Compose([
            transforms.ToTensor(), 
            transforms.Normalize((0.5,), (0.5,))
        ])
        dataset = datasets.MNIST('.', train=True, download=True, transform=transform)
        loader = torch.utils.data.DataLoader(dataset, batch_size=64, shuffle=True)
        return loader

def main():
    # Initialize the model
    model = Net()

    # Initialize PyTorch Lightning trainer with DeepSpeed plugin
    trainer = pl.Trainer(
        plugins=DeepSpeedPlugin(stage=3, cpu_offload=True, partition_activations=True),
        max_epochs=5
    )

    # Train the model
    trainer.fit(model)

if __name__ == "__main__":
    main()
