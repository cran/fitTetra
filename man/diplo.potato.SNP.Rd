\name{diplo.potato.SNP}
\alias{diplo.potato.SNP}
\docType{data}
\title{ SNP data for diploid potato }
\description{
Contains data for set of 384 SNP markers from Illumina GoldenGate arrays of 64 diploid potato varieties. SNP markers are identical to those in tetraploid dataset.
}
\usage{data(diplo.potato.SNP)}
\format{
  A data frame with 24576 observations on the following 6 variables.
  \describe{
    \item{\code{MarkerName}}{a factor with levels \code{PotSNP001} to \code{PotSNP384}}
    \item{\code{SampleName}}{a factor with 64 levels}
    \item{\code{X_Raw}}{a numeric vector, raw intensity of first channel}
    \item{\code{Y_Raw}}{a numeric vector, raw intensity of second channel}
    \item{\code{Theta}}{a numeric vector, angle in (2/pi)*radials and first polar coordinate, obtained from GenomeStudio}
    \item{\code{R}}{a numeric vector, radius and second polar coordinate, obtained from GenomeStudio}
  }
}
\source{
Described in Anithakumari AM, J Tang, HJ van Eck, RFG Visser, JAM Leunissen, B Vosman, CG van der Linden (2010). \emph{A pipeline for high throughput detection and mapping of SNPs from EST databases}. Mol. Breeding 26: 65-75
}
\examples{
data(diplo.potato.SNP)
}
\keyword{datasets}
