# load data
load("/Users/mahedi/Documents/UCL/scripts/R/Projects/Copy-number-architectures-define-treatment-mediated-selection-of-lethal-prostate-cancer-clones/figure_data.RData")

# set the pipe operator
"%>%" <- magrittr::`%>%`

# function for filtering genes with less than 10 counts in 90% of samples
filter_low_count_gene <- function(mat,
                                  min_counts = 10L,
                                  min_cells_pc = 0.90) {
  n_genes_before <- dim(mat)[[1]]
  min_cells <- floor(dim(mat)[[2]] * min_cells_pc)
  keep_genes <- apply(mat, 1, function(x) {
    length(x[x >= min_counts]) > min_cells
  })
  mat <- mat[keep_genes, ]

  return(mat)
}


low_count_filtered_exprMat <- filter_low_count_gene(count_data %>% dplyr::select(meta_data_RNAseq$sample_ID) %>% as.matrix())

# quantile normalization of the count data remaining gene 
exprMat_norm <- (limma::voom(low_count_filtered_exprMat, normalize.method = "quantile"))$E %>%
  data.frame() %>%
  dplyr::mutate(hgnc = rownames(.)) %>%
  dplyr::filter(hgnc %in% c("AR", hieronymus_geneset$gene))

# scale the normalized count data
exprMat_norm_scaled <- exprMat_norm %>%
  dplyr::select(-hgnc) %>%
  t() %>%
  data.frame() %>%
  purrr::modify(., ~ {
    (.x - mean(.x)) / sd(.x)
  }) %>%
  t() %>%
  data.frame()

colnames(exprMat_norm_scaled) <- colnames(exprMat_norm)[1:(ncol(exprMat_norm) - 1)]

# calculate the AR score
up_AR_genes_exprMat_norm_scaled <- exprMat_norm_scaled[-3, ] %>%
  dplyr::filter(rownames(exprMat_norm_scaled[-3, ]) %in% (hieronymus_geneset %>%
    dplyr::filter(expression == "up") %>%
    dplyr::select(gene) %>% unlist())) %>%
  purrr::modify(., ~ {
    ifelse(.x > 1, 1, ifelse(((.x < 1) & (.x > -1)), 0, -1))
  })


down_AR_genes_exprMat_norm_scaled <- exprMat_norm_scaled[-3, ] %>%
  dplyr::filter(rownames(exprMat_norm_scaled[-3, ]) %in% (hieronymus_geneset %>%
    dplyr::filter(expression == "down") %>%
    dplyr::select(gene) %>% unlist())) %>%
  purrr::modify(., ~ {
    ifelse(.x < -1, 1, ifelse(((.x > -1) & (.x < 1)), 0, -1))
  })


exprMat_AR_score <- dplyr::bind_rows(up_AR_genes_exprMat_norm_scaled, down_AR_genes_exprMat_norm_scaled) %>%
  colSums(na.rm = T) %>%
  reshape2::melt() %>%
  dplyr::select(AR_score = value) %>%
  dplyr::mutate(sample_ID = rownames(.))


plot_data <- dplyr::left_join(meta_data_RNAseq, exprMat_AR_score, by = "sample_ID") %>%
  dplyr::left_join(.,
    exprMat_norm_scaled["AR", ] %>%
      t() %>%
      data.frame() %>%
      dplyr::mutate(sample_ID = rownames(.)),
    by = "sample_ID"
  ) %>%
  dplyr::filter(TC >= 0.2)


# plot the AR score as a fuction of nomalized and scaled AR expression
ggplot2::ggplot(
  data = plot_data,
  ggplot2::aes(x = AR, y = AR_score)
) +
  ggplot2::geom_point(pch = 21, ggplot2::aes(fill = patient_ID, size = AR_copy_number_ACE)) +
  ggplot2::geom_smooth(method = "lm", se = F, ggplot2::aes(colour = patient_ID), show.legend = F) +
  ggplot2::labs(
    x = "Normalized AR expression",
    y = "AR score", size = "AR CN", fill = "patient ID"
  ) +
  ggplot2::theme_bw()


######### test of significance

plot_data %>%
  dplyr::group_by(patient_ID) %>%
  tidyr::nest() %>%
  dplyr::mutate(
    model = purrr::map(.x = data, .f = ~ cor.test(.x$AR_score, .x$AR)),
    tidied = purrr::map(model, .f = broom::tidy)
  ) %>%
  tidyr::unnest(tidied) %>%
  dplyr::arrange(patient_ID) %>%
  dplyr::select(patient_ID, estimate, p.value)
