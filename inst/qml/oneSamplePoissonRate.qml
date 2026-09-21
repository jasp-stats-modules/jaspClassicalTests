//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//
import QtQuick
import QtQuick.Layouts
import JASP.Controls
import JASP.Widgets
import JASP

Form
{
	infoBottom: "## " + qsTr("References") + "\n" +
	"- Barker, L. (2002). A comparison of nine confidence intervals for a Poisson parameter when the expected number of events is ≤ 5. _The American Statistician, 56_(2), 85-89. https://doi.org/10.1198/000313002317572736\n" +
	"- Garwood, F. (1936). Fiducial limits for the Poisson distribution. _Biometrika, 28_(3/4), 437-442. https://doi.org/10.1093/biomet/28.3-4.437\n" +
	"- Patil V. V. & Kulkarni H. V. (2012). Comparison of confidence intervals for the Poisson mean: Some new aspects. _REVSTAT-Statistical Journal, 10_(2), 211-222. https://doi.org/10.57805/revstat.v10i2.117"

	RadioButtonGroup
	{
		name:    "inputType"
		title:   qsTr("Input")
		columns: 2

		RadioButton
		{
			value:   "rawData"
			label:   qsTr("Raw data")
			checked: true
			id:      inputRawData
		}

		RadioButton
		{
			value: "summarized"
			label: qsTr("Summarized data")
			id:    inputSummarized
		}
	}

	VariablesForm
	{
		infoLabel:       qsTr("Input")
		preferredHeight: jaspTheme.smallDefaultVariablesFormHeight
		enabled:         inputRawData.checked

		AvailableVariablesList { name: "allVariablesList" }

		AssignedVariablesList
		{
			name:           "count"
			title:          qsTr("Count/Occurrences")
			singleVariable: true
			allowedColumns: ["scale"]
			info:           qsTr("A variable containing the observed event counts.")
		}

		AssignedVariablesList
		{
			name:           "time"
			title:          qsTr("Interval (optional)")
			singleVariable: true
			allowedColumns: ["scale"]
			info:           qsTr("A variable containing the interval, observation time or exposure for each row. If omitted, each row is assumed to contribute one unit of time.")
		}
	}

	Group
	{
		title:   qsTr("Summarized data")
		enabled: inputSummarized.checked
		columns: 2

		IntegerField
		{
			name:         "observedOccurrences"
			label:        qsTr("Number of occurrences")
			defaultValue: 1
			min:          0
			info:         qsTr("Total number of observed occurrences.")
		}

		DoubleField
		{
			name:         "interval"
			label:        qsTr("Interval")
			defaultValue: 1
			min:          0
			decimals:     4
			inclusive:    JASP.MaxOnly
			info:         qsTr("Total interval (observation time or exposure).")
		}
	}

	Group
	{
		title:   qsTr("Tests")
		columns: 2

		CheckBox
		{
			name:    "exactTest"
			label:   qsTr("Exact")
			checked: true
			info:    qsTr("Exact Poisson test based on the Poisson distribution. Valid for any number of occurrences, including zero; the confidence interval (Garwood, 1936) is conservative, i.e., its coverage is at least the nominal level (Barker, 2002; Patil & Kulkarni, 2012).")
		}

		CheckBox
		{
			name:  "normalApprox"
			label: qsTr("Normal approximation")
			info:  qsTr("Large-sample normal approximation. The z statistic uses the standard error under the hypothesized rate; the confidence interval (Wald) uses the standard error at the observed rate. Unreliable for small numbers of occurrences (Barker, 2002).")
		}
	}

	DoubleField
	{
		name:         "testRate"
		label:        qsTr("Hypothesized rate:")
		defaultValue: 1
		min:          0
		decimals:     4
		inclusive:    JASP.MaxOnly
		info:         qsTr("The null hypothesis rate (events per unit time).")
	}

	RadioButtonGroup
	{
		name:  "alternative"
		title: qsTr("Alternative Hypothesis")

		RadioButton
		{
			value:   "two.sided"
			label:   qsTr("≠ Hypothesized rate")
			checked: true
			info:    qsTr("Two-sided test: rate differs from the hypothesized value.")
		}

		RadioButton
		{
			value: "greater"
			label: qsTr("> Hypothesized rate")
			info:  qsTr("One-sided test: rate is greater than the hypothesized value.")
		}

		RadioButton
		{
			value: "less"
			label: qsTr("< Hypothesized rate")
			info:  qsTr("One-sided test: rate is less than the hypothesized value.")
		}
	}

	Group
	{
		title: qsTr("Additional Statistics")

		CheckBox
		{
			name:              "rateCi"
			label:             qsTr("Confidence interval")
			childrenOnSameRow: true
			info:              qsTr("Confidence interval for the event rate λ. Each row uses its own method: exact (Garwood, 1936) or normal approximation (Wald). For one-sided alternatives, a one-sided confidence bound is shown.")

			CIField { name: "confLevel" }
		}
	}
}
