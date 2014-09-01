<cfcomponent output=false hint="" >

    <cfset this.name               = 'Mothership'>
    <cfset this.applicationTimeout = createTimeSpan(6,0,0,0)>
    <cfset this.sessionTimeout     = createTimeSpan(0,0,0,5)>
    <cfset this.sessionManagement  = true>
    <cfset this.setDomainCookies   = false>
    <cfset this.setClientCookies   = false>
    <cfset this.clientManagement   = false>
    <cfset this.clientStorage      = false>
    <cfset this.scriptProtect      = true>

    <cfset variables.labels.config.activate = true>
    <cfset variables.labels.config.show     = ''> <!--- option to show stages (current, all) --->
    <cfset variables.labels.sequence        = ''>
    <cfset variables.labels.sequenceAll     = ''>
    <cfset variables.reset.showMsg     = ''><!--- option to show reset msg (app,req) --->

<!--- application hooks --->
    <cffunction access="public" name="onApplicationStart" output=true>
        <cfset this.resetAppScope('all')>
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
        <cfset application.vars.web.latestSession = session.sessionId>
        <cfset session.setting.timeout = 1>
        <cfset session.setting.appNow = 'login'>
        <cfset session.setting.envNow = ''>
        <!--- junk
        #getPageContext().getSession().invalidate()#
        --->
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

    <cffunction access="public" name="onSessionEnd" output=true>
        <cfif StructKeyExists(session,'data')> 
            <cfset StructDelete(session,'data')> 
        </cfif>
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

<!--- request hooks --->
    <cffunction access="public" name="onRequestStart" output=true>
        <cfargument name="targetPage" required="true">
        <cfargument name="resetAppVars" required="false" default="false">
<!---  
        <cfset this.resetAppScope('vars')>
        <cfset this.resetAppScope('obj')>
--->
        <cfset this.resetAppScope('all')>
        <cfset this.resetRequestScope('all')>

        <!--- domain/ application access rights --->
        <!--- need to check if session is actuall permitted --->
        <!--- check url.user = username hash() --->
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>   

    <cffunction access="public" name="onRequest" output=true>
        <cfargument name="targetPage" required="true">
        <cfif StructKeyExists(url,'route')>
            <cfset application.obj.Router.setTargetRoute(url.route)>
        <cfelse>
            <cfset application.obj.Router.setTargetRoute('login_home')>
        </cfif>
        <cfset application.obj.Router.setTargetScript(CGI.script_name)>


<!--- 
<cfexecute name="#request.dir.root#\test.bat" variable="data" timeout="10" />
<cfset data="">
<cfexecute name="c:\windows\system32\cmd.exe" arguments="/c set" variable="data" timeout="10" />
<cfdump var="#data#">
<cfdump var=#request.dir#>
--->
        <cfset var body = ''>
        <cfset body = application.obj.Router.view()>
        <cfif FileExists('#application.vars.dir.root#\wrapper.cfm')>
            <cfmodule template="wrapper.cfm" 
                body=#body# 
                nojs=#application.obj.Router.nojs()# 
                nocss=#application.obj.Router.nocss()#>
        </cfif>

        <!--- domain event triggers --->
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

    <cffunction access="public" name="onRequestEnd" output=true>
<!---  
        <cfset request.obj.Router.setPassedRoutes('')>
--->
        <!--- security status checking --->
        <cfset var currentStatus = application.obj.Security.status()>
        <cfif currentStatus eq 'loggedIn'>
            <cfif session.data.identity.role eq "admin">
                <cfset session.setting.appNow = 'admin'>
            <cfelse>
                <cfset session.setting.appNow = 'tracker'>
            </cfif>
            <cfset session.setting.timeout = 2700>

        <cfelse>
            <cfset session.setting.appNow = 'login'>
            <cfset session.setting.timeout = 1>
        </cfif>

        <!--- logout operation --->
        <cfif StructKeyExists(session.setting,'overwrite')>
            <cfset session.setting.timeout = session.setting.overwrite>
            <cfset StructDelete(session.setting,'overwrite')>
        </cfif>
        <cfif StructKeyExists(session,'data') and session.setting.timeout eq 1> 
            <cfset StructDelete(session,'data')> 
        </cfif>

        <!--- for stricter rules (really ensure session expired), sleep thread for 1 second --->
        <cfset session.setMaxInactiveInterval(session.setting.timeout)>

        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>

        <!--- redirect --->
        <cfif StructKeyExists(request,'redirect')>
            <cflocation url='#request.redirect#' addToken=no>            
        </cfif>
    </cffunction>

