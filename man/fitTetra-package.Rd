\name{fitTetra-package}
\alias{fitTetra-package}
\docType{package}
\title{Fits mixture models for genotype calling in tetraploid species}
\description{
Package fitTetra contains three functions that can be used to assign genotypes to a collection of 
tetraploid samples based on biallelic marker assays. Functions fitTetra (to fit several models for 
one marker from the data and select the best fitting) or saveMarkerModels (calls fitTetra for 
multiple markers and saves the results to files) will probably be the most convenient to use. 
Function CodomMarker offers more control and fits one specified model for a given marker.
}

\details{
\tabular{ll}{
Package: \tab fitTetra\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-04-23\cr
License: \tab GPL (>= 2)\cr
LazyLoad: \tab yes\cr
}
}

\author{
Roeland Voorrips: <roeland.voorrips@wur.nl> and Gerrit Gort: <gerrit.gort@wur.nl>
}

\references{
Voorrips, RE, G Gort, B Vosman (2011) \emph{Genotype calling in tetraploid species from bi-allelic marker data using mixture models} BMC Bioinformatics 12: 172.
}

\keyword{ package }
\examples{
data(tetra.potato.SNP)
data(diplo.potato.SNP)
SNP4 <- subset(tetra.potato.SNP, MarkerName=='PotSNP004')
# Single marker, single mixture model
rawratio <- SNP4$X_Raw/(SNP4$X_Raw+SNP4$Y_Raw) 
unmix <- CodomMarker(rawratio)

# Single marker, multiple mixture models
# df.tetra <- with(tetra.potato.SNP, data.frame(MarkerName=MarkerName, 
#                   SampleName=SampleName, ratio=X_Raw/(X_Raw+Y_Raw)))
# df.diplo <- with(diplo.potato.SNP, data.frame(MarkerName=MarkerName, 
#                  SampleName=SampleName, ratio=X_Raw/(X_Raw+Y_Raw)))

# unmix <- fitTetra(marker=6, data=df.tetra)
# unmix <- fitTetra(marker=6, data=df.tetra, plot='fitted')
# unmix <- fitTetra(marker=6, data=df.tetra, diplo=df.diplo, plot='all')

# Multiple markers (3 are chosen), multiple mixture models
# saveMarkerModels(markers=4:6, data=df.tetra, diplo=df.diplo, plot='all',
#                  maxiter=40, logfile='output.log', modelfile='mixresults.dat',
#                  allmodelsfile='allmixresults.dat', scorefile='scores.dat')
}

\seealso{
  \code{\link[fitTetra]{CodomMarker}}
  \code{\link[fitTetra]{fitTetra}}
  \code{\link[fitTetra]{saveMarkerModels}}
}