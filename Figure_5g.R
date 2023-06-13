# load data
load("./figure_data.RData")

# plot normalized AR expression in PEA172 by clusters
ggplot2::ggplot(data = ARV12mimic, ggplot2::aes(x = clusterID, y = AR_norm)) +
  ggplot2::geom_jitter(width = 0.1, ggplot2::aes(fill = ARV12mimic), size = 4, pch = 21) +
  ggplot2::theme_classic() +
  ggplot2::xlab("SCRATCH cluster") +
  ggplot2::ylab("Normalized AR expression") +
  ggplot2::scale_fill_discrete(name = "AR-V12 mimics")

# Fisher's exact test comparing expression of AR-V12 mimics in both clusters

table(ARV12mimic$clusterID, ARV12mimic$ARV12mimic) %>% 
  fisher.test()

