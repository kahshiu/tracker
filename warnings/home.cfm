<cfparam name="attributes.data" default="">
<div>
    this is warnings home
    compile all warning msgs
</div>
<cfdump var=#attributes.data#>
    <cfmodule template=#attributes.data#>
<cfset routes=ListToArray("#attributes.data#")>
<cfloop array=#routes# index="item">
</cfloop>

