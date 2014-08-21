<cfoutput>
<div class="grid">
    <div class="grid-item large-one-third island">
        <div class="grid">
        <form method="post" action="#request.web.url#route=login_authenticate_act">
            <h4 class="header" style="text-align:center">Welcome, Stranger!</h4>
            <div class="grid-item large-one-whole">Username</div> <p class="grid-item large-one-whole"><input type="text" name="username" id="username" data-bind=""></p>
            <div class="grid-item large-one-whole">Password</div> <p class="grid-item large-one-whole"><input type="text" name="userpwd" id="userpwd" data-bind=""></p>
            <div class="grid-item large-one-whole">&nbsp;</div>
            <div class="grid-item large-one-whole"> <input type="submit" class="button button-primary button-block one-whole" value="Login" name="" id="" data-bind=""> </div>
        </form>
        </div>
    </div>
    <div class="grid-item large-two-thirds">
        <h4 class="header" style="text-align:center">Shout Board:</h4>
        <div class="large-one-whole" id="areaShout" data-bind="template:{name:'shoutItem', foreach:mShout}"></div>
        <div class="large-one-whole">Note: Announcement expires after 6 months</div>
    </div>
</div>
<script type="text/html" id="shoutItem">
    <span data-bind="html:$index()+1"> </span>
    <strong data-bind="html:vausmail"></strong> says on <em data-bind="html:dtpublish"></em><br>
    <blockquote data-bind="html:vaann" style="font-style:normal"></blockquote>
</script>

<script>
<cfset data = serializeJSON([{vausmail:'somethng',vaann:'asdfo',dtpublish:'12-12-12'}])>
var mShout = #data#
ko.applyBindings(mShout,document.getElementById('areaShout'))
</script>
</cfoutput>
<cfset caller.this.view('admin_random')>
