% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SuppressDec.R
\name{IpsoExtra}
\alias{IpsoExtra}
\title{Extended variant of RegSDCipso}
\usage{
IpsoExtra(
  y,
  x = NULL,
  ensureIntercept = TRUE,
  returnParts = FALSE,
  nRep = 1,
  resScale = NULL,
  digits = 9,
  rmse = NULL,
  sparseLimit = 500,
  printInc = TRUE
)
}
\arguments{
\item{y}{Matrix of confidential variables}

\item{x}{Matrix of non-confidential variables}

\item{ensureIntercept}{Whether to ensure/include a constant term. Non-NULL x is subjected to \code{\link{EnsureIntercept}}}

\item{returnParts}{Alternative output two matrices: yHat (fitted) and yRes (generated residuals).}

\item{nRep}{Integer, when >1, several y's will be generated. Extra columns in output.}

\item{resScale}{Residuals will be scaled by resScale}

\item{digits}{Digits used to detect perfect fit (caused by fitted values as input). 
This checking will be done only when rmse is in input. When perfect fit, rmse will be used instead of resScale.}

\item{rmse}{Desired root mean square error (residual standard error). Will be used when resScale is 
NULL or cannot be used (see parameter digits). This parameter forces the rmse value for one y variable (the first).}

\item{sparseLimit}{Limit for the number of rows of a reduced x-matrix within the algorithm. When exceeded, a sparse algorithm is used (see reference).}
}
\value{
Generated version of y
}
\description{
Possible to generate several y's and to re-scale residuals.
Regression fitting by a sparse matrix algorithm is also possible (see reference).
}
\examples{
x <- matrix(1:5, 5, 1)
y <- matrix(10 * (sample(7:39, 15) + 4 * (1:15)), 5, 3)
colnames(y) <- paste("y", 1:3, sep = "")
y1 <- y[, 1, drop = FALSE]

IpsoExtra(y, x)  # Same as RegSDCipso(y, x)

IpsoExtra(y, x, resScale = 0)  # Fitted values (whole numbers in this case)
IpsoExtra(y, x, nRep = 2, resScale = 1e-05)  # Downscaled residuals 

ySynth <- IpsoExtra(y1, x, nRep = 2, rmse = 0.25)  # Downscaled residuals 
summary(lm(ySynth ~ x))  # Identical regression results with Residual standard error: 0.25

IpsoExtra(fitted(lm(y1 ~ x)), x, nRep = 2, resScale = 0.1)  # resScale no effect since perfect fit
IpsoExtra(fitted(lm(y1 ~ x)), x, nRep = 2, resScale = 0.1, rmse = 2)  # with warning

# Using data in the paper
IpsoExtra(RegSDCdata("sec7y"), RegSDCdata("sec7x"))  # Similar to Y*
IpsoExtra(RegSDCdata("sec7y"), RegSDCdata("sec7x"), rmse = 1)
}
\references{
Douglas Bates and R Development Core Team (2022), 
Comparing Least Squares Calculations, 
R Vignette, 
\code{vignette("Comparisons", package="Matrix")}.
}
\author{
Øyvind Langsrud
}
\keyword{internal}
