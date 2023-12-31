import os
import torch
from torch import optim, nn
from torchvision.datasets import MNIST
from torchvision.transforms import ToTensor
import pytorch_lightning as pl
from torch.utils.data import DataLoader
from pytorch_lightning.strategies import DDPStrategy
import socket
import pickle

hostname = socket.gethostname()
rank = int(hostname[len("worker"):]) - 1
os.environ['RANK'] = str(rank)

# Assuming encoder and decoder are defined as before

class LitAutoEncoder(pl.LightningModule):
    def __init__(self, encoder, decoder):
        super().__init__()
        self.encoder = encoder
        self.decoder = decoder

    def training_step(self, batch, batch_idx):
        x, _ = batch
        x = x.view(x.size(0), -1)
        z = self.encoder(x)
        x_hat = self.decoder(z)
        loss = nn.functional.mse_loss(x_hat, x)
        self.log("train_loss", loss)
        return loss

    def configure_optimizers(self):
        optimizer = optim.Adam(self.parameters(), lr=1e-3)
        return optimizer

    def train_dataloader(self):
        # Data loader with distributed sampler for DDP
        dataset = self.fetch_dataset()
        train_sampler = None
        train_sampler = torch.utils.data.distributed.DistributedSampler(dataset)
        return DataLoader(dataset, batch_size=64, sampler=train_sampler)

    def fetch_dataset(self):
        data_path = '/data/mnist_dataset/mnist_dataset.pkl'
        with open(data_path, 'rb') as file:
            dataset = pickle.load(file)
        return dataset

class Encoder(nn.Module):
    def __init__(self):
        super(Encoder, self).__init__()
        self.linear = nn.Linear(28 * 28, 128) 

    def forward(self, x):
        return self.linear(x)

class Decoder(nn.Module):
    def __init__(self):
        super(Decoder, self).__init__()
        self.linear = nn.Linear(128, 28 * 28) 

    def forward(self, x):
        return self.linear(x)

encoder = Encoder()
decoder = Decoder()

# init the autoencoder
autoencoder = LitAutoEncoder(encoder, decoder)

# Set up the trainer for DDP
trainer = pl.Trainer(
    strategy=DDPStrategy(),  # Use DistributedDataParallel strategy
    limit_train_batches=100,
    max_epochs=1
)

# Train the model
trainer.fit(model=autoencoder)
