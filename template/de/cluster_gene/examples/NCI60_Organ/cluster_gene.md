---
title: "Cluster genes across multiple sample groups"
author: "Zhe Zhang"
date: "2016-05-08"
output:
  html_document:
    self_contained: no
    number_sections: yes
    toc: yes
    toc_float: 
      collapsed: no
---

<div style="border:black 1px solid; padding: 0.5cm 0.5cm">
**Introduction: ** This procedure performs a gene-gene clustering analysis that will identify clusters co-expressed genes across multiple sample groups. It first runs an ANOVA to find genes significantly changed across sample groups and uses these genes to initiate a few gene clusters. The clusters will be refined based on several user-specific paramters. Gene set enrichment analysis will be used to assign biological functionality to the finalized gene clusters. 

  - **Selection of differentially expressed gene:** ANOVA is used to get each gene a p value 
    for its differential expression across sample groups and corresponding false discovery rate 
    was calculated using the p values. Seed genes for clustering are sequentially selected by FDR, 
    p value, and range until the number of selected genes is smaller than a given minimal number.
  - **Gene clustering analysis:** The _hclust{stat}_ function is used to generate hierchical 
    clustering tree from the seed genes; the tree is cut at a given height to get initial clusters;
    the cutting height is lowered to get more clusters if the number of clusters is less than the 
    number of sample groups; the initial clusters are filtered to remove small and outlier genes; 
    initial clusters close to each other are merged; and finally, the clusters are refined through 
    multiple rounds of re-clustering while including genes with less significant ANOVA p values. 
  - **Gene set enrichment analysis:** Hypergeometric test is used to find predefined gene sets over-
    represented in each gene cluster. A collection of gene sets of different species from different 
    sources can be found at https://github.com/zhezhangsh/RoCA/tree/master/data.
</div>

&nbsp;



<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

# Description

## Project


Comparison between cell lines from 9 different cancer tissues (NCI-60); **[GSE5949](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)**


## PubMed


