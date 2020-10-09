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

#' wf_home
#' @export wf_home
wf_home <- function() {
  workflower_home <- fs::path_expand("~/.workflower")
  workflower_home
}

#' wf_print
#' @export wf_print
wf_print <- function() {
  workflower_home <- fs::path_expand("~/.workflower")
  fs::dir_ls(workflower_home)
}


#' wf_home
#' @export wf_delete
wf_delete <- function() {
  fs::dir_delete(wf_home())
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
  print(fs::dir_ls(wf_home(), recurse = TRUE))
  if (fs::dir_exists("R")) styler::style_dir("R")
  roxygen2::roxygenise()
  renv::snapshot(prompt = FALSE)
  devtools::install()
  rstudioapi::restartSession(command = {
    "cat('\014')"
  })
}
