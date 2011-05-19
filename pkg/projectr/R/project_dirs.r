copy_dir_structure <- function(location = getwd())
{
  #Creates a data frame suitable for getOption("project_dirs") from the
  #directories that exist in the specified location
  #NOTE: Can't just pass location into list.dirs because it may return absolute paths.
  old_wd <- setwd(location)
  dir_list <- list.dirs()[-1L]
  setwd(old_wd)
  data.frame(
    name = make.names(basename(dir_list), unique = TRUE),
    path = substring(dir_list, 3L),
    stringsAsFactors = FALSE
  )
}

create_dir_fn <- function(name., envir = globalenv())              
{
  #Assigns a function that can be used to access a directory
  assign(
    paste(name., "_dir", sep = ""), 
    function(expand = getOption("expand_path"))
    {
      as.character(.path_expand(
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
  #Assigns a dir function for each row of the project_dirs option
  invisible(lapply(
    getOption("project_dirs")$name, create_dir_fn, envir
  ))
}

create_file_fn <- function(name., envir = globalenv())                 
{
  #Assigns a function that can be used to access a directory
  assign(
    paste(name., "_file", sep = ""), 
    function(file, expand = getOption("expand_path"))
    {
      as.character(.path_expand(
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
  #Assigns a dir function for each row of the project_dirs option
  invisible(lapply(
    getOption("project_dirs")$name, create_file_fn, envir
  ))
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

get_dir <- function(name., expand = getOption("expand_path"))
{
  #Returns the location of a directory named in getOptions("project_dirs")
  as.character(.path_expand(
    with(getOption("project_dirs"),   
      path[name == name.]
    ), 
    expand
  ))
}
     
get_file <- function(file, name., expand = getOption("expand_path"))
{              
  #Returns the location of a file in a directory named in getOptions("project_dirs")
  as.character(.path_expand(
    with(getOption("project_dirs"),   
      file.path(path[name == name.], file)
    ), 
    expand
  ))
}
 
is_data_suitable_for_project_dirs_option <- function(data)
{          
  #Checks to see if the input is suitable to be used for getOption("project_dirs")
  if(!.is_data_suitable_base(data))
  {
    return(FALSE)
  }
  if(!all(.is_valid_variable_name(data$name)))
  {
    warning("The values in the name column are not all unique valid variable names")
    return(FALSE)
  }
  return(TRUE)
}
  
write_readme_txt <- function(infile, outfile = "README.txt")
{
  #Writes a string suitable for a README.txt file, detailing contents of directories
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
