<cfcomponent displayname="Sequencer" output="true">

    <cfset variables.labels = {}>
    <cfset variables.labels.onApplicationStart = 'AppStarted'>
    <cfset variables.labels.onApplicationEnd   = 'AppEnded'>
    <cfset variables.labels.onSessionStart     = 'SessionStarted'>
    <cfset variables.labels.onSessionEnd       = 'SessionEnded'>
    <cfset variables.labels.onRequestStart     = 'RequestStarted'>
    <cfset variables.labels.onRequest          = 'RequestExecuted'>
    <cfset variables.labels.onRequestEnd       = 'RequestEnded'>
    <cfset variables.labels.onError            = 'ErrorEncountered'>

    <cfset this.sequence = ''>
    <cfset this.fullSequence = ''>

    <cffunction access="public" name="init" output="true">
        <cfset this.sequence = ''>
        <cfset this.fullSequence = ''>
        <cfreturn this>
    </cffunction>

    <cffunction access="public" name="addSequence" output="true">
        <cfargument required="false" name="fn" default="">

        <cfset var sequence = variables.labels['#arguments.fn#']>
        <cfset this.sequence = sequence>
        <cfset this.fullSequence = ListAppend(this.fullSequence, sequence)>
        <cfreturn sequence>
    </cffunction>

</cfcomponent>
