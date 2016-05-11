# Convert file path to full path
# Do nothing if file name is an URL
Convert2FullPath<-function(fns) {
  # fns    File names of input files as a character vector or list
  require(RCurl);
  
  cnvrt.file<-function(fn) { # helper function
    if (url.exists(fn)) fn else {
      f<-c(paste(getwd(), fn, sep='/'), fn); 
      f<-f[file.exists(f)][1]; 
      if (is.na(f)) stop('File of input data not found: ', fn, '\n'); 
      f; 
    }
  }
  
  if (is.character(fns)) {
    f<-sapply(fns, cnvrt.file)
  } else if (length(fns)>0) {
    fn.unlist<-unlist(as.relistable(fns));
    fn.unlist[1:length(fn.unlist)]<-sapply(fn.unlist, cnvrt.file); 
    f<-relist(fn.unlist);
  } else f<-fns;
  
  f;
}

# Create folder and default subfolders for output files
# Use this function to create default subfolers. Different templates could create their own.
GenerateFolder<-function(path, subfolder=c('input', 'R', 'figure', 'table')) {
  # path      Home folder of all output files
  # subfoler  Subfolder to be created
  
  f<-c(path, paste(path, subfolder, sep='/'));
  sapply(f, function(f) if (!dir.exists(f)) dir.create(f, recursive = TRUE))->x;
  names(f)<-c('', subfolder);  
  
  invisible(f); 
}

# Write the description section in markdown format, using the information provided by the YAML file 
WriteDescription<-function(desc) {
  # desc  A named list of character element, each will be written as a subsection
  
  lns<-lapply(names(desc), function(nm) {
    c(paste('##', nm), '\n', desc[[nm]], '\n'); 
  });
  
  paste(do.call('c', lns), collapse='\n'); 
}

# Create a markdown line with a link to the project home
Link2Home<-function(url) {
  if (is.null(url)) home.url<-'' else 
    home.url<-paste("<div align='right'>_[Go to project home](", url, ")_</div>", sep='');
}