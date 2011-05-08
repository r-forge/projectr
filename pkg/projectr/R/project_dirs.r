#Code for projectr package, which provides function access to file locations.
#It creates subdirectories for a project (e.g., "Data" for your data, and a function to access that location, e.g., data_dir()).


path_expand <- function(path, expand)
{
  #Converts a relative path to an absolute path in the PWD
  if(is.null(path)) warning("path is NULL")
  if(expand) path <- file.path(getwd(), path)
  path
}

get_dir <- function(name., expand = getOption("expand_path"))
{
  as.character(path_expand(
    with(getOption("project_dirs"),   
      path[name == name.]
    ), 
    expand
  ))
}
     
get_file <- function(file, name., expand = getOption("expand_path"))
{
  as.character(path_expand(
    with(getOption("project_dirs"),   
      file.path(path[name == name.], file)
    ), 
    expand
  ))
}

write_readme_txt <- function(infile, outfile = "README.txt")
{
  #Returns a string suitable for a README.txt file, detailing contents of directories
  project_dirs <- getOption("project_dirs")
  paths <- c("Path", project_dirs$path)
  dir_table <- paste(
    format(paths, width = max(nchar(paths))), 
    c("Description", project_dirs$description), 
    sep = "\t", collapse = "\n"
  )     
  
  if(missing(infile) || is.null(infile))
  {
    infile <- system.file(
      "extdata", "README.txt", package = "projectr"
    )
  }
  readme <- readLines(infile)
  
  readme[grep("\\$project_dirs\\$", readme)] <- dir_table
  writeLines(readme, outfile)  
}

create_project_dirs <- function(location = getwd(), ...)  
{
  #Creates sub-directories in the directory location, according to the "project_dirs" option
  #... args passed to dir.create and write_readme_txt
  dirs <- file.path(location, getOption("project_dirs")$path)
  dir_ok <- sapply(dirs, dir.create, ...)
  names(dir_ok) <- getOption("project_dirs")$name
  readme_ok <- write_readme_txt(..., 
    outfile = file.path(location, "README.txt"))
  invisible(c(dir_ok, readme = readme_ok))
}

create_dir_fn <- function(name., envir = globalenv())              
{
  #Returns a function that can be used to access a directory
  assign(
    paste(name., "_dir", sep = ""), 
    function(expand = getOption("expand_path"))
    {
      as.character(path_expand(
        with(getOption("project_dirs"), 
          path[name == name.]
        ), expand
      ))
    },
    envir = envir
  )
}

create_dir_fns <- function(envir = globalenv())                   
{
  #Creates a dir function for each row of the project_dirs option
  invisible(lapply(
    getOption("project_dirs")$name, create_dir_fn, envir
  ))
}


create_file_fn <- function(name., envir = globalenv())                 
{
  #Returns a function that can be used to access a directory
  assign(
    paste(name., "_file", sep = ""), 
    function(file, expand = getOption("expand_path"))
    {
      as.character(path_expand(
        with(getOption("project_dirs"), 
          file.path(path[name == name.], file)
        ), expand
      ))
    },
    envir = envir
  )
}

create_file_fns <- function(envir = globalenv())          
{
  #Creates a dir function for each row of the project_dirs option
  invisible(lapply(
    getOption("project_dirs")$name, create_file_fn, envir
  ))
}

is_valid_variable_name <- function(names, unique = TRUE)
{
  #Checks to see if the input names are valid variable names
  make.names(names, unique = unique) == names
}

is_data_suitable_for_project_dirs <- function(data)
{
  #Checks to see if the input is suitable to be used for getOption(project_dirs)
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
  if(!all(is_valid_variable_name(data$name)))
  {
    warning("The values in the name column are not all unique valid variable names")
    return(FALSE)
  }
  rx <- '[:*?"<>|]'
  if(.Platform$OS.type == "windows" && any(grepl(rx, data$path)))
  {
    warning("The path column contains characters that are forbidden in Windows paths")
    return(FALSE)
  }  
  TRUE
}

copy_dir_structure <- function(location = getwd())
{
  #Creates a data frame suitable for getOption(project_dirs) from the
  #directories that exist in the specified location
  dir_list <- list.dirs()[-1]
  data.frame(
    name = make.names(basename(dir_list), unique = TRUE),
    path = substring(dir_list, 3),
    stringsAsFactors = FALSE
  )
}
