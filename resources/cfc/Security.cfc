<cfcomponent displayname="Security" output="true">

    <cffunction access="public" name="viaGateways" output=true>
        <cfargument name="accessedScript" required="true">
        <cfset approvedGateways = '#application.web.gateway#'>
        <cfreturn ListFindNoCase(approvedGateways,arguments.accessedScript) gt 0>
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

        <cfset authenticity.flag = false>

<!--- perform actual identity checks  --->
        <cfset authenticity.data = {}>
        <cfif arguments.username eq 'admin'>
            <cfset authenticity.flag = true>
            <cfset authenticity.data.identity.role = 'admin'>
        <cfelseif arguments.username eq 'user'>
            <cfset authenticity.flag = true>
            <cfset authenticity.data.identity.role = 'user'>
        </cfif>
        <cfreturn authenticity>
    </cffunction>
</cfcomponent>
