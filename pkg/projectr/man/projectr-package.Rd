\name{projectr-package}
\alias{projectr-package}
\alias{projectr}
\docType{package}
\title{
Creates and organises project directories
}
\description{
This package helps you maintain consistency in file locations across projects,
  by allowing functional access to directories.  For example, if you specify that
  your project should have a data directory with location "Data", then a function \code{data_dir} will be created returning that location, and \code{data_file} will specify that a file should be in that directory.
}
\details{
\tabular{ll}{
Package: \tab projectr\cr
Type: \tab Package\cr
Version: \tab 0.0-7\cr
Date: \tab 2011-05-05\cr
License: \tab WTFPL v2\cr
LazyLoad: \tab yes\cr
}
}
\author{
Richard Cotton <richierocks@gmail.com>
}
\keyword{package} 
\keyword{projectr}
\keyword{project}

\examples{
\dontrun{
td <- tempdir()
create_project_dirs(td)
dir(td)
get_dir("data")
data_dir()
}

}
