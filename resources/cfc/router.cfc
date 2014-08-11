<cfcomponent displayName="router" output="true">

<cfset variables.security = ''>
<cfset variables.targetScript = ''>
<cfset variables.targetRoute = ''>
<cfset variables.passedRoutes = ''>
<cfset this.warnings = ''>

<cffunction name="init" output="false">
    <cfargument required="true" name="targetRoute"> 
    <cfargument required="true" name="targetScript">
    <cfargument required="true" name="securityObj">
    <cfset variables.targetRoute = arguments.targetRoute>
    <cfset variables.targetScript = arguments.targetScript>
    <cfset variables.security = arguments.securityObj>
</cffunction>

<cffunction access="public" name="introspect" output=true>
    <cfdump var=#this#>
    <cfdump var=#variables#>
</cffunction>

<cffunction name="getTargetRoute" output="false">
    <cfreturn variables.targetRoute>
</cffunction>

<cffunction name="setTargetRoute" output="false">
    <cfargument required="true" name="targetRoute" default="">
    <cfreturn variables.targetRoute = arguments.targetRoute>
</cffunction>

<cffunction access="public" name="setPassedRouted" output=false>
    <cfargument required="false" name="routes" default="">
    <cfset variables.passedRoutes = arguments.routes>
</cffunction>

<cffunction name="isRouteFunctioned" output="true">
    <cfargument required="false" name="targetRoute" default="#variables.targetRoute#">

    <cfset var isFunctioned = false>
    <cfset var classFunctions = getmetadata(this).functions>
    <cfloop array=#classFunctions# index="currentFunction">
        <cfif currentFunction.name eq arguments.targetRoute> 
            <cfset isFunctioned = true> <cfbreak> 
        </cfif>
    </cfloop>
    <cfreturn isFunctioned>
</cffunction>

<cffunction name="isRouteRecursive" output="true">
    <cfargument required="true" name="targetRoute">
    <cfargument required="false" name="passedRoutes" default="#variables.passedRoutes#">
    <cfset var result = ListFindNoCase(arguments.passedRoutes,arguments.targetRoute) gt 0>
    <cfreturn result> 
</cffunction>

<cffunction name="fatalError" output="true">
    <cfargument required="true" name="targetRoute">
    <cfargument required="false" name="targetScript" default="#variables.targetScript#">

    <cfif NOT variables.security.isLegalScript(arguments.targetScript)>
        <cfset this.warnings = ListAppend(this.warnings,'warnings_illegalAcces')>
    </cfif>
    <cfif NOT this.isRouteFunctioned()>
        <cfset this.warnings = ListAppend(this.warnings,'warnings_invalidPage')>
    </cfif>
    <cfif this.isRouteRecursive(arguments.targetRoute)>
        <cfset this.warnings = ListAppend(this.warnings,'warnings_recursivePage')>
    </cfif>
    <cfif NOT(
            variables.security.status() eq 'loggedIn'
            OR (ListFindNoCase('unauthenticated,loggedOut',variables.security.status()) gt 0 and REFindNoCase('(^login_)|(^warnings)',arguments.targetRoute) gt 0 )
        )>
        <cfset this.warnings = ListAppend(this.warnings,'warnings_refusedPage')>
    </cfif>

    <cfif this.warnings eq ''>
        <cfset route = arguments.targetRoute>
    <cfelse>
        <cfset route = 'warnings_home'>
        <cfset this.setPassedRouted()>
    </cfif>
    <cfreturn route> 
</cffunction>    
         
<cffunction name="view" output="true">
    <cfargument required="true" name="route">
    <cfargument required="false" name="data" default="">
    <cfset var route = this.fatalError(arguments.route)>
    <cfset var data = this.warnings neq ''?this.warnings:arguments.data>
    <cfset var fn=#this[route]#>
                       <!--- done in router set the base landing page for each webapp and the default page for each route --->
    <cfset variables.passedRoutes = ListAppend(variables.passedRoutes,route)>
    <cfset fn(data)>
    <cfset variables.passedRoutes = ListDeleteAt(variables.passedRoutes,ListLen(variables.passedRoutes))>
</cffunction>
          
<cffunction name="viewTemplate" output="true">
    <cfargument required="true" name="templatePath" default="false">
    <cfargument required="true" name="templateData" default="false">
    <cfargument required="false" name="templateWrapper" default="true">

    <cfset parentPath = REReplace(arguments.templatePath,'/[^/]+\.cfm','')>  
    <cfoutput>
    <cfif arguments.templateWrapper and FileExists('#request.dir.root##parentPath#\header.cfm')>
        <cfmodule template="#parentPath#/header.cfm">
    </cfif>
    <cfmodule template=#arguments.templatePath# data=#arguments.templateData#> 
    <cfif arguments.templateWrapper and FileExists('#request.dir.root##parentPath#\footer.cfm')>
        <cfmodule template="#parentPath#/footer.cfm">
    </cfif>
    </cfoutput>
</cffunction>

<!--- routes --->
    <cffunction name="warnings_home">
        <cfargument name="data" required="false" default=''>
        <cfargument name="wrap" required="false" default=true>
        <cfset this.viewTemplate('/warnings/home.cfm',#arguments.data#,#arguments.wrap#)>
    </cffunction>
    <cffunction name="warnings_illegalAccess">
        <cfargument name="data" required="false">
        <cfargument name="wrap" required="false" default=true>
        <cfset this.viewTemplate("/warnings/illegalAccess.cfm",#arguments.data#,#arguments.wrap#)>
    </cffunction>
    <cffunction name="warnings_invalidPage">
        <cfargument name="data" required="false">
        <cfargument name="wrap" required="false" default=true>
        <cfset this.viewTemplate("/warnings/invalidPage.cfm",#arguments.data#,#arguments.wrap#)>
    </cffunction>
    <cffunction name="warnings_recursivePage">
        <cfargument name="data" required="false">
        <cfargument name="wrap" required="false" default=true>
        <cfset this.viewTemplate("/warnings/recursivePage.cfm",#arguments.data#,#arguments.wrap#)>
    </cffunction>
    <cffunction name="warnings_refusedPage">
        <cfargument name="data" required="false">
        <cfargument name="wrap" required="false" default=true>
        <cfset this.viewTemplate("/warnings/refusedPage.cfm",#arguments.data#,#arguments.wrap#)>
    </cffunction>

    <cffunction name="admin_home">
        <cfargument name="data" required="false">
        <cfargument name="wrap" required="false" default=true>
<!--- 
        <cfset this.viewTemplate("/admin/home.cfm",#arguments.data#,#arguments.wrap#)>
--->
    </cffunction>
    <cffunction name="db_home">
        <cfargument name="data" required="false">
        <cfargument name="wrap" required="false" default=true>
        <cfset this.viewTemplate("/admin/db/home.cfm",#arguments.data#,#arguments.wrap#)>
    </cffunction>

    <cffunction name="login_authenticate_act">
        <cfargument name="data" required="false">
        <cfargument name="wrap" required="false" default=true>
        <cfset this.viewTemplate("/login/authenticate.act.cfm",#arguments.data#,#arguments.wrap#)>
    </cffunction>
    <cffunction name="login_home">
        <cfargument name="data" required="false">
        <cfargument name="wrap" required="false" default=true>
        <cfset this.viewTemplate("/login/home.cfm",#arguments.data#,#arguments.wrap#)>
    </cffunction>
</cfcomponent>
