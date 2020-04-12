
using CSV
using DataFrames
using LinearAlgebra

include("Flux.jl")

stoich_array=CSV.read("/Users/Ellen/Documents/Julia/PS3/S_array.csv");
stoich_array=stoich_array[:,2:22];
stoich_array=convert(Array{Float64}, stoich_array);

A_array=CSV.read("/Users/Ellen/Documents/Julia/PS3/A_array.csv");
A=A_array[:,2:7];
A=convert(Array{Float64}, A);
A_T=transpose(A);

mole=A_T*stoich_array

if mole[:,1:6]==zeros(6,6)
    println("\n Elementally balanced w.r.t C,H,N,O,P, and S \n")
else
    println("\n Not elemnetally balanced w.r.t C,H,N,O,P, and S \n")
end

flux_array=CSV.read("/Users/Ellen/Documents/Julia/PS3/V_array.csv")
flux_array=flux_array[1:21,2:3];
flux_array=convert(Array{Float64}, flux_array);

X_array=CSV.read("/Users/Ellen/Documents/Julia/PS3/X_array.csv")
X=X_array[:,2:3];
X=convert(Array{Float64}, X);


C_array=CSV.read("/Users/Ellen/Documents/Julia/PS3/C_array.csv")
C=C_array[:,2];
c=convert(Array{Float64}, C);

(obj_value, calc_flux_array, dual_value_array, up_array, exit, status)=calculate_optimal_flux_distribution(stoich_array,flux_array,X,c)

# print("object value \n")
# print(obj_value)

print("\n calculated flux array \n\n")
print(calc_flux_array)

# print("\n dual value array \n")
# print(dual_value_array)

# print("\n uptake array \n")
# print(up_array)

print("\n\n urea production \n")
println(calc_flux_array[10])
