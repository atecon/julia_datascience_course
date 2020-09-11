using LinearAlgebra
using SparseArrays
Pkg.add("Images")
using Images
using MAT


A = randn(10, 10)
A_tr = transpose(A) # or A'
A = A * A_tr
@show A[11] == A[1,2];

isposdef(A)

b = rand(10)
x = A \ b       # solution fo Ax = b
@show norm(A * x - b)

typeof(A)
typeof(b)
typeof(x)

B = copy(A)     # actual copy not pointer

# Create matrices
A = [1 ; 2]
print(A)
A = [1 2 6; 3 4 5]
print(A)

@show size(A)     # r by c dim.
@show size(A, 2)     # r by c dim.
@show length(A)   # r * c
@show ndims(A)
@show A[:,1]
@show A * zeros(2,2)
@show A * 4
@show A .* 4

m = [1, 2, NaN, 4]
@show m

m =  ones(3,2) * NaN;
@show m;

m1 = [1; 2; 3]
m2 = [4; 5; 6]
@show hcat(m1, m2)
@show vcat(m1, m2)
