.path_expand <- function(path, expand)
{
  #Converts a relative path to an absolute path in the PWD
  if(is.null(path)) warning("path is NULL")
  if(expand) path <- file.path(getwd(), path)
  path
}

.is_data_suitable_base <- function(data)
{
  #Checks to see if the input is suitable to be used for getOption("projects")
  if(!is.data.frame(data))
  {
    warning("The input is not a data.frame")
    return(FALSE)
  }    
  if(nrow(data) == 0L)
  {
    warning("There are no rows in the data frame")
    return(FALSE)
  }
  required_cols <- c("name", "path")
  for(column in required_cols)
  {
    if(!(column %in% colnames(data)))
    {
      warning(paste("There is no column named", sQuote(column)))
      return(FALSE)
    }
    if(!is.character(data[[column]]))
    {
      warning(paste("The", sQuote(column), "column does not have mode 'character'"))
      return(FALSE)
    }
  } 
  if(anyDuplicated(data$name))
  {
    warning("The values in the name column are not all unique")
    return(FALSE)
  }
  rx <- '[*?"<>|]'
  if(.Platform$OS.type == "windows" && any(grepl(rx, data$path)))
  {
    warning("The path column contains characters that are forbidden in Windows paths")
    return(FALSE)
  }  
  TRUE
}

.is_valid_variable_name <- function(names, unique = TRUE)
{
  #Checks that names are valid variable names
  names == make.names(names, unique = unique)
}
