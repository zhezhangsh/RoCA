# Install packages required by the RoCA package
InstallDependency<-function(packages=NA, reinstall=FALSE, cran=TRUE, bioc=TRUE, github=TRUE, lib=.libPaths()[1],
                            list.source='https://raw.githubusercontent.com/zhezhangsh/RoCA/master/document/packages.txt') {
  # packages    Name of packages to be installed. All listed packages from source if no package names were given
  # reinstall   Whether to reinstall packages if they already existed in library path
  # cran        Whether to install Cran packages
  # bioc        Whether to install Bioconductor packages
  # github      Whether to install GitHub packages
  # list.source Source (coulbe be an URL) of a tab-delimited file with 3 fields: package source, package name, and package source URL.
  
  require('devtools'); 

  cat('Running ', version$version.string, '. Required version: 3.2.2\n');
  cat('Installing default packages depended by RoCA:\n');
    
  installed <- rownames(installed.packages());
  
  packages <- packages[!is.na(packages)];
  
  # split package URLs by source
  pkgs <- read.table(list.source, stringsAsFactors = FALSE);
  url <- pkgs[, 3]; 
  names(url) <- pkgs[, 2];
  pkgs <- split(url, pkgs[, 1]); 
  if (length(packages) > 0) pkgs <- lapply(pkgs, function(p) p[p %in% packages]); 
  
  out <- list();
  
  ##########################################################################################
  # Download packages from CRAN
  if (cran) {
    cat('\nInstalling CRAN packages ...\n'); 
    out$cran <- sapply(names(pkgs[['cran']]), function(nm) {
      cat('Installing package:', nm, '\n'); 
      if (reinstall | !is.element(nm, installed)) install_url(pkgs[['cran']][nm], quiet=TRUE, lib=lib) else NA; 
    });
    names(out$cran) <- names(pkgs[['cran']]); 
  }
 
  ##########################################################################################
  # Download packages from github
  if (bioc) {
    cat('\nInstalling Bioconductor packages ...\n'); 
    out$bioc <- sapply(names(pkgs[['bioc']]), function(nm) {
      cat('Installing package:', nm, '\n'); 
      if (reinstall | !is.element(nm, installed)) install_url(pkgs[['bioc']][nm], quiet=TRUE, lib=lib) else NA; 
    });
    names(out$bioc) <- names(pkgs[['bioc']]); 
  }

  ##########################################################################################
  # Download packages from github
  if (github) {
    cat('\nInstalling GitHub packages ...\n'); 
    out$github <- sapply(names(pkgs[['github']]), function(nm) {
      cat('Installing package:', nm, '\n'); 
      if (reinstall | !is.element(nm, installed)) install_github(pkgs[['github']][nm], quiet=TRUE, lib=lib) else NA; 
    });
    names(out$github) <- names(pkgs[['github']]); 
  }
  
  out;
}

