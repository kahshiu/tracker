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
        <cfif this.checkStatus() eq 'unauthenticated'>
            <cfset isAuthentic = this.authenticate(1,1)>
            <cfif isAuthentic.flag>
                <cfset session.vars.user = 1>
                <cfset session.vars.appNow = 'tracker'>
                <cfset session.vars.envNow = 'live'>
                <cfset session.vars.db = this.resetDB( session.vars.appNow,session.vars.envNow )>
                <cfset session.timeout = 2700>
            <cfelse>
                <cfset session.timeout = 1>
            </cfif>
        </cfif>

        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
        <!--- junk
        #getPageContext().getSession().invalidate()#
        --->
    </cffunction>

    <cffunction access="public" name="onSessionEnd" output=true>
        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

<!--- request hooks --->
    <cffunction access="public" name="onRequestStart" output=true>
        <cfargument name="targetPage" required="true">
        <cfargument name="resetAppVars" required="false" default="true">
        <cfargument name="debugSession" required="false" default="false">

        <cfif arguments.resetAppVars>
            <cfset this.resetAppVars()> 
        </cfif>
        <cfif this.checkStatus() eq 'loggedIn'>
            <cfset request.db = session.vars.db>
        </cfif>

        <!--- domain/ application access rights --->
        <!--- need to check if session is actuall permitted --->
        <!--- check url.user = username hash() --->
        <cfset request.web = application.web>
        <cfset request.dir = application.dir>
        <cfset request.railo = application.railo>
        <cfset request.obj.router = application.obj.router>

        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

    <cffunction access="public" name="onRequest" output=true>
        <cfargument name="targetPage" required="true">

        <cfset route='login_home'>
        <cfif NOT isScriptLegal(arguments.targetpage)> 
            <cfset route='warning_illegalScriptName'>    
        </cfif>
        <cfset route = 'admin_home'>
        <cfset request.obj.router.view(route)>

        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

    <cffunction access="public" name="onRequestEnd" output=true>
        <!--- domain event triggers --->

        <!--- logout operation --->
        <cfif session.timeout eq 1> <cfset StructClear(session.vars)> </cfif>
        <cfset session.setMaxInactiveInterval(session.timeout)>

        <cfset this.stampSequence(getFunctionCalledName())>
        <cfset this.printSequence()>
    </cffunction>

