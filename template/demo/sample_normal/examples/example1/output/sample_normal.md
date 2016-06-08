---
title: "Random sampling of a normal distribution"
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

**Introduction** This is a procedure that randomly generates a vector of _X_ values following a normal distribution, with given mean and standard deviation.



# Description



## Project


Reporting of customized workflow (RoCA)


## Analysis


This is a demo of the RoCA framework that generates random values with normal distribution.



# Sampling

## Summary statistics



<div align='center'>**Table 1** Sampling results: expected vs. actual mean and standard deviation</div>

|              | Length   | Mean    | Standard deviation |
|:-------------|---------:|--------:|-------------------:|                  
| **Expected** | 1000 | 20 | 2            |
| **Actual**   | 1000 | 19.986431 | 2.0358734            |



```
Summary statistics:
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  13.73   18.56   19.98   19.99   21.37   26.13 

	Shapiro-Wilk normality test

data:  v
W = 0.9988, p-value = 0.7556
```

## Plot distribution

<div align='center'>
<img src="figure/distribution-1.png" title="plot of chunk distribution" alt="plot of chunk distribution" width="600px" />
</div>

**Figure 1** This figure compares the expected data distribution with given mean and standard deviation (grey) and actual distribution of sampled data vector (blue line). 

## Outputs



The output folder, <**output**>, includes the following files: 

  - **sample_normal.Rmd**: The Rmarkdown file that generates this report
  - **sample_normal.yml**: The Yaml configuration file that specifies this run
  - **index.html**: The Html index file of this report
  - **vector.rds**: The randomly generated values saved as an R vector
  - **vector.csv**: The randomly generated values saved as text file

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

***
**END_OF_DOCUMENT**
