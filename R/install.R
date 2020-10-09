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

# https://github.com/ropensci/git2r.git
#' install_workflower
#' @export install_workflower
install_workflower <- function(delete = FALSE) {
  workflower_home <- fs::path_expand("~/.workflower")
  cli::cli_alert_info("Setting up HOME directory paths for workflower at {workflower_home}")

  if (delete) {
    if (fs::dir_exists(workflower_home)) {
      fs::dir_delete(workflower_home)
    }
  }

  if (fs::dir_exists(workflower_home)) {
    print(fs::dir_ls(workflower_home, all = TRUE))
    cli::cli_alert_info(readr::read_file(file.path(workflower_home, "installation", "gitssh.txt")))
    cli::cli_alert_warning("workflower already exists at {workflower_home}\nSkipped for now")
    return(FALSE)
  }

  fs::dir_create(workflower_home)
  cmd_git <- glue::glue("git clone https://github.com/fdrennan/workflower.git {workflower_home}")
  cli::cli_alert_info(cmd_git)
  system(cmd_git)
  cli::cli_alert_success("Installed workflower at {workflower_home}")
}


#' install_workflower
#' @export install_workflower
install_workflower <- function(delete = FALSE) {
  workflower_home <- fs::path_expand("~/.workflower")
  cli::cli_alert_info("Setting up HOME directory paths for workflower at {workflower_home}")

  if (delete) {
    if (fs::dir_exists(workflower_home)) {
      fs::dir_delete(workflower_home)
    }
  }
  if (fs::dir_exists(workflower_home)) {
    # cli::cli_alert_info(readr::read_file(file.path(workflower_home, "notes", "gitssh.txt")))
    cli::cli_alert_warning("workflower already exists at {workflower_home}\nSkipped for now")
    return(FALSE)
  }

  fs::dir_create(workflower_home)
  cmd_git <- glue::glue("git clone https://github.com/fdrennan/workflower.git {workflower_home}")
  cli::cli_alert_info(cmd_git)
  system(cmd_git)
  cli::cli_alert_success("Installed workflower at {workflower_home}")
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
  renv::snapshot(prompt = FALSE)
  devtools::install()
}


