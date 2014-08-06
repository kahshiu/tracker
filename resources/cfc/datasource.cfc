<cfcomponent displayname="general storage" output="true">

    <cfset variables.application = ''>
    <cfset variables.environment = ''>

    <cffunction name="init" output="true">
        <cfset

        <cfargument required="true" name="application" default="">
        <cfargument required="true" name="environment" default="">

        <cfset variables.application = arguments.application>
        <cfset variables.environment = arguments.environment>
    </cffunction>

    <cffunction name="db" output="false">
        <cfset var dbname = ''>

        <cfif variables.application eq 'login'>
            <cfset dbname = 'login'>

        <cfelseif variables.application eq 'tracker'>
            <cfif variables.environment eq 'live'>
                <cfset dbname = 'tracker'>
            <cfelseif variables.environment eq 'training'>
                <cfset dbname = 'tracker_testing'>
            </cfif>
        </cfif>

        <cfreturn dbname>
    </cffunction>


<!--- libary paths --->
    <cffunction name="cfc" output="false">
        <cfreturn '/lib/cfc'>    
    </cffunction>
    <cffunction name="css" output="false">
        <cfreturn '/lib/css'>    
    </cffunction>
    <cffunction name="js" output="false">
        <cfreturn '/lib/js'>    
    </cffunction>
</cfcomponent>
