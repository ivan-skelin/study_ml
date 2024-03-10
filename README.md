# EEGLAB STUDY export plugin for ML applications

This EEGLAB plugin formats EEG data contained in a STUDY to be processed by Machine Learning (ML) and Deep Learning (DL) solution and stored on the Amazon S3 cloud for dynamical access if necessary. 
The repository contains three examples, each within a separate live script. The live scripts are named based on the corresponding OpenNeuro dataset. The datasets (or their subsets) are downloaded from S3 storage, preprocessed by the EEGLAB toolbox plugin functions (pop_importbids_integrated and pop_study_dl), stored in MATLAB datastores (training, testing and validation subsets) and used to train/test/validate the VGG16 convolutional neural network model. All the examples contain the scalp EEG data with various number of channels. 
```diff
- Although the code is public, this version is alpha and still in development. Use at your own risk.
```
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=ivan-skelin/study_ml//tree/clean)
# Examples
Use example_ds003061_multiclass_integrated.mlx for EEG-based multi-class classification of auditory stimuly (1000 Hz, 500 Hz and pink noise).
Use example_ds002680_binary_integrated.mlx for EEG-based binary classification of visual stimuli (animal vs. non-animal).
Use example_ds004186_binary_integrated.mlx for EEG-based binary classification of eyes-open vs. eyes-closed state.

# Reference article

This is the reference article correspond to this dataset

https://ieeexplore.ieee.org/document/9871708

# Other related repository

Use of MATLAB DataStore
https://github.com/arnodelorme/child_mind_arno/tree/master

Use of VGG16 MATLAB
https://github.com/dungscout96/DL-EEG

See also this private repo (requires access)
https://github.com/sccn/childmind

# To do

- Fix adding the EEGLAB and BIDS toolbox to the path
