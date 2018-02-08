#' A qPCR ChIP-seq QC function for Vii7 qPCR machine
#'
#' This function allows you to calculate qPCR Fold Enrichment  
#' @author 
#' Alireza Lorzadeh
#' @param x 'Vii7 result Excel sheet'
#' @param Name '.... Title for you graph, (ie: Projects name and date)'
#' @keywords qpcr
#' @examples
#' @import ggplot2
#' 
#' Follow these steps to run the function:
#' 
#' Install readxl package:
#' install.packages("readxl")
#' 
#' Load the library:
#' library(readxl)
#' 
#' Load the data:
#' <Data Name> <- read_excel("<path to file>",skip = 31)
#' 
#' load ggplot:
#' library(ggplot2)
#' 
#' Run the function:
#' qcQpcr(<Data Name>,'<.... Title for you graph>')
#'
#'   
#'      
#'  Vii7 Data Set Example (Excel sheet):       
#'               
#'  Block Type	384-Well Block									
#'	Calibration Background is expired 	Yes									
#'	Calibration Background performed on 	2015-07-30 15:15:19 PM PDT									
#'	Calibration FAM is expired 	Yes									
#'	Calibration FAM performed on 	2015-07-30 15:49:14 PM PDT									
#'	Calibration ROI is expired 	Yes									
#'	Calibration ROI performed on 	2015-07-30 14:59:46 PM PDT									
#'	Calibration ROX is expired 	Yes									
#'	Calibration ROX performed on 	2015-07-30 15:35:36 PM PDT									
#'	Calibration SYBR is expired 	Yes									
#'	Calibration SYBR performed on 	2015-07-30 15:57:20 PM PDT									
#'	Calibration Uniformity is expired 	Yes									
#'	Calibration Uniformity performed on 	2015-07-30 15:26:19 PM PDT									
#'	Calibration VIC is expired 	Yes									
#'	Calibration VIC performed on 	2015-07-30 16:04:51 PM PDT									
#'	Chemistry	SYBR_GREEN									
#'	Experiment Barcode										
#'	Experiment Comments										
#'	Experiment File Name										
#'	Experiment Name	lINDAjAN22									
#'	Experiment Run End Time	2017-01-20 20:32:38 PM PST									
#'	Experiment Type	Standard Curve									
#'	Experiment User Name										
#'	Instrument Name	278881968									
#'	Instrument Serial Number	278881968									
#'	Instrument Type	ViiA 7									
#'	Passive Reference										
#'	Quantification Cycle Method	Ct									
#'	Signal Smoothing On	false									
#'	Stage/ Cycle where Analysis is performed	Stage 2, Step 2									
#'											
#'	Well	Well Position	Sample Name		Target Name	Task	Reporter	Quencher	CT	Ct Mean	Ct SD
#'	1	A1	Ali_positive	A1	H3K36me3	UNKNOWN	SYBR	None	25.193	24.972	0.313
#'	2	A2	Ali_positive	A1	H3K36me3	UNKNOWN	SYBR	None	24.751	24.972	0.313
#'	3	A3	Ali_positive	A2	H3K4me3	UNKNOWN	SYBR	None	25.697	25.710	0.019
#'	4	A4	Ali_positive	A2	H3K4me3	UNKNOWN	SYBR	None	25.723	25.710	0.019
#'	5	A5	Ali_positive	A3	H3K27me3	UNKNOWN	SYBR	None	27.441	28.853	1.997
#'	6	A6	Ali_positive	A3	H3K27me3	UNKNOWN	SYBR	None	30.266	28.853	1.997
#'	7	A7	Ali_positive	A4	H3K4me1	UNKNOWN	SYBR	None	24.839	24.810	0.041
#'	8	A8	Ali_positive	A4	H3K4me1	UNKNOWN	SYBR	None	24.780	24.810	0.041
#'	9	A9	Ali_positive	A5	H3K9me3	UNKNOWN	SYBR	None	22.599	22.613	0.020
#'	10	A10	Ali_positive	A5	H3K9me3	UNKNOWN	SYBR	None	22.628	22.613	0.020
#'	14	A14	Ali_Input	A-INPUT	H3K36me3	UNKNOWN	SYBR	None	28.004	28.004	
#'	15	A15	Ali_Input	A-INPUT	H3K36me3	UNKNOWN	SYBR	None	Undetermined	28.004	
#'	16	A16	Ali_Input	A-INPUT	H3K4me3	UNKNOWN	SYBR	None	31.282	29.791	2.107
#'	17	A17	Ali_Input	A-INPUT	H3K4me3	UNKNOWN	SYBR	None	28.301	29.791	2.107
#'	18	A18	Ali_Input	A-INPUT	H3K27me3	UNKNOWN	SYBR	None	24.940	26.424	2.099
#'	19	A19	Ali_Input	A-INPUT	H3K27me3	UNKNOWN	SYBR	None	27.908	26.424	2.099
#'	20	A20	Ali_Input	A-INPUT	H3K9me3	UNKNOWN	SYBR	None	27.509	26.876	0.895
#'	21	A21	Ali_Input	A-INPUT	H3K9me3	UNKNOWN	SYBR	None	26.243	26.876	0.895
#'	25	B1	Ali_Negative	A1	H3K36me3	UNKNOWN	SYBR	None	28.515	28.158	0.505
#'	26	B2	Ali_Negative	A1	H3K36me3	UNKNOWN	SYBR	None	27.801	28.158	0.505
#'	27	B3	Ali_Negative	A2	H3K4me3	UNKNOWN	SYBR	None	17.982	17.983	0.001
#'	28	B4	Ali_Negative	A2	H3K4me3	UNKNOWN	SYBR	None	17.984	17.983	0.001
#'	29	B5	Ali_Negative	A3	H3K27me3	UNKNOWN	SYBR	None	26.677	26.708	0.043
#'	30	B6	Ali_Negative	A3	H3K27me3	UNKNOWN	SYBR	None	26.738	26.708	0.043
#'	31	B7	Ali_Negative	A4	H3K4me1	UNKNOWN	SYBR	None	23.196	23.159	0.052
#'	32	B8	Ali_Negative	A4	H3K4me1	UNKNOWN	SYBR	None	23.123	23.159	0.052
#'	33	B9	Ali_Negative	A5	H3K9me3	UNKNOWN	SYBR	None	25.911	26.133	0.315
#'	34	B10	Ali_Negative	A5	H3K9me3	UNKNOWN	SYBR	None	26.356	26.133	0.315
#'	38	B14		NTC	H3K36me3	NTC	SYBR	None	Undetermined		
#'	39	B15		NTC	H3K36me3	NTC	SYBR	None	Undetermined		
#'	40	B16		NTC	H3K4me3	NTC	SYBR	None	Undetermined		
#'	41	B17		NTC	H3K4me3	NTC	SYBR	None	Undetermined		
#'	42	B18		NTC	H3K27me3	NTC	SYBR	None	Undetermined		
#'	43	B19		NTC	H3K27me3	NTC	SYBR	None	Undetermined		
#'	44	B20		NTC	H3K9me3	NTC	SYBR	None	Undetermined		
#'	45	B21		NTC	H3K9me3	NTC	SYBR	None	Undetermined		
#'	49	C1	Sample2_positive	B1	H3K36me3	UNKNOWN	SYBR	None	24.426	24.343	0.117
#'	50	C2	Sample2_positive	B1	H3K36me3	UNKNOWN	SYBR	None	24.260	24.343	0.117
#'	51	C3	Sample2_positive	B2	H3K4me3	UNKNOWN	SYBR	None	25.490	25.470	0.029
#'	52	C4	Sample2_positive	B2	H3K4me3	UNKNOWN	SYBR	None	25.450	25.470	0.029
#'	53	C5	Sample2_positive	B3	H3K27me3	UNKNOWN	SYBR	None	26.351	26.312	0.055
#'	54	C6	Sample2_positive	B3	H3K27me3	UNKNOWN	SYBR	None	26.273	26.312	0.055
#'	55	C7	Sample2_positive	B4	H3K4me1	UNKNOWN	SYBR	None	24.452	24.307	0.205
#'	56	C8	Sample2_positive	B4	H3K4me1	UNKNOWN	SYBR	None	24.162	24.307	0.205
#'	57	C9	Sample2_positive	B5	H3K9me3	UNKNOWN	SYBR	None	23.149	23.144	0.007
#'	58	C10	Sample2_positive	B5	H3K9me3	UNKNOWN	SYBR	None	23.139	23.144	0.007
#'	62	C14	Sample2_Input	B-INPUT	H3K36me3	UNKNOWN	SYBR	None	28.284	28.106	0.252
#'	63	C15	Sample2_Input	B-INPUT	H3K36me3	UNKNOWN	SYBR	None	27.928	28.106	0.252
#'	64	C16	Sample2_Input	B-INPUT	H3K4me3	UNKNOWN	SYBR	None	32.615	32.400	0.303
#'	65	C17	Sample2_Input	B-INPUT	H3K4me3	UNKNOWN	SYBR	None	32.186	32.400	0.303
#'	66	C18	Sample2_Input	B-INPUT	H3K27me3	UNKNOWN	SYBR	None	25.584	25.743	0.225
#'	67	C19	Sample2_Input	B-INPUT	H3K27me3	UNKNOWN	SYBR	None	25.902	25.743	0.225
#'	68	C20	Sample2_Input	B-INPUT	H3K9me3	UNKNOWN	SYBR	None	28.429	28.414	0.021
#'	69	C21	Sample2_Input	B-INPUT	H3K9me3	UNKNOWN	SYBR	None	28.399	28.414	0.021
#'	73	D1	Sample2_Negative	B1	H3K36me3	UNKNOWN	SYBR	None	28.756	28.662	0.132
#'	74	D2	Sample2_Negative	B1	H3K36me3	UNKNOWN	SYBR	None	28.569	28.662	0.132
#'	75	D3	Sample2_Negative	B2	H3K4me3	UNKNOWN	SYBR	None	17.547	17.538	0.012
#'	76	D4	Sample2_Negative	B2	H3K4me3	UNKNOWN	SYBR	None	17.530	17.538	0.012
#'	77	D5	Sample2_Negative	B3	H3K27me3	UNKNOWN	SYBR	None	26.061	26.074	0.019
#'	78	D6	Sample2_Negative	B3	H3K27me3	UNKNOWN	SYBR	None	26.088	26.074	0.019
#'	79	D7	Sample2_Negative	B4	H3K4me1	UNKNOWN	SYBR	None	22.784	22.796	0.017
#'	80	D8	Sample2_Negative	B4	H3K4me1	UNKNOWN	SYBR	None	22.808	22.796	0.017
#'	81	D9	Sample2_Negative	B5	H3K9me3	UNKNOWN	SYBR	None	26.750	26.798	0.068
#'	82	D10	Sample2_Negative	B5	H3K9me3	UNKNOWN	SYBR	None	26.847	26.798	0.068
NULL

