#' #' build_workflower_params
#' build_workflower_params <- function() {
#'   #' update_package
#'   #' importFrom fs file_exists
#'   params <- list(
#'     styler = c(
#'       directories = 'R',
#'       files = 'main.R'
#'     )
#'   )
#' }

#' install_workflower
#' @export install_workflower
install_workflower <- function() {
  workflower_home <- fs::path_expand("~/.workflower")
  if (fs::dir_exists(workflower_home)) {
    # cli::cli_alert_info(readr::read_file(file.path(workflower_home, 'notes', 'gitssh.txt')))
    cli::cli_alert_warning("workflower already exists at {workflower}")
  } else {
    fs::dir_create(workflower_home)
    cli::cli_alert_success("Installed workflower at {path.expand('~/.workflower')}")
  }
}


#' importFrom fs file_delete
#' @export update_package
update_package <- function(params = NULL) {
  if (fs::file_exists("NAMESPACE")) {
    fs::file_delete("NAMESPACE")
  }
  if (fs::dir_exists("man")) {
    cli::cli_alert_warning("Deleting and rebuilding man folder...")
    fs::dir_delete("man")
  }
  if (fs::dir_exists("R")) styler::style_dir("R")
  roxygen2::roxygenise()
  fs::dir_ls()
  renv::snapshot()
  styler::style_dir(
    style = styler::tidyverse_style,
    filetype = c("R", "Rprofile"),
    recursive = TRUE,
    exclude_files = NULL,
    exclude_dirs = c("packrat", "renv"),
    include_roxygen_examples = TRUE
  )
  devtools::install()
}


