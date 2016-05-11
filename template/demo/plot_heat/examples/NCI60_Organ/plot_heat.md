---
title: "Select variables to plot a heatmap"
author: "Jim Zhang"
date: "2016-05-06"
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
  - 4916 total variables
    * there are no variables including missing values.



<div style="color:darkblue; padding:0 3cm">
**Table 1.** The mean, standard deviation, and range of all variables.
</div>

<div align='center', style="padding:0 3cm">


|      |  Min.  | 1st Qu. | Median |  Mean  | 3rd Qu. |  Max.  |
|:-----|:------:|:-------:|:------:|:------:|:-------:|:------:|
|Mean  | 2.1850 | 4.1790  | 5.518  | 5.6010 | 6.8470  | 12.160 |
|SD    | 0.2538 | 0.4567  | 0.551  | 0.6414 | 0.7145  | 3.108  |
|Range | 2.0000 | 2.3300  | 2.780  | 3.1570 | 3.6300  | 8.840  |


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

As a result, **453** variables were selected. Click [here](table/selected.html) to view these variables.

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
_END OF DOCUMENT_
