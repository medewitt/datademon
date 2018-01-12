#' Install Dependent Packages
#' @md
#' @param pkg.dir refers to the package directory that contains the
#'     \code{Description} file
#' @param dependencies defines which dependencies of the dependent packages are
#'     to be installed
#' @param repos is the (CRAN) repository used to install dependencies
#' @param lib is the library to which packages are installed
install_dep <- function(pkg.dir = ".", dependencies = TRUE, repos = getOption("repos")[1], lib = .libPaths()[1]) {

  # default dependencies
  if(dependencies == TRUE) {
    dependencies = c("Depends", "Imports", "LinkingTo")
  }

  # returns string w/o leading or trailing whitespace
  trim = function (x) gsub("^\\s+|\\s+$", "", x)

  # http://stackoverflow.com/questions/30223957/elegantly-extract-r-package-dependencies-of-a-package-not-listed-on-cran
  dcf = read.dcf(file.path(pkg.dir, "DESCRIPTION"))
  deps = unique(gsub("\\s.*", "", trim(unlist(strsplit(dcf[, intersect(dependencies, colnames(dcf))], ","), use.names = FALSE))))

  # install dependencies that aren't already installed
  deps = deps[!(deps %in% c("R", rownames(installed.packages())))]
  if(length(deps) > 0) {
    message(paste("Also installing:", paste(deps)))
    install.packages(deps)
  }
}
