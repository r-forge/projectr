.onLoad <- function(libname, pkgname)
{     
  options(expand_path = FALSE)
  
  project_dirs_file_name <- ".Rprojectdirs"
  dir_file <- file.path("~", project_dirs_file_name)           
  if(!exists(dir_file))
  {
    dir_file <- system.file(
      "extdata", project_dirs_file_name, package = "projectr"
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
  
  projects_file <- file.path("~", ".Rprojects")
  if(exists(projects_file))
  {
    projects <- try(
      utils::read.csv(projects_file, stringsAsFactors = FALSE)
    )
    if(!inherits(projects, "try-error"))
    {
      options(projects = projects)
    } else
    {
      warning("Could not set 'projects' option")
    }
  }
}
