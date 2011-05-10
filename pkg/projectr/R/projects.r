open_project <- function(name., cleanup = FALSE, ...)
{
  #Opens a project named in getOption("projects"), changing the working directory and running startup code.
  if(cleanup)
  {
    rm(list = ls(envir = globalenv()))
    graphics.off()
  }
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
  project <- subset(projects, name == name.)
  setwd(project$path)
  if("startup" %in% colnames(project))
  {
    eval(parse(text = project$startup))
  }
  files_in_project <- list.files(recursive = TRUE)
  is_startup_file <- grepl(
    "startup.r", 
    tolower(basename(files_in_project)), 
    fixed = TRUE
  )
  lapply(files_in_project[is_startup_file], source, ...)
  invisible(project)
}
