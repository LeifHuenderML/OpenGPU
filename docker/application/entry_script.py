import os
import socket
import subprocess

hostname = socket.gethostname()
rank = int(hostname.split('_'[-1]))

os.environ['RANK'] = str(rank)
##TODO change this to be dynamic
os.environ['WORLDSIZE'] = '2'

subprocess.run(["python", "/workspace/train.py"])