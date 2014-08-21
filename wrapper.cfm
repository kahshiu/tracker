<cfsilent>
    <cfparam name="attributes.body" default="">
    <cfparam name="attributes.nojs" default="">
    <cfparam name="attributes.nocss" default="">

    <cfset use.js = 'jq,ko,kovalidation,_,custom,sha'>
    <cfset use.css = 'cardinal'>
    <cfif ListLen(attributes.nojs) gt 0> <cfset use.js = request.obj.utils.ListRemoveValues(use.js,attributes.nojs)> </cfif>
    <cfif ListLen(attributes.nocss) gt 0> <cfset use.css = request.obj.utils.ListRemoveValues(use.css,attributes.nocss)> </cfif>
</cfsilent>
<cfoutput>
<!DOCTYPE html>
<html>
    <head>
        <title>Internal Applications</title>
        <cfif ListFind(use.css,'cardinal')>    <link rel="stylesheet" href="#request.dir.css#\main.css"></cfif>
        <cfif ListFind(use.js,'jq')>           <script type="text/javascript" src="#request.dir.js#\jquery-1.11.0.min.js"></script></cfif>
        <cfif ListFind(use.js,'ko')>           <script type="text/javascript" src="#request.dir.js#\knockout-latest.js"></script></cfif>
        <cfif ListFind(use.js,'kovalidation')> <script type="text/javascript" src="#request.dir.js#\knockout.validation.js"></script></cfif>
        <cfif ListFind(use.js,'_')>            <script type="text/javascript" src="#request.dir.js#\underscore-min.js"></script></cfif>
        <cfif ListFind(use.js,'sha')>          <script type="text/javascript" src="#request.dir.js#\crypto\sha.js"></script></cfif>
        <cfif ListFind(use.js,'custom')>       <script type="text/javascript" src="#request.dir.js#\main.js"></script></cfif>
<!--- 
        <!-- custom validation template -->
        <script type="text/html" id="myValidationMsg">
           <div><em style="color:darkred" class="customMessage" data-bind='validationMessage: field'></em></div>
        </script>
--->
    </head>
    <body class="wrapper"> #attributes.body# </body>
</html>
</cfoutput>  
<!---  
    <div class="grid-pad">
        <div class="col-2-12 sidebar">
            <div class="col-1-1 title bold">TRACKER</div>
            <div class="col-1-1">
                <a href="#request.fn.writeUrl('admin:user')#">wwwwwwwwww</a> ||
                <a href="#request.fn.writeUrl('security:logout')#">logout</a>
            </div>
            <div class="col-1-1">&nbsp;</div>
            <div class="col-1-1 navbar bR" id="mainnav">
                <ul>
                    <li data-url="home">Home</li>
                    <li>Profiling
                        <ul data-subtree="profiling">
                            <li data-url="filing:form"><span>::</span> Filing</li>
                            <li data-url="person:form"><span>::</span> Person</li>
                            <li data-url="business:form"><span>::</span> Business</li>
                        </ul>
                    </li>
                    <li data-url="cases:creation">Cases</li>
                    <li data-url="reports">Reports</li>
                    <li data-url="help">Help</li>
                </ul>
                <script>
                //$('ul[data-subtree="profiling"]').toggleClass('open')
                $('##mainnav li').on('click',function(evt){
                    var el = $(evt.target)
                    if( el.attr('data-url') ){
                        goURL(el.attr('data-url'))
                    }else{
                        el.children('ul').toggleClass('open')
                        evt.stopPropagation();
                    }
                })
                </script>
            </div>
        </div>

        <div class="col-10-12" >
<!---
            <div class="col-1-2 pageTitle bold"> #UCase(ListFirst(url.route,':'))#&nbsp; </div>
--->
            <div class="col-1-2 rightText">
                <form method=post action="">
                    <input type="text">
                    <select name="searchCriteria">
                        <option value="" selected>All criteria</option>
                        <option value="">E-File No.</option>
                        <option value="">YK File No.</option>
                        <option value="">Company Reg No.</option>
                        <option value="">...</option>
                    </select>           
                    <input type=submit value=Search>
                </form>   
            </div>
        <!--- main body section --->

            <div class="col-1-1">&nbsp;</div>
            <div class="col-1-2 bT">Developed by: shiu</div>
            <div class="col-1-2 bT rightText">v1 tracker 2014</div>
        </div>
    </div>
--->


