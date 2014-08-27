<cfcomponent displayName="router" output="true">

<cfset variables.security = ''>
<cfset variables.targetScript = ''>
<cfset variables.targetRoute = ''>
<cfset variables.passedRoutes = ''>

<!--- page mappings --->
<cfset variables.routes = {}>
<cfset variables.routes.default = ''>
<cfset variables.routes.warnings_home          = '/warnings/home.cfm'>
<cfset variables.routes.warnings_illegalAccess = '/warnings/illegalAccess.cfm'>
<cfset variables.routes.warnings_invalidPage   = '/warnings/invalidPage.cfm'>
<cfset variables.routes.warnings_recursivePage = '/warnings/recursivePage.cfm'>
<cfset variables.routes.warnings_refusedPage   = '/warnings/refusedPage.cfm'>

<cfset variables.routes.admin_random           = '/admin/random.cfm'>
<cfset variables.routes.admin_home             = '/admin/home.cfm'>
<cfset variables.routes.admin_r_index          = '/admin/railo.index.cfm'>
<cfset variables.routes.admin_sessiontracker   = '/admin/sessiontracker.cfm'>
<cfset variables.routes.admin_mongo            = '/admin/mongo.cfm'>
<cfset variables.routes.db_home                = '/admin/db/home.cfm'>

<cfset variables.routes.login_home             = '/login/home.cfm'>
<cfset variables.routes.login_authenticate_act = '/login/authenticate.act.cfm'>
<cfset variables.routes.user_personal         = '/login/personal.form.cfm'>
<cfset variables.routes.user_ann              = '/login/announcements.cfm'>
<cfset variables.routes.login_ann              = '/login/announcements.cfm'>

<cfset variables.routes.tracker_home           = '/tracker/home.cfm'>
<cfset variables.routes.file_form           = '/tracker/prf.file.form.cfm'>
<cfset variables.routes.file_form_act       = '/tracker/prf.file.form.act.cfm'>

<cffunction name="init" output="true">
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

<cffunction name="isRouteRecursive" output="true">
    <cfargument required="true" name="targetRoute">

    <cfset var result = false>
    <cfif ListFindNoCase(variables.passedRoutes,arguments.targetRoute) eq 0>
        <cfset variables.passedRoutes = ListAppend(variables.passedRoutes,arguments.targetRoute)>
    <cfelse>
        <cfset var result = true>
    </cfif>

    <cfreturn result> 
</cffunction>

<cffunction name="routingError" output="true">
    <cfargument required="true" name="route">

    <cfif NOT variables.security.viaGateways(variables.targetScript)>
        <cfreturn 'warnings_illegalAccess'>
    </cfif>

    <cfif NOT(
            (ListFindNoCase('unauthenticated,loggedOut',variables.security.status()) gt 0 
            AND REFindNoCase('(^login_)|(^warnings)',arguments.route) gt 0)
            OR variables.security.status() eq 'loggedIn'
        )>
        <cfreturn 'warnings_refusedPage'>
    </cfif>

    <cfif NOT StructKeyExists(variables.routes,'#arguments.route#')>
        <cfreturn 'warnings_invalidPage'>
    </cfif>

    <cfif this.isRouteRecursive(arguments.route)>
        <cfreturn 'warnings_recursivePage'>
    </cfif>
    <cfreturn ''>
</cffunction>    
         
<cffunction name="view" output="true">
    <cfargument required="true" name="route">
    <cfargument required="false" name="render" default="true">
    <cfargument required="false" name="data" default="">
    <cfargument required="false" name="wrap" default="true">

    <cfset var path.errored = this.routingError(arguments.route)>
    <cfset var path.relative = this.mapping(path.errored neq ''? path.errored:arguments.route)>
    <cfset var path.extract = REReplace(path.relative,'/[^/]+\.cfm','')>  

    <cfset var tempData = path.errored neq ''?arguments.data:'error'>
    <cfset var tempBody=''>
    <cfsavecontent variable='tempBody'> 
        <cfmodule template=#path.relative# data=#tempData#> 
    </cfsavecontent>
    <cfif arguments.wrap 
        and ListFindNoCase(arguments.route,'act','_') eq 0 
        and FileExists('#request.dir.root##path.extract#\wrapper.cfm')>
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
    <cfargument required="true" name="route" default="">
    <cfset path = ''> 
    <cfif arguments.route eq 'default'>
        <cfif session.setting.appNow eq 'tracker'> 
            <cfset path='/tracker/home.cfm'>
        <cfelseif session.setting.appNow eq 'admin'> 
            <cfset path='/admin/home.cfm'>
        </cfif>
    <cfelse>
        <cfset path = variables.routes['#arguments.route#']>
    </cfif>
    <cfreturn path>
</cffunction>

<cffunction access="public" name="nojs" output="true">
    <cfargument required="true" name="route">

    <cfset var nojs='sha'>
    <cfset var nocss=''>

    <cfif ListFindNoCase(arguments.route,'act','_') gt 0>
        <cfset nojs = 'jq,jqModal,ko,kovalidation,_,custom,sha'>
        <cfset nocss = 'cardinal'>
    <cfelse>
        <cfif arguments.route eq 'login_home'> 
            <cfset nojs=request.obj.utils.ListRemoveValues(nojs,'sha')>
        </cfif>
    </cfif>

    <cfreturn nojs>
</cffunction>

<cffunction access="public" name="nocss" output="true">
    <cfargument required="true" name="route">

    <cfset var nocss=''>
    <cfif arguments.route eq 'admin_r_index'> 
        <cfset nocss=ListAppend(nocss,'cardinal')>
    </cfif>

    <cfreturn nocss>
</cffunction>

</cfcomponent>
