# load data:
load("./figure_data.RData")

# set the pipe operator
"%>%" <- magrittr::`%>%`

# calculating CCF
data_fig3b %>% dplyr::mutate(
  AF = var_read_number / (var_read_number + ref_read_number),
  adjusted_AF = AF / TC,
  u = adjusted_AF * ((TC * T_CCN) + ((1 - TC) * N_CCN)),
  m = dplyr::case_when(
    u >= 1 ~ abs(u),
    u < 1 ~ 1
  ),
  CCF = u / m,
  comment = dplyr::case_when(
    CCF == 1 ~ "Clonal",
    CCF == 0 ~ "NA",
    CCF < 1 ~ "Subclonal"
  )
)

