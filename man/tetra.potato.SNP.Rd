\name{tetra.potato.SNP}
\alias{tetra.potato.SNP}
\docType{data}
\title{ SNP data for tetraploid potato }
\description{
Contains data for set of 384 SNP markers from Illumina GoldenGate arrays of 224 tetraploid potato varieties covering a wide range with respect to
geographic origin, year of first registration and intended application.
}
\usage{data(tetra.potato.SNP)}
\format{
  A data frame with 86016 observations on the following 6 variables.
  \describe{
    \item{\code{MarkerName}}{a factor with levels \code{PotSNP001} to \code{PotSNP384}}
    \item{\code{SampleName}}{a factor with 224 levels}
    \item{\code{X_Raw}}{a numeric vector, raw intensity of first channel}
    \item{\code{Y_Raw}}{a numeric vector, raw intensity of second channel}
    \item{\code{Theta}}{a numeric vector, angle in (2/pi)*radials and first polar coordinate, obtained from GenomeStudio}
    \item{\code{R}}{a numeric vector, radius and second polar coordinate, obtained from GenomeStudio}
  }
}
\source{Described in Anithakumari AM, J Tang, HJ van Eck, RFG Visser, JAM Leunissen, B Vosman, CG van der Linden (2010). \emph{A pipeline for high throughput detection 
and mapping of SNPs from EST databases}. Mol. Breeding 26: 65-75 }
\examples{data(tetra.potato.SNP)}
\keyword{datasets}
