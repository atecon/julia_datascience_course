using BenchmarkTools
using DataFrames
using DelimitedFiles
using CSV
using XLSX
#Pkg.add("Printf")
using Printf


P = download("https://raw.githubusercontent.com/nassarhuda/easy_data/master/programming_languages.csv")

# Way 1 to read use the "DelimitedFiles" lib.
values,header = readdlm("./data/programming_languages.csv",',';header=true);
# Write
writedlm("foo.txt", values, ';')

# Way 2: Use the CSV package
C = DataFrame!(CSV.File("./data/programming_languages.csv"));
@show typeof(C)

@show C[1:10,:]     # print 1st ten rows

@show names(C)
@show C[:,"year"]   # equivalent to C[:,:year]
C.year
@show C[:,["year", "language"]]


# Statistics
@show describe(C)

# DataFrames
foods = ["apple", "pear"]
calories = [105, 47]
prices = [0.85, 1.6]
df_calories = DataFrame(item=foods, calories=calories) # item==index
@show df_calories
df_prices = DataFrame(item=foods, prices=prices)
DF = innerjoin(df_calories, df_prices, on="item")
@show DF

@show by(DF,:prices,size)

# Try open a gretl 'mat' file..
# Pkg.add("MAT")
# using MAT
# gretl_mat = matread("./data/gretl.mat")



function year_created(C, language::String)
   # Which year was a given language invented?
   loc = findfirst(C.language .== language)
   if !isnothing(loc)
      return C.year[loc]
   else
      error(@printf("Language %s not listed", language))
   end
end
year_created(C, "Julia")
year_created(C, "Gretl")


function how_many_per_year(C, year::Int64)
   # Number of languages created in a year.
   n = sum(C.year .== year)
   return n
end
n = how_many_per_year(C, 2012)
print(n)


# Dictionaries
Dict([("A", 1), ("B", 2)])

# Default dict of type any (index), any(value)
D1 = Dict()
D1[23] = ["julia", "prog"]
print(D1)

# not going to work as index was pre-dfined as numeric before
#D1["foo"] = ["some_string", 42]
@show ["some_string", 42]

# Write DataFrame C as dictionary
dict = Dict{Integer, Vector{String}}()
for i = 1:size(C,1)
   year, lang = C[i,:]
   if year in keys(dict)
      dict[year] = push!(dict[year], lang)
   else
      dict[year] = [lang]
   end
end
@show dict
length(keys(dict))

function year_created_dict(dict::Dict, language::String)
   # Which year was a given language created?
   key_vals = collect(keys(dict))     # array of key values
   @show key_vals
   lookup = map(id -> findfirst(dict[id] .== language), key_vals) # Union of 'nothing' and '1'
   #@show lookup
   return key_vals[findfirst((!isnothing).(lookup))]
end
@show year_created_dict(dict, "Julia")    # fails for non-existing language

 
