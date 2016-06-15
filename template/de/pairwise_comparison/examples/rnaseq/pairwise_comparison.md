---
title: "Two-group differential gene expression"
author: "Zhe Zhang"
date: "2016-06-15"
output:
  html_document:
    number_sections: yes
    self_contained: no
    toc: yes
    toc_float:
      collapsed: no
---

<div style="border:black 1px solid; padding: 0.5cm 0.5cm">
**Introduction** This procedure performs a two-group comparison of all genes in a transcriptome data set. It accepts both signal intensities from microarray and read counts from RNA-seq. All genes must be annotated with NCBI [Entrez](http://www.ncbi.nlm.nih.gov/gene) unique gene IDs. The main elements of this procedure include:

  - Sample-level analysis
    - Overall distribution of gene expression level and between-sample variance
    - Sample similarity evaluated via sample-sample correlation, hierarchical clustering and principal components analysis
  - Gene-level analysis
    - Statistical test of group means on each genes. Call DeWrapper() to find available statistical tests, such as [Significance Analysis of Microarrays](http://statweb.stanford.edu/~tibs/SAM/) for microarray data and [edgeR](http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2796818/) for RNA-seq read count data
    - Visualization of differential gene expression through M-A plot, Volcano plot, heatmap, etc.
    - Selection of top-ranked differentially expressed genes (DEGs)
  - Gene set-level analysis
    - Over-representation analysis (ORA)
    - [Gene set enrichment analysis (GSEA)](http://software.broadinstitute.org/gsea/index.jsp)
    - Visualization of [KEGG pathway](http://www.genome.jp/kegg/pathway.html) maps
    - Gene-gene set biclustering
    
</div>

&nbsp;



























































