<cfcomponent output=true hint="" >

    <cfset this.name = 'Mothership'>
    <cfset this.applicationTimeout=createTimeSpan(6,0,0,0)>
    <cfset this.sessionManagement=true>
    <cfset this.sessionTimeout=createTimeSpan(0,0,0,30)>
    <cfset this.setClientCookies=false>
    <cfset this.setDomainCookies=false>
    <cfset this.clientManagement=false>
    <cfset this.clientStorage=false>
    <cfset this.scriptProtect=true>

    <cfset variables.debug.sequence.activate = true>
    <cfset variables.debug.sequence.show = 'current'><!--- option to show stages (current, all) --->

<!--- application hooks --->
    <cffunction access="public" name="onApplicationStart" output=true>
        <cfset this.resetAppVars()>
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

    <cffunction access="public" name="onApplicationEnd" output=true>
        <!--- application audit logging --->
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

<!--- session hooks --->
    <cffunction access="public" name="onSessionStart" output=true>
        <cfset application.web.latestSession = session.sessionId>
        <cfset session.setting.timeout = 1>
        <cfset session.setting.appNow = 'login'>
        <cfset session.setting.envNow = ''>
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
        <!--- junk
        #getPageContext().getSession().invalidate()#
        --->
    </cffunction>

    <cffunction access="public" name="onSessionEnd" output=true>
        <cfif StructKeyExists(session,'data')> 
                <cfset StructClear(session.data)> 
        </cfif>
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

<!--- request hooks --->
    <cffunction access="public" name="onRequestStart" output=true>
        <cfargument name="targetPage" required="true">
        <cfargument name="resetAppVars" required="false" default="false">
<!--- 
<cfset arguments.resetAppVars = true>
<cfset arguments.resetSessions = true>
--->
<cfset arguments.resetAppVars = true>
        <cfif arguments.resetAppVars>
            <cfset this.resetAppVars()> 
        </cfif>
        <cfset resetRequestVars()>

        <!--- domain/ application access rights --->
        <!--- need to check if session is actuall permitted --->
        <!--- check url.user = username hash() --->
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>   

    <cffunction access="public" name="onRequest" output=true>
        <cfargument name="targetPage" required="true">
        <cfif StructKeyExists(url,'route')>
            <cfset var route = url.route>
        <cfelse>
            <cfset var route = 'login_home'>
        </cfif>
<!--- 
        <cfset route = 'login_home'>
        <cfset route = 'admin_home'>
        <cfset route = 'db_home'>
        <cfset route = 'login_home'>
--->
        <cfset route = 'login_home'>
        <cfset request.obj.Router.init(route,arguments.targetPage,request.obj.Security)>
        <cfset request.obj.Router.view(route)>
<cfexecute name="#request.dir.root#\test.bat"
        variable="data"
        timeout="10" />
<!--- 
<cfset data="">
<cfexecute name="c:\windows\system32\cmd.exe"
        arguments="/c set"
        variable="data"
        timeout="10" />

<cfdump var="#data#">
<cfdump var=#request.dir#>
--->
<!---
   --->
        <!--- domain event triggers --->

        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

    <cffunction access="public" name="onRequestEnd" output=true>
        <!--- security status checking --->
        <cfset currentStatus = request.obj.Security.status()>
        <cfif currentStatus eq 'loggedIn'>
            <cfset session.setting.appNow = 'tracker'>
            <cfset session.setting.envNow = 'live'>
            <cfset session.setting.timeout = 2700>
        <cfelse>
            <cfset session.setting.appNow = 'login'>
            <cfset session.setting.timeout = 1>
        </cfif>
        <!--- logout operation --->
        <cfif StructKeyExists(session,'data') and session.setting.timeout eq 1> 
                <cfset StructClear(session.data)> 
        </cfif>
        <cfset session.setMaxInactiveInterval(session.setting.timeout)>

        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>

        <cfif StructKeyExists(request,'redirect')>
            <cflocation url='#request.redirect#' addToken=no>            
        </cfif>
        <!--- for stricter rules (really ensure session expired), sleep thread for 1 second --->
    </cffunction>

<!--- error hooks --->
    <cffunction access="public" name="onError" output=true>
<cfmodule template='/warnings/error.cfm'>
<!--- 
        <cfset application.obj.Router.view('warnings_error')>
--->
    </cffunction>

<!--- custom functions --->
    <cffunction access="public" name="resetAppVars" output=false>
            <cfset application.web = {}>
            <cfset application.web.host = '#CGI.server_name#:#CGI.server_port#'>
            <cfset application.web.gateway = '/index.cfm'>
            <cfset application.web.URL = 'http://#application.web.host##application.web.gateway#?'>
            <cfset application.web.latestSession = ''>
            <cfset application.dir = {}>
            <cfset application.dir.root = '#server.coldfusion.rootdir#'>
            <cfset application.dir.cfc = '\resources\cfc'>
            <cfset application.dir.cfm = '\resources\cfm'>
            <cfset application.dir.css = '\resources\css'>
            <cfset application.dir.js  = '\resources\js'>
            <cfset application.railo = {}>
            <cfset application.railo.server = "http://#application.web.host#/railo-context/admin/server.cfm">
            <cfset application.railo.web = "http://#application.web.host#/railo-context/admin/web.cfm">
            <cfset application.obj = {}>
            <cfset application.obj.Router = createObject('component','#application.dir.cfc#/Router')>
            <cfset application.obj.Security = createObject('component','#application.dir.cfc#/Security')>
            <cfset application.obj.Sequencer = createObject('component','#application.dir.cfc#/Sequencer')>
    </cffunction>
    <cffunction name="resetRequestVars" output="true">
        <cfset request.web = application.web>
        <cfset request.dir = application.dir>
        <cfset request.railo = application.railo>
        <cfset request.obj = application.obj>
        <cfset request.db = this.resetDB(session.setting.appNow,session.setting.envNow)>
    </cffunction>
    <cffunction access="public" name="resetDB" output=false>
        <cfargument name="app" required="true">
        <cfargument name="environment" required="false" default="">
        <cfset db = ''>
        <cfif arguments.app eq 'tracker'>
            <cfif arguments.environment eq 'live'>         <cfset db = 'tracker'>
            <cfelseif arguments.environment eq 'training'> <cfset db = 'tracker_testing'>
            </cfif>
        <cfelseif arguments.app eq 'login'>
            <cfset db = 'login'>
        </cfif>
        <cfreturn db>
    </cffunction>

    <cffunction name="stampSequence" output="true">
        <cfargument required="true" name="functionName" default="">
        <cfif variables.debug.sequence.activate>
            <cfif NOT StructKeyExists(variables,'Sequencer')>
                <cfset variables.Sequencer = application.obj.Sequencer>
                <cfset variables.Sequencer.init()>
            </cfif>
            <cfset variables.Sequencer.setSequence(arguments.functionName)>
        </cfif>
    </cffunction>
    <cffunction name="printSequence" output="true">
        <cfif variables.debug.sequence.activate>
            <cfif ListFindNoCase(variables.debug.sequence.show,'all') gt 0> 
                <cfdump var='Full Stages: #variables.sequencer.getFullSequence()#'>
            </cfif>
            <cfif ListFindNoCase(variables.debug.sequence.show,'current') gt 0> 
                <cfdump var='Current Stage: #variables.sequencer.getSequence()#'>
            </cfif>
        </cfif>
    </cffunction>

</cfcomponent>