Reinhold WC, Reimers MA, Lorenzi P, Ho J et al. **Multifactorial regulation of E-cadherin expression: an integrative study.** Mol Cancer Ther 2010 Jan;9(1):1-16. PMID: [20053763](http://www.ncbi.nlm.nih.gov/pubmed/20053763).


## Experimental design


Comparison between cell lines from 9 different cancer tissue of origin types (Breast, Central Nervous System, Colon, Leukemia, Melanoma, Non-Small Cell Lung, Ovarian, Prostate, Renal) from NCI-60 panel


## Analysis


Cluster genes co-expressed acroo 9 tissues/organs



<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

## Data and samples



  - There are 17647 total genes
  - There are 60 total [samples](table/sample.html)
  - There are Breast, CNS, Colon, Blood, Skin, Lung, Ovary, Prostate, Kidney sample groups

The input data matrix was normalized so each gene had mean of 0 and SD of 1.0

<div align='center'>
<img src="figure/pca-1.png" title="plot of chunk pca" alt="plot of chunk pca" width="640px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 1.** Principal components analysis (PCA) using all genes. Samples were colored by their groups. 
</div>

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

# Analysis and results

## Gene-level summary statistics and ANOVA



Summary statistics and ANOVA p value across all sample groups were calculated for each gene.

- [Summary statistics and ANOVA result.](table/anova.html) 

<div align='center'>
<img src="figure/anova_pvalue-1.png" title="plot of chunk anova_pvalue" alt="plot of chunk anova_pvalue" width="640" />
</div>
  
<div style="color:darkblue; padding:0 3cm">
**Figure 2.** Distribution of ANOVA p values. 3438 genes have p values less than 0.01.
</div>
  
<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

## Identification of gene clusters

### Selection of differentially expressed genes

Differentially expressed genes (DEGs) were selected as seeds for generating gene clusters, using the following criteria:
  
  - Select genes with FDR less than 0.1
  - Stop if less than 100 genes were left; otherwise, select those with ANOVA p values less than 0.01
  - Stop if less than 100 genes were left; otherwise, select those with range (_max-min_) greater than 1
  - If there are still more than 2000 genes left, select the top 2000 with the biggest ranges



A total of **2000** genes were selected. These genes would be used as seeds to generate gene clusters in the next step.

<div align='center'>
<img src="figure/hierarchical_clustering-1.png" title="plot of chunk hierarchical_clustering" alt="plot of chunk hierarchical_clustering" width="800px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 3.** Hierarchical clustering of samples using all genes (unsupervised) or selected DEGs (supervised).
</div>

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

### Idetnfication of gene clusters

Gene clusters were identified from the DEG seeds with the following steps:
  
  - Create a hierchical tree based on gene-gene correlation
  - Cut the tree at height 1.2, which will classify genes into clusters. Then apply the following steps to refine the clusters
  - Calculate correlation of each gene to the centroid (median) of its cluster. Remove the genes if the correlation is less than 0.6
  - Remove clusters with size less than 20% of the expected size (the expected size is 50 if there are 500 genes and 10 clusters)
  - If there are less than 9 (the number of sample groups) clusters left, reduce the height cutoff by 0.05 and repeat this step until there are enough clusters
  - Merge the 2 most similar clusters if the correlation of their centroids is greater than or equal to 0.6. Repeat this step until no 2 clusters are that similar



**12** gene clusters of **797** genes were identified from **2000** seed DEGs.

<div align='center'>
<img src="figure/plot_cluster_mean-1.png" title="plot of chunk plot_cluster_mean" alt="plot of chunk plot_cluster_mean" width="600px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 4.** Color of each block corresponds to the average expression (normalized) of each initial gene cluster in each sample (red = higher).
</div>

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

### Refinement of gene clusters



The gene clusters identified from the DEG seeds were further refined with the following steps: 

  - Select all 3438 genes with p values less than 0.01 to continue
  - Assign selected genes to clusters:
  - Calculate centroid (median expression level of all genes in the cluster) of each cluster
  - Calculate correlation coefficient of each gene to centroid of each cluster to get a 3438 X 11 matrix
  - Assign a gene to a cluster if its correlation coefficient to the cluster is greater than 0.6, and the correlation coefficient to any other cluster is at least 0.1 less
  - Repeat this reclustering steps for 20 times unless the reclustering converged
  - Finally, remove clusters with number of genes less than 13.2833333
  
The reclustering converged after 15 cycles

A total of **999** genes were clustered after refinement. 

<div align='center'>
<img src="figure/plot_recluster_mean-1.png" title="plot of chunk plot_recluster_mean" alt="plot of chunk plot_recluster_mean" width="600px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 5.** Color of each block corresponds to the average expression (normalized) of each refined gene cluster in each sample (red = higher).
</div>



More info:

  - [Original data of clustered genes](table/clustered_data.html) ([download table](table/clustered_data.csv))
  - [Statistic result of clustered genes](table/clustered_stat.html) ([download table](table/clustered_stat.csv))

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

## Analysis of individual clusters

### Summary statistics and visualization of individual clusters



<div style="color:darkblue; padding:0 2cm">
**Table 1** Summary of individual clusters, with the average expression (normalized) of all genes of each cluster in all sample groups. Click on cluster name for visualization of each cluster: 1). the average and standard error of sample averages in each group; 2). hierarchical sample clustering using all genes of the cluster; and 3). heatmap of all genes and samples of the cluster.
</div>

<div align='center', style="padding:0 2cm">


|Cluster                              | Num_Gene| Mean_Breast| Mean_CNS| Mean_Colon| Mean_Blood| Mean_Skin| Mean_Lung| Mean_Ovary| Mean_Prostate| Mean_Kidney|
|:------------------------------------|--------:|-----------:|--------:|----------:|----------:|---------:|---------:|----------:|-------------:|-----------:|
|[Cluster_1](cluster/Cluster_1.pdf)   |       49|      0.4200|   1.6034|    -0.6021|    -0.5307|   -0.3356|    -0.034|     -0.200|        -0.280|      0.1660|
|[Cluster_2](cluster/Cluster_2.pdf)   |      158|     -0.0095|  -0.5146|     1.6276|    -0.2994|   -0.4184|    -0.120|      0.084|         0.036|     -0.2373|
|[Cluster_3](cluster/Cluster_3.pdf)   |      105|     -0.3300|  -0.3727|     0.7720|     1.2038|   -0.5485|    -0.110|     -0.040|         0.014|     -0.2572|
|[Cluster_4](cluster/Cluster_4.pdf)   |      122|     -0.1300|  -0.2931|    -0.0999|     1.8963|   -0.1933|    -0.260|     -0.200|        -0.300|     -0.2459|
|[Cluster_5](cluster/Cluster_5.pdf)   |       21|      0.2300|  -0.0830|     0.7062|     0.8434|   -0.2068|    -0.700|     -0.370|        -0.780|      0.2241|
|[Cluster_6](cluster/Cluster_6.pdf)   |       64|     -0.3900|  -0.4063|     0.3452|     1.2622|    0.4681|    -0.370|     -0.300|        -0.110|     -0.5738|
|[Cluster_7](cluster/Cluster_7.pdf)   |      201|     -0.2800|  -0.2562|    -0.2527|    -0.2524|    1.4544|    -0.330|     -0.330|        -0.290|     -0.3097|
|[Cluster_8](cluster/Cluster_8.pdf)   |       63|     -0.1200|   0.7150|    -0.7674|    -0.7404|    0.9665|    -0.120|     -0.360|        -0.220|      0.0595|
|[Cluster_9](cluster/Cluster_9.pdf)   |      144|      0.1800|   0.4859|    -0.5660|    -1.2392|   -0.3843|     0.260|      0.380|         0.180|      0.7552|
|[Cluster_10](cluster/Cluster_10.pdf) |       29|     -0.3600|   0.0678|     0.0830|     1.2673|   -0.6071|    -0.270|      0.450|        -0.780|      0.0156|
|[Cluster_11](cluster/Cluster_11.pdf) |       43|     -0.3000|  -0.2494|    -0.3515|    -0.4361|   -0.3675|    -0.190|      0.240|        -0.200|      1.5212|


