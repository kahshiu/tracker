<cfset authenticity.flag = false>

<cfif StructKeyExists(form,'username') and StructKeyExists(form,'userpwd')>     
    <cfif form.username neq '' and form.userpwd neq ''>
        <!--- hash it first and etc b4 authenticating --->
        <cfset authenticity = request.obj.Security.authenticate(form.username,form.userpwd)>
    </cfif>
</cfif>

<cfif authenticity.flag> 
    <cfset session.data = authenticity.data> 
    <cfset request.redirect='#request.web.url#route=default&#session.urltoken#'> 
<cfelse>
    <cfset request.redirect='#request.web.url#route=login_home'> 
</cfif>
