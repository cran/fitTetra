\name{CodomMarker}
\alias{CodomMarker}
\title{
Function to fit a mixture model to a vector of signal ratios of a single bi-allelic marker
}
\description{
This function fits a specified mixture model to a vector of signal ratios of multiple samples for a single bi-allelic marker. 
Returns a list with results from the fitted mixture model.
}
\usage{
CodomMarker(y, ng = 5, mutype = 0, sdtype = "sd.const", ptype = "p.free", 
            clus = TRUE, mu.start = NA, sd.start=rep(0.075,ng), sd.fixed = 0.075, 
            p = NA, maxiter = 500, maxn.bin = 200, nbin = 200, plothist = TRUE, 
            nbreaks = 40, maintitle = NULL, subtitle = NULL, xlabel = NULL, 
            xaxis = "s")
}
\arguments{
  \item{y}{
the vector of signal ratios (each value is from one sample, vector y contains the values for 1 marker). All values must be between 0 and 1 (inclusive), NAs are not allowed. The minimum length of y is 10*ng.
}
  \item{ng}{
the number of possible genotypes (mixture components) to be fitted: one more than the ploidy of the samples
}
  \item{mutype}{
an integer in 0:6. Describes how to fit the means of the components of the mixture model: with mutype=0 the means are not constrained, requiring ng degrees of freedom. With mutype in 1:6 the means are constrained based on the ng possible allele ratios according to one of 6 models; see Details.
}
  \item{sdtype}{
one of "sd.const", "sd.free", "sd.fixed". Describes how to fit the standard deviations of the components of the mixture model: with "sd.const" all standard deviations (on the transformed scale) are equal (requiring 1 degree of freedom); with "sd.free" all standard deviations are fitted separately (ng d.f.); with "sd.fixed" all sd's on the transformed scale are equal to parameter sd.fixed (0 d.f.).
}
  \item{ptype}{
one of "p.free", "p.fixed" or "p.HW". Describes how to fit the mixing proportions of the components of the mixture model: with "p.free", the proportions are not constrained (and require ng-1 degrees of freedom); with "p.fixed" the proportions given in parameter p are fixed; with "p.HW" the proportions are calculated from the overall allele frequency, requiring only 1 degree of freedom.
}
  \item{clus}{
boolean. If TRUE, the initial means and standard deviations are based on a kmeans clustering into ng groups. If false, the initial means are equally spaced on the transformed scale between the values corresponding to 0.02 and 0.98 on the original scale and the initial standard deviations are 0.075 on the transformed scale.
}
  \item{mu.start}{
vector of ng values. If present, gives the start values of mu (the means of the mixture components) on the original (untransformed) scale, must be strictly ascending (mu[i]>mu[i-1]). Overrides the start values determined by clus TRUE or FALSE.
}
  \item{sd.start}{
vector of ng values. If present, gives the start values of sd (the standard deviations of the mixture components) on the transformed scale. Overrides the start values determined by clus TRUE or FALSE.
}

  \item{sd.fixed}{
vector, recycled if less than ng values: if argument sdtype is "sd.fixed", argument sd.fixed specifies the fixed standard deviations.
}
  \item{p}{
a vector of ng elements with the initial (or fixed, if parameter ptype is "p.fixed") mixing proportions of the mixture model components.
}
  \item{maxiter}{
integer: the maximum number of times the nls function is called in CodomMarker (0 = no limit, default=500)
}
  \item{maxn.bin}{
integer, default=200: if the length of y is larger than max.nbin the values of y (after arcsine square root transformation) are binned (i.e. the range of y (0 to pi/2) is divided into nbin bins of equal width and the number of y values in each bin is used as the weight of the midpoints of each bin). This results in significant speed improvement with large numbers of samples without noticeable effects on model fitting.
}
  \item{nbin}{
integer, default=200: the number of bins(see maxn.bin)
}
  \item{plothist}{
If TRUE a histogram of y is plotted with the fitted distributions superimposed
}
  \item{nbreaks}{
number of breaks for plotting the histogram; does not have an effect on fitting the mixture model
}
  \item{maintitle}{
string, used for plotting
}
  \item{subtitle}{
string, used for plotting
}
  \item{xlabel}{
string, used for plotting
}
  \item{xaxis}{
string, used for plotting: if "n" no x-axis is plotted
}
}
\details{
This function takes as input a vector of ratios of the signals of two alleles (a and b) at a genetic marker locus (ratios as a/(a+b)), one for each sample, and fits a mixture model with ng components (for a tetraploid species: ng=5 components representing the nulliplex, simplex, duplex, triplex and quadruplex genotypes). Ideally these signal ratios should reflect the possible allele ratios (for a tetraploid: 0, 0.25, 0.5, 0.75, 1) but in real life they show a continuous distribution with a number of more or less clearly defined peaks.
The arguments specify what model to fit and with what values the iterative fitting process should start. If the argument mutype is set to a value in 1:6 the means of the mixture model components are
constrained based on the possible allele ratios. This constraint takes the form of one of 6 possible models, specified by mutype, as follows:
1: a basic model assuming that both allele signals have a linear response to the allele dosage; one
parameter for the ratio of the slopes of the two signal responses, and two parameters for the background
levels (intercepts) of both signals (total 3 parameters).
2: as 1, but with the same background level for both signals (2 parameters)
3: as 1, with two parameters for a quadratic effect in the signal responses (5 parameters)
4: as 3, but with the same background level for both signals (4 parameters)
5: as 3, but with the same quadratic parameter for both signal responses (4 parameters)
6: as 5, but with the same background level for both signals (3 parameters)
}
\value{
A list; if an error occurs the only list component is
\item{message}{the error message}
If no error occurs the list has the following components:
\item{loglik}{the optimized log-likelihood}
\item{npar}{the number of fitted parameters}
\item{AIC}{Akaike's Information Criterion}
\item{BIC}{Bayesian Information Criterion}
\item{psi}{a list with components mu, sigma and p: each a vector of length ng with the means, standard deviations and mixing proportions of the components of the fitted mixture model;the means and standard deviations are on the transformed scale}
\item{post}{a matrix of ng columns and length(y) rows; each row r gives the ng probabilities that the y[r] belongs to the ng components}
\item{nobs}{the number of observations in y (excluding NA's and possibly removed outliers)}
\item{iter}{the number of iterations}
\item{message}{an error message, "" if no error}
\item{back}{a list with components mu.back and sigma.back: each a vector of length ng with the means and standard deviations of the mixture model components back-transformed to the original scale.}
}
\references{
Voorrips, RE, G Gort, B Vosman (2011) \emph{Genotype calling in tetraploid species from bi-allelic marker data using mixture models} BMC Bioinformatics 12: 172.
}
\author{
Gerrit Gort: <gerrit.gort@wur.nl>
}

\examples{
data(tetra.potato.SNP)
SNP6 <- subset(tetra.potato.SNP, MarkerName=='PotSNP006')
# Single marker, single mixture model
rawratio <- SNP6$X_Raw/(SNP6$X_Raw+SNP6$Y_Raw) 
unmix <- CodomMarker(rawratio)
}
\keyword{ utilities }

\seealso{
  \code{\link[fitTetra]{saveMarkerModels}}
  \code{\link[fitTetra]{fitTetra}}
  \code{\link[fitTetra]{fitTetra-package}}
}
