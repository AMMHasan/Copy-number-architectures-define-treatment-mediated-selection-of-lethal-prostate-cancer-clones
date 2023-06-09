# load data
load("/Users/mahedi/Documents/UCL/scripts/R/Projects/Copy-number-architectures-define-treatment-mediated-selection-of-lethal-prostate-cancer-clones/figure_data.RData")

# set the pipe operator
"%>%" <- magrittr::`%>%`

# plot the distribution of Transition Points in different metastases in patient CA27
data_fig4c %>%
  reshape2::melt() %>%
  ggplot2::ggplot() +
  ggplot2::geom_bar(ggplot2::aes(x = SampleID_organ, y = value, fill = variable), stat = "identity", colour = "black", width = .8) +
  ggplot2::facet_grid(. ~ Breakpoint, scales = "free", space = "free") +
  ggplot2::theme_classic() +
  ggplot2::theme(
    axis.text.x = ggplot2::element_text(angle = 90, vjust = 1, hjust = 0.5),
    panel.spacing = ggplot2::unit(0.5, "cm")
  ) +
  ggplot2::xlab("CA27") +
  ggplot2::ylab("Number of Transition points") +
  ggplot2::labs(fill = "") +
  ggplot2::scale_fill_manual(values = c("#e28743", "#76b5c5", "#154c79"))
