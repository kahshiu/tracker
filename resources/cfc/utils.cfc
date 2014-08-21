<cfcomponent displayname="" output="true">
    <cffunction access="public" name="ListRemoveValues" output="true">
        <cfargument required="yes" name="targetlist">
        <cfargument required="yes" name="listtoremove">
        <cfargument required="false" name="delimiter" default=','>
            
        <cfloop list=#arguments.listtoremove# index="i" item='item' delimiters='#arguments.delimiter#'>
            <cfset arguments.targetlist = ListDeleteAt(arguments.targetlist,ListFind(arguments.targetlist,#item#))>
        </cfloop>
        <cfreturn arguments.targetlist>
    </cffunction>
</cfcomponent>

