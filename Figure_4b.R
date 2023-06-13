# load data
load("./Source_Data.RData")

# set the pipe operator
"%>%" <- magrittr::`%>%`

# plot Figure 4b: Plasma to metastases comparison of Transition Points
ggplot2::ggplot(data = data_fig4b) +
  ggplot2::geom_line(ggplot2::aes(Common_TPs, CA34, colour = "CA34"), linewidth = 1) +
  ggplot2::geom_line(ggplot2::aes(Common_TPs, CA36, colour = "CA36"), linewidth = 1) +
  ggplot2::geom_line(ggplot2::aes(Common_TPs, CA76, colour = "CA76"), linewidth = 1) +
  ggplot2::geom_line(ggplot2::aes(Common_TPs, CA83, colour = "CA83"), linewidth = 1) +
  ggplot2::geom_line(ggplot2::aes(Common_TPs, PEA172, colour = "PEA172"), linewidth = 1) +
  ggplot2::theme_bw() +
  ggplot2::scale_x_reverse(breaks = c(25, 20, 15, 10, 5, 1)) +
  ggplot2::scale_color_manual(
    name = "Patients",
    values = c(
      "CA34" = "black",
      "CA36" = "orange",
      "CA76" = "purple",
      "CA83" = "red",
      "PEA172" = "skyblue"
    )
  ) +
  ggplot2::xlab("Number of autopsy samples") +
  ggplot2::ylab("Percent of plasma TPs found in autopsy cores") +
  ggplot2::ggtitle("Plasma to metastases comparison of TPs")