<!--- error hooks --->
    <cffunction access="public" name="onError" output=true>
{{{
<!---
        #request.router.view('warning_hitError')#
        <table width=100% class='error'>
                <colgroup>
                    <col class="meta" style="vertical-align: top; width:20%">
                </colgroup>
                <tr>
                    <th>Item</th>
                    <th>Description</th>
                </tr>
                <tr>
                    <td>Error Id</td> <td></td>
                </tr>
                <tr>
                    <td>Error Type</td>
                    <td>#exception.type#</td>
                </tr>
                <tr>
                    <td>Error Message</td>
                    <td>#exception.message#</td>
                </tr>
                <tr>
                    <td>Error Extended Info</td>
                    <td>#Exception.extendedinfo#</td>
                </tr>
            </table>
            <div align=center>
            <script>
            function jumpPrev () {
                window.location.href='#cgi.http_referer#'
            }
            </script>
            <input type="button" value="Go Back" onclick='jumpPrev()'>
            </div>
        <cfelseif version eq 'long'>
            <table width=100% class='error'>
                <colgroup>
                    <col class="meta" style="vertical-align: top">
                </colgroup>
                <tr>
                    <th>Item</th>
                    <th colspan=#totCol-1#>Description</th>
                </tr>
                <tr class='alt1'>
                    <td>Source:</td>
                    <td>IP</td>
                    <td colspan=#totCol-2#>:: User agent</td>
                </tr>
                <tr class='alt1'>
                    <td>&nbsp;</td>
                    <td>#cgi.remote_addr#</td>
                    <td colspan=#totCol-2#>:: #cgi.http_user_agent#</td>
                </tr>
                <tr class='alt2'>
                    <td>&nbsp;</td>
                    <td>Method</td>
                    <td colspan=#totCol-2#>:: HTTP Request</td>
                </tr>
                <tr class='alt2'>
                    <td>Referrer</td>
                    <td>&nbsp;</td>
                    <td colspan=#totCol-2#>:: #cgi.http_referer#</td>
                </tr>
                <tr class='alt2'>
                    <td>Request</td>
                    <td>#cgi.request_method#</td>
                    <td colspan=#totCol-2#>:: #cgi.request_url#</td>
                </tr>
                <tr class='alt1'>
                    <td>QString:</td>
                    <td>key</td>
                    <td colspan=#totCol-2#>:: value</td>
                </tr>
                <cfloop list=#cgi.query_string# index="item" delimiters="&">
                <tr class='alt1'>
                    <td>&nbsp;</td>
                    <td>#ListGetAt(item,1,'=')#</td>
                    <td colspan=#totCol-2#>
                        <cfset val = ListGetAt(item,2,'=')>
                        <cfif val neq ''>:: #val# </cfif>
                    </td>
                </tr>
                </cfloop>
                <tr class='alt2'>
                    <td>form:</td>
                    <td>key</td>
                    <td colspan=#totCol-2#>:: value</td>
                </tr>
                <cfloop collection=#form# item="key">
                <tr class='alt2'>
                    <td>&nbsp;</td>
                    <td>#key#</td>
                    <td colspan=#totCol-1#><cfif form[key] neq ''>:: #form[key]#</cfif></td>
                </tr>
                </cfloop>
                <tr class='alt1'>
                    <td>Error Time:</td>
                    <td colspan=#totCol-1#>#dateformat(now(),'full')# :: #timeformat(now(),'medium')#</td>
                </tr> 
                <tr class='alt1'>
                    <td>Error code:</td>
                    <td colspan=#totCol-1#>#exception.errorcode#</td>
                </tr>
                <tr class='alt1'>
                    <td> Error Class: </td>
                    <td> Error Type </td>
                    <td> :: Error Message </td>
                    <td> :: Error Extended Info </td>
                </tr>
                <tr class='alt1'>
                    <td> &nbsp;</td>
                    <td> #exception.type#</td>
                    <td> <cfif exception.message neq ""> :: #exception.message# </cfif> </td>
                    <td> <cfif exception.extendedinfo neq ""> :: #exception.extendedInfo# </cfif> </td>
                </tr>
                <tr class='alt2'>
                    <td>Template:</td>
                    <td colspan=#totCol-1#>
                    <pre style="white-space:nowrap; overflow:auto; width:75em">
                            <cfloop array=#exception.tagContext# index="item">
                            #item.type# :: #item.template# :: line #item.line# col #item.column#<br>
                            #item.codePrintHTML#<br>
                            </cfloop>
                    </pre>
                    </td>
                </tr>    
                <tr class='alt1'>
                    <td>EventName:</td>
                    <td colspan=#totCol-1#>#eventname#</td>
                </tr>
                <tr class='alt2'>
                    <td>StackTrace:</td>
                    <td colspan=#totCol-1#><pre>#exception.stacktrace#</pre></td>
                </tr>
            </table> 
--->}}}
    </cffunction>

<!--- custom functions --->
    <cffunction access="public" name="resetAppVars" output=false>
            <cfset application.web = {}>
            <cfset application.web.host = '#CGI.server_name#:#CGI.server_port#'>
            <cfset application.web.gateway = '/index.cfm'>
            <cfset application.web.URL = 'http://#application.web.host##application.web.gateway#?'>
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
            <cfset application.obj.router = createObject('component','#application.dir.cfc#/router')>
            <cfset application.obj.Sequencer = createObject('component','#application.dir.cfc#/Sequencer')>
    </cffunction>

    <cffunction access="public" name="resetDB" output=false>
        <cfargument name="app" required="true">
        <cfargument name="environment" required="true">
    
        <cfset db = ''>
        <cfif arguments.app eq 'tracker'>
            <cfif arguments.environment eq 'live'>
                <cfset db = 'tracker'>
            <cfelseif arguments.environment eq 'training'>
                <cfset db = 'tracker_testing'>
            </cfif>
        </cfif>

        <cfreturn db>
    </cffunction>

    <cffunction access="public" name="checkStatus" output=false>
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

    <cffunction access="public" name="isScriptLegal" output=false>
        <cfargument name="accessedScript" required="true">
        <cfreturn application.web.gateway eq arguments.accessedScript>
    </cffunction>

    <cffunction access="public" name="authenticate" output=true>
        <cfargument name="username" required="true">
        <cfargument name="password" required="true">
            <!--- 
            <cfquery name="qry_identity" datasource="logger">
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
