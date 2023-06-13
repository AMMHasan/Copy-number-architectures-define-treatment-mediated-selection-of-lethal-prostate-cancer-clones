# load data
load("./figure_data.RData")

# set the pipe operator
"%>%" <- magrittr::`%>%`

# function for drawing tanglegram for defined trees, Congruence Index and it's p-value and Baker's Gamma Index by patient
draw_tanglegram <- function(tree_1, tree_2, C.Index, p.value, patientID) {
  dendextend::dendlist(
    tree_1 %>%
      dendextend::set("branches_lwd", 3) %>%
      dendextend::set("branches_col", "salmon"),
    tree_2 %>%
      dendextend::set("branches_lwd", 3) %>%
      dendextend::set("branches_col", "cadetblue")
  ) %>%
    dendextend::untangle(method = "step2side") %>%
    dendextend::tanglegram(
      common_subtrees_color_lines = T,
      highlight_distinct_edges = FALSE,
      highlight_branches_lwd = F,
      margin_inner = 3,
      lwd = 3,
      color = "darkgrey",
      main_left = "Autosomal",
      cex_main_left = 1,
      main_right = "ChrX-based",
      cex_main_right = 1,
      main = paste0(
        patientID, "\n Baker's Gamma index = ",
        dendextend::cor_bakers_gamma(tree_1, tree_2) %>% round(2),
        "\n Congruence Index = ",
        C.Index,
        "; P-value = ",
        p.value
      ),
      cex_main = 0.7
    )
}

phylogram::write.dendrogram(autosomal_tree_CA63, edges = F)
phylogram::write.dendrogram(chrX_tree_CA63, edges = F)
phylogram::write.dendrogram(autosomal_tree_PEA172, edges = F)
phylogram::write.dendrogram(chrX_tree_PEA172, edges = F)

# for calculating Congruence Index:  https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fmax2.ese.u-psud.fr%2Ficong%2Findex.help.html&amp;data=04%7C01%7C%7C8c7044b2c2c849c1dedd08d8dcad3f30%7C1faf88fea9984c5b93c9210a11d9a5c2%7C0%7C0%7C637501983939372658%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tIIOWOnV2SIsr%2FlVvN%2F4BF5C%2BoAuHivD5ORjrj%2FR5C0%3D&amp;reserved=0
# C.Index for CA63 = 2.05 and p-value = 3.07e-08
# C.Index for PEA172 = 1.50 and p-value = 0.00064

draw_tanglegram(autosomal_tree_CA63, chrX_tree_CA63, 2.05, 3.07e-08, patientID = "CA63")
draw_tanglegram(autosomal_tree_PEA172, chrX_tree_PEA172, 1.50, 0.00064, patientID = "PEA172")
