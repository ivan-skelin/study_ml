# EEGLAB STUDY export plugin for ML applications

This EEGLAB plugin formats EEG data contained in a STUDY to be processed by Machine Learning (ML) and Deep Learning (DL) solution and stored on the Amazon S3 cloud for dynamical access if necessary. 

```diff
- Although the code is public, this version is alpha and still in development. Use at your own risk.
```

# Examples

Use [example_tutorial_dataset.m](example_tutorial_dataset.m) for an example of dataset conversion. This simple script creates a STUDY with a single dataset, convert it to a format suitable for deep learning and apply a simple convolutional network. This example is not supposed to provide meaningful results.

Use [example_ds003061.m](example_ds003061.m) for an example of BIDS STUDY conversion.

# Reference article

This is the reference article correspond to this dataset

https://ieeexplore.ieee.org/document/9871708

# Other related repository

Use of MATLAB DataStore
https://github.com/arnodelorme/child_mind_arno/tree/master

Use of VGG16 MATLAB
https://github.com/sccn/childmind

# To do

- Fix issue with borders (exported size is 12 x 12 but all the borders are empty)
- example_ds003061.m: Train and test on different individuals (otherwise performance 100%)
- Add export to 2-second dataset
- Add export to different features
- Test first with HBN data
