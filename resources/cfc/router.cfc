<cfcomponent displayName="Router" output="true">

    <cffunction name="init" output="true">
        <cfreturn this>
    </cffunction>

<!--- {{{ getter/setter: targetroute,targetscript,passedroute --->
    <cffunction name="getTargetRoute" output="false">
        <cfreturn request.vars.routes.targetRoute>
    </cffunction>
    <cffunction name="setTargetRoute" output="false">
        <cfargument required="true" name="targetRoute" default="">
        <cfset request.vars.routes.targetRoute = arguments.targetRoute>
    </cffunction>

    <cffunction name="getPassedRoutes" output="false">
        <cfreturn request.vars.routes.passed>
    </cffunction>
    <cffunction name="setPassedRoutes" output="false">
        <cfargument required="true" name="passedRoutes" default="">
        <cfset request.vars.routes.passed = arguments.passedRoutes>
    </cffunction>

    <cffunction name="getTargetScript" output="false">
        <cfreturn request.vars.routes.targetScript>
    </cffunction>
    <cffunction name="setTargetScript" output="false">
        <cfargument required="true" name="targetScript" default="">
        <cfset request.vars.routes.targetScript = arguments.targetScript>
    </cffunction>
<!--- }}} --->

    <cffunction access="public" name="introspect" output=true>
        <cfdump var=#this#>
        <cfdump var=#variables#>
    </cffunction>

    <cffunction name="isRouteRecursive" output="true">
        <cfargument required="true" name="targetRoute">
        <cfset var result = false>
        <cfif ListFindNoCase(this.getPassedRoutes(),arguments.targetRoute) eq 0>
            <cfset variables.passedRoutes = ListAppend(variables.passedRoutes,arguments.targetRoute)>
        <cfelse>
            <cfset var result = true>
        </cfif>
        <cfreturn result> 
    </cffunction>

<cffunction name="routingError" output="true">
    <cfargument required="true" name="route">

    <cfif application.obj.security.viaGateways(this.getTargetScript()) eq 0>
        <cfreturn 'warnings_illegalAccess'>
    </cfif>

<cfdump var=#application.obj.security.status()#>
    <cfif NOT(
            (ListFindNoCase('unauthenticated',application.obj.security.status()) gt 0 
            AND REFindNoCase('(^login_)|(^warnings)',arguments.route) gt 0)
            OR application.obj.security.status() eq 'loggedIn'
        )>
        <cfreturn 'warnings_refusedPage'>
    </cfif>
<!---  

    <cfif NOT StructKeyExists(application.vars.routes,'#arguments.route#')>
        <cfreturn 'warnings_invalidPage'>
    </cfif>

    <cfif this.isRouteRecursive(arguments.route)>
        <cfreturn 'warnings_recursivePage'>
    </cfif>
    <cfset this.isRouteRecursive(arguments.route)>
--->
    <cfreturn ''>
</cffunction>    
         
<cffunction name="view" output="true">
    <cfargument required="false" name="data" default="">
    <cfargument required="false" name="render" default="false">
    <cfargument required="false" name="wrap" default="true">

    <cfset var route = this.getTargetRoute()>
    <cfset var path.errored = this.routingError(route)>
    <cfset var path.relative = this.mapping(path.errored neq ''?path.errored:route)>
    <cfset var path.extract = REReplace(path.relative,'/[^/]+\.cfm','')>  

    <cfset var tempBody=''>
    <cfset var tempData = path.errored neq ''?arguments.data:'error'>
    <cfsavecontent variable='tempBody'> 
        <cfmodule template=#path.relative# data=#tempData#> 
    </cfsavecontent>

    <cfif arguments.wrap 
        and ListFindNoCase(route,'act','_') eq 0 
        and FileExists('#application.vars.dir.root##path.extract#\wrapper.cfm')>
        <cfsavecontent variable='tempBody'> 
            <cfmodule template="#path.extract#\wrapper.cfm" body=#tempBody#>
        </cfsavecontent>
    </cfif>

    <cfif arguments.render>
        <cfoutput> #tempBody# </cfoutput>
        <cfset tempBody = ''> 
    </cfif>

    <cfreturn tempBody>
</cffunction>
          
    <cffunction access="public" name="mapping" output="true">
        <cfargument name="route" required="true">
        <cfset var path = ''> 
        <cfif arguments.route eq 'default'>
            <cfif session.setting.appNow eq 'tracker'> 
                <cfset path='/tracker/home.cfm'>
            <cfelseif session.setting.appNow eq 'admin'> 
                <cfset path='/admin/home.cfm'>
            </cfif>
        <cfelse>
            <cfset path = application.vars.routes[arguments.route]>
        </cfif>
        <cfreturn path>
    </cffunction>

    <cffunction access="public" name="nojs" output="true">
        <cfset var nojs='sha'>

        <cfif ListFindNoCase(this.getTargetRoute(),'act','_') gt 0>
            <cfset nojs = 'jq,jqModal,ko,kovalidation,_,custom,sha'>
        <cfelse>
            <cfif this.getTargetRoute() eq 'login_home'> 
                <cfset nojs=application.obj.utils.ListRemoveValues(nojs,'sha')>
            </cfif>
        </cfif>

        <cfreturn nojs>
    </cffunction>

    <cffunction access="public" name="nocss" output="true">
        <cfset var nocss=''>
        <cfif ListFindNoCase(this.getTargetRoute(),'act','_') gt 0
            OR this.getTargetRoute() eq 'admin_r_index'> 
            <cfset nocss=ListAppend(nocss,'cardinal')>
        </cfif>

        <cfreturn nocss>
    </cffunction>

</cfcomponent>
