#' update_package
#' importFrom fs file_exists
#' importFrom fs file_delete
#' @export update_package
update_package <- function() {
  if (fs::file_exists("NAMESPACE")) {
    fs::file_delete("NAMESPACE")
  }
  if (fs::dir_exists("man")) {
    cli::cli_alert_warning("Deleting and rebuilding man folder...")
    fs::dir_delete("man")
  }
  styler::style_dir(exclude_dirs = c('renv', '.Rproj.user'))
  if (fs::dir_exists("R")) styler::style_dir("R")
  roxygen2::roxygenise()
  devtools::install()
}


#' install_workflower
#' @install_workflower
install_workflower <- function() {
  workflower_home <- fs::path_expand("~/.workflower")
  if (fs::dir_exists(workflower_home)) {
    cli::cli_alert_warning("workflower already exists at {workflower}")
  } else {
    fs::dir_create(workflower_home)
    cli::cli_alert_success("Installed workflower at {path.expand('~/.workflower')}")
  }
}
