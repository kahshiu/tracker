<cfoutput>
<style>
nav .nav {}
</style>
<div class="grid">
    <div class='grid-item large-one-sixth'>
    <nav class="nav">
            <ul>
                <li> <a href="">link</a> </li>
                <li> <a href="">link</a> </li>
                <li> <a href="">link</a> </li>
                <li> <a href="">link</a> </li>
                <li> <a href="">link</a> </li>
                <li> <a href="">link</a> </li>
            </ul>
    </nav>
    </div>
    <div class="grid-item large-five-sixths">
Main Admin Page
    <a href="#request.web.URL#route=admin_r_index">Railo Main</a> 
    || <a href="#application.railo.server#">Railo Admin</a> 
    || <a href="#application.railo.web#">Railo Web</a>
    </div>
</div>
</cfoutput>
<!--- 
<cfset caller.this.view('admin_sessiontracker')>
--->
