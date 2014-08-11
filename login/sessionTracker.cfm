<cfparam name="attributes.appname" default="#application.applicationName#">
<cfparam name="attributes.print" default="sessionTracker">
<!--- 
<cfparam name="attributes.print" default="sessionTrackerClass,sessionTracker,session">
--->
<!--- 
print is list of options:
-sessionTrackerClass
-sessionTracker
-sessionClass
-session
--->

<cfset variables.defaultTimeout = 1>

<cfif StructKeyExists(url,'timeout')>
    <cfif url.timeout eq 'long'> <cfset session.setting.timeout = '2700'>
    <cfelseif url.timeout eq 'med'> <cfset session.setting.timeout = '120'>
    <cfelseif url.timeout eq 'short'> <cfset session.setting.timeout = '30'>
    <cfelseif url.timeout eq 'kill'> <cfset session.setting.timeout = '1'>
    </cfif>
</cfif>

<cfif ListLen(attributes.print) gt 0>
    <!--- page model --->
    <cfset variables.tracker = createObject("java", "coldfusion.runtime.SessionTracker")>
    <cfset variables.total = tracker.getSessionCount()>
    <cfset variables.sessions = tracker.getSessionCollection(attributes.appname)>

    <!--- page presentation --->
    <cfoutput>
    <style>
        table td{vertical-align:top}
    </style>
    <!--- {{{ List sessions tracker --->
    <cfif ListFindNoCase(attributes.print,'sessionTrackerClass') gt 0>
    <br> <table>
            <thead>
                <tr>
                    <th>No.</th>
                    <th>Method</th>
                    <th>Description</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1.</td>
                    <td>getSessionCount()</td>
                    <td>Total sessions available. Not tied to availability of <em>getSessionCollection()</em> results; <br>Returns Integer</td>
                </tr>
                <tr>
                    <td>2.</td>
                    <td>getSessionCollection()</td>
                    <td>List down details of each session;<br>Returns Struct (cfid, cftoken, lastvist, sessionid, timecreated, urltoken)</td>
                </tr>
            </tbody>
        </table>
    </cfif>
    <!--- }}} List sessions tracker --->

    <!--- List sessions --->
    <cfif ListFindNoCase(attributes.print,'sessionTracker') gt 0>
    <br> <table border=1>
            <thead>
                <tr>
                    <th>
                        Session ID 
                        &nbsp; &nbsp; &nbsp; &nbsp; (Total: #variables.total#)
                        &nbsp; &nbsp; &nbsp; &nbsp; <a href='#application.web.URL#'>Create session</a>
                    </th>
                    <th colspan=2>Timing <br>(Now: #now()#)</th>
                    <th>Timeout</th>
                    <th>Session State</th>
                </tr>
            </thead>
            <tbody>
                <cfloop collection='#variables.sessions#' item="key">
                    <cfset item = #variables.sessions[key]#>
                    <cfset variables.isCurrentSession = item.sessionId eq session.sessionId>
                    <cfset variables.isFreshSession   = item.sessionId eq request.web.latestSession>
                    <cfset variables.text1            = variables.isCurrentSession? ' Current Session ':''>
                    <cfset variables.text2            = variables.isFreshSession? ' Fresh Session ':''>
                    <tr>
                        <td rowspan=4>
                            [#key#]
                            <cfif item.setting.timeout eq 1>
                                <br>?#item.urltoken#
                            <cfelse>
                                <br><a href='#application.web.URL##item.urltoken#'>?#item.urltoken#</a>
                            </cfif>
                            <cfif isCurrentSession> <br><span style="color:white;background-color:darkred;font-weight:bold">#variables.text1#</span> </cfif>
                            <cfif isFreshSession> <br><span style="color:white;background-color:magenta;font-weight:bold">#variables.text2#</span> </cfif>
                        </td>
                        <td>Timeout</td>
                        <td>: #item.setting.timeout#</td>
                        <td rowspan=4>
                            <cfif item.setting.timeout eq 1>
                                [Dying]
                            <cfelse>
                                <a href="#application.web.URL##item.urltoken#&timeout=long">Long</a>
                                <br><a href="#application.web.URL##item.urltoken#&timeout=med">Medium</a>
                                <br><a href="#application.web.URL##item.urltoken#&timeout=short">Short</a>
                                <br><a href="#application.web.URL##item.urltoken#&timeout=kill">Kill</a>
                            </cfif>
                        </td>
                        <td rowspan=4> #request.obj.Security.status()# </td>
                    </tr>
                    <tr><td>expire</td>
                        <td>: #DateAdd('s',item.setting.timeout,item.lastvisit)#</td>
                    </tr>
                    <tr><td>last visit</td>
                        <td>: #item.lastvisit#</td>
                    </tr>
                    <tr><td> creation </td>
                        <td>: #item.timecreated# </td>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    </cfif>

    <cfif ListFindNoCase(attributes.print,'sessionClass') gt 0> 
    <br><cfdump var=#getMetadata(session)#> 
    </cfif>
    <cfif ListFindNoCase(attributes.print,'session') gt 0> 
    <br><cfdump var=#session#> 
    </cfif>
    </cfoutput>
</cfif>
