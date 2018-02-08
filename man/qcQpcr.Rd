\name{qcQpcr}
\alias{qcQpcr}
\title{Histone ChIP-Seq qPCR Analyzer}
\usage{
qcQpcr(xx, Name)
}
\arguments{
\item{xx}{'Your Data Set'}

\item{Name}{'.... Title for you graph, (ie: Projects name and date)'}
}
\description{
Quality control of chromatin immunoprecipitation libraries (ChIP-seq) by quantitative polymerase chain reaction (qPCR). This function calculates Enrichment value with respect to reference for each histone modification (specific to 'Vii7' software <http://www.thermofisher.com/ca/en/home/life-science/pcr/real-time-pcr/real-time-pcr-instruments/viia-7-real-time-pcr-system/viia-7-software.html>). This function is applicable to full panel of histone modifications described by International Human Epigenomic Consortium (IHEC).
}
\examples{

library(ggplot2)
data(SampleTest)
qcQpcr(SampleTest,'Title for your graph')

}
\author{
Alireza Lorzadeh
}
\keyword{qpcr}
