from ligthning_gpt.model import GPT
import lightning as L
import torch

model_config = GPT.get_default_config()
model_config.model_type = 'gpt2'
model_config.vocab_size = 50257
model_config.clock_size = 1024
ltng_gpt = GPT(model_config)

dataset = # add a dataset
train_loader = # add a train loader

if torch.cuda.is_available():
    device_accelerator="gpu",
    n_devices = torch.cuda.device_count();
else:
    device_accelerator="cpu"
    n_devices = 1

trainer = L.Trainer(
    limit_train_batches=100,
    max_epochs=10,
    devices=n_devices,
    num_nodes=4,  # change this to be dynamic
    accelerator=device_accelerator,
    plugins="ddp_sharded"
    strategy="deepspeed_stage_1",
    precision=16
)

trainer.fit(model=ltng_gpt, train_dataloaders=train_loader)
