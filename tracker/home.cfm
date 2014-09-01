<cfset attributes.mode = "create">
<cfif StructKeyExists(url,'fileid') and url.fileid neq ''> 
    <cfset attributes.mode = "Edit">
</cfif>
<cfoutput>
<div class="grid">
    <div class="grid-item large-one-whole">
        <header style="overflow:hidden"> <h4 class="crossbars">Workflow</h4> </header>
        <div class="grid grid-gutter-half">
            <p class="grid-item large-one-fourth">Date of Case</p>
            <p class="grid-item large-one-fourth">Date of Case</p>
            <p class="grid-item large-one-fourth">Date of Case</p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
<hr>
            <p class="grid-item large-one-fourth">PIC</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date PIC Assigned</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date 1st Prcssing Started</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date 1st Prcssing Completed</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Processing Target Duration</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Processing Actual Duration</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
<hr>
            <p class="grid-item large-one-fourth">Castor</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date Castor Assigned</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date Casting Completed</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date Casting Started</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Casting Target Duration</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
<hr>
            <p class="grid-item large-one-fourth">Date of Submission</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
<hr>
            <p class="grid-item large-one-fourth">Invoice No.</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Invoice Date</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date Invoice Sent</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date Payment Received</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Date Case Closed</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Close Reason</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">Closing Remarks</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
            <cfif ListFindNoCase(attributes.mode, 'Create') gt 0> 
                <p class="grid-item large-one-fourth">&nbsp;</p>
                <p class="grid-item large-one-fourth"><input type="submit" value="Create File" class="button button-primary one-whole"></p> 
            </cfif>
            <cfif ListFindNoCase(attributes.mode, 'Edit') gt 0> 
                <p class="grid-item large-one-fourth"><input type="checkbox" name="id"> Mark for delete</p>
                <p class="grid-item large-one-fourth"><input type="submit" value="Edit File" class="button button-primary one-whole"></p> 
            </cfif>
        </div>
    </div>
    <div class="grid-item large-one-whole">
        <header style="overflow:hidden"> <h4 class="crossbars">Search Profile</h4> </header>
        <div class="grid grid-gutter-half">
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""> </p>
            <p class="grid-item large-one-fourth">
                <select id="" name=""><option value=""></option></select>
            </p>
            <p class="grid-item large-one-fourth"><input type="submit" value="Search" class="button button-primary one-whole"></p> 
        </div>
        <header style="overflow:hidden"> <h4 class="crossbars">Search Results</h4> </header>
        <div class="grid grid-gutter-half">
            <div class="grid-item large-one-fourth"> attr name</div>
            <div class="grid-item large-one-fourth"> co name</div>
            <div class="grid-item large-one-fourth"> </div>
            <div class="grid-item large-one-fourth"> <input type="button" class="button one-whole" value="Link" name="" id="" data-bind=""></div>
        </div>
    </div>
    <div class="grid-item large-one-whole">
        <header style="overflow:hidden"> <h4 class="crossbars">Linked Profiles</h4> </header>
        <div class="grid grid-gutter-half">
            <div class="grid-item large-one-fourth"> attr name</div>
            <div class="grid-item large-one-fourth"> co name</div>
            <div class="grid-item large-one-fourth"> something</div>
            <div class="grid-item large-one-fourth"> something</div>
            <hr>
        </div>
    </div>
    <div class="grid-item large-one-whole">
        <header style="overflow:hidden"> <h4 class="crossbars">Personal Profile</h4> </header>
        <div class="grid grid-gutter-half">
            <p class="grid-item large-one-fourth">Name</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""></p>
            <p class="grid-item large-one-fourth">E-File No.</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""></p>
            <p class="grid-item large-one-fourth">Gender</p>
            <p class="grid-item large-one-fourth"><select id="" name=""><option value=""></option></select></p>
            <p class="grid-item large-one-fourth">Marital Status</p>
            <p class="grid-item large-one-fourth"><select id="" name=""><option value=""></option></select></p>
            <p class="grid-item large-one-fourth">Nationality</p>
            <p class="grid-item large-one-fourth"><select id="" name=""><option value=""></option></select></p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
            <p class="grid-item large-one-fourth">&nbsp;</p>
            <p class="grid-item large-one-fourth">ID Type</p>
            <p class="grid-item large-one-fourth"><select id="" name=""><option value=""></option></select></p>
            <p class="grid-item large-one-fourth">ID No.</p>
            <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""></p>
            <fieldset class="fieldset-border"> <legend style="font-weight:200">Contact Details</legend>
                <div class="grid">
                    <p class="grid-item large-one-fourth">Contact Name</p>
                    <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""></p>
                    <p class="grid-item large-one-fourth">Address</p>
                    <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""></p>
                    <p class="grid-item large-one-fourth">Phone No.</p>
                    <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""></p>
                    <p class="grid-item large-one-fourth">Email</p>
                    <p class="grid-item large-one-fourth"><input type="text" name="" id="" data-bind=""></p>
                    <p class="grid-item large-one-fourth"><input type="checkbox" name="id"> Mark for delete</p>
                    <p class="grid-item large-one-fourth"><input type="button" class="button button-mini one-whole" value="Add New" name="" id="" data-bind=""></p>
                </div><br>
                <table class="table-border-rows">
                    <caption>Available Contacts</caption>
                    <tbody>
                    <tr>
                        <th>##</th> <th>Name</th> <th>Address</th> <th>Phone</th> <th>Email</th>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>1246</td>
                        <td>Hello</td>
                        <td>true</td>
                        <td>true</td>
                    </tr>
                    <tr>
                        <td>5</td>
                        <td>3286</td>
                        <td>Awesome</td>
                        <td>true</td>
                        <td>true</td>
                    </tr>
                    </tbody>
                </table> 
                <p> Note: <em>Click "Name" to Edit</em> </p>
            </fieldset>
            <fieldset class="fieldset-border"> <legend style="font-weight:200">Remarks</legend>
                <div class="grid">
                    <p class="grid-item large-one-fourth">Remarks</p>
                    <p class="grid-item large-three-fourths"><textarea name="" id="" data-bind=""> </textarea></p>
                    <p class="grid-item large-one-fourth"><input type="checkbox" name="id"> Mark for delete</p>
                    <p class="grid-item large-one-fourth"><input type="button" class="button button-mini one-whole" value="Add New" name="" id="" data-bind=""></p>
                </div><br>
                <table class="table-border-rows">
                    <caption>Remarks</caption>
                    <tbody>
                    <tr>
                        <th>##</th> <th>Remarks</th> <th>Author</th> <th>Date</th>
                    </tr>
                    <tr>
                        <td>1246</td>
                        <td>asdfasdf asd fasd fas fs1asdf asd fasd fas f</td>
                        <td>Hello</td>
                        <td>true</td>
                    </tr>
                    <tr>
                        <td>1246</td>
                        <td>1</td>
                        <td>Hello</td>
                        <td>true</td>
                    </tr>
                    </tbody>
                </table> 
                <p> Note: <em>Click "Remarks" to Edit</em> </p>
            </fieldset>
            <p class="grid-item large-one-fourth">Remarks</p>
            <hr>
        </div>
    </div>
