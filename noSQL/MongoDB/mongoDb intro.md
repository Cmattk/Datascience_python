install mongodb and mongodb shell 

database group of collections

collection group of documents

# shell
cls - clear

exit - exit

# check databases
test> show dbs

# use database
test> use admin

admin> use school

# show databases
school> show dbs

#  create a collection
db.createCollection("students")

# drop a database
school> db.dropDatabase()


# insertMany and insertOne documents  
db.students.insertMany([{name:"Spongebob", age:30, gpa:3.2},{name: "Patrick", age:38, gpa:1.5},{name: "Sandy", age:27, gpa:4.0},{name:'Gary',age:18,gpa:2.5}])


db.students.insertOne({name:'Squidward',age:37,gpa:3.5,fullTime:true,registerDate: new Date(),graduationDate: null,courses:['Business','Hospitality'],address: {street:'123 Fake St.', city:'Bikini Bottom',zip:12345}})  

# find , sort and limit documents

db.students.find().sort({name:1})

db.students.find().sort({name: -1})

db.students.find().sort({gpa: -1})

db.students.find().limit(2)

db.students.find().sort({gpa:-1}).limit(2)

# find({query},{projection})

db.students.find({name:'Spongebob'})

db.students.find({gpa: 4.0, age: 28})

db.students.find({gpa: 4.0},{name:true})

db.students.find({},{_id:false,name:true})

db.students.find({},{_id:false,name:true,gpa:true})

# update documents
db.students.updateOne({filter},{update})

## set a field

db.students.updateOne({name:"Spongebob"},{$set:{fullTime:true}})  

db.students.updateOne({},{$set:{fullTime:true}})  

## unset a field
db.students.updateOne({name:"Spongebob"}, {$unset:{fullTime:""}})  

db.students.updateMany({},{$set:{fullTime:false}})  

## update a field if it doesnot exists
db.students.updateMany({fullTime:{$exists:false}}, {$set:{fullTime:true}})

# delete document deleteOne and deleteMany

db.students.deleteOne({name:'Gary'})

db.students.deleteMany({fullTime:false})

db.students.deleteMany({registerDate:{$exists:false}})

# operators 

## not equals
db.students.find({name:{$ne:'Spongebob'}})

## less than , less than equal to

db.students.find({age:{$lt:20}})

db.students.find({age:{$lte:27}})

## greater than or equal than

db.students.find({age:{$gt:27}})

db.students.find({age:{$gte:27}})

db.students.find({gpa:{$gte:3, $lte:4}})

## in and not in

db.students.find({name:{$in:['Spongebob','Sandy','Sheldon']}})

db.students.find({name:{$nin:['Spongebob','Sandy','Sheldon']}})

## Logical operators - evaluate expressions true or false ($and,$not,$nor,$or)

db.students.find({$and: [{fullTime:true},{age:{$lte:22}}]})

db.students.find({$or: [{fullTime:true},{age:{$lte:22}}]})

db.students.find({$nor: [{fullTime:true},{age:{$lte:22}}]})

db.students.find({age:{$lt:30}})

db.students.find({age:{$not:{$gte:30}}})

# Indexes - support the efficient execution of queries in MongoDb, limit no of docs to be inspected

db.students.find({name:'Gary'}).explain('executionStats')
## create index
db.students.createIndex({name:1})
## check indexes
db.students.getIndexes()

## drop index
db.students.dropIndex("name_1")

# collections
db.createCollection("teachers",{capped:true, size:10000000, max:100},{autoIndexId:false})

show collections

db.courses.drop()

