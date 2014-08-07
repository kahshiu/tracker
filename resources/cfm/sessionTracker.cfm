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
<cfif StructKeyExists(url,'timeout')>
    <cfif url.timeout eq 'long'> <cfset session.timeout = '2700'>
    </cfif>
    <cfif url.timeout eq 'med'> <cfset session.timeout = '120'>
    </cfif>
    <cfif url.timeout eq 'short'> <cfset session.timeout = '30'>
    </cfif>
    <cfif url.timeout eq 'kill'> <cfset session.timeout = '1'>
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
    <!--- List sessions tracker --->
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

    <!--- List sessions --->
    <cfif ListFindNoCase(attributes.print,'sessionTracker') gt 0>
    <br> <table border=1>
            <thead>
                <tr>
                    <th>
                        Session ID 
                        &nbsp; &nbsp; &nbsp; &nbsp;
                        (Total: #variables.total#)
                        &nbsp; &nbsp; &nbsp; &nbsp;
                        <a href='#application.web.URL#'>Create session</a>
                    </th>
                    <th colspan=2>Timing <br>(Now: #now()#)</th>
                    <th>Timeout</th>
                    <th>Session State</th>
                </tr>
            </thead>
            <tbody>
                <cfloop collection='#variables.sessions#' item="key">
                    <cfset item = #variables.sessions[key]#>

                    <cfset isCurrentSession = item.urltoken eq session.urltoken>
<cfset request.sequence = 'asdf'>
                    <cfset isStartedSession = ListFindNoCase(request.sequence,'SessionStarted') gt 0>
                    <cfset variables.text = isCurrentSession?'&nbsp;Current Session':''>
                    <cfset variables.text = variables.text&#isStartedSession?'&nbsp;Fresh Session':''#>
                    <cfset variables.text = variables.text&'&nbsp;'>
                    <tr>
                        <td rowspan=4>
                            [#key#]
                            <br><a href='#application.web.URL##item.urltoken#'>?#item.urltoken#</a>
                            <cfif isCurrentSession>
                            <br><span style="color:white;background-color:darkred;font-weight:bold">#variables.text#</span>
                            </cfif>
                        </td>
                        <td>Timeout</td>
                        <td>: #item.timeout#</td>
                        <td rowspan=4>
                            <a href="#application.web.URL##item.urltoken#&timeout=long">Long</a>
                            <br><a href="#application.web.URL##item.urltoken#&timeout=med">Medium</a>
                            <br><a href="#application.web.URL##item.urltoken#&timeout=short">Short</a>
                            <br><a href="#application.web.URL##item.urltoken#&timeout=kill">Kill</a>
                        </td>
<!---
                        <td rowspan=4>
                            <cfif StructKeyExists(item,'vars')>
                                <cfif StructIsEmpty(item.vars)> Logged out [Struct cleared]
                                <cfelse> Logged in [Struct remain populate]
                                </cfif>
                            <cfelse> Not logged in [Key not exists] 
                            </cfif>
--->
                    </tr>
                    <tr><td>expire</td>
                        <td>: #DateAdd('s',item.timeout,item.lastvisit)#</td>
                    </tr>
                    <tr><td>last visit</td>
                        <td>: #item.lastvisit#</td>
                    </tr>
                    <tr><td> creation </td>
                        <td>: #variables.sessions[key]['timecreated']# </td>
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
