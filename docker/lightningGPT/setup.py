from setuptools import setup

setup(name='LightningGPT',
      version='0.0.1',
      author='Andrej Karpathy edited by Leif Huender',
      packages=['mingpt'],
      description='A PyTorch Lightning re-implementation of GPT',
      license='MIT',
      install_requires=[
            'torch',
      ],
)
