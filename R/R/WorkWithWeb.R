# Download a file via URL to a given directory and return the path to the downloade file
DownloadFile<-function(url, path, check.existence=TRUE) {
  # url               The URL to the file to be downloaded
  # path              The path where to save the downloaded file
  # check.existence   Check if the URL exists before downloading. If the URL not exists, return the URL without any effect.
  
  require(RCurl);
  require(awsomics);
  require(RoCA);
  
  if (check.existence & !url.exists(url)) url else {
    if (!dir.exists(path)) dir.create(path, recursive = TRUE);
    fn <- paste(path, TrimPath(url), sep='/'); 
    download.file(url, fn); 
    fn; 
  } 
}
