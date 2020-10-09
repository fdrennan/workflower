#' @install_workflower
install_workflower <- function() {
  workflower_home <- fs::path_expand('~/.workflower')
  if (fs::dir_exists(workflower_home)) {
    cli_alert_warning("workflower already exists at {workflower}")
  } else {
    fs::dir_create(workflower_home)
    cli_alert_success("Installed workflower at {path.expand('~/.workflower')}")
  }
}
