*** version 1.2 5August2019
*** contact information: plus1@sogang.ac.kr

program varlakeep
	version 10
	syntax varlist [, OBServations(string asis) Drop noVARiables Missing(numlist max=1) UP DOWN]

quietly {

	if "`observations'" != "" {
	* obs(exp): on
		if "`drop'" != "" {
		* drop: on
			drop if `observations'

		}
		else {
		* drop: off
			keep if `observations'

		}

	}
	else {
	* obs(exp): off
		if "`drop'" != "" {
		* drop: on
			noisily Error 198 "option drop requires option observations to be set"

		}

	}

	label dir
	local laall `r(names)'
	local lakeep
	foreach x of varlist `varlist' {
		local xlabel0 : value label `x'
		local lakeep `lakeep' `xlabel0'
	}
	local ladrop : list laall - lakeep
	label drop `ladrop'

	if "`variables'" != "novariables" {
	* novar: off
		keep `varlist'
		if "`missing'" !=  "" {
		* m(#): on
			ds , has(type numeric)
			local varnum `r(varlist)'
			foreach x of varlist `varnum' {
				local xlabel : value label `x'
				if "`up'" != "" & "`down'" != "" {
					noisily Error 198 "option up may not be combined with down"
				}
				else if "`up'" != "" & "`down'" == "" {
					sum `x'
					if r(min) >= `missing' {
						if "`xlabel'" != "" {
							label drop `xlabel'
						}
						drop `x'
					}
				}
				else if "`up'" == "" & "`down'" != "" {
					sum `x'
					if r(max) <= `missing' {
						if "`xlabel'" != "" {
							label drop `xlabel'
						}
						drop `x'
					}
				}
				else {
					sum `x'
					if ( r(min) == `missing' ) & ( r(max) == `missing' ) {
						if "`xlabel'" != "" {
							label drop `xlabel'
						}
						drop `x'
					}
				}
			}

		}
		else {
		* m(#): off
			if "`up'" != "" | "`down'" != "" {
				noisily Error 198 "option up or down requires option missing to be set"
			}

		}
		* m(#): on or off
		ds , has(type numeric)
		local varnum2 `r(varlist)'
		foreach x of varlist `varnum2' {
			local xlabel2 : value label `x'
			sum `x'
			if r(N) == 0 {
				if "`xlabel2'" != "" {
					label drop `xlabel2'
				}
				drop `x'
			}
		}

	}
	else {
	* novar: on
		if "`missing'" !=  "" {
		* m(#): on
			noisily Error 198 "option missing may not be combined with option novariables"

		}
		if "`up'" != "" | "`down'" != "" {
		* up or down: on
			noisily Error 198 "option up or down may not be combined with option novariables"

		}

	}

}

end

program define Error
	version 10
	args nr txt

	dis as err `"{p}`txt'{p_end}"'
	exit `nr'
end
