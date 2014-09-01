<cfcomponent displayname="" output="true">

    <cfset variables.mapping.vafileykno = 'fileykno'>
    <cfset variables.mapping.dtfileopened = 'fileopened'>
    <cfset variables.mapping.dtfileclosed = 'fileclosed'>
    <cfset variables.mapping.vafiletype = 'filetype'>

    <cffunction access="public" name="init" output="true"> 
    </cffunction>

    <cffunction access="public" name="createFile" output="true"> 
        <cfset var filtered = request.obj.utils.StructKeyRemap(form,variables.mapping)>
        <cfscript>
<!---  
        javaloaderFactory = createObject('component','cfmongodb.core.JavaloaderFactory').init();
        mongoConfig = createObject('component','cfmongodb.core.MongoConfig').init(dbName="mydb", mongoFactory=javaloaderFactory);
        mongo = createObject('component','cfmongodb.core.Mongo').init(mongoConfig);
        collection = application.db.tracker.getdbcollection('logger')
--->
        //util = mongo.getdbcollection('logger').getMongoUtil()
        //a = collection..insert({hello:'11/22/2013'})
              
        </cfscript>
<!---  
<cfset a.p = 'adsf'>
<cfset a.time = now()>
<cfset collection.insert(a)>
<cfdump var=#collection.query().$exists('time',true).find().asArray()#>
--->
<cfset a = now()>

<!---  
<cfdump var=#collection.query().$gte('time',a).find().asArray()#>
<cfdump var=#collection.query().$('time',true).find().asArray()#>
<cfset application.db[request.db].g.insert({date2:now()})> 
<cfdump var=#application.db[request.db]#>
--->

        <cfreturn 'asdf'>
    </cffunction>

<!---  
    <cffunction access="public" name="init" output="true"> 
    </cffunction>
--->
</cfcomponent>
