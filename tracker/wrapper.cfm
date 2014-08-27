<cfoutput>
<div class="grid">
    <div class="grid-item large-three-fifths"> &nbsp; </div>
    <div class="grid-item large-two-fifths header2">
        <div class="grid">
            <form method="get" action="" style="margin:0rem">
                <div class="grid-item large-one-third"> <input type="text" class="text-mini" name="" id="" data-bind=""> </div>
                <div class="grid-item large-one-third"> 
                    <select class="select-mini" id="" name="">
                        <option value=""></option>
                    </select>
                </div>
                <div class="grid-item large-one-third"> 
                    <input type="submit" class="button button-primary button-mini one-whole" value="Search" name="" id="" data-bind="">
                </div>
            </form>
        </div>
    </div>
    <div class="grid-item large-three-fifths" style="vertical-align:bottom; cursor:pointer" id="SectionApp" data-bind="click:selectApps()">
        <span class="h3" data-bind="html:currentApp"></span> <span class="h5" data-bind="html: '&raquo;&nbsp;'+currentSubApp()"></span>
        <!--- begin: modal window for selecting apps --->
        <div id='selectingApps' class="grid" style="width:50%">
            <div class="grid-item large-one-whole header" style="background-color:white;">
                <h3>Select your application</h3>
                <div data-bind="foreach:applications">
                    <label><input type="radio" data-bind="attr:{value:app},checked:$root.currentApp" name='appOptions'>&nbsp;&nbsp;&nbsp;<span data-bind="html:app"></span></label><br>
                    <div data-bind='visible:app == $root.currentApp()'>
                    <!-- ko foreach:$data.subApp -->
                        &nbsp; &nbsp; &nbsp;
                        <label><input type="radio" data-bind="attr:{value:name},checked:$root.currentSubApp" name='subAppOptions'>&nbsp;&nbsp;&nbsp;<span data-bind="html:name"></span></label><br>
                    <!-- /ko -->
                    </div>
                </div>
            </div>
            <div class="grid-item large-one-whole footer" style="background-color:white;">
                <br><a class="button button-primary" data-bind="attr:{href:$root.currentLink}">Go to application</a>
            </div>
        </div>
        <!--- end: modal window for selecting apps --->
    </div>
    <div class="grid-item large-two-fifths" style="vertical-align:bottom">
        <span class="h5">
            <a href="#request.web.url#route=user_personal&#session.urltoken#">username</a> &nbsp; &nbsp; &nbsp; 
            <a href="">logout</a> &nbsp; &nbsp; &nbsp; 
        </span>
    </div>
    <div class="grid-item large-one-fifth">
        <cfmodule template="#request.dir.cfm#\navbar.cfm">
    </div>
    <div class="grid-item large-four-fifths content">#attributes.body#</div>
</div>

<!---  
style="background-color:#FF2D55; color:white"> 
--->
    <script>
        function SectionApp() {
            var self = this

            /* static data */
            this.applications = [
                {app:'Tr&atilde;cker', subApp:[{name:'Profiler',link:'#request.web.url#route=tracker_profiler&#session.urltoken#'},{name:'Case Tracker',link:''}]}
                ,{app:'Reports', subApp:[{name:'Interactive Reports',link:''},{name:'Periodical Reports',link:''}]}
                ]
            /* observables */
            this.currentApp = ko.observable('')
            this.currentSubApp = ko.observable('')
            this.currentLink = ko.observable('')

            /* manual subscriptions */
            this.currentApp.subscribe(function(newValue){
                _.find(self.applications,function(el){
                    if( el.app == self.currentApp() ){ self.currentSubApp(el.subApp[0].name) }
                })
            })

            /* behaviours */
            this.selectApps = function(){
                $('##selectingApps').trigger('openModal')
            }
        }
        function defaultSettings(){
            sApp.currentApp(sApp.applications[0].app)
            sApp.currentSubApp(sApp.applications[0].subApp[0].name)
            sApp.currentLink(sApp.applications[0].subApp[0].link)
            $('##selectingApps').easyModal()
        }
        var sApp = new SectionApp()
        ko.applyBindings(sApp,document.getElementById('SectionApp'))
        defaultSettings()
    </script>
</cfoutput>
