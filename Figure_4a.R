# load data
load("./Source_Data.RData")

# set the pipe operator
"%>%" <- magrittr::`%>%`

# calculate intra- and inter-patient probabilities of having each archival transition point
data <- data_fig4a %>% dplyr::transmute(
  intra_patient_prob = archival_summary_matched_patient / archival_summary_tested_patient,
  inter_patient_prob = archival_summary_matched_control / archival_summary_tested_control,
  patient_ID = patient_ID
)

# plot proportion of transition points detected within or across patients
p1 <- ggplot2::ggplot(data) +
  ggplot2::geom_histogram(ggplot2::aes(x = intra_patient_prob), colour = "black", fill = "blue", alpha = 0.5, binwidth = 0.02) +
  ggplot2::ylim(0, 500) +
  ggplot2::theme_classic() +
  ggplot2::xlab("Proportion of transition points detected within a patient") +
  ggplot2::ylab("# Transition points") +
  ggplot2::coord_cartesian(xlim = c(0, 1))

p2 <- ggplot2::ggplot(data) +
  ggplot2::geom_histogram(ggplot2::aes(x = inter_patient_prob), colour = "black", fill = "red", alpha = 0.5, binwidth = 0.02) +
  ggplot2::ylim(0, 500) +
  ggplot2::theme_classic() +
  ggplot2::xlab("Proportion of transition points detected across patients") +
  ggplot2::ylab("# Transition points") +
  ggplot2::coord_cartesian(xlim = c(0, 1))


gridExtra::grid.arrange(p1, p2)

# broader picture for supplementary
p <- ggplot2::ggplot(data) +
  ggplot2::geom_point(ggplot2::aes(intra_patient_prob, inter_patient_prob, fill = patient_ID), size = 3.5, alpha = 0.3, pch = 21) +
  ggplot2::ylim(0, 1) +
  ggplot2::theme_bw() +
  ggplot2::xlab("Intra-patient proportion of samples with shared TPs") +
  ggplot2::ylab("Inter-patient proportion of samples with shared TPs") +
  ggplot2::labs(fill = "Patient IDs") +
  ggplot2::theme(legend.position = "left")

ggExtra::ggMarginal(p, type = "density", fill = "grey", alpha = 0.5)
ggExtra::ggMarginal(p, type = "histogram", fill = "cadetblue", alpha = 0.5)
