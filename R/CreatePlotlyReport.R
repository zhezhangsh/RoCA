# Use this template to create a data analysis report based on an R markdown template
CreatePlotlyReport<-function(yml) {
  # yml     The yaml file or an yaml list defines the inputs and parameters of the analysis
  
  require(knitr);
  require(rmarkdown); 
  require(yaml);
  require(awsomics);
  require(RCurl);
  
  # Load YAML file
  if (is.character(yml[1])) {
    fn.yml<-yml[1]; 
    if (!file.exists(fn.yml)) stop('YAML file: ', fn.yml, ' not found\n'); 
    yml <- yaml::yaml.load_file(fn.yml);  
  } else fn.yml<-NA;
  
  # Output paths
  path<-yml$output;
  GenerateFolder(path); 
  yml$input <- Convert2FullPath(yml$input); # Convert path of input files to full path;

  #################################################################################################################
  # Download or copy Rmarkdown template and YAML file to output path  
  path.tmpl<-yml$template;
  fn.tmpl<-paste(path, TrimPath(path.tmpl), sep='/'); 
  fn.yaml<-paste(RemoveExtension(fn.tmpl), '.yaml', sep='');
  fn.md<-paste(RemoveExtension(fn.tmpl), '.md', sep='');
  
  if (url.exists(path.tmpl)) download.file(path.tmpl, fn.tmpl) else 
    if (file.exists(path.tmpl)) file.copy(path.tmpl, fn.tmpl, overwrite = TRUE) else 
      stop('Rmarkdown template file: ', path.tmpl, ' not found\n'); 
  if (is.na(fn.yml)) writeLines(as.yaml(yml), fn.yaml) else file.copy(fn.yml, fn.yaml, overwrite = TRUE);
  if (file.exists(fn.md)) file.remove(fn.md); 
  #################################################################################################################
  
  # Reset working directory
  wd<-getwd();
  setwd(path); 
  yml$output<-path<-getwd(); 
  
  # Error and warning messages
  roca.message<-list(noError=TRUE);
  roca.warning<-list();
  
  ###########################################################################################
  tryCatch({
    fn.tmpl<-TrimPath(fn.tmpl);
    fn.yaml<-TrimPath(fn.yaml);
    fn.md<-TrimPath(fn.md);
    
    # Run template, save error message
#     roca.message$knit<-try(
#       ################################
#       knitr::knit(fn.tmpl, fn.md), ###
#       ################################
#     silent=TRUE);
#     if (!identical(roca.message$knit, fn.md)) roca.message$noError<-FALSE else
#       roca.message$knit<-paste(getwd(), roca.message$knit, sep='/'); 
    
    # Convert markdown file to html file
    if (roca.message$noError) {
      roca.message$render<-try({
        ###############################################################################################################
        rmarkdown::render(fn.tmpl, output_format="html_document", output_file="index_alone.html", output_dir=getwd(), ###
                          output_options=list('self_contained'=TRUE), quiet=TRUE, envir=new.env());                 ###
        rmarkdown::render(fn.tmpl, output_format="html_document", output_file="index.html", output_dir=getwd(),       ###
                          quiet=TRUE, envir=new.env());                                                             ###
        ###############################################################################################################
      }, silent=TRUE);
    }
    if (!identical(roca.message$render, paste(getwd(), 'index.html', sep='/'))) roca.message$noError<-FALSE; 
    
    # zip whole folder
    if (is.null(yml$zip)) yml$zip<-FALSE;
    if (roca.message$noError & yml$zip) { 
      zipped<-try({
        fld<-TrimPath(path);
        setwd('..'); 
        fn.zip<-paste(fld, '.zip', sep=''); 
        zip(fn.zip, fld, flag='-r0X', zip='zip'); 
        file.rename(fn.zip, paste(fld, fn.zip, sep='/')); 
      }, silent=TRUE);
      if (!zipped) roca.warning$zip<-'output files not zipped successfully!'
    }

  }, error = function(err) {
    roca.message$noError<-FALSE;
    roca.message$other<-err;
  }, finally = {
    setwd(wd);
  }); 
  ###########################################################################################

  cat('##############################################################################################\n\n');
  if (roca.message$noError) {
    cat('Report has been successfully generated, and saved to:\n'); 
    cat(path, '\n');
    cat('Open the "index.html" file in this folder to read the report.\n'); 
  } else {
    cat('Report generation failed.\n');
    cat('Error(s) happended during:', names(roca.message)[length(roca.message)], '\n');
    cat('Error message:', roca.message[[length(roca.message)]], '\n'); 
  }
  cat('\n##############################################################################################\n');
  if (length(roca.warning) > 0) sapply(roca.warning, function(w) cat('Extra warning:', w, '\n')); 
  
  invisible(list(output=path, message=roca.message)); 
}
