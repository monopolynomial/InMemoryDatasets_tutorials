using InMemoryDatasets
data=Dataset(x1=[1,2,3],x2=[4,5,6])

# sort!
sort!(data,:x1)

# modify!
modify!(data,:x1=>sqrt=>:y)
