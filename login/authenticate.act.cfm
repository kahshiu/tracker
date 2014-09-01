<cfset authenticity.flag = false>

<cfif StructKeyExists(form,'username') and StructKeyExists(form,'userpwd')>     
    <cfif form.username neq '' and form.userpwd neq ''>
        <!--- hash it first and etc b4 authenticating --->
        <cfset authenticity = application.obj.Security.authenticate(form.username,form.userpwd)>
    </cfif>
</cfif>

<cfif authenticity.flag> 
    <cfset session.data = authenticity.data> 
    <cfset session.setting.envNow = form.isTraining?'Training':'Live'>
    <cfset request.redirect=REReplace(application.vars.web.url,'{{queryString}}','route=default')> 
<cfelse>
    <cfset request.redirect=REReplace(application.vars.web.url,'{{queryString}}','route=login_home')> 
</cfif>
