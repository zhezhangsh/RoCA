# Format input data

Properly formatting input data is THE most critical step to generate an RoCA report. In principal, the acceptable input data should be template-specific as each R Markdown template will import data from files specified in the YAML file and check the validity of input data during runtime. Therefore, the developers of each template should provide sufficient information about the input data. It is strongly recommended for developers to:

  - describe the requirements of input data at the beginning of the YAML file, such as
    - file type: Excel, txt, etc.
    - variable type: character, numeric, etc.
    - ID type of row names: gene symbol, Entrez ID, etc.
    - matching names, such as sample names vs. column names of data matrix
    - is missing value allowed?
  - provide sample data known to be acceptable to template
  - handle ill-formatted data properly within the R Markdown template
  
To reduce the burden of preparing and importing input data, the ***RoCA*** package also provides support to several common data formats as described below.

## Import data from local files in supported formats 

RoCA provides helper functions to import several common data types formatted as described below. The helper functions assume that data is saved in a local file, do not support importing data from a remote file yet. 

### Table-like data

The table-like data supported by RoCA must meet the following requirements:

  - The first column must be unique row names.
  - The first row must be unique column names. 
  - Each column is a character or numeric vector.  
  - Columns are separated by default separator: ',' for _.csv_ and '\t' for _.txt_ and _.tab_ files

The ***ImportTable {RoCA}*** function can be used to import table-like data saved in any of the following file types. It determines file types based on known file extensions, such as _.txt_ and _.html_, so users have the flexibility to import the files at their convenience. File extensions are case insensitive, and the first row/column is the unique column/row names in all text, Excel, and html file by default.

  - **R file** (_.rdata_, _.rda_, _.rds_): could be a _matrix_ or _data.frame_
  - **Tab separated text file** (_.txt_, _.tab_): with '\t' as separator by default
  - **Comma separated text file** (_.csv_): with ',' as separator by default
  - **Excel file** (_.xls_, _s.xlsx_): import the first worksheet by default
  - **HTML file** (_.html_, _.htm_): import the first table on the html page by default

### List-like data

RoCA supports list-like data saved in Excel or text files as long as they meet the following requirements. However, it should be noted that neither Excel nor text file is recommended options for storing list-like data.

  - The list has only one level
  - There is no header line unless it is commented out
  - First value of each row is the element name
  - In text files, values are separated by default separator: ',' for _.csv_ and '\t' for _.txt_ and _.tab_ files

The ***ImportList {RoCA}*** function can be used to import list-like data saved in any of the following file types. It determines file types based on known file extensions, such as _.txt_ and _.rdata_, so users have the flexibility to import the files at their convenience. File extensions are case insensitive, and the first value of each row is the element name in all text and Excel files by default.

  - **R file** (_.rdata_, _.rda, _.rds_): will be loaded as the way it was saved
  - **Tab separated text file** (_.txt_, _.tab_, _.bed_): with '\t' as separator and first value is element name by default
  - **Comma separated text file** (_.csv_): with ',' as separator and first value is element name by default
  - **Excel file** (_.xls_, _s.xlsx_): import the first worksheet and first column is element name by default
  - **HTML file** (_.html_, _.htm_): import the first list on the html page by default
  - **YAML file** (_.yaml_, _.yml_): could have multiple levels
  - **JSON file** (_.json_): could have multiple levels

### Vector-like data

RoCA supports vector-like data saved in Excel or text files as long as they meet the following requirements.

  - There is no header line unless it is commented out
  - If the file has a single row or single column, it will be imported as a nameless vector; if the file has at least 2 columns, the first column will be used as element names and the seconde column will be used as element values.
  - In text files, values are separated by default separator: ',' for _.csv_ and '\t' for _.txt_ and _.tab_ files

The ***ImportVector {RoCA}*** function can be used to import vector-like data saved in any of the following file types. It determines file types based on known file extensions, such as _.txt_ and _.rdata_, so users have the flexibility to import the files at their convenience. File extensions are case insensitive. Imported data will be a nameless vector if the Excel or text file has a single column or row. The vector will be named using the first column if the file has 2 columns, and the second column will be used as vector values.

  - **R file** (_.rdata_, _.rda, _.rds_): will be loaded as the way it was saved
  - **Tab separated text file** (_.txt_, _.tab_): with '\t' as separator by default
  - **Comma separated text file** (_.csv_): with ',' as separator by default
  - **Excel file** (_.xls_, _s.xlsx_): import the first worksheet by default

### R objects

R objects can be saved in _.rdata_, _.rda_, or _.rds_ files. The ***ImportR {RoCA}*** function will recognize these files types and load the R objects as the way they were saved. 

## Import data from remote files

***
_END OF DOCUMENT_