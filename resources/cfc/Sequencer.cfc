<cfcomponent displayname="Sequencer" output="true">
    <cfset variables.sequence = ''>
    <cfset variables.currentSequence = ''>

    <cffunction name="init" output="true">
        <cfset variables.sequence = ''>
    </cffunction>

    <cffunction name="resetSequence" output="true">
        <cfset variables.sequence = ''>
    </cffunction>

    <cffunction name="setSequence" output="true">
        <cfargument required="true" name="functionCalled" default="">
        <cfset var labels = {}>
        <cfset labels.onApplicationStart = 'AppStarted'>
        <cfset labels.onApplicationEnd   = 'AppEnded'>
        <cfset labels.onSessionStart     = 'SessionStarted'>
        <cfset labels.onSessionEnd       = 'SessionEnded'>
        <cfset labels.onRequestStart     = 'RequestStarted'>
        <cfset labels.onRequest          = 'RequestExecuted'>
        <cfset labels.onRequestEnd       = 'RequestEnded'>
        <cfset labels.onError            = 'ErrorEncountered'>

        <cfset var currentSequence = labels['#arguments.functionCalled#']>
        <cfset variables.sequence = ListAppend(variables.sequence, currentSequence)>
        <cfset variables.currentSequence = currentSequence>
        <cfreturn currentSequence>
    </cffunction>

    <cffunction name="getSequence" output="true">
        <cfreturn variables.currentSequence>
    </cffunction>

    <cffunction name="getFullSequence" output="true">
        <cfreturn variables.sequence>
    </cffunction>
</cfcomponent>
