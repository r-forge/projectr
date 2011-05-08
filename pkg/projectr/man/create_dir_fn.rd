\name{create_dir_fn}       
\alias{create_dir_fn}
\alias{create_dir_fns}
\title{
Create functions that locate directories.
}
\description{
Create functions that locate directories in the global environment.
}
\usage{
create_dir_fn(name., envir = globalenv())
create_dir_fns(envir = globalenv())
}
\arguments{
  \item{name.}{
The name to match in getOption("project_dirs").
}          
  \item{envir}{
The environment in which to assign the function.
}
}
\details{
\code{create_dir_fn} matches the \code{name.} argument to the \code{name} column of \code{getOption("project_dirs")} and assigns a function with name "<name.>_dir" in the envinonment specified by \code{envir} (by default, the global environment).  The created function returns a path pointing to the value of the location column of that entry to \code{getOption("project_dirs")}.
\code{create_dir_fns} calls \code{create_dir_fn} for each row in \code{getOption("project_dirs")}.
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
