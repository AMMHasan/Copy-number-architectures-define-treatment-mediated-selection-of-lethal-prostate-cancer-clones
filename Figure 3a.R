# load data:
load("/Users/mahedi/Documents/UCL/scripts/R/Projects/Copy-number-architectures-define-treatment-mediated-selection-of-lethal-prostate-cancer-clones/figure_data.RData")

# set the pipe operator
"%>%" <- magrittr::`%>%`

# set the color palette:
cbPalette <- c(
  "#999999",
  "#E69F00",
  "#56B4E9",
  "#009E73",
  "#F0E442",
  "#0072B2",
  "#D55E00",
  "#CC79A7"
)


# plot SVs (start break-points) distribution at the AR locus
ggplot2::ggplot(data_fig3a, ggplot2::aes(start, yCoord, colour = Type)) +
  ggplot2::annotate("rect", xmin = 66774465, xmax = 66950461, ymin = 0.5, ymax = 25.5, alpha = 0.5, fill = "salmon") +
  ggplot2::annotate("rect", xmin = 66117800, xmax = 66128800, ymin = 0.5, ymax = 25.5, fill = "black") +
  ggplot2::geom_point(shape = 73, size = 5) +
  ggplot2::geom_hline(yintercept = c(0.5, data_fig3a$yCoord + 0.5), colour = "grey", linetype = 2, linewidth = 0.3) +
  ggplot2::scale_colour_manual(values = cbPalette) +
  ggplot2::scale_x_continuous(
    name = "Chromosome X position (Mb)",
    limits = c(4.3e7, 8e7),
    breaks = seq(50e6, 80e6, 1e6),
    labels = as.character(seq(50, 80))
  ) +
  ggplot2::annotate("text", x = 4.4e7, y = data_fig3a$yCoord, label = data_fig3a$met, hjust = "left") +
  ggplot2::theme_classic() +
  ggplot2::theme(
    axis.title.y = ggplot2::element_blank(),
    axis.text.y = ggplot2::element_blank(),
    axis.ticks.y = ggplot2::element_blank()
  )

