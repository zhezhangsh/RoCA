---
title: "Cluster genes across multiple sample groups"
author: "Zhe Zhang"
date: "2016-05-12"
output:
  html_document:
    self_contained: no
    number_sections: yes
    toc: yes
    toc_float: 
      collapsed: no
---

<div style="border:black 1px solid; padding: 0.5cm 0.5cm">
**Introduction: ** This analysis performs a gene-gene clustering procedure that will identify clusters of co-expressed genes across multiple sample groups. It first runs an ANOVA to find genes significantly changed across sample groups and uses these genes as seeds to initiate a number of gene clusters. These clusters will be further refined based on several user-specific paramters. Gene set enrichment analysis is then used to find pre-defined gene sets that are over-represented in each cluster. 

  - **Selection of differentially expressed gene:** ANOVA is used to get each gene a p value 
    for its differential expression across sample groups and false discovery rates are calculated      using the p values. Afterwards, genes are filtered sequentially by their FDR, p value, and         range until the number of remaining genes is smaller than a given minimal number.
  - **Gene clustering analysis:** Remaining genes from the last step are used as seeds for the         _hclust{stat}_ function to generate a hierchical clustering tree; the tree is cut at a given       height to get initial clusters; the cutting height will be lowered if the number of clusters is     less than the number of sample groups; the initial clusters are filtered to remove small           clusters, and refined to remove outlier genes; initial clusters close to each other are merged;     and finally, the clusters are refined through multiple rounds of re-clustering while including     genes with less significant ANOVA p values. 
  - **Gene set enrichment analysis:** Hypergeometric test is used to find predefined gene sets         over-represented in each gene cluster. A collection of gene sets obtained from                     different sources are available for a few model species and can be found at             
    https://github.com/zhezhangsh/RoCA/tree/master/data.
    
</div>

&nbsp;



<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Description

## Project


Comparison between cell lines from 9 different cancer tissues (NCI-60); **[GSE5949](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)**


## PubMed


Reinhold WC, Reimers MA, Lorenzi P, Ho J et al. **Multifactorial regulation of E-cadherin expression: an integrative study.** Mol Cancer Ther 2010 Jan;9(1):1-16. PMID: [20053763](http://www.ncbi.nlm.nih.gov/pubmed/20053763).


## Experimental design


Comparison between cell lines from 9 different cancer tissue of origin types (Breast, Central Nervous System, Colon, Leukemia, Melanoma, Non-Small Cell Lung, Ovarian, Prostate, Renal) from NCI-60 panel


## Analysis


Cluster genes co-expressed acroo 9 tissues/organs As a demonstration, only a subset of genes in the original data with high between sample variance were used.



<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

## Data and samples



  - There are 3105 total genes
  - There are 60 total [samples](table/sample.html)
  - There are Breast, CNS, Colon, Blood, Skin, Lung, Ovary, Prostate, Kidney sample groups

The input data matrix was normalized so each gene had mean of 0 and SD of 1.0

<div align='center'>
<img src="figure/pca-1.png" title="plot of chunk pca" alt="plot of chunk pca" width="640px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 1.** Principal components analysis (PCA) using all genes. Samples were colored by their groups. 
</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Analysis and results

## Gene-level summary statistics and ANOVA



Summary statistics and ANOVA p value across all sample groups were calculated for each gene.

- [Summary statistics and ANOVA result.](table/anova.html) 

<div align='center'>
<img src="figure/anova_pvalue-1.png" title="plot of chunk anova_pvalue" alt="plot of chunk anova_pvalue" width="640" />
</div>
  
<div style="color:darkblue; padding:0 3cm">
**Figure 2.** Distribution of ANOVA p values. 1481 genes have p values less than 0.01.
</div>
  
<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

## Identification of gene clusters

### Selection of differentially expressed genes

Differentially expressed genes (DEGs) were selected as seeds for generating gene clusters, using the following criteria:
  
  - Select genes with FDR less than 0.1
  - Stop if less than 200 genes were left; otherwise, select those with ANOVA p values less than 0.01
  - Stop if less than 200 genes were left; otherwise, select those with range (_max-min_) greater than 1
  - If there are still more than 1000 genes left, select the top 1000 with the biggest ranges



A total of **1000** genes were selected. These genes would be used as seeds to generate gene clusters in the next step.

<div align='center'>
<img src="figure/hierarchical_clustering-1.png" title="plot of chunk hierarchical_clustering" alt="plot of chunk hierarchical_clustering" width="800px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 3.** Hierarchical clustering of samples using all genes (unsupervised) or selected DEGs (supervised).
</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

### Idetnfication of gene clusters

Gene clusters were identified from the DEG seeds with the following steps:
  
  - Create a hierchical tree based on gene-gene correlation
  - Cut the tree at height 1.2, which will classify genes into clusters. Then apply the following steps to refine the clusters
  - Calculate correlation of each gene to the centroid (median) of its cluster. Remove the genes if the correlation is less than 0.6
  - Remove clusters with size less than 20% of the expected size (the expected size is 50 if there are 500 genes and 10 clusters)
  - If there are less than 9 (the number of sample groups) clusters left, reduce the height cutoff by 0.05 and repeat this step until there are enough clusters
  - Merge the 2 most similar clusters if the correlation of their centroids is greater than or equal to 0.6. Repeat this step until no 2 clusters are that similar



**10** gene clusters of **525** genes were identified from **1000** seed DEGs.

<div align='center'>
<img src="figure/plot_cluster_mean-1.png" title="plot of chunk plot_cluster_mean" alt="plot of chunk plot_cluster_mean" width="600px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 4.** Color of each block corresponds to the average expression (normalized) of each initial gene cluster in each sample (red = higher).
</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

### Refinement of gene clusters



The gene clusters identified from the DEG seeds were further refined with the following steps: 

  - Select all 1481 genes with p values less than 0.01 to continue
  - Assign selected genes to clusters:
  - Calculate centroid (median expression level of all genes in the cluster) of each cluster
  - Calculate correlation coefficient of each gene to centroid of each cluster to get a 1481 X 9 matrix
  - Assign a gene to a cluster if its correlation coefficient to the cluster is greater than 0.6, and the correlation coefficient to any other cluster is at least 0.1 less
  - Repeat this reclustering steps for 20 times unless the reclustering converged
  - Finally, remove clusters with number of genes less than 10.5
  
The reclustering converged after 7 cycles

A total of **533** genes were clustered after refinement. 

<div align='center'>
<img src="figure/plot_recluster_mean-1.png" title="plot of chunk plot_recluster_mean" alt="plot of chunk plot_recluster_mean" width="600px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 5.** Color of each block corresponds to the average expression (normalized) of each refined gene cluster in each sample (red = higher).
</div>



More info:

  - [Original data of clustered genes](table/clustered_data.html) ([download table](table/clustered_data.csv))
  - [Statistic result of clustered genes](table/clustered_stat.html) ([download table](table/clustered_stat.csv))

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

## Analysis of individual clusters

### Summary statistics and visualization of individual clusters



<div style="color:darkblue; padding:0 2cm">
**Table 1** Summary of individual clusters, with the average expression (normalized) of all genes of each cluster in all sample groups. Click on cluster name for visualization of each cluster: 1). the average and standard error of sample averages in each group; 2). hierarchical sample clustering using all genes of the cluster; and 3). heatmap of all genes and samples of the cluster.
</div>

