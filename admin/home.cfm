<cfoutput>
    <div class="grid-item large-one-whole">
    <a href="#request.web.URL#route=admin_r_index">Railo Main</a> 
    || <a href="#application.railo.server#">Railo Admin</a> 
    || <a href="#application.railo.web#">Railo Web</a>
    </div>
</cfoutput>
<cfset caller.this.view('admin_sessiontracker')>
