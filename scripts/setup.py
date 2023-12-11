from setuptools import setup, find_packages

setup(
    name="OpenGPU",
    version="0.1",
    packages=find_packages(),
    install_requires=[
        "torch",
        "torchvision",
        "torchtext",
        "scikit-learn",
        "numpy",
        "pandas",
        "scipy",
        "tensorboard",
        "tqdm",
        "seaborn",
        "notebook",
        "datasets"
    ],
)