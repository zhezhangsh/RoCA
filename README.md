
### ***RoCA*** 
***R***eporting ***o***f ***C***ustom ***A***nalysis

The goal of RoCA is to set up a paradigm of reproducible data analysis. It provides a framework for data analysts to conveniently re-run custom analysis using their own data and parameters. Each run will generates a self-contained output file folder and an _index.html_ file as a summary report. 

[Download an example](https://github.com/zhezhangsh/RoCA/blob/master/template/demo/plot_heat/examples/circadian_rhythm.zip?raw=true) (unzip the file and open the index.html file to view report)

---

<a name="toc"/>
##### Table of contents
  - [How to use](#howto)
    * [Install R packages](#installR)
    * [Prepare for an analysis](#prepare)
    * [Generate a report](#report)
  - [Develop a template](#develop)

---

<a name="howto"/>
## How to use

<a name='installR'/>
### Install R packages

Use the code below to install default R packages. Please note that individual R Markdown templates might require extra packages. Read instruction of each template for details. Before start,

  - make sure that base R version _3.2.3_ or newer was installed through **RStudio** or **R Console**
  - and open **RStudio** or **R Console** to start a new R session.

```

# install.packages(c('devtools', 'RCurl')); # if packages have not been installed
require(devtools); 
require(RCurl);

devtools::install_github("zhezhangsh/RoCA/R"); # Install the RoCA package itself from GitHub

# Install default packages from Cran, GitHub, or Bioconductor, used by the RoCA package and Rmarkdown templates
# Note that individual Rmarkdown templates might require more packages
installed <- RoCA::InstallDependency(reinstall=FALSE) # Use reinstall=TRUE to force re-installing all packages
```

<a name='prepare'/>
### Prepare for an analysis

1. Clone the whole RoCA GitHub repo
 
2. Download and edit a YAML file

<a name='report'/>
### Generate a report

1. Use the RoCA::CreateReport() function

2. Use RStudio

3. Use the knitr::knit() function

_<div align='right'><a href='#toc'>back to top</a></div>_

<a name='develop'/>
## Develop a template

### R Markdown in a nutshell

### The R Markdown/YAML pair

### Required YAML fields

_<div align='right'><a href='#toc'>back to top</a></div>_
