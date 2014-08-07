<cfcomponent displayname="Authenticator" output="true">
    <cfset variables.loginDB = ''>

    <cffunction access="public" name="status" output=false>
        <cfset var status = ''>
        <cfif StructKeyExists(session,'vars')>
            <cfif StructIsEmpty(session.vars)> 
                <cfset status='loggedOut'>
            <cfelse> 
                <cfset status='loggedIn'>
            </cfif>
        <cfelse> 
            <cfset status='unauthenticated'>
        </cfif>
        <cfreturn status>
    </cffunction>

    <cffunction access="public" name="authenticate" output=true>
        <cfargument name="username" required="true">
        <cfargument name="password" required="true">
            <!--- 
            <cfquery name="qry_identity" datasource="#variables.loginDB#">
                select * from sec0001 
                where vauserpwdhashed = <cfqueryparam CFSQLType='CF_SQL_VARCHAR' value=hash(arguments.username)>
                and vausidhashed =  <cfqueryparam CFSQLType='CF_SQL_VARCHAR' value=hash(arguments.password)
            </cfquery>
            --->
        <cfset qry_identity.recordcount =1>
        <cfset authenticity = {}>
        <cfset authenticity.flag = qry_identity.recordcount eq 1>
        <cfreturn authenticity>
    </cffunction>
</cfcomponent>