</div>

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

### Gene set enrichment analysis

Find predefined gene sets enriched in gene cluster comparing to the background. 



<div style="color:darkblue; padding:0 2cm">
**Table 2** Numbers of predefined gene sets significantly enriched in each gene cluster. Gene sets were split based on their sources, such as the NCBI BioSystems and KEGG databases. Click on each number to see list of the gene sets. 
</div>

<div align='center', style="padding:0 2cm">


|           |                BioSystems                 |                KEGG                |                MSigDb                 |                PubTator                 |
|:----------|:-----------------------------------------:|:----------------------------------:|:-------------------------------------:|:---------------------------------------:|
|Cluster_1  | [240](cluster/Cluster_1/BioSystems.html)  |  [9](cluster/Cluster_1/KEGG.html)  | [525](cluster/Cluster_1/MSigDb.html)  | [895](cluster/Cluster_1/PubTator.html)  |
|Cluster_2  | [295](cluster/Cluster_2/BioSystems.html)  | [19](cluster/Cluster_2/KEGG.html)  | [393](cluster/Cluster_2/MSigDb.html)  | [191](cluster/Cluster_2/PubTator.html)  |
|Cluster_3  | [480](cluster/Cluster_3/BioSystems.html)  | [19](cluster/Cluster_3/KEGG.html)  | [771](cluster/Cluster_3/MSigDb.html)  | [105](cluster/Cluster_3/PubTator.html)  |
|Cluster_4  | [486](cluster/Cluster_4/BioSystems.html)  | [30](cluster/Cluster_4/KEGG.html)  | [920](cluster/Cluster_4/MSigDb.html)  | [370](cluster/Cluster_4/PubTator.html)  |
|Cluster_5  |  [81](cluster/Cluster_5/BioSystems.html)  |  [9](cluster/Cluster_5/KEGG.html)  |  [39](cluster/Cluster_5/MSigDb.html)  |  [42](cluster/Cluster_5/PubTator.html)  |
|Cluster_6  | [169](cluster/Cluster_6/BioSystems.html)  | [20](cluster/Cluster_6/KEGG.html)  | [294](cluster/Cluster_6/MSigDb.html)  | [143](cluster/Cluster_6/PubTator.html)  |
|Cluster_7  | [392](cluster/Cluster_7/BioSystems.html)  | [34](cluster/Cluster_7/KEGG.html)  | [541](cluster/Cluster_7/MSigDb.html)  | [141](cluster/Cluster_7/PubTator.html)  |
|Cluster_8  | [281](cluster/Cluster_8/BioSystems.html)  |  [9](cluster/Cluster_8/KEGG.html)  | [655](cluster/Cluster_8/MSigDb.html)  | [975](cluster/Cluster_8/PubTator.html)  |
|Cluster_9  | [695](cluster/Cluster_9/BioSystems.html)  | [34](cluster/Cluster_9/KEGG.html)  | [1119](cluster/Cluster_9/MSigDb.html) | [237](cluster/Cluster_9/PubTator.html)  |
|Cluster_10 | [139](cluster/Cluster_10/BioSystems.html) | [10](cluster/Cluster_10/KEGG.html) | [254](cluster/Cluster_10/MSigDb.html) | [209](cluster/Cluster_10/PubTator.html) |
|Cluster_11 | [360](cluster/Cluster_11/BioSystems.html) | [45](cluster/Cluster_11/KEGG.html) | [270](cluster/Cluster_11/MSigDb.html) | [355](cluster/Cluster_11/PubTator.html) |


</div>

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

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

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)_</div>

***
_END OF DOCUMENT_

