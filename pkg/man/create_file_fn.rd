\name{create_file_fn}      
\alias{create_file_fn}
\alias{create_file_fns}
\title{
Create functions that locate files.
}
\description{
Create functions that locate files in the global environment.
}
\usage{
create_file_fn(name., envir = globalenv())
create_file_fns(envir = globalenv())
}
\arguments{
  \item{name.}{
The name to match in \code{getOption("project_dirs")}.
}               
  \item{envir}{
The environment in which to assign the function.
}
}
\details{
\code{create_file_fn} matches the \code{name.} argument to the \code{name} column of \code{getOption("project_dirs")} and assigns a function with name "<name.>_dir" in the environment specified by \code{envir} (by default, the global environment).  The created function takes a file name and returns a path pointing to that file in the directory given by the location column of that entry to \code{getOption("project_dirs")}.
\code{create_file_fns} calls \code{create_file_fn} for each row in \code{getOption("project_dirs")}.
}
\value{
This function is invoked for its side effect, which is assigning a function in the global environment.
}
\author{
Richie Cotton
}
\examples{
\dontrun{
create_dir_fn("data")
eval(data_dir(), envir = globalenv())
create_dir_fns()
}
}
\keyword{dir}
\keyword{path} 
\keyword{folder}