<!--- error hooks --->
    <cffunction access="public" name="onError" output=true>
        <cfargument required="true" name="Exception"> 
        <cfargument required="true" name="EventName"> 
<cfdump var=#exception#>
<cfdump var=#eventname#>
    </cffunction>

<!--- custom functions --->
    <cffunction access="public" name="resetAppScope" output=true>
        <cfargument name="values" required="true">
        <!--- {{{ application vars --->
        <cfif ListFindNoCase(arguments.values, 'vars') gt 0 OR ListFindNoCase(arguments.values, 'all') gt 0>
            <cfset application.vars = {}>

            <cfset application.vars.dir      = {}>
            <cfset application.vars.dir.root = '#server.coldfusion.rootdir#'>
            <cfset application.vars.dir.cfc  = '\resources\cfc'>
            <cfset application.vars.dir.cfm  = '\resources\cfm'>
            <cfset application.vars.dir.css  = '\resources\css'>
            <cfset application.vars.dir.js   = '\resources\js'>

            <cfset application.vars.web               = {}>
            <cfset application.vars.web.host          = 'http://#CGI.server_name#:#CGI.server_port#'>
            <cfset application.vars.web.gateway       = '/index.cfm'>
            <cfset application.vars.web.url           = '#application.vars.web.host##application.vars.web.gateway#?{{queryString}}&#session.urltoken#'>
            <cfset application.vars.web.latestSession = ''>

            <cfset application.vars.railo        = {}>
            <cfset application.vars.railo.home   = "#application.vars.web.host#/railo.index.cfm">
            <cfset application.vars.railo.server = "#application.vars.web.host#/railo-context/admin/server.cfm">
            <cfset application.vars.railo.web    = "#application.vars.web.host#/railo-context/admin/web.cfm">

            <cfset application.vars.labels.onApplicationStart = 'AppStarted'>
            <cfset application.vars.labels.onApplicationEnd   = 'AppEnded'>
            <cfset application.vars.labels.onSessionStart     = 'SessionStarted'>
            <cfset application.vars.labels.onSessionEnd       = 'SessionEnded'>
            <cfset application.vars.labels.onRequestStart     = 'RequestStarted'>
            <cfset application.vars.labels.onRequest          = 'RequestExecuted'>
            <cfset application.vars.labels.onRequestEnd       = 'RequestEnded'>
            <cfset application.vars.labels.onError            = 'ErrorEncountered'>   

            <cfset application.vars.routes = {}>
            <cfset application.vars.routes.default                = ''>
            <cfset application.vars.routes.warnings_home          = '/warnings/home.cfm'>
            <cfset application.vars.routes.warnings_illegalAccess = '/warnings/illegalAccess.cfm'>
            <cfset application.vars.routes.warnings_invalidPage   = '/warnings/invalidPage.cfm'>
            <cfset application.vars.routes.warnings_recursivePage = '/warnings/recursivePage.cfm'>
            <cfset application.vars.routes.warnings_refusedPage   = '/warnings/refusedPage.cfm'>

            <cfset application.vars.routes.admin_random           = '/admin/random.cfm'>
            <cfset application.vars.routes.admin_home             = '/admin/home.cfm'>
            <cfset application.vars.routes.admin_r_index          = '/admin/railo.index.cfm'>
            <cfset application.vars.routes.admin_sessiontracker   = '/admin/sessiontracker.cfm'>
            <cfset application.vars.routes.admin_mongo            = '/admin/mongo.cfm'>
            <cfset application.vars.routes.db_home                = '/admin/db/home.cfm'>

            <cfset application.vars.routes.login_home             = '/login/home.cfm'>
            <cfset application.vars.routes.login_authenticate_act = '/login/authenticate.act.cfm'>
            <cfset application.vars.routes.user_personal          = '/login/personal.form.cfm'>
            <cfset application.vars.routes.user_ann               = '/login/announcements.cfm'>
            <cfset application.vars.routes.login_ann              = '/login/announcements.cfm'>

            <cfset application.vars.routes.tracker_home           = '/tracker/home.cfm'>
            <cfset application.vars.routes.file_form              = '/tracker/prf.file.form.cfm'>
            <cfset application.vars.routes.file_form_act          = '/tracker/prf.file.form.act.cfm'>  

            <cfif ListFindNoCase(variables.reset.showMsg,'app') gt 0>
                <cfdump var='application: vars reset'>
            </cfif>
        </cfif>
        <!--- }}} --->

        <cfif ListFindNoCase(arguments.values,'obj') gt 0 OR ListFindNoCase(arguments.values, 'all') gt 0>
            <cfset application.obj = {}>
            <cfset application.obj = instantiateCFCs()>  

            <cfif ListFindNoCase(variables.reset.showMsg,'app') gt 0>
                <cfdump var='application: obj reset'>
            </cfif>
        </cfif>

