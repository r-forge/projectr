\name{get_file}
\alias{get_file}   
\alias{admin_file}
\alias{analysis_file}
\alias{test_file}
\alias{data_file}      
\alias{original_data_file}
\alias{presentations_file}
\alias{reports_file}
\alias{results_file}
\alias{graphs_file}
\title{Get project file}
\description{
Returns the path to a file in a project directory.
}
\usage{
get_file(file, name., expand = getOption("expand_path"))
name_file(file, expand = getOption("expand_path"))
}
\arguments{   
  \item{file}{
The name of the file to return a path to.
}
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
  #contains an entry with name datay  
  get_file("my data.csv", "data")       
  data_file("my data.csv")
  data_file("my data.csv", !getOption("expand_path"))
}
}
\keyword{dir}
\keyword{path} 
