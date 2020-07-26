using BenchmarkTools
using DataFrames
using DelimitedFiles
using CSV
using XLSX

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