<div align='center', style="padding:0 2cm">


|Cluster                            | Num_Gene| Mean_Breast| Mean_CNS| Mean_Colon| Mean_Blood| Mean_Skin| Mean_Lung| Mean_Ovary| Mean_Prostate| Mean_Kidney|
|:----------------------------------|--------:|-----------:|--------:|----------:|----------:|---------:|---------:|----------:|-------------:|-----------:|
|[Cluster_1](cluster/Cluster_1.pdf) |       24|       0.430|   1.7071|    -0.6095|    -0.4794|   -0.3584|    -0.027|     -0.240|       -0.2200|      0.0853|
|[Cluster_2](cluster/Cluster_2.pdf) |       82|      -0.017|  -0.5071|     1.6785|    -0.3899|   -0.4641|    -0.062|      0.097|        0.0770|     -0.2399|
|[Cluster_3](cluster/Cluster_3.pdf) |       57|      -0.160|  -0.2906|    -0.1920|     2.0391|   -0.1890|    -0.250|     -0.230|       -0.3100|     -0.2475|
|[Cluster_4](cluster/Cluster_4.pdf) |       16|      -0.370|  -0.5177|     1.1083|     1.0814|   -0.3114|    -0.200|     -0.200|       -0.2300|     -0.3166|
|[Cluster_5](cluster/Cluster_5.pdf) |       24|      -0.190|  -0.1019|     0.4968|     1.2466|   -0.7612|    -0.140|      0.150|       -0.2000|     -0.1535|
|[Cluster_6](cluster/Cluster_6.pdf) |       47|      -0.067|   0.3230|     0.0223|    -1.8258|    0.1561|     0.300|      0.230|        0.1500|      0.3767|
|[Cluster_7](cluster/Cluster_7.pdf) |      156|      -0.310|  -0.1729|    -0.2899|    -0.2985|    1.4933|    -0.300|     -0.370|       -0.2900|     -0.3311|
|[Cluster_8](cluster/Cluster_8.pdf) |       97|       0.260|   0.6147|    -0.7912|    -0.9946|   -0.3664|     0.190|      0.310|        0.0076|      0.7872|
|[Cluster_9](cluster/Cluster_9.pdf) |       30|      -0.310|  -0.2642|    -0.3230|    -0.5247|   -0.3492|    -0.160|      0.270|       -0.2400|      1.5013|


