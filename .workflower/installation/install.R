renv::install('fdrennan/workflower', prompt = FALSE)
devtools::install(wf_home())
renv::restore(prompt = FALSE)

# path <- file.path(workflower::wf_home(), '.workflower/installation/install.R');
# path <- glue::glue('Rscript {path}')
