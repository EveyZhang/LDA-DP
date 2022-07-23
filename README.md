# LDA-DP
An Unsupervised and Automatic Spike Sorting Method based on the Joint Optimization of Linear Discrimination Analysis and Density Peaks. `Run_Sample.m` is an example of  use.

## How to detect
Run `DetectWave.m` to detect spikes from raw data.

## How to sort
Run `ldadp_fuc.m` to do the sorting.

### Input
  <br>**X**: Waveforms of the spikes.
  <br>**Sample_data**: Number of the spikes
  <br>**Dim_sub**: dimension of the feature
  <br>**numCluster0**: initial number of clusters
  <br>**flagMerge**: merge the cluster or not
  
### Output
  <br>**Idx_sort**: the cluster label
  <br>**Idx_center**: the centers of each clusters
  
 ## References
 ### How to cite
 A Robust Spike Sorting Method based on the Joint Optimization of Linear Discrimination Analysis and Density Peaks. Yiwei Zhang, Jiawei Han, Tengjun Liu, Zelan Yang, Weidong Chen, Shaomin Zhang. BioRxiv 2022.02.10.479846; doi: https://doi.org/10.1101/2022.02.10.479846
 