library(ggplot2)
globalVariables(c("Sample", "FoldEn","Target"))
qcQpcr <- function(xx,Name) {
  
  
  Data<-data.frame(Sample = character(),
                   Mark = character(), 
                   Target = character(),
                   FoldEn = numeric(0))
  
  x<-xx[-(grep('NTC',xx$`Sample Name`)),]
  b<-unique(x$`Sample Name`)
  b<-b[!(is.na(b))]
  c<-b
  c<-sub("*_.*","",c)
  c<-c(unique(c))
  bb<-x[grep("positive",x$`Sample Name`),]
  d<-unique(bb$`Target Name`)
  d<-d[!(is.na(d))]
  i <- 1
  for (i in i:length(d)){
    
    ii <- 1
    
    for (ii in ii:length(c)){
      
      if(d[i] == "H3K4me1"){
        
      
      temp<-c[ii]
      mark<- x[grep(d[i],x$`Target Name`),]
      pos<-mark[grep(paste(c[ii], "positive", sep="_"),mark$`Sample Name`),]
      pos<- pos[!duplicated( pos$`Ct Mean`),]
      neg<-mark[grep(paste(c[ii], "Negative", sep="_"),mark$`Sample Name`),]
      neg<- neg[!duplicated( neg$`Ct Mean`),]
      mark<- x[grep('H3K36me3',x$`Target Name`),]
      inp<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
      inp<- inp[!duplicated( inp$`Ct Mean`),]
      mark<- x[grep('H3K9me3',x$`Target Name`),]
      inp_neg<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
      inp_neg<- inp[!duplicated( inp$`Ct Mean`),]
      
      p<-2^(inp$`Ct Mean` - pos$`Ct Mean`)
      n<-2^(inp_neg$`Ct Mean` - neg$`Ct Mean`)
      
      data<-data.frame(Sample = c(temp,temp),
                       Mark = c(d[i],d[i]), 
                       Target = c('Positive',"Negative"),
                       FoldEn = c(p,n))
      
     
      } 
            if(d[i] == "H3K4me3") {
                    temp<-c[ii]
                    mark<- x[grep(d[i],x$`Target Name`),]
                    pos<-mark[grep(paste(c[ii], "positive", sep="_"),mark$`Sample Name`),]
                    pos<- pos[!duplicated( pos$`Ct Mean`),]
                    neg<-mark[grep(paste(c[ii], "Negative", sep="_"),mark$`Sample Name`),]
                    neg<- neg[!duplicated( neg$`Ct Mean`),]
                    inp<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                    inp<- inp[!duplicated( inp$`Ct Mean`),]
                    mark<- x[grep('H3K27me3',x$`Target Name`),]
                    inp_neg<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                    inp_neg<- inp[!duplicated( inp$`Ct Mean`),]
                    
                    p<-2^(inp$`Ct Mean` - pos$`Ct Mean`)
                    n<-2^(inp_neg$`Ct Mean` - neg$`Ct Mean`)
                    
                    data<-data.frame(Sample = c(temp,temp),
                                     Mark = c(d[i],d[i]), 
                                     Target = c('Positive',"Negative"),
                                     FoldEn = c(p,n))
                    
                    
            }
              
              if(d[i] == "H3K9me3") {
                temp<-c[ii]
                mark<- x[grep(d[i],x$`Target Name`),]
                pos<-mark[grep(paste(c[ii], "positive", sep="_"),mark$`Sample Name`),]
                pos<- pos[!duplicated( pos$`Ct Mean`),]
                neg<-mark[grep(paste(c[ii], "Negative", sep="_"),mark$`Sample Name`),]
                neg<- neg[!duplicated( neg$`Ct Mean`),]
                inp<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                inp<- inp[!duplicated( inp$`Ct Mean`),]
                mark<- x[grep('H3K27me3',x$`Target Name`),]
                inp_neg<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                inp_neg<- inp[!duplicated( inp$`Ct Mean`),]
                
                p<-2^(inp$`Ct Mean` - pos$`Ct Mean`)
                n<-2^(inp_neg$`Ct Mean` - neg$`Ct Mean`)
                
                data<-data.frame(Sample = c(temp,temp),
                                 Mark = c(d[i],d[i]), 
                                 Target = c('Positive',"Negative"),
                                 FoldEn = c(p,n))
                
                
              } 
      if(d[i] == "H3K27me3") {
                  temp<-c[ii]
                  mark<- x[grep(d[i],x$`Target Name`),]
                  pos<-mark[grep(paste(c[ii], "positive", sep="_"),mark$`Sample Name`),]
                  pos<- pos[!duplicated( pos$`Ct Mean`),]
                  neg<-mark[grep(paste(c[ii], "Negative", sep="_"),mark$`Sample Name`),]
                  neg<- neg[!duplicated( neg$`Ct Mean`),]
                  inp<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                  inp<- inp[!duplicated( inp$`Ct Mean`),]
                  mark<- x[grep('H3K9me3',x$`Target Name`),]
                  inp_neg<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                  inp_neg<- inp[!duplicated( inp$`Ct Mean`),]
                  
                  p<-2^(inp$`Ct Mean` - pos$`Ct Mean`)
                  n<-2^(inp_neg$`Ct Mean` - neg$`Ct Mean`)
                  
                  data<-data.frame(Sample = c(temp,temp),
                                   Mark = c(d[i],d[i]), 
                                   Target = c('Positive',"Negative"),
                                   FoldEn = c(p,n))
                  
                  
                }
                
                  if(d[i] == "H3K36me3") {
                    temp<-c[ii]
                    mark<- x[grep(d[i],x$`Target Name`),]
                    pos<-mark[grep(paste(c[ii], "positive", sep="_"),mark$`Sample Name`),]
                    pos<- pos[!duplicated( pos$`Ct Mean`),]
                    neg<-mark[grep(paste(c[ii], "Negative", sep="_"),mark$`Sample Name`),]
                    neg<- neg[!duplicated( neg$`Ct Mean`),]
                    inp<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                    inp<- inp[!duplicated( inp$`Ct Mean`),]
                    mark<- x[grep('H3K9me3',x$`Target Name`),]
                    inp_neg<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                    inp_neg<- inp[!duplicated( inp$`Ct Mean`),]
                    
                    p<-2^(inp$`Ct Mean` - pos$`Ct Mean`)
                    n<-2^(inp_neg$`Ct Mean` - neg$`Ct Mean`)
                    
                    data<-data.frame(Sample = c(temp,temp),
                                     Mark = c(d[i],d[i]), 
                                     Target = c('Positive',"Negative"),
                                     FoldEn = c(p,n))
                    
                    
                  }
                
                    if(d[i] == "H3K36me3") {
                      temp<-c[ii]
                      mark<- x[grep(d[i],x$`Target Name`),]
                      pos<-mark[grep(paste(c[ii], "positive", sep="_"),mark$`Sample Name`),]
                      pos<- pos[!duplicated( pos$`Ct Mean`),]
                      neg<-mark[grep(paste(c[ii], "Negative", sep="_"),mark$`Sample Name`),]
                      neg<- neg[!duplicated( neg$`Ct Mean`),]
                      mark<- x[grep('H3K4me3',x$`Target Name`),]
                      inp<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                      inp<- inp[!duplicated( inp$`Ct Mean`),]
                      mark<- x[grep('H3K9me3',x$`Target Name`),]
                      inp_neg<-mark[grep(paste(c[ii], "Input", sep="_"),mark$`Sample Name`),]
                      inp_neg<- inp[!duplicated( inp$`Ct Mean`),]
                      
                      p<-2^(inp$`Ct Mean` - pos$`Ct Mean`)
                      n<-2^(inp_neg$`Ct Mean` - neg$`Ct Mean`)
                      
                      data<-data.frame(Sample = c(temp,temp),
                                       Mark = c(d[i],d[i]), 
                                       Target = c('Positive',"Negative"),
                                       FoldEn = c(p,n))
                      
                      
                    }
      
      Data<-rbind(Data,data)
            }
      }
   
    x <- y <- NULL
  ggplot(Data,aes(x=Sample,y=FoldEn,fill=Target))+
    geom_bar(stat="identity",position=position_dodge())+
    scale_fill_manual(values=c("red","blue"))+
    facet_wrap(~Mark,scales="free")+
    ggtitle(Name)
    
  }
  

    