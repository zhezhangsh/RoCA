---
title: "Select variables to plot a heatmap"
author: "Jim Zhang"
date: "2016-05-09"
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


Perturbed rhythmic activation of signaling pathways in mice deficient for Sterol Carrier Protein 2-dependent diurnal lipid transport and metabolism. (**[GSE67426](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)**)


## PubMed


Jouffe C, Gobet C, Martin E, Métairon S et al. ***Perturbed rhythmic activation of signaling pathways in mice deficient for Sterol Carrier Protein 2-dependent diurnal lipid transport and metabolism.*** Sci Rep 2016 Apr 21;6:24631. PMID: [27097688](http://www.ncbi.nlm.nih.gov/pubmed/27097688).


## Experimental design


Comparison of liver mRNA expression from Scp2 KO and wild-type mice harvested every 2 hours during 3 consecutive days.


## Analysis


Circadian rhythm in mouse liver, wild type mice only, 3 replicates every 2 hours (12 groups). Each gene was adjusted to its 0 hour mean and rescaled to make its standard deviation equal to 0.



<div align='right'>_[Go to project home](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)_</div>

# Summary statistics



The input data matrix has

  - 12 sample groups
  - 36 total samples
  - 12065 total variables
    * there are no variables including missing values.



<div style="color:darkblue; padding:0 3cm">
**Table 1.** The mean, standard deviation, and range of all variables.
</div>

<div align='center', style="padding:0 3cm">


|      |  Min.  | 1st Qu. |  Median   |   Mean   | 3rd Qu. | Max.  |
|:-----|:------:|:-------:|:---------:|:--------:|:-------:|:-----:|
|Mean  | -1.982 | -0.4139 | -0.009352 | -0.02012 | 0.3797  | 1.970 |
|SD    | 1.000  | 1.0000  | 1.000000  | 1.00000  | 1.0000  | 1.000 |
|Range | 2.752  | 3.9950  | 4.318000  | 4.39400  | 4.7100  | 6.938 |


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

  - Select variables with ANOVA p values less than **0.001**
  - Stop if the number of remaining variables is between **50** and **500**, else
    * if the number remaining variable is less than 50, select the top 50 variables with the smallest p values
    * if the number remaining variable is greater than 500, select the top 500 variables with the smallest p values

As a result, **500** variables were selected. Click [here](table/selected.html) to view these variables.

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
