\name{create_project_dirs}
\alias{create_project_dirs}
\title{
Creates directories for a project
}
\description{
Creates directories to hold your project files.
}
\usage{
create_project_dirs(location = getwd(), ...)
}
\arguments{
  \item{location}{
The root path for the project, i.e., where to create the directories.
}
  \item{\dots}{
Passed to \code{dir.create} and \code{write_readme_txt}
}
}
\details{
Directories detailed in \code{getOption("project_dirs")} are created within the location given by \code{location}.  Additionally, a README.txt file is created in the project root directory.
}
\value{
A logical vector of which directories were created is invisibly returned.
}
\author{
Richie Cotton
}
\examples{
\dontrun{
td <- tempdir()
create_project_dirs(td)
dir(td)
}
}
\keyword{dir}
\keyword{path} 
\keyword{folder}
