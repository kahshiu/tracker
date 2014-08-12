<cfcomponent displayname="Security" output="true">

    <cffunction access="public" name="isLegalScript" output=false>
        <cfargument name="accessedScript" required="true">
        <cfargument name="allowedScript" required="false" default="#application.web.gateway#">
        <cfreturn ListFindNoCase(arguments.allowedScript,arguments.accessedScript) gt 0>
    </cffunction>

    <cffunction access="public" name="status" output=true>
        <cfset var status = ''>
        <cfif StructKeyExists(session,'data')>
            <cfif StructIsEmpty(session.data)> 
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
        <cfquery name="qry_identity" datasource="#request.db#">
            select * from sec0001 
            where vauserpwdhashed = <cfqueryparam CFSQLType='CF_SQL_VARCHAR' value=hash(arguments.username)>
            and vausidhashed =  <cfqueryparam CFSQLType='CF_SQL_VARCHAR' value=hash(arguments.password)
        </cfquery>
        <cfset isAuthentic = qry_identity.recordcount eq 1>
            --->
<!--- kill when ready  --->
<!--- 
        <cfset authenticity.data = qry_identity>
--->
        <cfset authenticity.flag = true>
        <cfset authenticity.data = {}>
        <cfset authenticity.data.identity = 'something'>
        <cfreturn authenticity>
    </cffunction>
</cfcomponent>
