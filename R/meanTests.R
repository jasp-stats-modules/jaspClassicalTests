#
# Copyright (C) 2013-2018 University of Amsterdam
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

#' @import jaspBase
#' @import jaspTTests
#jaspTTests internals read options that this module's QML does not define;
#giving them defaults here keeps delegation from crashing on NULL
.fillTTestOptionDefaults <- function(options) {
  if (is.null(options[["qqPlotCi"]]))      options[["qqPlotCi"]]      <- FALSE
  if (is.null(options[["qqPlotCiLevel"]])) options[["qqPlotCiLevel"]] <- 0.95
  options
}

#' @export
oneSampleTests <- function(jaspResults, dataset, options, ...) {
  return(jaspTTests::TTestOneSampleInternal(jaspResults, dataset, .fillTTestOptionDefaults(options), ...))
}

#' @export
independentSamplesTests <- function(jaspResults, dataset, options, ...) {
  return(jaspTTests::TTestIndependentSamplesInternal(jaspResults, dataset, .fillTTestOptionDefaults(options), ...))
}

#' @export
pairedSamplesTests <- function(jaspResults, dataset, options, ...) {
  return(jaspTTests::TTestPairedSamplesInternal(jaspResults, dataset, .fillTTestOptionDefaults(options), ...))
}