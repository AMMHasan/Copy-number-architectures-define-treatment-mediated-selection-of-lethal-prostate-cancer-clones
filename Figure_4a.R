# load data
load("./Source_Data.RData")

# set the pipe operator
"%>%" <- magrittr::`%>%`

# plot proportion of transition points detected within or across patients
p1 <- ggplot2::ggplot(data_fig4a) +
  ggplot2::geom_histogram(ggplot2::aes(x = intra_patient_prob), colour = "black", fill = "blue", alpha = 0.5, binwidth = 0.02) +
  ggplot2::ylim(0, 600) +
  ggplot2::theme_classic() +
  ggplot2::xlab("Proportion of transition points detected within a patient") +
  ggplot2::ylab("# Transition points") +
  ggplot2::coord_cartesian(xlim = c(0, 1))

p2 <- ggplot2::ggplot(data_fig4a) +
  ggplot2::geom_histogram(ggplot2::aes(x = inter_patient_prob), colour = "black", fill = "red", alpha = 0.5, binwidth = 0.02) +
  ggplot2::ylim(0, 800) +
  ggplot2::theme_classic() +
  ggplot2::xlab("Proportion of transition points detected across patients") +
  ggplot2::ylab("# Transition points") +
  ggplot2::coord_cartesian(xlim = c(0, 1))


gridExtra::grid.arrange(p1, p2)
