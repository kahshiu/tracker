<cfoutput>
<html>
<!---
    <head>
        <link rel="stylesheet" href="resources/css/simplegrid.css">
        <link rel="stylesheet" href="resources/css/general.css">
    </head>
--->
    <body>
<cfset caller.this.view('login_ann')>
<cfoutput>

</cfoutput>
      <link rel="stylesheet" href="#request.dir.css#/main.css">
        <form method="post" action="#request.web.url#route=login_authenticate_act">
<div>
    <div>
Login for Stranger Who!
    </div>
    <div></div>
    <div></div>
</div>
        <table>
            <tr> <td colspan=2 align=center>Welcome, Stranger.</td> </tr>
            <tr> <td>Name</td> <td> <input type="text" name="username"></td> </tr>
            <tr> <td>Password</td> <td> <input type="text" name="userpwd"></td> </tr>
            <tr> <td colspan=2 align=center><input type="submit" value="Login"></td> </tr>
        </table>
        </form>                    

<!---  
    <div class="grid grid-pad">
        <div class="col-1-3"> 
<!--- login panel --->
<!---  
--->
        </div>
<!--- announcement --->
<!--- 
        <cfquery name="qry_announcement" datasource="gatekeeper">
            select top 20 vaAnnouncement, thedate = coalesce(ann.dtModOn, ann.dtCrtOn), usermail = case when isNull(usr.vaemail,'') = '' then 'Stranger.no-mail' else usr.vaemail end
            from announcement ann inner join sec0001 usr on usr.iusid = ann.iusid
            order by iannounce desc
        </cfquery>
        <table>
            <tbody class="alt">
            <tr> <td colspan=3><input type="button" data-link="" onclick="gotoDataLink(this)" value="Announcement"></td> </tr>
            <cfloop query="qry_announcement">
                <tr>
                    <td>#currentrow#.</td>
                    <td><strong>#usermail#</strong> says on <em>#dateformat(thedate,'dd-mm-yyyy')#</em><br>
                         &lt;&lt;&nbsp;#vaAnnouncement#&nbsp;&gt;&gt;
                    </td>
                </tr>
            </cfloop>
            <tr> <td colspan=3>Note: Announcement expires after 6 months</td> </tr>
            </tbody>
        </table>
        </div>
--->
--->
    </div>
    </body>
</html>
</cfoutput>
