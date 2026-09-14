# CI: disable renv cache. renv's graph installer links cache hits before
# ordering the rest, so e.g. cached tibble can precede uncached vctrs and
# test-loading archive/jaspGraphs fails with "no package called 'vctrs'".
if (identical(Sys.getenv("GITHUB_ACTIONS"), "true"))
  Sys.setenv(RENV_CONFIG_CACHE_ENABLED = "FALSE")

source("renv/activate.R")
