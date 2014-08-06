<!--- 
done in router set the base landing page for each webapp and the default page for each route
--->

<cfcomponent displayName="folder router" output="false">
    
    <cfset variables.routeraw = ''>
    <cfset variables.anchor = ''>

    <cffunction access="public" name="setrouteraw" output=false>
        <cfargument name="routeraw" required="true">
        <cfset variables.routeraw = arguments.routeraw>
        <cfreturn variables.routeraw>
    </cffunction>

    <cffunction access="public" name="getrouteraw" output=false>
        <cfreturn variables.routeraw>
    </cffunction>

    <cffunction name="introspect" output=false>
        <cfdump var=#variables.routeraw#>
    </cffunction>

    <cffunction name="admin_home">
        <cfargument name="nom" required="false" type="string" default="xxx"/>
        <cfmodule template="/admin/home.cfm">
    </cffunction>

    <cffunction name="login_home">
        <cfargument name="nom" required="false" type="string" default="xxx"/>
        <cfmodule template="/login/home.cfm">
    </cffunction>

    <cffunction name="view">
        <cfargument name="route" required="true">
<!---
        <cfoutput>
            <p>function name: #getfunctioncalledname()# 
            <br>container routes: #variables.anchor eq ''? 'root':variables.anchor#
            <br>current route: #arguments.route#
            </p>
        </cfoutput>
--->
        <cfset isValidFn = false>
        <cfset classFn = getmetadata(this).functions>

        <cfloop array=#classFn# index="currFn">
            <cfif currFn.name eq arguments.route> <cfset isValidFn = true> <cfbreak> 
            </cfif>
        </cfloop>

        <cfif isValidFn>
            <cfif Listfindnocase(variables.anchor, arguments.route) gt 0>
                <p> cut recursive page call </p>
                <cfreturn>
            </cfif>
            <cfset var fn=#this[arguments.route]#>
            <cfset variables.anchor = ListAppend(variables.anchor,arguments.route)>
            <cfset fn()>
            <cfset variables.anchor = listdeleteat(variables.anchor,listlen(variables.anchor))>
        <cfelse>
            <cfoutput>
            you have attempted an invalid page
            </cfoutput>
        </cfif>
<!---
        <cfdump var='exiting to #variables.anchor eq ''? 'root':variables.anchor#'>
--->
    </cffunction>
</cfcomponent>
