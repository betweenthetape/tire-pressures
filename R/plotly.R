#' @noRd
plotly_low_config <- function(plot) {
  ggplotly(plot) |>
    config(
      displayModeBar = TRUE,
      displaylogo = FALSE,
      modeBarButtonsToRemove = list(
        "zoom",
        # "pan",
        "select",
        # "zoomIn",
        # "zoomOut",
        "autoScale",
        # "resetScale",
        "lasso2d",
        "hoverClosestCartesian",
        "hoverCompareCartesian"
      ),
      # Download button
      toImageButtonOptions = list(
        height = NULL,
        width = NULL,
        scale = 6
      )
    )
}
