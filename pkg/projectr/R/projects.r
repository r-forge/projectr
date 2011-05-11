is_data_suitable_for_projects_option <- function(data)
{          
  #Checks to see if the input is suitable to be used for getOption("projects")
  if(!.is_data_suitable_base(data))
  {
    return(FALSE)
  }
  if("startup" %in% colnames(data) && !is.character(data$startup))
  {
    warning("The 'startup' column does not have mode 'character'")
    return(FALSE)
  }
  return(TRUE)
}

open_project <- function(name., cleanup = FALSE, ...)
{
  #Opens a project named in getOption("projects"), changing the working directory and running startup code.
  projects <- getOption("projects")
  if(!is_data_suitable_for_projects_option(projects))
  {
    stop("The projects option is invalid.")
  }
  if(length(name.) > 1L)
  {
    warning("Only the first element of 'name.' will be used")
    name. <- name.[1L]
  }
  name. <- as.character(name.)
  if(!(name. %in% projects$name))
  {
    stop("The project name was not recognised.")
  }
  project <- subset(projects, name == name.)
  
  if(cleanup)
  {
    rm(list = ls(envir = globalenv()))
    graphics.off()
  }
  
  setwd(project$path)
  
  if("startup" %in% colnames(project))
  {
    eval(parse(text = project$startup))
  }
  invisible(project)
}