</div>
<!---  
    <div class="grid-item large-one-half"> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse massa diam, posuere vitae egestas ultrices, condimentum quis leo. Etiam et mattis dui. Etiam et urna magna. Sed eleifend a lacus sed rutrum. Duis eu tristique nunc. Fusce nec aliquam massa. Donec a purus in ligula porta tempor. Quisque porttitor in enim sit amet interdum. Quisque sit amet venenatis enim. Morbi suscipit nunc est, vel sollicitudin sapien tempus in. Donec lacinia arcu sit amet magna suscipit, eu malesuada lorem tincidunt. Curabitur at molestie felis. Fusce non elementum nunc. In laoreet lectus elit, a dapibus leo fermentum a. Vestibulum pharetra euismod lorem, sit amet facilisis sem aliquam id. Lorem ipsum dolor sit amet, consectetur adipiscing elit.  </div>
    <div class="grid-item large-one-half"> Praesent dictum velit in sapien placerat, ac porta orci volutpat. Maecenas laoreet libero vel augue gravida sodales. Praesent volutpat accumsan elit a finibus. Ut a felis ante. Aliquam hendrerit a nisl non tempus. Aenean blandit metus viverra odio rhoncus dignissim. Morbi neque est, sodales eget volutpat eu, aliquet eget dui. Etiam egestas viverra leo at pretium. Praesent mi ipsum, pretium sed massa eu, vulputate hendrerit lectus. In cursus hendrerit tempor. Sed sagittis non sem sed bibendum. Pellentesque nec tellus a lectus commodo scelerisque. Donec eget orci ante. Mauris dolor elit, accumsan vel blandit eget, consequat non enim.  </div>
    <div class="grid-item large-one-whole"> Maecenas lacus enim, viverra sed nisl non, auctor sollicitudin dolor. Pellentesque tincidunt lacus vel lectus molestie sagittis. Donec eu neque eu nulla gravida rutrum. Sed sed nulla nec odio ornare lobortis. Nam fermentum elit eget quam pharetra dapibus. Aenean quis ornare leo. Suspendisse vitae nisi elit. Donec dolor leo, commodo vitae consequat ac, tempor in ipsum. Vestibulum quis diam vel urna faucibus sollicitudin. Etiam laoreet hendrerit iaculis. Vestibulum suscipit, mi ac ornare congue, dui lorem suscipit metus, quis consequat lorem nibh ut turpis. Nam ac gravida erat, at rutrum massa. Curabitur molestie elementum dui, non auctor lectus molestie vel. Cras vel tortor mollis, scelerisque quam ut, cursus nisl. Suspendisse sit amet feugiat sapien. Ut sed felis eu orci laoreet consectetur pellentesque eu nunc.  </div>
--->
</cfoutput>
