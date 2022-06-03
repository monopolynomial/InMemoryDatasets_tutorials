using InMemoryDatasets
data=Dataset(x1=[1,2,1],x2=[4,5,6])

# sort!
sort!(data,:x1)
sort!(data,[:x2,:x1],rev=[true,false])

#view and sort
view(data,sortperm(data,:x1),:)
groupby(data,:x1)
gatherby(data,:x1)

# modify!
modify!(data,:x1=>byrow(sqrt)=>:y)
modify!(groupby(data,:x1),:x2=>IMD.sum=>:x3)

# combine
data=Dataset(group=[2,1,1,2,2,3],y=rand(6))
combine(groupby(data,:group),:y=>IMD.sum)
combine(gatherby(data,:group),:y=>IMD.sum)

# flatten a data set - this is new feature
data=Dataset(x=[1,2,3],y=["1,2","10,10","1,2,3,4"])
f(x)=parse.(Int,split(x,","))
setformat!(data,:y=>f)
flatten!(data,:y,mapformats=true)

# simulate data-do fun stuff :D
data=Dataset(rand(1:10, 1000, 3),[:group,:x,:y])
map!(data,x->rand()<0.1 ? missing : x,[:x,:y])

#byrow calculations
byrow(data,sum,[:x,:y])
byrow(data,findfirst,[:x,:y],by= ==(1))

#filter
filter(data,[:x,:y],by=ismissing)
filter(data,[:x,:y],by=ismissing,type=any)
filter(data,[:x,:y],type=isequal)
# replace missing in [:x,:y] for only group==1 with 0
using Chain
@chain data begin
  filter(:group,by= ==(1),view=true)
  map!(x->ismissing(x) ? 0 : x,[:x,:y])
  parent
end
#check
combine(groupby(data,:group),[:x,:y]=>IMD.nmissing)

#keep random occurance of duplicates / cool!
unique(data,:group,keep=:random)
#other forms
unique(data,:group,keep=:none)

#repeat function - just found about its power
repeat(data,freq=:y)
