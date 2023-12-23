from ligthning_gpt.model import GPT
import lightning as L
import torch

model_config = GPT.get_default_config()
model_config.model_type = 'gpt2'
model_config.vocab_size = 50257
model_config.clock_size = 1024
ltng_gpt = GPT(model_config)

dataset = #add a dataset
train_loader = #add a train loader

if torch.cuda.is_available():
    device_accelerator = "gpu"
else:
    device_accelerator = "cpu"

trainer = L.Trainer(
    limit_train_batches=100,
    max_epochs=10,
    devices=4 #change to be dynamic
    accelerator=device_accelerator
    strategy="deepspeed_stage_1" #update so it fits the stage where it is DP+PP+TP+ZeRO-1 currently it is at just DP+ZeRO-1 
    precision=16 #prolly change this too

)
trainer.fit(model=ltng_gpt, train_dataloader = train_loader)
