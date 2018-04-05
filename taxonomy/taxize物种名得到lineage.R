# --------------
# Date:  2018-02-27 11:25:40 
# Author:yuanquan
# Email: quan575@qq.com
# --------------
# About project:
# 
require(taxize)

Args=commandArgs(T)
#setwd("/testdata/taxize/");
Args=c('data/species_name.txt','data/out.txt')

file_input=Args[1]  #输入文件名
file_out  =Args[2]  #输出名


specieslist<-read.table(file_input,sep = '\t',stringsAsFactors = F)[,1]

dict_pre<-list("superkingdom"='sk__',"kingdom"='k__',"phylum"='p__',"class"="c__",
               "order"="o__","family"="f__","genus"="g__","species"="s__")

#返回的lineage 结果加上前缀，并用分号连接 
lineage_addpre<-function(relineage){
  if (is.na(relineage)){return(NA)}
  relineage_p<-relineage[relineage$rank %in% names(dict_pre),] #删除norank的级别
  relineage_p$pre<-dict_pre[relineage_p$rank]   #得到前缀
  relineage_p$pre_sp<- paste(relineage_p$pre,relineage_p$name,sep = '') #前缀与物种连接
  relineage_o<-paste(relineage_p$pre_sp,collapse =';') #所有级别用;连接
  return(gsub(' ','_',relineage_o)) #替换 空格为下划线
}

#classification(c("Bacteria"), db = 'ncbi')

get_lineage<-classification(unique(specieslist), db = 'ncbi',rows = 2) #获取lineage
get_lineage_list<-lapply(get_lineage,lineage_addpre) #加上前缀

get_lineage_df<-as.matrix(get_lineage_list[specieslist])

write.table(get_lineage_df,file = file_out,col.names = F,sep = '\t')




