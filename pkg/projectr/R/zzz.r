.onLoad <- function(libname, pkgname)
{     
  options(expand_path = FALSE)
  
  file_name <- "project_dirs.csv"
  dir_file <- file.path("~", file_name)           
  if(!exists(dir_file))
  {
    dir_file <- system.file(
      "extdata", file_name, package = "projectr"
    )
  }
  project_dirs <- try(utils::read.csv(dir_file, stringsAsFactors = FALSE))
  
  if(!inherits(project_dirs, "try-error"))
  {
    options(project_dirs = project_dirs)
  } else
  {
    warning("Could not set 'project_dirs' option")
  }

  #create_dir_fns()  
  #create_file_fns()
}
