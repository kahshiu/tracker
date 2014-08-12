<cfparam name="attributes.data" default="">
<div>
    this is warnings home
    compile all warning msgs
</div>
<cfset routes=ListToArray("#attributes.data#")>
<cfloop array=#routes# index="item">
<cfinclude template=#item#>
</cfloop>

