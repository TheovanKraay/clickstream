% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ClusterOptimization.r
\name{getOptimalMarkovChain}
\alias{getOptimalMarkovChain}
\title{Generates the optimal markov chains from a list of markov chains and corresponding clusters}
\usage{
getOptimalMarkovChain(startPattern, markovchains, clusters)
}
\arguments{
\item{startPattern}{The pattern object to be used.}

\item{markovchains}{The pre-computed markov chains generated from a set of clusters.}

\item{clusters}{The corresponding clusters (should be in the corresponding order as the markov chains).}
}
\description{
The purpose of this function is to predict from a pattern using pre-computed markov chains and corresponding clusters. The markov chain corresponding with the cluster that is the best fit to the prediction value is used.
}
\examples{

training <- c("User1,h,c,c,p,c,h,c,p,p,c,p,p,o",
              "User2,i,c,i,c,c,c,d",
              "User3,h,i,c,i,c,p,c,c,p,c,c,i,d",
              "User4,c,c,p,c,d")

test <- c("User1,h,c,c,p,p,h,c,p,p,c,p,p,o",
          "User2,i,c,i,c,c,c,d",
          "User4,c,c,c,c,d")

csf <- tempfile()
writeLines(training, csf)
trainingCLS <- readClickstreams(csf, header = TRUE)
unlink(csf)

csf <- tempfile()
writeLines(test, csf)
testCLS <- readClickstreams(csf, header = TRUE)
unlink(csf)

clusters <- clusterClickstreams(trainingCLS, centers = 2)
markovchains <- fitMarkovChains(clusters, order = 1)
startPattern <- new("Pattern", sequence = c("c")) 
mc <- getOptimalMarkovChain(startPattern, markovchains, clusters)
predict(mc, startPattern)
}
\author{
Theo van Kraay \email{theo.vankraay@hotmail.com}
}
