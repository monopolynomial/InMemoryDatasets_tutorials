using InMemoryDatasets
data=Dataset(x1=[1,2,3],x2=[4,5,6])

# sort!
sort!(data,:x1)

# modify!
modify!(data,:x1=>sqrt=>:y)

# combine
data=Dataset(group=[2,1,1,2,2,3],y=rand(6))
combine(groupby(data,:group),:y=>IMD.sum)
combine(gatherby(data,:group),:y=>IMD.sum)
