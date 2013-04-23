\name{saveMarkerModels}
\alias{saveMarkerModels}
\title{
A function to fit mixture models for series of markers and save the results to files
}
\description{
This is a convenience function that calls fitTetra for a series of markers and saves the tabular, graphical and log output to files.
Most of the arguments are identical to those of fitTetra and are directly passed through.}
\usage{
saveMarkerModels(markers = NA, data, diplo = NA, select = TRUE, diploselect = TRUE, 
                 maxiter = 40, maxn.bin = 200, nbin = 200, sd.threshold = 0.1, 
                 p.threshold = 0.99, call.threshold = 0.6, peak.threshold = 0.85, 
                 try.HW = TRUE, dip.filter = 1, sd.target = NA, ncores = NA, 
                 logfile = "", modelfile, allmodelsfile = "", scorefile, 
                 diploscorefile = "", plot = "none", plot.type = "png")
}
\arguments{
  \item{markers}{
an integer vector listing the marker numbers to be analyzed. The numbers refer to the levels of data$MarkerName. If NA (default) all markers are analyzed.
}
  \item{data}{
data frame for tetraploid samples, with (at least) columns "MarkerName", "SampleName", and "ratio", where ratio is the a allele signal divided by the sum of the a and b allele signals (ratio = a/(a+b ).
}
  \item{diplo}{
data frame like "data" with diploid samples. Facultative, does not affect model fitting. Diploid samples will be plotted in the plots of the best-fitting models if argument plot is "fitted" or "all". Genotypic scores for diploid samples are calculated according to the best-fitting models and are therefore from 0 (nulliplex) to 4 (quadruplex), as for the tetraploid samples.
}
  \item{select}{
boolean vector, recycled if shorter than the columns in data: indicates which rows are to be used (default: select=TRUE, i.e. keep all rows)
}
  \item{diploselect}{
as select, for diplo instead of data
}
  \item{maxiter}{
integer: the maximum number of times the nls function is called in CodomMarker (0 = no limit, default=500)
}
  \item{maxn.bin}{
integer, passed to CodomMarker, see there for explanation
}
  \item{nbin}{
integer, passed to CodomMarker, see there for explanation
}
  \item{sd.threshold}{
the maximum value allowed for the (constant) standard deviation on the arcsine - square root transformed scale, default 0.1. If the optimal model has a larger standard deviation the marker is rejected.
}
  \item{p.threshold}{
the minimum P-value required to assign a genotype to a sample; default 0.99. If the P-value for all 5 possible genotypes is less than p.threshold the sample is assigned genotype NA.
}
  \item{call.threshold}{
the minimum fraction of samples to have genotypes assigned ("called"); default 0.6. If under the optimal model the fraction of "called" samples is less than call.threshold the marker is rejected.
}
  \item{peak.threshold}{
the maximum allowed fraction of the scored samples that are in one peak; default 0.85. If any of the possible genotypes (peaks in the ratio histogram) contains more than peak.threshold of the samples the marker is rejected (because the remaining samples offers too little information for reliable model fitting)
}
  \item{try.HW}{
boolean: if TRUE (default), try models with and without a constraint on the mixing proportions according to Hardy-Weinberg equilibrium ratios. If FALSE, only try models without this constraint.
}
  \item{dip.filter}{
integer: if 1 (default), select best model only from models that do not have a dip (a lower peak surrounded by higher peaks: these are not expected under Hardy-Weinberg equilibrium or in cross progenies). If all fitted models have a dip still the best of these is selected. If 2, similar, but if all fitted models have a dip the marker is rejected. If 0, select from all fitted models including those with a dip.
}
  \item{sd.target}{
if the fitted standard deviation on the transformed scale is larger than sd.target a penalty is given (see Details); default NA i.e. no penalty is given.
}
  \item{ncores}{
integer: the number of processor cores that can be used for parallel processing. If NA (default) or 1 no parallelization takes place. On operating systems other than Unix / Linux, or if the packages doMC and foreach are not installed the ncores argument is ignored.
}
  \item{logfile}{
string, name of a text file. This file will contain several text lines per marker corresponding to component "log" in the result of fitTetra. If "" (default) no file is created. The directory for the plot files will be named as the log file preceded by "plots_" and without the extension ".log"; or simply "plots" if no logfile is specified. 
}
  \item{modelfile}{
string, name of a text file. This file will contain one line per marker corresponding to component "modeldata" in the result of fitTetra. modelfile can be read using read.table. This argument is required and has no default value.
}
  \item{allmodelsfile}{
string, name of a text file. This file will contain 16 or 24 lines per marker, corresponding to component "allmodeldata" in the result of fitTetra. allmodelsfile can be read using read.table. If "" (default) no file is created.
}
  \item{scorefile}{
string, name of a text file. This file will contain one line per sample for every marker that could be fitted, corresponding to component "scores" in the result of fitTetra. scorefile can later be read using read.table. This argument is required and has no default value.
}
\item{diploscorefile}{
string, name of a text file. This file will contain one line per sample in diplo for every marker that could be fitted, corresponding to component "diploscores" in the result of fitTetra. diploscorefile can later be read using read.table. If "" (default) no file is created.
}
  \item{plot}{
string, "none" (default), "fitted" or "all". Same as argument plot in fitTetra. 
}
  \item{plot.type}{
string, "png" (default), "emf", "svg" or "pdf". Indicates format for saving the plots. Same as argument plot.type in fitTetra.
}
}
\details{
No further details.
}
\value{
This function does not return a value.
}
\references{
Voorrips, RE, G Gort, B Vosman (2011) \emph{Genotype calling in tetraploid species from bi-allelic marker data using mixture models} BMC Bioinformatics 12: 172.
}
\author{
Roeland Voorrips: <roeland.voorrips@wur.nl>
}
\examples{
data(tetra.potato.SNP)
data(diplo.potato.SNP)

df.tetra <- with(tetra.potato.SNP, data.frame(MarkerName=MarkerName, 
                 SampleName=SampleName, ratio=X_Raw/(X_Raw+Y_Raw)))
df.diplo <- with(diplo.potato.SNP, data.frame(MarkerName=MarkerName, 
                 SampleName=SampleName, ratio=X_Raw/(X_Raw+Y_Raw)))

# Multiple markers (only 1 is chosen here), multiple mixture models
saveMarkerModels(markers=87:87, data=df.tetra, diplo=df.diplo, plot='fitted', 
         try.HW=FALSE, modelfile = 'modelfile.dat', scorefile='scorefile.dat')
}

\keyword{ utilities}

\seealso{
  \code{\link[fitTetra]{CodomMarker}}
  \code{\link[fitTetra]{fitTetra}}
  \code{\link[fitTetra]{fitTetra-package}}
}
