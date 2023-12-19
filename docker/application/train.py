import os
import torch
import torch.nn as nn
import torch.optim as optim
from torchvision import datasets, transforms

# Define a simple neural network
class Net(nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.fc = nn.Linear(784, 10)

    def forward(self, x):
        x = x.view(-1, 784)
        return self.fc(x)

def main():
    # Set up the neural network and move it to GPU if available
    model = Net()
    if torch.cuda.is_available():
        model.cuda()

    # Set up the data loader for the MNIST dataset
    transform = transforms.Compose([transforms.ToTensor(), transforms.Normalize((0.5,), (0.5,))])
    dataset = datasets.MNIST('.', train=True, download=True, transform=transform)
    loader = torch.utils.data.DataLoader(dataset, batch_size=64, shuffle=True)

    # Set up the optimizer
    optimizer = optim.SGD(model.parameters(), lr=0.01, momentum=0.5)

    # Training loop
    for epoch in range(1, 5):
        model.train()
        for batch_idx, (data, target) in enumerate(loader):
            if torch.cuda.is_available():
                data, target = data.cuda(), target.cuda()
            optimizer.zero_grad()
            output = model(data)
            loss = nn.functional.cross_entropy(output, target)
            loss.backward()
            optimizer.step()

            if batch_idx % 10 == 0:
                print(f"Train Epoch: {epoch} [{batch_idx * len(data)}/{len(loader.dataset)} ({100. * batch_idx / len(loader):.0f}%)]\tLoss: {loss.item():.6f}")

if __name__ == "__main__":
    main()
