# CHEME-5440-PS3

## Part a
Used data from KEGG to construct a stoichiometric matrix S for the urea cycle. 
* See file [S_array.xlsx](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/S_Array.xlsx) or [S_array.csv](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/S_Array.csv) for stoichiometric matrix. S = [M x R] = [18,21]
* See file [Reaction Network.pdf](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/Reaction%20Network.pdf) for reaction network. 
* Below is the key for that defines the different fluxes. 
    * Reaction fluxes:
          * v1 EC 6.3.4.5
          * v2 EC 4.3.2.1
          * v3 EC 3.5.3.1
          * v4 2.1.3.3
          * v5(+) EC 1.14.13.39 arginine to citrulline
          * v5(-) EC 1.14.13.39 citrulline to arginine
    * Exchange fluxes
          * b1 carbamoyl phosphate in
          * b2 asparate in
          * b3 fumarate out 
          * b4 urea out
          * b5 ATP in
          * b6 AMP out
          * b7 diphosphate out 
          * b8 NADPH in
          * b9 NADP out
          * b10 O2 in 
          * b11 H+ in
          * b12 NO out
          * b13 phosphate out
          * b14(+) H2O in
          * b14(-) H20 out

## Part b
Created an atom matrix A = [M x A] where A = C,H,N,N,P,S. See file: [A_array.xlsx](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/A_Array.xlsx) or [A_array.csv](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/A_Array.csv) for atom matrix

To determine if the urea cycle reconstruction is elementally balanced, calculate A^T*S. If the reaction flux columns are all zero vectors, then the reconstruction is elementally balanced. If they are not, then one likely forgot some species exchange fluxes.

See [PS3.jl](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/PS3.jl) for elemental balance calculation. If reconstruction is elementally balanced, PS3.jl will print "balanced" as an output. If reconstruction is not balanced, PS3.jl will print "unbalanced.

Reconstruction is elementally balanced with respect to C,H,N,P, and S.
    
## Part c
Used Flux Balance Analysis to calculate the maximum rate of urea production. Solved FBA problem using linear program GLPK solve [Flux.jl](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/Flux.jl). FLux.jl source: Prof. Varner.

To solve solve this FBA problem, 
* Used the stoichiometric matrix S from part a
* Calculated the flux bounds for the reaction fluxes using Michaelis Menten multiple saturation kinetics. See [MM Multiple Saturation Kinetics.jpg](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/MM%20Multiple%20Saturation%20Kinetics.jpg)
   * Used the given enzyme reaction rate constants (kcat) and assumed a uniform enzyme concentration [E]=0.01 µmol/gDW.
   * Used Park et al Nat Chem Biol 12:482-9, 2016 for metabolite concentrations
   * Used BRENDA for metabolite Km values
   * See file [Metabolite values.xlsx](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/Metabolite%20values.xlsx) for metabolite data
   * Calculated the saturation terms for each metabolite. If metabolite data were missing, assumed [S] >> Km, so saturation term =1. Saturation terms calculated in [Metabolite values.xlsx](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/Metabolite%20values.xlsx)
   * Reaction flux bounds were calculated in excel. See file [V_array.xlsx](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/V_array.xlsx) for calculations and flux bounds.
* Assumed exchange flux bounds were -10 <= b,i <= 10 mmol/gDW-hr
* See file [V_array.xlsx](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/V_array.xlsx) or [V_array.csv] (https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/V_array.csv) for complete flux bounds.
* Used Flux.jl to solve the FBA problem with the given flux bound constraints
   * Because all species were balanced, the metabolite species lower and upper bounds were 0. See [X_array.xlsx](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/X_array.xlsx) or [X_array.csv](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/X_array.csv) for metabolite species bounds
   * The objective of this FBA is to maximize urea production, b4. Therefore, the objective function was set to maximize b4 by setting the c value for b4 to -1 and the c values for all other fluxes to 0.

See [PS3.jl](https://github.com/erp98/CHEME-5440-PS3/blob/master/PS3/PS3.jl) for FBA results. PS3.jl outputs results for Flux.jl calculation. It also prints the urea exchange flux.

The maximum rate of urea production is 2.3 mmol/gDW-hr.