<!---  
        <cfif ListFindNoCase(arguments.values,'db') gt 0 OR ListFindNoCase(arguments.values, 'all') gt 0>
            <cfset application.db = {}>
            <cfset application.db.jFactory = createObject('component','cfmongodb.core.JavaloaderFactory').init()>
            <cfset application.db.config = createObject('component','cfmongodb.core.MongoConfig').init(dbName="logger", mongoFactory=#application.db.jFactory#)>
            <cfset application.db.logger = createObject('component','cfmongodb.core.MongoClient').init(mongoConfig)>

            <cfif ListFindNoCase(variables.reset.showMsg,'app') gt 0>
                <cfdump var='application: obj reset'>
            </cfif>
        </cfif>
--->
    </cffunction>

    <cffunction name="resetRequestScope" output="true">
        <cfargument name="values" required="true">
        <cfif ListFindNoCase(arguments.values,'vars') gt 0 OR ListFindNoCase(arguments.values,'all') gt 0>
            <cfset request.vars.routes.targetRoute  = ''>
            <cfset request.vars.routes.targetScript = ''>
            <cfset request.vars.routes.passed       = ''>

            <cfif ListFindNoCase(variables.reset.showMsg,'req') gt 0>
                <cfdump var='request: vars reset'>
            </cfif>
        </cfif>
        <cfif ListFindNoCase(arguments.values,'db') gt 0 OR ListFindNoCase(arguments.values,'vars') gt 0>
            <!--- reset db --->
<!---  
     <cfargument name="app" required="true">
        <cfargument name="environment" required="false" default="">
        <cfset db = ''>
        <cfif arguments.app eq 'tracker'>
            <cfif arguments.environment eq 'live'>         
                <cfset db = 'tracker'>
            <cfelseif arguments.environment eq 'training'> 
                <cfset db = 'tracker_testing'>
            </cfif>
        <cfelseif arguments.app eq 'login' OR arguments.app eq 'admin'>
            <cfset db = 'login'>
        </cfif>
        <cfreturn db>   
--->
        </cfif>
    </cffunction>

    <cffunction access="public" name="instantiateCFCs" output="true">
        <cfargument required="false" name="cfcPath" default="#application.vars.dir.cfc#">
        <cfargument required="false" name="rootPath" default="#application.vars.dir.root#">

        <cfset var obj = {}>
        <cfset var qfiles = ''>
        <cfset var REroot = REReplace('#arguments.rootPath#','\\','\\','all')>

        <cfdirectory directory="#arguments.cfcPath#" action="list" filter="*.cfc" name="qfiles" recurse="true" type="file">
        <cfloop query="qfiles">
            <cfset cfcname = REReplace(name,'(\w+).cfc','\1')>
            <cfset cfcDir = REReplace(directory,'#RERoot#','','all')>
            <cfobject type="component" component="#cfcDir#\#cfcname#" name="obj.#cfcname#">
        </cfloop>
        <cfreturn obj>
    </cffunction>

    <!--- debugger: sequence --->
    <cffunction access="public" name="stampSequence" output="true">
        <cfargument name="functionCalled" required="true">
        <cfif variables.labels.config.activate>
            <cfset var sequence = application.vars.labels['#arguments.functionCalled#']> 
            <cfset variables.labels.sequence = sequence>
            <cfset variables.labels.sequenceAll = ListAppend(variables.labels.sequenceAll,sequence)>
        </cfif>
    </cffunction>

    <cffunction access="public" name="printSequence" output="true">
        <cfif ListFindNoCase(variables.labels.config.show,'current')>
            <cfdump var=#variables.labels.sequence#>
        </cfif>
        <cfif ListFindNoCase(variables.labels.config.show,'all')>
            <cfdump var=#variables.labels.sequenceAll#>
        </cfif>
    </cffunction>

</cfcomponent>
