load("./Source_Data.RData")

cluster_assignment_vec <- setNames(cluster_assignment_CA63$Cluster, as.character(cluster_assignment_CA63$SampleID))

heatmap_col <- circlize::colorRamp2(c(0, 0.25, 0.5, 1, 2), c("red", "orange", "white", "white", "blue"))
cluster_col <- c("3" = "#b0c969", "2" = "#b91446", "1" = "#5b5fa3")

ComplexHeatmap::Heatmap(data_fig4d %>% as.matrix(),
  cluster_rows = autosomal_tree_CA63,
  cluster_columns = autosomal_tree_CA63,
  show_row_names = TRUE,
  show_column_names = TRUE,
  col = heatmap_col,
  rect_gp = grid::gpar(col = "black", lwd = 0.5),
  column_names_gp = grid::gpar(fontsize = 8),
  row_names_gp = grid::gpar(fontsize = 8),
  left_annotation = ComplexHeatmap::rowAnnotation(
    cluster = cluster_assignment_vec,
    col = list(cluster = cluster_col),
    show_legend = F,
    show_annotation_name = F,
    gp = grid::gpar(col = "black", lwd = 0.5)
  ),
  top_annotation = ComplexHeatmap::HeatmapAnnotation(
    cluster = cluster_assignment_vec,
    col = list(cluster = cluster_col),
    show_legend = F,
    show_annotation_name = F,
    gp = grid::gpar(col = "black", lwd = 0.5)
  ),
  show_heatmap_legend = F
)

