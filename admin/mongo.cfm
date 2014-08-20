<cfsetting showdebugoutput="no">
<!---
<cffunction name="valueEquals">
	<cfargument name="left" required="yes">
	<cfargument name="right" required="yes">
    <cf_valueEquals left="#left#" right="#right#">
</cffunction>
 
<cf_valueEquals left="" right="">
--->
<!---
<cfquery datasource="test_ms">
select 'test' as test
</cfquery>
--->
<cfset db=MongoDBConnect("mydb","localhost", 27017)>

<cfset records=db.testData.find({j:10})>

<cfoutput>
    #records.count()#
</cfoutput>

<!---  
<cfwhile records.hasNext()>
    <cfdump var=#records.next()._id#>
</cfwhile>
--->
<cfset var myId = '53e3af36396d22fcdde8d53c'>
<cfset a={}>
<cfset a.j=10>
<!---  
<cfset d = createObject("java","org.bson.types.ObjectId").init("537f45c17f1c61118e48e20b")>
--->

<cfset x = #db.testData.findOne({j:'the bean'})._id#>
<cfdump var = #x#>
<!---  
<cfdump var = #db.testData.find({_id:x}).toArray()#>
<cfdump var = #db.testData.find({j:{$gte:0,$lte:20}}).toArray()#>
<cfdump var = #db.testData.find( {$or:[ {j:{$gte:0,$lte:20}} ,{j:{$gte:0,$lte:20}} ]}).toArray()#>
<cfdump var = #db.testData.find({j:{$exists:true}}).toArray()#>
<cfdump var = #db.testData.distinct('j')#>
--->

<cffunction name="functiona" output="true">
    <cfargument required="false" name="x" default="1">
    <cfreturn 2*3>
</cffunction>
<cfdump var=#functiona#>
<cfdump var = #functiona()#>
<cfset yyy= #db.testData.find({j:{$exists:true}})#>
<cfset db.testData.update({j:10},{$set:{label:'label333'}},false,true)>
<cfset yyy=#db.testData.find({j:10})#>
<cfdump var=#yyy.toArray()#>
<cfscript>
products_map = function() {
  emit(this.product_id, {"title" : this.title});
}

prices_map = function() {
  emit(this.product_id, {"price" : this.price});
};

r = function(key, values) {
  var result = {
      "title" : "",
      "price" : ""
    };

    values.forEach(function(value) {
      if(value.title !== null) {result.title = value.title;}

      if(value.price !== null) {result.price = value.price;}
    });

    return result;
}
res = db.products.mapReduce(products_map, r, {out: {reduce : 'joined2'}});
res = db.prices.mapReduce(prices_map, r, {out: {reduce : 'joined2'}});
</cfscript>
<!---  
<cfset yyy=#db.testData.group({ key:{j:true}, initial:{counting:0}, reduce: function(record,a){a.favCount += 1}, fanalize: function(o){} })#>
<cfset yyy=#db.testData.find({j:'the bean'}).forEach(function(s){print(s)})#>
--->
<cfscript>
function b() {
    return 'asdfsadf';
}
dump(b())
dump(yyy)
a = [1,2,3]
arrayEach(a,function(c){dump(c)})
</cfscript>
<!---  

<cfdump var= #db.testData.getIndexes()#>
<cfset xxx=#db.testData.aggregate({$match:{j:10}})#>
<cfdump var=#xxx.results()#>
<cfset x = #db.testData.findOne({j:'the bean'})._id#>

adsfas
<cfdump var= #db.testData.findOne({_id: createObject("java", "org.bson.types.ObjectId").init('53e3af36396d22fcdde8d53c')})._id#>
adsfas
--->


<cfscript>

// for this we do a build in function
//db=MongoDBConnect("mydb","localhost", 27017);	



dump("------ DB -------");
	dump(var:db, expand:false);
	dump(db.getCollectionNames());
	dump(db.getName());
	
	dump(structCount(db));
	loop collection="#db#" index="n" item="v" {
		dump(var:v,label:n, expand:false);
	}
<!---  

	db.testData.insert({j:10})
	db.testData.insert({j:10})
	db.testData.insert({j:10})
--->
//dump("------ Collection ""test"" -------");
//	dump(var:db.testdb, expand:false);
//	dump(var:db.TEST, expand:false);
//	dump(var:db['test'], expand:false);
//	
//	dump(var:db.test.find(), expand:false);
//	dump(var:db.test.findOne(), expand:false);
//
//dump("------ Collection ""test2"" -------");	
//	db.test2={};
//	db.test2.insert({susi:"Sorglos"});
//	dump(db.test2);
//	dump(db.test2.findOne().susi);
//	id=db.test2.findOne()._id;
//
//dump("------ Collection ""test2._id"" -------");
//	dump(id);
//	dump(id&"");
//	dump(id.inc);
//	dump(id.time);
//	dump(id.machine);
//	dump(id.getMachine());
	// id.susi=1;
	// x=id.susi;
</cfscript>

 
