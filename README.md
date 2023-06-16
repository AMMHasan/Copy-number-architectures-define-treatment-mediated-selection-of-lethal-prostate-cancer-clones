# Copy-number-architectures-define-treatment-mediated-selection-of-lethal-prostate-cancer-clones

Below are brief descriptions of each code and accompanied source data provided:


Figure 2 was generated using GraphPad Prism by connecting the dots representing the proportion of mets with gain for Chr:X 500kb bins from data_fig2 (copy number for 299 bins of 0.5Mb in size, along Chromosome X, across patients along with proportion of gain for each patient calculated). The area below the line was subsequently colored using Adobe Illustrator.

#Figure_3a.R:
The R codes for Figure 3a use the data_fig3a, from Source_Data.RData object provided with this git project, to generate the map of structural variant break-points at the AR locus on chromosome X. The data are also provided as data_fig3a sheet in Source_Data.xlsx file. 

#Figure_3b.R:
The R codes for Figure 3b use the data_fig3b, from Source_Data.RData object provided with this git project, to calculate Cancer Cell Fractions. data_fig3b contains 11 columns: SampleID, metID, Chr, Start_pos_of_SV, End_of_SV, SV_type, ref_read_number, Variant_read_number, Tumour_content, Chromosoe_copy_number_of_Tumor and Chromosome_copy_number_Normal. This data can also be found as data_fig3b sheet in Source_Data.xlsx file.

#Figure_3c.R:
Similar to codes for Figure 3c, this code uses the data_fig3c from Source_Data.RData object provided with this git project.  Alternatively, the data are also provided as data_fig3c sheet in Source_Data.xlsx file.

#Figure_4a.R:
R codes for Figure 4a use the data_fig4a from Source_Data.RData object and calculates the intra- and inter-patient commonality of copy number transition points detected as diagnosis with that in the metastases harvested at post-mortem. The data can also be found as data_fig4a sheet in Source_Data.xlsx file.

#Figure_4b.R:
This code snippet utilizes data_fig4b from Source_Data.RData object and generates line graphs depecting percent transtion points detected in plasma at death as a function of the number of autopsy samples from the same patient. The data are also provided as data_fig4b sheet in Source_Data.xlsx file.

#Figure_4c.R:
This code snippet uses data_fig4c from Source_Data.RData object to generate stacked bars showing different percentages (<20%, 20-80% and >80%) of shared copy number transition points among autopsy samples in patient CA27. The data can also be found as data_fig4c sheet in Source_Data.xlsx file.


#Figure_4d.R:
This code snippet uses data_fig4d, autosomal_tree_CA63 (a tree object) and cluster_assignment_CA63 data frame from Source_Data.RData object to generate heatmap which clearly visualizes the cluster of metastases which are proposed to be mediated by properties of dominated clones. The data (except for the tree object) can also be found as data_fig4d and cluster_assignment_CA63 in separate sheets in Source_Data.xlsx file.


#Figure_4f.R:
The R codes for Figure 4f imply dNdScv model on the clonal_mutations data from Source_Data.RData object (provided in this repo), and utilizes the annotations to select for non-silent (clonal) mutations. Then calculate the per cent common clonal mutations in combination of 2 mets from each patient and merge it with the data correlation_distances (also from Source_Data.RData object). Then generate figures showing (1) the distribution of per cent common clonal non-silent mutations in compared pairs that are within the same cluster (assigned by SCRATCH algorithm) or not and (1) as a function of correlation distances. The data are also provided as clonal_mutations and correlation_distances in different sheets in Source_Data.xlsx file.

#Figure_5ab.R:
The R code snippet for Figure 5a and 5b uses autosomal_tree_CA63, chrX_tree_CA63, autosomal_tree_PEA172 and chrX_tree_PEA172 (from Source_Data.RData object) along with pre-calculated Congruence Indices and p-values form respective patient data (dendrogram from the tree objects) to generate tanglegrams.

#Figure_5c.R:
This R code snippet utilizes the count_data and meta_data_RNAseq data from Source_Data.RData object provided with this git project. It also uses AR-related gene set from hieronymus_geneset (also provided in Source_data.RData) to calculate AR scores and plot them as a function of Normalized AR expression values. Then it also measures the statistical significance of the correlation by the patient. These three dataframes are also provided in different work-sheets in Source_Data.xlsx file.

#Figure_5g.R:
The R code snippet for Figure 5g uses the ARV12_mimic from Source_Data.RData object to depict the distribution of normalized AR expression and the distribution of AR-V12 mimics in two SCRATCH-defined clusters. ARV12_mimic data are also provided as  ARV12_mimic sheet in Source_Data.xlsx file.





