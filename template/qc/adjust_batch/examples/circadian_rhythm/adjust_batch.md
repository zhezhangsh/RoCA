---
title: "Analysis and adjustment of batch effect"
author: "Zhe Zhang"
date: "2016-05-11"
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

  - Analyst provides the original data matrix and sample description with one or multiple features, and specifies
    - one or multiple features as variable(s) of interest
    - zero or one feature known to cause batch or other confounding effect
  - One to several surrogate variables will be identified from the original matrix, each accounts for a portion of the total data variation
    - The association between each sample feature and surrogate variable will be evaluated by ANOVA (categoral feature) or Pearson's correlation (numeric feature)
    - Samples are grouped by variable(s) of interest. P values of 1-way ANOVA across all sample groups is obtained for each gene, using the original data matrix or the data matrix adjusted by surrogate variables. 
  - Create an adjusted data matrix from the original one by removing known or potential batch effect.
    - A new data matrix is generated after adjusting the original ones for the sample feature known to cause the confoundering or batch effect. The ***[ComBat](combat batch effect correction)*** and ***[limma](http://bioinf.wehi.edu.au/limma/)*** methods will be used respectively for categoral and numeric variables. Adjust data for surrogate variable(s) instead if no sample feature is known to cause batch effect.
    - P values of 1-way ANOVA are compared between the original and the adjusted data matrix.
  - Adjust the data matrix by sample features and surrogate variables one by one and compare the ANOVA p values.
</div>

&nbsp;



<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Description

## Project


Perturbed rhythmic activation of signaling pathways in mice deficient for Sterol Carrier Protein 2-dependent diurnal lipid transport and metabolism. (**[GSE67426](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67426)**)


## PubMed


Jouffe C, Gobet C, Martin E, Métairon S et al. Perturbed rhythmic activation of signaling pathways in mice deficient for Sterol Carrier Protein 2-dependent diurnal lipid transport and metabolism. Sci Rep 2016 Apr 21;6:24631. PMID: [27097688](http://www.ncbi.nlm.nih.gov/pubmed/27097688).


## Experimental design


Comparison of liver mRNA expression from Scp2 KO and wild-type mice harvested every 2 hours during 3 consecutive days.


## Analysis


This analysis evaluates the potential batch effect of different days, a sample feature named ***Replicate***, on which the mice were harvested.



<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Samples and variable(s) of interest



A total of 36 samples and 3 sample features was provided by the input data. Click [here](html/sample.html) to see a full list of samples and samples features. 

  - Sample feature(s) to be studied by this project (variables of interest): ***Genotype; Hour***
  - Sample feature with potential batch effect: ***Replicate***
  - All other known sample feature(s): ****** 

<div style="color:darkblue; padding:0 2cm">
**Table 1** All sample features provided by the input data, which could include 1 or many variables of interest and 0 or 1 confounding variable known to be responsible for the batch effect in data. (**Sample_feature:** all sample features given in the input data; **Num_level:** number of unique values of each sample feature; **Variable_of_interest:** whether this sample feature is a variable of interest in this project; and **Batch_effect** whether this sample feature is a known source of batch effect)
</div>

<div align='center', style="padding:0 2cm">


| Sample_feature |  Type   | Num_level | Variable_of_interest | Batch_effect |
|:--------------:|:-------:|:---------:|:--------------------:|:------------:|
|    Genotype    | factor  |     1     |         TRUE         |    FALSE     |
|   Replicate    | factor  |     3     |        FALSE         |     TRUE     |
|      Hour      | integer |    12     |         TRUE         |    FALSE     |


</div>

<div align='right'>_[Go to project home](http://zhezhangsh.github.io/RoCA)_</div>

# Identification and evaluation of surrogate variables 















