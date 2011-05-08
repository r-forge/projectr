\name{is_data_suitable_for_project_dirs}
\alias{is_data_suitable_for_project_dirs}   
\title{Is data frame suitable to be used as project_dirs option}
\description{
Checks whether or not a data frame is suitable to be used as project_dirs option.
}
\usage{
is_data_suitable_for_project_dirs(data)
}
\arguments{
  \item{data}{
A data.frame to be used for getOption("project_dirs").
}
}
\details{
The following checks are made:
1. The data argument is a data.frame.
2. It has at least one row.
3. It has a column called 'name' and a column called 'path'. (Other columns are permitted.)
4. Those columns named above are of type 'character'.
5. The values in the name column are unique, and all valid variable names.
6. If on windows, the values in the path column don't contain forbidden characters.
}
\value{
  A scalar logical value: TRUE is the data argument is suitable to be used for the project_dirs options and FALSE otherwise.
}
\author{
Richie Cotton
}
\examples{
is_data_suitable_for_project_dirs(data.frame(
  name = c("data", "analysis", "results", "graphs"),
  path = c("Data", "Analysis", "Results", "Results/Graphs"),   
  stringsAsFactors = FALSE
))
}
\keyword{dir}
\keyword{path} 
\keyword{folder}
