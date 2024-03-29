# Load data
load("./Source_Data.RData")

# also load dndscv from bioconductor

# set the pipe operator
"%>%" <- magrittr::`%>%`

# perform dndscv analysis
dndsout <- dndscv::dndscv(clonal_mutations) %>% suppressWarnings()

# extract synonymous mutation and calculate common clonal non-silent mutations
mutation_position_tib <- dndsout$annotmuts %>%
  dplyr::filter((impact != "Synonymous")) %>%
  dplyr::group_by(sampleID) %>%
  dplyr::transmute(chr_pos = paste0(chr, "_", pos)) %>%
  dplyr::summarise_all(., list) %>%
  dplyr::mutate(cm_number = purrr::map_int(.x = chr_pos, .f = ~ {
    .x %>% length()
  })) %>%
  tidyr::separate(col = sampleID, into = c("patientID", "sample"), sep = "_", remove = F) %>%
  dplyr::select(-sample) %>%
  dplyr::group_by(patientID) %>%
  tidyr::nest()


func_pct_common <- function(sample_tibble) {
  res_list <- purrr::map(
    .x = combn(sample_tibble$sampleID, 2, simplify = F),
    .f = ~ {
      (sample_tibble %>%
        dplyr::filter(sampleID %in% .x) %>%
        dplyr::pull(chr_pos) %>%
        Reduce(intersect, .) %>%
        length()) / (sample_tibble %>%
        dplyr::filter(sampleID %in% .x) %>%
        dplyr::pull(cm_number) %>%
        Reduce(min, .)) * 100
    }
  )
  names(res_list) <- purrr::map(.x = combn(sample_tibble$sampleID, 2, simplify = F), .f = ~ paste(.x, collapse = " "))

  return(do.call(rbind, res_list) %>% data.frame(pct_common = .))
}

percent_common <- purrr::map(
  .x = mutation_position_tib %>% dplyr::pull(data),
  .f = func_pct_common
) %>%
  do.call(rbind, .)



df_stat <- percent_common %>%
  as.data.frame() %>%
  merge(., correlation_distances, by = "row.names", all = T) %>%
  dplyr::select(-Row.names)

# test and plot the significance of percent common clonal non-silent mutation by cluster assignment
p <- ggpubr::ggboxplot(df_stat, x = "within_same_cluster", y = "pct_common", fill = "within_same_cluster") +
  ggplot2::xlab("Within same cluster?") +
  ggplot2::ylab("% common clonal non-silent mutations") +
  ggplot2::labs(fill = "Within same cluster?")

p + ggpubr::stat_compare_means(method = "t.test")


# plot percent common clonal non-silent mutation as a function of correlatin distance between mets
label <- paste("italic(R)^2==", (lm(pct_common ~ distance, data = df_stat) %>% summary())$r.squared %>% round(2))

plt <- ggplot2::ggplot(df_stat, ggplot2::aes(distance, pct_common, label = intersection)) +
  ggplot2::geom_point(ggplot2::aes(fill = within_same_cluster), size = 4, pch = 21) +
  ggplot2::geom_smooth(ggplot2::aes(distance, pct_common), method = "lm") +
  ggplot2::xlab("Correlation distance") +
  ggplot2::ylab("% common clonal non-silent mutations") +
  ggplot2::theme_bw() +
  ggplot2::annotate("text", x = 0.5, y = 90, label = label, parse = T) +
  ggplot2::labs(fill = "Within same cluster?")

suppressWarnings(print(plt))
