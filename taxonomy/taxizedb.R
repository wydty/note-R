#install.packages('taxizedb')
#install.packages('taxonomizr')

#devtools::install_local('C:/Users/quan/Desktop/taxizedb-master')
#install.packages('curl')
#install.packages('RSQLite')
#install.packages('rlang')
options(timeout=100)



library(taxizedb)
children(3701, db='ncbi')
classification(3702, db='ncbi')


#db_download_col()
db_download_ncbi()
# ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdmp.zip
# tdb_cache$cache_path_get()

