# CHEME-5440-PS3

## Part a
Used data from KEGG to construct a stoichiometric matrix S for the urea cycle. 
* See file XXX.xls or XXX.csv for stoichiometric matrix. S = [M x R] = [18,21]
* See file XXXX.pdf for reaction network. 
* Below is the key for that defines the different fluxes. 
    * Reaction fluxes:
          v1
          v2
          v3
          v4
          v5(+)
          v5(-)
    * Exchange fluxes
          b1
          b2
          b3
          b4
          b5
          b6
          b7
          b8
          b9
          b10
          b11
          b12
          b13
          b14(+)
          b14(-)

## Part b
Created an atom matrix A = [M x A] where A = C,H,N,N,P,S. See file: XXX.xls or XXX.csv for atom matrix

To determine if the urea cycle reconstruction is elementally balanced, calculate A^T*S. If the reaction flux columns are all zero vectors, then the reconstruction is elementally balanced. If they are not, then one likely forgot some species exchange fluxes.

See PS3.jl for elemental balance calculation. If reconstruction is elementally balanced, PS3.jl will print "balanced" as an output. If reconstruction is not balanced, PS3.jl will print "unbalanced.

Reconstruction is elementally balanced with respect to C,H,N,P, and S.
    
## Part c
Used Flux Balance Analysis to calculate the maximum rate of urea production. Solved FBA problem using linear program GLPK solve Flux.jl.

To solve solve this FBA problem, 
* Used the stoichiometric matrix S from part a
* Calculated the flux bounds for the reaction fluxes using Michaelis Menten multiple saturation kinetics.
   * Used the given enzyme reaction rate constants (kcat) and assumed a uniform enzyme concentration [E]=0.01 µmol/gDW.
   * Used Park et al Nat Chem Biol 12:482-9, 2016 for metabolite concentrations
   * Used BRENDA for metabolite Km values
   * See file xxx.xls for metabolite data
   * Calculated the saturation terms for each metabolite. If metabolite data were missing, assumed [S] >> Km, so saturation term =1
   * Reaction flux bounds were calculated in excel. See file xxx.xls for calculations and flux bounds.
* Assumed exchange flux bounds were 0 <= b,i <= 10 mmol/gDW-hr
* See file XXX.xls for complete flux bounds.
* Used Flux.jl to solve the FBA problem with the given flux bound constraints
   * Because all species were balanced, the metabolite species lower and upper bounds were 0. See xxx.xls for metabolite species bounds
   * The objective of this FBA is to maximize urea production, b4. Therefore, the objective function was set to maximize b4 by setting the c value for b4 to -1 and the c values for all other fluxes to 0.

See PS3.jl for FBA results. PS3.jl outputs results for Flux.jl calculation. It also prints the urea exchange flux.

The maximum rate of urea production is XX mmol/gDW-hr.
