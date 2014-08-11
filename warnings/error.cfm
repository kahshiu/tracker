<cfoutput>
<!--- 
<cfif true>
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
</cfif>
<cfif true>

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
</cfif>
<cfif true>
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
</cfif>
<cfif true>
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
</cfif>
--->
</cfoutput>