</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

### Gene set enrichment analysis

Find predefined gene sets enriched in gene cluster comparing to the background. 



<div style="color:darkblue; padding:0 2cm">
**Table 2** Numbers of predefined gene sets significantly enriched in each gene cluster. Gene sets were split based on their sources, such as the NCBI BioSystems and KEGG databases. Click on each number to see list of the gene sets. 
</div>

<div align='center', style="padding:0 2cm">


|          |                BioSystems                |               KEGG                |                MSigDb                |               PubTator                |
|:---------|:----------------------------------------:|:---------------------------------:|:------------------------------------:|:-------------------------------------:|
|Cluster_1 | [90](cluster/Cluster_1/BioSystems.html)  | [2](cluster/Cluster_1/KEGG.html)  | [215](cluster/Cluster_1/MSigDb.html) | [6](cluster/Cluster_1/PubTator.html)  |
|Cluster_2 | [160](cluster/Cluster_2/BioSystems.html) | [8](cluster/Cluster_2/KEGG.html)  | [218](cluster/Cluster_2/MSigDb.html) | [23](cluster/Cluster_2/PubTator.html) |
|Cluster_3 | [305](cluster/Cluster_3/BioSystems.html) | [16](cluster/Cluster_3/KEGG.html) | [383](cluster/Cluster_3/MSigDb.html) | [12](cluster/Cluster_3/PubTator.html) |
|Cluster_4 | [75](cluster/Cluster_4/BioSystems.html)  | [5](cluster/Cluster_4/KEGG.html)  | [112](cluster/Cluster_4/MSigDb.html) | [1](cluster/Cluster_4/PubTator.html)  |
|Cluster_5 | [178](cluster/Cluster_5/BioSystems.html) | [9](cluster/Cluster_5/KEGG.html)  | [387](cluster/Cluster_5/MSigDb.html) | [2](cluster/Cluster_5/PubTator.html)  |
|Cluster_6 | [292](cluster/Cluster_6/BioSystems.html) | [14](cluster/Cluster_6/KEGG.html) | [364](cluster/Cluster_6/MSigDb.html) | [4](cluster/Cluster_6/PubTator.html)  |
|Cluster_7 | [119](cluster/Cluster_7/BioSystems.html) | [5](cluster/Cluster_7/KEGG.html)  | [183](cluster/Cluster_7/MSigDb.html) | [3](cluster/Cluster_7/PubTator.html)  |
|Cluster_8 | [363](cluster/Cluster_8/BioSystems.html) | [12](cluster/Cluster_8/KEGG.html) | [489](cluster/Cluster_8/MSigDb.html) | [63](cluster/Cluster_8/PubTator.html) |
|Cluster_9 | [60](cluster/Cluster_9/BioSystems.html)  | [1](cluster/Cluster_9/KEGG.html)  | [87](cluster/Cluster_9/MSigDb.html)  |                   0                   |


</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

## More plots

<div align='center'>
<img src="figure/plot_series-1.png" title="plot of chunk plot_series" alt="plot of chunk plot_series" width="750px" />
</div>

<div style="color:darkblue; padding:0 2cm">
**Figure 6.**  Plot the patterns of all clusters using the mean and standard error of samples of each group.
</div>


&nbsp;

<div align='center'>
<img src="figure/plot_means-1.png" title="plot of chunk plot_means" alt="plot of chunk plot_means" width="480px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 7.**  Color represents the average expression (normalized across samples) of all genes in the same cluster and all samples in the same group (red = higher).
</div>

&nbsp;

<div align='center'>
<img src="figure/plot_group_means-1.png" title="plot of chunk plot_group_means" alt="plot of chunk plot_group_means" width="480px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 8.**  Color represents the average expression (normalized across samples) of individual genes in all samples of the same group (red = higher).
</div>

&nbsp;

<div align='center'>
<img src="figure/plot_heatmap-1.png" title="plot of chunk plot_heatmap" alt="plot of chunk plot_heatmap" width="600px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 9.**  Color represents the expression level (normalized across samples) of each gene and each sample (red = higher).
</div>

&nbsp;

<div align='center'>
<img src="figure/plot_recluster_size-1.png" title="plot of chunk plot_recluster_size" alt="plot of chunk plot_recluster_size" width="480px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 10.** Color represents the size of each cluster (number of genes) after a reclustering cycle.  
</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

***
_END OF DOCUMENT_

