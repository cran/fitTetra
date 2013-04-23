\name{fitTetra}
\alias{fitTetra}
\title{
Function to fit multiple mixture models to signal ratios of a single bi-allelic marker.

}
\description{
This function takes a data frame with allele signal ratios for multiple bi-allelic markers and 
samples, and fits multiple mixture models to a selected marker. It returns a list, reporting 
on the performance of these models, selecting the best one based on the BIC criterion, 
optionally plotting results.
}
\usage{
fitTetra(marker, data, diplo = NA, select = TRUE, diploselect = TRUE, maxiter = 40, 
         maxn.bin = 200, nbin = 200, sd.threshold = 0.1, p.threshold = 0.99, 
         call.threshold = 0.6, peak.threshold = 0.85, try.HW = TRUE, dip.filter = 1, 
         sd.target =  NA, plot = "none", plot.type = "png", plot.dir = NA)
}
\arguments{
  \item{marker}{
integer: specifies the marker number to analyze. "marker" is the index to the alphabetically sorted MarkerNames (see argument "data")
}
  \item{data}{
data frame for tetraploid samples, with (at least) columns "MarkerName", "SampleName", and "ratio", where ratio is the a allele signal divided by the sum of the a and b allele signals (ratio = a/(a+b)).
}
  \item{diplo}{
data frame like "data" with diploid samples. Facultative, does not affect model fitting. Diploid samples will be plotted in the plot of the best-fitting model if argument plot is "fitted" or "all". Genotypic scores for diploid samples are calculated according to the best-fitting model and are therefore from 0 (nulliplex) to 4 (quadruplex), as for the tetraploid samples.
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
the maximum allowed fraction of the scored samples that are in one peak; default 0.85. If any of the possible genotypes (peaks in the ratio histogram) contains more than peak.threshold of the samples the marker is rejected (because the remaining samples offer too little information for reliable model fitting)
}
  \item{try.HW}{
boolean: if TRUE (default), try models with and without a constraint on the mixing proportions according to Hardy-Weinberg equilibrium ratios. If FALSE, only try models without this constraint.
}
  \item{dip.filter}{
integer: if 1 (default), select best model only from models that do not have a dip (a lower peak surrounded by higher peaks: these are not expected under Hardy-Weinberg equilibrium or in cross progenies). If all fitted models have a dip still the best of these is selected. If 2, similar, but if all fitted models have a dip the marker is rejected. If 0, select from all fitted models including those with a dip.
}
  \item{sd.target}{
If the fitted standard deviation on the transformed scale is larger than sd.target a penalty is given (see Details); default NA i.e. no penalty is given.
}
  \item{plot}{
string, "none" (default), "fitted" or "all". If "fitted" a plot of the best fitting model and the assigned genotypes is saved with filename <marker number><marker name>.<plot.type>, preceded by "rejected_" if the marker was rejected. If "all" small images of all models are saved to files (8 per file) with filename <"plots"><marker number><A/B/C/D><marker name>. <plot.type> in addition to the plot of the best fitting model.
}
  \item{plot.type}{
string, "png" (default), "emf", "svg" or "pdf". Indicates format for saving the plots. If "emf" and the operating system is not Windows, "png" is used. If "emf" and the package "devEMF" is not installed, or if the specified format canot be produced for any other reason, "png" is used.
}
  \item{plot.dir}{
The directory where the plot files are to be saved; default NA. i.e. plot files saved in working directory.
}
}
\details{
fitTetra fits a series of mixture models for the given marker by repeatedly calling CodomMarker and selects the optimal one. 
The models tested have four different models for the means of the mixture components: mutype 1, 2, 5 and 6 as described for CodomMarker, 
and one or two (depending on argument try.HW) models for the mixing proportions. These four or eight models are run using 2 or 3 different start configurations. 
The model with the smallest Bayesian Information Criterion (BIC) is selected, within the constraints specified by dip.filter. If sd.target is specified, the selection criterion is equal to BIC for models where (on the transformed scale) sd<sd.target, and to (sd.target/sd)*BIC where sd>sd.target (since BIC is negative, a larger sd results in a larger selection criterion which is less likely to be the minimum).
The final model selected according to these criteria is then checked against call.threshold and peak.threshold and may still be rejected, in which case no fitted model is reported.

}
\value{
a list with components:
\item{log}{a character vector with the lines of the log text}
\item{modeldata}{a data frame with one row with the marker number, marker name, number of samples and (if the marker is not rejected) data of the fitted model (see below)}
\item{allmodeldata}{a data frame with for each tried model one row with the marker number, marker name, number of samples and (if the marker is not rejected) data of the fitted model (see below)}
\item{scores}{a data frame with the name and data for all samples (including NA's for the samples that were not selected, see parameter select): marker (same as argument marker), MarkerName, SampleName, model (a string describing the model),select (value of argument select for this data point),ratio (the given ratio from argument data), P0,P1,P2,P3,P4 (the probabilities that this sample belongs to each of the five mixture components),
maxgeno (the genotype = mixture component with the highest P value), maxP (the P value for this genotype) and geno (the assigned genotype number: same as maxgeno, or NA if maxP<p.threshold). Maxgeno and geno numbers from 0 to 4: the allele dosage of the a allele.}
\item{diploscores}{a data frame like scores for the samples in the data frame supplied with argument diplo. If diplo is NA also diploscores will be NA.}
The modeldata and allmodeldata data frames present data on a fitted model. 
modeldata presents data on the selected model; allmodeldata lists all attempted. Both data frames contain the following columns:
\item{marker}{the sequential number of the marker (marker names are ordered alphabetically)}
\item{markername}{the name of the marker}
\item{m}{the number of the attempted or selected fit. The 8 (or 4 if try.HW is FALSE) models are tried with 2 or 3 start configurations, so m can range from 1 to 16 or 1 to 24.}
\item{model}{the fitted model. Possible values are "b1", "b2", "b1,q", "b2,q", "b1 HW", "b2 HW", "b1,q HW" and "b2,q HW" where b1 and b2 indicate whether 1 or two parameters for signal background were fitted, q indicates that a quadratic term in the signal response was fitted, 
and HW indicates that the mixing proportions were constrained according to Hardy-Weinberg equilibrium ratios. For more details see Voorrips et al (2011)}
\item{nsamp}{the number of samples for this marker for which select==TRUE, i.e. the number on which the call rate is based.}
\item{nsel}{the number of these samples that have a non-NA ratio value}
\item{npar}{the number of free parameters fitted}
\item{iter}{the number of iterations to reach convergence}
\item{dip}{0, 1 or 2, parameter passed to CodomMarker, see there for explanation.}
\item{LL}{the log-likelihood of the fitted model}
\item{AIC}{Akaike's Information Criterion}
\item{BIC}{Bayesian Information Criterion}
\item{minsepar}{a measure of the minimum peak separation. Each difference of the means of two successive mixture components is divided by the average of the standard deviations of the two components. 
The minimum of the four values is reported. All calculations are on the arcsine-square root transformed scale.}
\item{selcrit}{The selection criterion; the model with the lowest selcrit is selected. If argument sd.target is NA selcrit is equal to BIC, else selcrit is larger than BIC, see Details for details.}
\item{meanP}{For each sample the maximum probability of belonging to any mixture component is calculated. The average of these P values is reported in meanP}
\item{P80, P90, P95, P975, P99}{the fraction of samples that have a probability of at least 0.8, 0.9, 0.95, 0.975 or 0.99 to belong to one of the five mixture components (by default a level of 0.99 is required to assign a genotype score to a sample)}
\item{muact0, muact1, muact2, muact3, muact4}{the actual means of the samples in each of the five mixture components on the arcsine-square root transformed scale}
\item{sdact0, sdact1, sdact2, sdact3, sdact4}{the actual standard deviations of the samples in each of the five mixture components on the transformed scale}
\item{mutrans0, mutrans1, mutrans2, mutrans3, mutrans4}{the model means of the mixture components on the transformed scale}
\item{sdtrans0, sdtrans1, sdtrans2, sdtrans3, sdtrans4}{the model standard deviations of the mixture components on transformed scale}
\item{P0, P1, P2, P3, P4}{the mixing proportions of the five components}
\item{mu0, mu1, mu2, mu3, mu4}{the model means of the five mixture components back-transformed to the original scale}
\item{sd0, sd1, sd2, sd3, sd4}{the model standard deviations of the five mixture components back-transformed to the original scale}
\item{message}{if no model was fitted, the reason is reported here}
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
# Single marker, multiple mixture models
unmix <- fitTetra(marker=4, data=df.tetra)
#unmix <- fitTetra(marker=4, data=df.tetra, plot='fitted')
#unmix <- fitTetra(marker=4, data=df.tetra, diplo=df.diplo, plot='all')
}
\keyword{ utilities }

\seealso{
  \code{\link[fitTetra]{saveMarkerModels}}
  \code{\link[fitTetra]{CodomMarker}}
  \code{\link[fitTetra]{fitTetra-package}}
}
