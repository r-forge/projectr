\name{get_dir}
\alias{get_dir}   
\alias{admin_dir}
\alias{analysis_dir}
\alias{test_dir}
\alias{data_dir}      
\alias{original_data_dir}
\alias{presentations_dir}
\alias{reports_dir}
\alias{results_dir}
\alias{graphs_dir}
\title{Get project directory}
\description{
Returns the location of a project directory.
}
\usage{
get_dir(name., expand = getOption("expand_path"))
name_dir(expand = getOption("expand_path"))
}
\arguments{
  \item{name.}{
The name of a project directory type, as specified in getOption("project_dirs").
}
  \item{expand}{
If true, the path will be given as an absolute path that is a subdirectory of the present working directory; otherwise it will be a relative path.
}
}
\details{
When the package is loaded, a function is created for every row in \code{getOption("project_dirs")} with the form \code{name_dir(expand = getOption("expand_path"))}, where name is the value in the name column of that row of the project_dirs data.frame.  For example, if there is a row with name "data", a function named \code{data_dir} will be created.  These functions are assigned to the global environment (as returned by \code{globalenv()}).
}
\value{
  A path to a project directory.
}
\author{
Richie Cotton
}
\examples{
\dontrun{               
  #Examples assume that you getOption("project_dirs") 
  #contains an entry with name data
  get_dir("data")       
  data_dir()
  data_dir(!getOption("expand_path"))
}
}
\keyword{dir}
\keyword{path} 
\keyword{folder}
