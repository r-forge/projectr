\name{open_project}
\alias{open_project}
\title{
Opens a project.
}
\description{
Optionally cleans up, then changes the working dir and runs project startup code.
}
\usage{
open_project(name., cleanup = FALSE, ...)
}
\arguments{
  \item{name.}{
The name the project, as specified in getOptions("projects").
}           
  \item{cleanup}{
If TRUE, clean up before opening the project; see details.
}
  \item{\dots}{
Passed to \code{source}.
}
}
\details{
The function matches the \code{name.} against the values in the \code{name} column of \code{getOption("projects")} (henceforth "the projects data frame"). If \code{cleanup} is TRUE, then non-hidden variables are removed from the global environment, and graphics devices are closed. It then changes the working directory to the path given in the corresponding value in the \code{path} column of the projects data frame.  Finally, if the projects data frame has a column named "startup", the expression in the appropriate row of that column is evaluated.
}
\value{
A one row data frame with the name, path and startup code for the project.
}
\author{
Richie Cotton
}
\examples{
old_wd <- getwd()
old_options <- options(projects = data.frame(
  name = "my_test_project",
  path = "~",
  startup = "message('Starting my_test_project')",
  stringsAsFactors = FALSE
))
open_project("my_project")
cat("current working dir is", getwd(), "\n")
options(old_options)
setwd(old_wd)
}
\keyword{project}
\keyword{open} 
