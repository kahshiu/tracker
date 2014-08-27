<cfparam name="route" default="">
<cfoutput>
<div id="SectionNav">
    <nav>
        <div class="grid grid-gutter-none navlist">
            <div class="grid-item one-half"> <input type="button" class="button button-small one-whole" name="" value="Links" data-bind="toggle:{type:'invert',target:'nav_links',selected:currentTab,state:{css:'inactive'}},click:toggleTab"> </div>
            <div class="grid-item one-half"> <input type="button" class="button button-small one-whole" name="" value="Actions" data-bind="toggle:{type:'invert',target:'nav_actions',selected:currentTab,state:{css:'inactive'}},click:toggleTab"> </div>
        </div>
        <ul id="links" data-bind="toggle:{type:'match',target:'nav_links',selected:currentTab,state:{style:{'display':'block'},styleDef:{display:'none'}}}">
            <li> <a href="">Profiler Home</a> </li>
            <li> <a href="">Summary</a> </li>
        </ul>
        <ul id="links" data-bind="toggle:{type:'match',target:'nav_actions',selected:currentTab,state:{style:{'display':'block'},styleDef:{display:'none'}}}">
            <li> <a href="#request.web.url#route=file_form&#session.urltoken#">Create File</a> </li>
            <li> <a href="">Create Personal Prf.</a> </li>
            <li> <a href="">Create Business Prf.</a> </li>
        </ul>
    </nav>
</div>
<script>
    function SectionNav() {
        var self = this

        /* static data */
        /* observables */
        this.currentTab = ko.observable('')

        /* manual subscriptions */
        /* behaviours */
        this.toggleTab = function(){
            var curr = self.currentTab()
            self.currentTab(curr=='nav_links'?'nav_actions':'nav_links')
        }
    }
    function SectionNavDef(){
        sNav.currentTab('nav_links')
    }
    var sNav = new SectionNav()
    ko.applyBindings(sNav,document.getElementById('SectionNav'))
    SectionNavDef()
</script>
</cfoutput>

