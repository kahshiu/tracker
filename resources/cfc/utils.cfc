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

    <cffunction access="public" name="StructKeyRemap" output="true">
        <cfargument name="StructOrig" required="true">
        <cfargument name="StructMap" required="true"> <!---  Struct [valueRemap] = valueOrig --->
        <cfset temp = {}>
        <cfloop collection="#arguments.StructMap#" item="key">
            <cfset temp['#key#'] = arguments.StructOrig['#arguments.StructMap[key]#']>
        </cfloop>
        <cfreturn temp>
    </cffunction>

</cfcomponent>

