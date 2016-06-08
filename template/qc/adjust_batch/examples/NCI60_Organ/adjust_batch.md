---
title: "Analysis and adjustment of batch effect"
author: "Zhe Zhang"
date: "2016-06-07"
output:
  html_document:
    self_contained: no
    number_sections: yes
    toc: yes
    toc_float:
      collapsed: no
---

<div style="border:black 1px solid; padding: 0.5cm 0.5cm">
**Introduction: ** This analysis applies the Bioconductor ***[SVA](https://bioconductor.org/packages/release/bioc/html/sva.html)*** (Surrogate Variable Analysis) package and other methods to evaluate and adjust for known or unknown batch effect. It includes the following steps:

  - This analysis requires an original data matrix and sample description with one or multiple features, and parameters including
    * One or multiple features as variable(s) of interest
    * Zero or one feature known to be the source of batch effect
    * The number of surrogate variables (default=5) to be identified from the data matrix
  - The _sva_ function will first identify the given number of surrogate variables, each accounting for a portion of the total data variation. These surrogate variables will be evaluated as below. 
    * The association between each sample feature and each surrogate variable will be evaluated by ANOVA (categoral feature) or Pearson's correlation (numeric feature)
    * By grouping samples according variable(s) of interest, 2 sets of 1-way ANOVA p values, using the data matrix and the matrix adjusted for all surrogate variables, will be compared to evaluate whether removing potential batch effect will improve the signal/noise ratio in the data set. 
  - A new data matrix will be generated after adjusting for batch effect. 
    * If a sample feature is known to be the source of batch effect, the original matrix will be adjusted for it using  ***[ComBat](combat batch effect correction)*** (categoral variable) or ***[limma](http://bioinf.wehi.edu.au/limma/)*** (continuous variable). It will be adjusted for all surrogate variables instead otherwise.
    * Same as the last step, the impact of data adjustment will be evaluated with 1-way ANOVA of samples grouped by variable(s) of interest.
  - An extra step will be carried out to adjust the original data matrix for all sample features and surrogate variables one by one, and evaluate the consequence. 
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


Evaluate and adjust batch effect of p53 status. Only a subset of genes with high between-sample variance was used as a demo.



<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Samples and variable(s) of interest



A total of 60 samples and 3 sample features was provided by the input data. Click [here](html/sample.html) to see a full list of samples and samples features. 

  - Sample feature(s) to be studied by this project (variables of interest): ***Organ***
  - Sample feature with potential batch effect: ***p53_Status***
  - All other known sample feature(s): ***Sex*** 

<div style="color:darkblue; padding:0 2cm">
**Table 1** All sample features provided by the input data, which could include 1 or many variables of interest and 0 or 1 confounding variable known to be responsible for the batch effect in data. (**Sample_feature:** all sample features given in the input data; **Num_level:** number of unique values of each sample feature; **Variable_of_interest:** whether this sample feature is a variable of interest in this project; and **Batch_effect** whether this sample feature is a known source of batch effect)
</div>

<div align='center', style="padding:0 2cm">


| Sample_feature |  Type  | Num_level | Variable_of_interest | Batch_effect |
|:--------------:|:------:|:---------:|:--------------------:|:------------:|
|     Organ      | factor |     9     |         TRUE         |    FALSE     |
|      Sex       | factor |     3     |        FALSE         |    FALSE     |
|   p53_Status   | factor |     3     |        FALSE         |     TRUE     |


</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Identification and evaluation of surrogate variables 



The _sva()_ function was used to identify  surrogate variables from the original data matrix. Each surrogate variable is responsible for part of the overall data variation, and may or may not be related to known sample features, such as any variables of interest or experiment batch. Since each sample was assigned a value of each surrogate variable by the _sva_ function, these values were used to evaluate the association between surrogate variables and sample features using ANOVA for categoral variables or Pearson's correlation for numeric variables.

<div style="color:darkblue; padding:0 2cm">
**Table 2** ANOVA p value for the association between surrogate variables and sample features. 
</div>

<div align='center', style="padding:0 1cm">


|           | SV1  |  SV2  |  SV3  | SV4  |  SV5  |
|:----------|:----:|:-----:|:-----:|:----:|:-----:|
|Organ      | 0.00 | 0.000 | 0.000 | 0.07 | 0.029 |
|Sex        | 0.56 | 0.096 | 0.052 | 0.69 | 0.620 |
|p53_Status | 0.79 | 0.089 | 0.850 | 0.61 | 0.810 |


</div>

The _f.pvalue()_ function was used to run ANOVA tests using the variable(s) of interest and original data matrix, so each gene got an ANOVA p value. The test was then run again after adjusting the data matrix for surrogate variables that were not significantly associated with the surrogate variables (p < 0.01). The goal is to evaluate if the global statistical power was improved after the confounding effect of surrogate variables was removed.

<div align='center'>
<img src="figure/p_value_surrogate-1.png" title="plot of chunk p_value_surrogate" alt="plot of chunk p_value_surrogate" width="640px" />
</div>

<div style="color:darkblue; padding:0 2cm">
**Figure 1.** Comparison of the ANOVA p values obtained using the original data matrix and the matrix adjusted by surrogate variables not significantly associated with any variable(s) of interest. 
</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Adjust data for batch effect



Since sample feature, _p53_Status_, was known to cause batch effect in the data, the original data matrix was then adjusted to remove its effect using the [_ComBat_](http://biostatistics.oxfordjournals.org/content/8/1/118.abstract) method if it is a categoral variable or the limma method if it is a numerical variable



<div align='center'> 
<img src="figure/p_value_adj-1.png" title="plot of chunk p_value_adj" alt="plot of chunk p_value_adj" width="640px" />
</div>

<div style="color:darkblue; padding:0 2cm">
**Figure 2.** Same plot as **Figure 1**, except that the y-axis p values were based on the data adjusted by the known batch effect variable using the _ComBat_ (categoral) or _limma_ (numeric) method.
</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Evaluate all variables

Finally, the confounding or batch effect of all sample features and surrogate variables was evaluated one by one, after removing it from the original data matrix. 



<div align='center'>
<img src="figure/all_variable_top_ratio-1.png" title="plot of chunk all_variable_top_ratio" alt="plot of chunk all_variable_top_ratio" width="480px" />
</div>

<div style="color:darkblue; padding:0 2cm">
**Figure 3.** After adjusting the original data for each of the sample features or surrogate variables, ANOVA p values were calculated again for each gene. The numbers of significant genes obtaining from each adjusted data matrix were compared to the numbers of genes obtained from the original matrix. The color in this plot represents relative frequency of genes (red = more). Clcik [here](table/gene_count_adjusted.html) to view table of gene counts.
</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

***

# Appendix 

Check out the **[RoCA home page](http://zhezhangsh.github.io/RoCA)** for more information.  

## Reproduce this report

To reproduce this report: 

1. Find the data analysis template you want to use and an example of its pairing YAML file  [here](https://github.com/zhezhangsh/RoCA/wiki/Templates-and-examples) and download the YAML example to your working directory

2. To generate a new report using your own input data and parameter, edit the following items in the YAML file:

- _output_        : where you want to put the output files
- _home_          : the URL if you have a home page for your project
- _analyst_       : your name
- _description_   : background information about your project, analysis, etc.
- _input_         : where are your input data, read instruction for preparing them
- _parameter_     : parameters for this analysis; read instruction about how to prepare input data

3. Run the code below within ***R Console*** or ***RStudio***, preferablly with a new R session:


```r
if (!require(devtools)) { install.packages('devtools'); require(devtools); }
if (!require(RCurl)) { install.packages('RCurl'); require(RCurl); }
if (!require(RoCA)) { install_github('zhezhangsh/RoCAR'); require(RoCA); }

CreateReport(filename.yaml);  # filename.yaml is the YAML file you just downloaded and edited for your analysis
```

If there is no complaint, go to the _output_ folder and open the ***index.html*** file to view report. 

## Session information


```
## R version 3.2.2 (2015-08-14)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## Running under: OS X 10.10.5 (Yosemite)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
##  [1] splines   stats4    parallel  stats     graphics  grDevices utils    
##  [8] datasets  methods   base     
## 
## other attached packages:
##  [1] sva_3.18.0           genefilter_1.50.0    mgcv_1.8-7          
##  [4] nlme_3.1-121         CHOPseq_0.0.0.9000   Agri_0.0.0.9000     
##  [7] edgeR_3.10.2         limma_3.26.9         NOISeq_2.16.0       
## [10] GenomicRanges_1.22.4 GenomeInfoDb_1.6.3   IRanges_2.4.8       
## [13] S4Vectors_0.8.11     Biobase_2.28.0       BiocGenerics_0.16.1 
## [16] Matrix_1.2-2         vioplot_0.2          sm_2.2-5.4          
## [19] rchive_0.0.0.9000    htmlwidgets_0.5      DT_0.1              
## [22] GtUtility_0.0.0.9000 gplots_3.0.1         awsomics_0.0.0.9000 
## [25] yaml_2.1.13          rmarkdown_0.9.6      knitr_1.12.3        
## [28] RoCA_0.0.0.9000      RCurl_1.95-4.8       bitops_1.0-6        
## [31] devtools_1.11.1     
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.4          XVector_0.10.0       formatR_1.3         
##  [4] highr_0.5.1          zlibbioc_1.14.0      tools_3.2.2         
##  [7] digest_0.6.9         annotate_1.46.1      lattice_0.20-33     
## [10] jsonlite_0.9.20      evaluate_0.9         memoise_1.0.0       
## [13] RSQLite_1.0.0        DBI_0.3.1            withr_1.0.1         
## [16] stringr_1.0.0        gtools_3.5.0         caTools_1.17.1      
## [19] grid_3.2.2           AnnotationDbi_1.32.3 survival_2.38-3     
## [22] XML_3.98-1.3         gdata_2.17.0         magrittr_1.5        
## [25] htmltools_0.3.5      xtable_1.7-4         KernSmooth_2.23-15  
## [28] stringi_1.0-1
```

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

***
**END OF DOCUMENT**

