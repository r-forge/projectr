\name{is_data_suitable_for_projects_option}
\alias{is_data_suitable_for_projects_option}   
\alias{is_data_suitable_for_project_dirs_option}
\title{Is data frame suitable to be used as projects/project_dirs option}
\description{
Checks whether or not a data frame is suitable to be used as the projects or project_dirs option.
}
\usage{
is_data_suitable_for_projects_option(data)  
is_data_suitable_for_project_dirs_option(data)
}
\arguments{
  \item{data}{
A data.frame to be used for getOption("projects") or getOption("project_dirs").
}
}
\details{
The following checks are made:
1. The data argument is a data.frame.
2. It has at least one row.
3. It has a column called 'name' and a column called 'path'. (Other columns are permitted.)
4. Those columns named above are of type 'character'.
5. The values in the name column are unique, and all valid variable names.
6. If on windows, the values in the path column don't contain any of the forbidden characters '*?"<>|'.

For \code{is_data_suitable_for_projects_option}, if there is a column named 'startup', there is a check to ensure that it is of type 'character'.
For \code{is_data_suitable_for_project_dirs_option}, the values in the 'name' column are checked to ensure that they are unique, valid variable names.
}
\value{
  A scalar logical value: TRUE is the data argument is suitable to be used for the projects/project_dirs options and FALSE otherwise.
}
\author{
Richie Cotton
}
\examples{     
is_data_suitable_for_projects_option(data.frame(
  name = "my_test_project",
  path = "~",
  startup = "message('Starting my_test_project')",
  stringsAsFactors = FALSE
))
\dontrun{
is_data_suitable_for_project_dirs_option(data.frame(
  name = c("data", "analysis", "results", "graphs"),
  path = c("Data", "Analysis", "Results", "Results/Graphs"),   
  stringsAsFactors = FALSE
))
}
}
\keyword{dir}
\keyword{path} 
\keyword{folder}
