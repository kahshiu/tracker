<cfoutput>
<div class="grid">
    <div class="grid-item large-one-whole">
        <header style="overflow:hidden"> <h4 class="crossbars">Create File</h4> </header>
        <form method="post" action="#request.web.url#route=file_form_act&#session.urltoken#">
            <div class="grid grid-gutter-half">
                <p class="grid-item large-one-fourth">YK File No :</p>
                <p class="grid-item large-one-fourth"><input type="text" name="fileykno" id="" data-bind=""> </p>
                <p class="grid-item large-one-fourth">File Type :</p>
                <p class="grid-item large-one-fourth">
                    <select id="" name="filetype"><option value=""></option></select>
                </p>
                <p class="grid-item large-one-fourth">Date File Open :</p>
                <p class="grid-item large-one-fourth"><input type="text" name="fileopened" id="" data-bind=""> </p>
                <p class="grid-item large-one-fourth">Date File Closed :</p>
                <p class="grid-item large-one-fourth"><input type="text" name="fileclosed" id="" data-bind=""> </p>
                <p class="grid-item large-one-fourth">&nbsp;</p>
                <p class="grid-item large-one-fourth"><input type="submit" value="Create File" class="button button-primary one-whole"></p> 
    <!---  
                <cfif ListFindNoCase(attributes.mode, 'Create') gt 0> 
                </cfif>
                <cfif ListFindNoCase(attributes.mode, 'Edit') gt 0> 
                    <p class="grid-item large-one-fourth"><input type="checkbox" name="id"> Mark for delete</p>
                    <p class="grid-item large-one-fourth"><input type="submit" value="Edit File" class="button button-primary one-whole"></p> 
                </cfif>
    --->
            </div>
        </form>
    </div>
</div>
</cfoutput>
