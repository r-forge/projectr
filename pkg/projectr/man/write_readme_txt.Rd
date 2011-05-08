\name{write_readme_txt}
\alias{write_readme_txt}
\title{
Writes a README.txt file
}
\description{
Writes a README.txt file specifying details of the contents of a project root directory.
}
\usage{
write_readme_txt(infile, outfile = "README.txt")
}
\arguments{
  \item{infile}{
Location of the README.txt file template.  If missing or NULL, the default template in the data directory of this package will be used.
}
  \item{outfile}{
Location to write the file to.
}
}
\details{
The file is copied from infile to outfile verbatim except that if a line contains the string \code{$project_dirs$}, that line will be replaced by a formatted version of the contents of \code{getOption("project_dirs")}
}
\value{
The return value from \code{writeLines} is invisibly returned.
}
\author{
Richie Cotton
}
\examples{
\dontrun{
write_readme_txt()
}
}
\keyword{readme}
