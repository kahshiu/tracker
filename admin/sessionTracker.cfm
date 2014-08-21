<cfparam name="attributes.appname" default="#application.applicationName#">
<cfparam name="attributes.print" default="sessionTracker">
<cfparam name="attributes.origId" default="">

<cfif StructKeyExists(url,'origId') and url.origId neq ''>
    <cfset attributes.origId = url.origId>
<cfelse>
    <cfset attributes.origId = '#session.cfid#|#session.cftoken#'>
</cfif>

<cfif StructKeyExists(url,'timeout')>
    <cfif url.timeout eq 'long'> <cfset session.setting.overwrite = '2700'>
    <cfelseif url.timeout eq 'med'> <cfset session.setting.overwrite = '120'>
    <cfelseif url.timeout eq 'kill'> <cfset session.setting.overwrite = '1'>
    </cfif>
</cfif>

<cfset targeturl = '#request.web.URL#route=admin_sessiontracker&origId=#attributes.origId#'>
<cfset variables.isOwnSession = false>
<cfset variables.isCurrentSession = false>


<!---  
<cffunction access="public" name="genRefererURL" output="true">
    <cfargument required="false" name="structURL" default={}>
    <cfargument required="false" name="addtoken" default="yes">
    <cf
    <cfreturn >
</cffunction>
--->
<!--- /*{{{*/
<cfparam name="attributes.print" default="sessionTrackerClass,sessionTracker,session">
--->
<!--- 
print is list of options:
-sessionTrackerClass
-sessionTracker
-sessionClass
-session
--->/*}}}*/

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
    <div class="grid grid-gutter-half">
        <h4 class="grid-item large-one-whole"> Total running session: #variables.total#</h4>

        <cfloop collection='#variables.sessions#' item="key">
            <cfset item = #variables.sessions[key]#>
            <cfif attributes.origId neq ''>
                <cfif ListGetAt(attributes.origId,1,'|') eq item.cfid and ListGetAt(attributes.origId,2,'|') eq item.cftoken>
                    <cfset variables.isOwnSession = true>
                <cfelse>
                    <cfset variables.isOwnSession = false>
                </cfif>
            <cfelse>
                <cfset variables.isOwnSession = false>
            </cfif>
            <cfset variables.isCurrentSession = session.sessionid eq item.sessionid>
            <hr>
            <div class="grid-item large-one-half"> 
                Key: [#key#] <br>
                <cfif item.setting.timeout eq 1> 
                    ?#item.urltoken# 
                <cfelse> 
                    <a href='#targeturl#&#item.urltoken#' class="button">?#item.urltoken#</a> 
                </cfif>
            </div>
            <div class="grid-item large-one-half"> 
                overwrite timeout:
                <br>
                <cfif NOT isOwnSession
                    and item.setting.timeout neq 1 
                    and NOT (StructKeyExists(item.setting,'overwrite') and item.setting.overwrite eq 1)>
                    <a href="#targeturl#&timeout=kill&#item.urltoken#" class="button">1s</a>
                    <a href="#targeturl#&timeout=med&#item.urltoken#" class="button">120s</a>
                    <a href="#targeturl#&timeout=long&#item.urltoken#" class="button">2700s</a>
                </cfif> 
            </div>
            <div class="grid-item large-one-half"> 
                expire: #DateAdd('s',item.setting.timeout,item.lastvisit)#
                <br>visited: #item.lastvisit# 
                <br>created: #item.timecreated# 
            </div>
            <div class="grid-item large-one-half"> 
                <div class="grid">
                    <div class="grid-item large-one-half"> 
                        Identity: 
<!---  
                        <cfif isDefined('item.data.identity')>
                            <cfif StructKeyExists(item.data.identity,'vausmail')> #item.data.identity.vausmail#
                            <cfelseif StructKeyExists(item.data.identity,'vausname')> #item.data.identity.vausname#
                            <cfelse>unidentified
                            </cfif>

                            <cfif StructKeyExists(item.data.identity,'role')> (#item.data.identity.role#) 
                            </cfif>
                        </cfif>
                        <br>status: <cfif StructIsEmpty(item.data)> Not Logged <cfelse> Logged in </cfif>
--->
                        <br>current timeout:
                        <cfif StructKeyExists(item.setting,'overwrite')>
                          #item.setting.overwrite#
                        <cfelse>
                          #item.setting.timeout#
                        </cfif>
                    </div>
                    <div class="grid-item large-one-half"> 
                        <cfif variables.isOwnSession> <span style="background:darkred;color:white">&nbsp;own session&nbsp;</span> </cfif>
                        <cfif variables.isCurrentSession> <span style="background:darkred;color:white">&nbsp;current session&nbsp;</span> </cfif>
                    </div>
                </div>

            </div>
        </cfloop>
    </div>
    </cfif>

<!---  
            </tbody>
        </table>
    </cfif>
    <cfif ListFindNoCase(attributes.print,'sessionClass') gt 0> 
    <br><cfdump var=#getMetadata(session)#> 
    </cfif>
    <cfif ListFindNoCase(attributes.print,'session') gt 0> 
    <br><cfdump var=#session#> 
    </cfif>
--->
    </cfoutput>
</cfif>
