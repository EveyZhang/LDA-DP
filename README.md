# LDA-DP
An Unsupervised and Automatic Spike Sorting Method based on the Joint Optimization of Linear Discrimination Analysis and Density Peaks. `Run_Sample.m` is an example of  use.

## How to Use
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
  
  
