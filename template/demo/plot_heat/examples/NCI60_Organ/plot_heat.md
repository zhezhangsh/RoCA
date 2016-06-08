---
title: "Select variables to plot a heatmap"
author: "Jim Zhang"
date: "2016-06-07"
output:
  html_document:
    number_sections: yes
    self_contained: no
    toc: yes
    toc_float:
      collapsed: no
---


<div style="border:black 1px solid; padding: 0.5cm 0.5cm">
**Introduction** This analysis runs a simple procedure that identifies variables significantly different across sample groups via ANOVA and then plots a heatmap of these variables.
</div>

&nbsp;





<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)_</div>

# Description

## Project


Comparison between cell lines from 9 different cancer tissues (NCI-60); **[GSE5949](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE5949)**


## PubMed


Reinhold WC, Reimers MA, Lorenzi P, Ho J et al. **Multifactorial regulation of E-cadherin expression: an integrative study.** Mol Cancer Ther 2010 Jan;9(1):1-16. PMID: [20053763](http://www.ncbi.nlm.nih.gov/pubmed/20053763).


## Experimental design


Comparison between cell lines from 9 different cancer tissue of origin types (Breast, Central Nervous System, Colon, Leukemia, Melanoma, Non-Small Cell Lung, Ovarian, Prostate, Renal) from NCI-60 panel


## Analysis


Cluster genes co-expressed acroo 9 tissues/organs



<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)_</div>

# Summary statistics



The input data matrix has

  - 9 sample groups
  - 60 total samples
  - 3105 total variables
    * there are no variables including missing values.



<div style="color:darkblue; padding:0 3cm">
**Table 1.** The mean, standard deviation, and range of all variables.
</div>

<div align='center', style="padding:0 3cm">


|      | Min.  | 1st Qu. | Median |  Mean  | 3rd Qu. |  Max.  |
|:-----|:-----:|:-------:|:------:|:------:|:-------:|:------:|
|Mean  | 2.274 | 4.3560  | 5.6260 | 5.6820 | 6.8810  | 12.160 |
|SD    | 0.500 | 0.5625  | 0.6536 | 0.7684 | 0.8506  | 3.108  |
|Range | 2.010 | 2.7500  | 3.2900 | 3.6180 | 4.2000  | 8.840  |


</div>

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)_</div>

# Variable selection

## Run ANOVA



Run 1-way ANOVA on each variable to identify those significantly different across all sample groups.

<div align='center'>
<img src="figure/hist_p-1.png" title="plot of chunk hist_p" alt="plot of chunk hist_p" width="480px" />
</div>

<div style="color:darkblue; padding:0 3cm">
**Figure 1.** Distribution of ANOVA p values. Number of variables with p values within each 0.01 interval.
</div>

## Select variables



Significant variables were selected using the following criteria:

  - Select variables with ANOVA p values less than **10<sup>-5</sup>**
  - Stop if the number of remaining variables is between **100** and **2000**, else
    * if the number remaining variable is less than 100, select the top 100 variables with the smallest p values
    * if the number remaining variable is greater than 2000, select the top 2000 variables with the smallest p values

As a result, **396** variables were selected. Click [here](table/selected.html) to view these variables.

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)_</div>

# Heatmap



<div align='center'>
<img src="figure/heatmap-1.png" title="plot of chunk heatmap" alt="plot of chunk heatmap" width="720px" />
</div>

<div style="color:darkblue; padding:0 2cm">
**Figure 2.** Color-coded data of selected variables different across sample groups (red = higher). Variables (rows) were clustered based on their correlation to each other and samples were arranged by groups.
</div>

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)_</div>

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
##  [1] CHOPseq_0.0.0.9000   Agri_0.0.0.9000      edgeR_3.10.2        
##  [4] limma_3.26.9         NOISeq_2.16.0        GenomicRanges_1.22.4
##  [7] GenomeInfoDb_1.6.3   IRanges_2.4.8        S4Vectors_0.8.11    
## [10] Biobase_2.28.0       BiocGenerics_0.16.1  Matrix_1.2-2        
## [13] vioplot_0.2          sm_2.2-5.4           rchive_0.0.0.9000   
## [16] htmlwidgets_0.5      DT_0.1               GtUtility_0.0.0.9000
## [19] gplots_3.0.1         awsomics_0.0.0.9000  yaml_2.1.13         
## [22] rmarkdown_0.9.6      knitr_1.12.3         RoCA_0.0.0.9000     
## [25] RCurl_1.95-4.8       bitops_1.0-6         devtools_1.11.1     
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.12.4          XVector_0.10.0       formatR_1.3         
##  [4] highr_0.5.1          zlibbioc_1.14.0      tools_3.2.2         
##  [7] digest_0.6.9         lattice_0.20-33      jsonlite_0.9.20     
## [10] evaluate_0.9         memoise_1.0.0        RSQLite_1.0.0       
## [13] DBI_0.3.1            withr_1.0.1          stringr_1.0.0       
## [16] gtools_3.5.0         caTools_1.17.1       grid_3.2.2          
## [19] AnnotationDbi_1.32.3 gdata_2.17.0         magrittr_1.5        
## [22] htmltools_0.3.5      KernSmooth_2.23-15   stringi_1.0-1
```

<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)_</div>

***
_END OF DOCUMENT_
