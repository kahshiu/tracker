// application specific
//**************
$('li').on('click',function(evt){
    $(evt.target).children('ul').toggle()
})
// random functions
//**************
function URL (url){
    var self = this
    this._url = url?url:undefined
    this._webpath = undefined
    this._qstrings = undefined
    this._qobj = {}

    this.objectify = function (urlfull) {
        var obj = {}
        qstrings = urlfull.match(new RegExp('[?&][^=]+=[^&]+','g'))
        _.each(qstrings,function(value,pointer,values){
            var parts = value.split('=')
            obj[parts[0].substring(1).toLowerCase()] = parts[1]
        })
        return obj
    }
    this.stringify = function (obj) {
        var str = []
        _.each(obj, function(value,pointer,values){
            str.push(pointer,'=',value,'&')
        })
        str.unshift('?')
        return str.join('')
    }
    this.setLocals = function (urlfull) {
        var temp = urlfull? urlfull.split('?'):self._url.split('?')
        self._url = urlfull? urlfull:self._url
        self._webpath=temp[0]
        self._qstrings=temp[1]
        self._qobj=self.objectify(self._url)
    }
    this.mergeQS = function (qstringObj){
        _.extend(self._qobj,qstringObj)
    }
    this.getUrlFull = function () {
        return self._webpath+self.stringify(self._qobj)
    }
}
var a = new URL(window.location.href)
    a.setLocals()

    console.log(a.getUrlFull())
function writeURL(route,additional){
    var temp = new URL(window.location.href)
        temp.setLocals()
        temp._qobj.route = route
        if( additional ) temp.mergeQS(additional)
    return temp.getUrlFull()
}
function goURL(route,additional){
    window.location.href = writeURL(route,additional)
}
function objectifyJSON(raw_json) {
    var temp = []
    _.each(raw_json.DATA, function (item,index,arr) { temp.push(_.object(raw_json.COLUMNS, item)) })
    return temp
} 
function colorise (data,target){
    for(var i=0; i<data.length; i++){
        _.each(data[i], function(value,key,obj){
            data[i][key] = target[key]? highlighter(value, target[key], '<span class="highlight">{{x}}</span>'): obj[key]
        })
    }
    return data
}    
function highlighter (baseString, target, highlight){
    var highlighted = highlight.replace(/{{x}}/g,target)
    return baseString.replace(new RegExp(target,'g'),highlighted)
}

// object extensions
//**************   
String.prototype.hashCode = function(){
    var hash = 0;
    if (this.length == 0) return hash;
    for (i = 0; i < this.length; i++) {
        char = this.charCodeAt(i);
        hash = ((hash<<5)-hash)+char;
        hash = hash & hash; // Convert to 32bit integer
    }
    return hash;
}
String.prototype.validateDateFormat = function (config){
    var _config = config? config:new Object(), _conclusion; 
    _config.style = _config.style? _config.style:'MYint'
    _cleanstring = this.toString().split(',')[0]
    _config.style == 'MYint'? regex =/^(?:\d{1,2}\/){2}\d{4}$/
    :_config.style == 'MYshort'? regex =/^\d{1,2}\s(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)\s\d{4}$/
    :regex =/^\d{1,2}\s(january|february|march|april|may|june|july|august|september|october|november|december)\s\d{4}$/
    return regex.test(_cleanstring)
}  
Date.prototype.getMonthInt = function (){
    return this.getMonth()+1
}
Date.prototype.setMonthInt = function (value){
    return this.setMonth(value-1)
}
Date.prototype.getMonthLong = function (){
    if (this.getMonth()==0) {return 'January'}
    else if (this.getMonth()==1) {return 'February'}
    else if (this.getMonth()==2) {return 'March'}
    else if (this.getMonth()==3) {return 'April'}
    else if (this.getMonth()==4) {return 'May'}
    else if (this.getMonth()==5) {return 'June'}
    else if (this.getMonth()==6) {return 'July'}
    else if (this.getMonth()==7) {return 'August'}
    else if (this.getMonth()==8) {return 'September'}
    else if (this.getMonth()==9) {return 'October'}
    else if (this.getMonth()==10) {return 'November'}
    else if (this.getMonth()==11) {return 'December'}
}
Date.prototype.getMonthShort = function (){
    if (this.getMonth()==0) {return 'Jan'}
    else if (this.getMonth()==1) {return 'Feb'}
    else if (this.getMonth()==2) {return 'Mar'}
    else if (this.getMonth()==3) {return 'Apr'}
    else if (this.getMonth()==4) {return 'May'}
    else if (this.getMonth()==5) {return 'Jun'}
    else if (this.getMonth()==6) {return 'Jul'}
    else if (this.getMonth()==7) {return 'Aug'}
    else if (this.getMonth()==8) {return 'Sep'}
    else if (this.getMonth()==9) {return 'Oct'}
    else if (this.getMonth()==10) {return 'Nov'}
    else if (this.getMonth()==11) {return 'Dec'}
}
Date.prototype.getDayShort = function (){
    if (this.getDay()==0)      { return 'Sun'}
    else if (this.getDay()==1) { return 'Mon'}
    else if (this.getDay()==2) { return 'Tue'}
    else if (this.getDay()==3) { return 'Wed'}
    else if (this.getDay()==4) { return 'Thu'}
    else if (this.getDay()==5) { return 'Fri'}
    else if (this.getDay()==6) { return 'Sat'}
}
Date.prototype.getDayLong = function (){
    if (this.getDay()==0)      { return 'Sunday'   }
    else if (this.getDay()==1) { return 'Monday'   }
    else if (this.getDay()==2) { return 'Tuesday'  }
    else if (this.getDay()==3) { return 'Wednesday'}
    else if (this.getDay()==4) { return 'Thursday' }
    else if (this.getDay()==5) { return 'Friday'   }
    else if (this.getDay()==6) { return 'Saturday' }

}
Date.prototype.getMonthsLong = function (){ return ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'] }
Date.prototype.getMonthsShort = function (){ return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'] }
Date.prototype.getDaysLong = function (){ return [ 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday' ] }
Date.prototype.getDaysShort = function (){ return [ 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat' ] }
Date.prototype.setMonthLong = function (item){
    if (item=='January')        { return this.setMonth(0)}
    else if (item=='February')  { return this.setMonth(1)}
    else if (item=='March')     { return this.setMonth(2)}
    else if (item=='April')     { return this.setMonth(3)}
    else if (item=='May')       { return this.setMonth(4)}
    else if (item=='June')      { return this.setMonth(5)}
    else if (item=='July')      { return this.setMonth(6)}
    else if (item=='August')    { return this.setMonth(7)}
    else if (item=='September') { return this.setMonth(8)}
    else if (item=='October')   { return this.setMonth(9)}
    else if (item=='November')  { return this.setMonth(10)}
    else if (item=='December')  { return this.setMonth(11)}
}
Date.prototype.setMonthShort = function (item){
    if (item=='Jan')      { return this.setMonth(0)}
    else if (item=='Feb') { return this.setMonth(1)}
    else if (item=='Mar') { return this.setMonth(2)}
    else if (item=='Apr') { return this.setMonth(3)}
    else if (item=='May') { return this.setMonth(4)}
    else if (item=='Jun') { return this.setMonth(5)}
    else if (item=='Jul') { return this.setMonth(6)}
    else if (item=='Aug') { return this.setMonth(7)}
    else if (item=='Sep') { return this.setMonth(8)}
    else if (item=='Oct') { return this.setMonth(9)}
    else if (item=='Nov') { return this.setMonth(10)}
    else if (item=='Dec') { return this.setMonth(11)}
}
Date.prototype.getDateFormat = function (config){
    var _config = config? config:new Object();
    _config.style = _config.style? _config.style:'MYint'
    _config.day = _config.day? _config.day:'nil'
    if (_config.style == 'MYint'      && _config.day == 'short') {return this.getDate()+'/'+this.getMonthInt()+'/'+this.getFullYear()+', '+this.getDayShort()}
    else if (_config.style == 'MYint' && _config.day == 'long' ) {return this.getDate()+'/'+this.getMonthInt()+'/'+this.getFullYear()+', '+this.getDayLong()}
    else if (_config.style == 'MYint') {return this.getDate()+'/'+this.getMonthInt()+'/'+this.getFullYear()}
    else if (_config.style == 'MYshort' && _config.day == 'short') {return this.getDate()+' '+this.getMonthShort()+' '+this.getFullYear()+', '+this.getDayShort()}
    else if (_config.style == 'MYshort' && _config.day == 'long' ) {return this.getDate()+' '+this.getMonthShort()+' '+this.getFullYear()+', '+this.getDayLong()}
    else if (_config.style == 'MYshort') {return this.getDate()+' '+this.getMonthShort()+' '+this.getFullYear()}
    else if (_config.style == 'MYlong' && _config.day == 'short') {return this.getDate()+' '+this.getMonthLong()+' '+this.getFullYear()+', '+this.getDayShort()}
    else if (_config.style == 'MYlong' && _config.day == 'long' ) {return this.getDate()+' '+this.getMonthLong()+' '+this.getFullYear()+', '+this.getDayLong()}
    else if (_config.style == 'MYlong') {return this.getDate()+' '+this.getMonthLong()+' '+this.getFullYear()}
}
Date.prototype.setDateFormat = function (item,config){
    var _config = config? config:new Object(); 
    _config.style = _config.style? _config.style:'MYint'
    var _item = item.split(',')[0]
    if (_config.style == 'MYint') { _item = _item.split('/'); this.setFullYear(_item[2]); this.setMonthInt(_item[1]); this.setDate(_item[0]); }
    else if (_config.style == 'MYshort') { _item = _item.split(' '); this.setFullYear(_item[2]); this.setMonthShort(_item[1]); this.setDate(_item[0]); }
    else if (_config.style == 'MYlong') { _item = _item.split(' '); this.setFullYear(_item[2]); this.setMonthLong(_item[1]); this.setDate(_item[0]); }
    return this
}
Date.prototype.setDateBounds = function (config){
    var _config = config? config:new Object(); 
    _config.style = _config.style? _config.style:'MYint'
    _config.min = _config.min? _config.min:''
    _config.max = _config.max? _config.max:''
    var compare = new Date()
    if (_config.min != ''){
        compare.setDateFormat(_config.min,{style:_config.style})
        this.setTime( Math.max(this.getTime(),compare.getTime()) )
    }
    if (_config.max != ''){
        compare.setDateFormat(_config.max,{style:_config.style})
        this.setTime( Math.min(this.getTime(),compare.getTime()) )
    }
    return this
}

//ko validation config object
//**************
ko.validation.rules['datemin'] = {
    validator: function (val,config){
        var _style ,_min = new Date() ,_val = new Date()

        if (_.isObject(config)){
            _style = config.style && config.style != ''? config.style:'MYint'
            _min.setDateFormat( ko.isObservable(config.compare)?config.compare():config.compare)
        } else {
            _style = 'MYint'
            _min.setDateFormat( ko.isObservable(config)?config():config)
        }
        _val.setDateFormat(val,{style:_style})
        return val==''? true:_val.getTime()>=_min.getTime()
    }
    ,message: 'Maximum date exceeded'
}
ko.validation.rules['datemax'] = {
    validator: function (val,config){
        var _style ,_max = new Date() ,_val = new Date()

        if (_.isObject(config)){
            _style = config.style && config.style != ''? config.style:'MYint'
            _max.setDateFormat( ko.isObservable(config.compare)?config.compare():config.compare)
        } else {
            _style = 'MYint'
            _max.setDateFormat( ko.isObservable(config)?config():config)
        }
        _val.setDateFormat(val,{style:_style})
        return val==''? true:_val.getTime()<=_max.getTime()
    }
    ,message: 'Maximum date exceeded'
}
ko.validation.rules['dateformat'] = {
    validator: function (val,style){
        var _style = style? style:'MYint'
            ,regexStr = ''
        if (_style == 'MYint') {regexStr = '^\\d{1,2}\/\\d{1,2}\/\\d{4}$'}
        return val == ''? true: new RegExp(regexStr).test(val)
    }
    ,message: 'Date format must in dd/mm/yyyy'
}

ko.validation.registerExtenders();

ko.validation.configure({
    registerExtenders: true,
    messagesOnModified: true,
    insertMessages: true,
    parseInputAttributes: true,
    messageTemplate: 'myValidationMsg'
})          
//begin ko utils
//**************
ko.extenders.monoSync = function (target,config){

    target.subscribe(function (newValue) {
        isFunction(config.data)? config.data(newValue):config.data=newValue
    })
    return target;
}   
ko.extenders.autoFormatter = function (target, config){
    target.subscribe(function( newValue ) {
       target(config.regex.test(newValue)? newValue.replace(config.regex,config.format):newValue)
    })
    return target;
}
ko.bindingHandlers.calender = {
    calendarString: function (date) {
        days = date.getDaysShort()
        ,lastMonth = new Date(date.getFullYear(), date.getMonth(), 0)
        ,thisMonth = new Date(date.getFullYear(), date.getMonth()+1, 0)
        ,markers = [lastMonth.getDate(),thisMonth.getDate(),0], mark = markers.shift()
        ,calHeader = "", calBody = "", calRowTemp=""
        ,calRow = "<tr>{{content}}</tr>" 
        ,calCell0 = "<th>{{content}}</th>" 
        ,calCell1 = "<td class='comp_calPrevMth' style='color:#999'>{{content}}</td>" 
        ,calCell21 = "<td class='comp_calDate'>{{content}}</td>" 
        ,calCell22 = "<td style='font-weight:bold;background-color:#ccc' >{{content}}</td>" 
        ,calCell3 = "<td class='comp_calNextMth' style='color:#999'>{{content}}</td>" 
        for(var i=0; i<7; i++){
            calHeader = calHeader + calCell0.replace(/{{content}}/,days[i])
            calHeader = i==6? calRow.replace(/{{content}}/,calHeader): calHeader
        }
        for(var i=1, j=lastMonth.getDate()-lastMonth.getDay(); i<43; i++, j= j==mark?0:j, mark= j==0?markers.shift():mark, j++){
            calRowTemp = markers.length == 2? calRowTemp + calCell1.replace(/{{content}}/,j)
            : calRowTemp = markers.length == 1? j == date.getDate()?  calRowTemp + calCell22.replace(/{{content}}/,j) : calRowTemp + calCell21.replace(/{{content}}/,j)
            : calRowTemp + calCell3.replace(/{{content}}/,j);
            if (i%7==0){
                calBody = calBody+calRow.replace(/{{content}}/,calRowTemp);
                calRowTemp = ""
            }
        }
        return calHeader+calBody
    }
    ,init: function (element,valueAccessor,allBindings,viewModel,bindingContext){ 
        function setDate(evt){
            //textual update
            var tempDate = now()
            if (evt.target.type == 'text'){
                var el_val = evt.target.value
                if (el_val != '' && el_val.validateDateFormat()){
                    tempDate.setDateFormat(evt.target.value); 
                } 
            //visual update
            }else{
                var curClassName = evt.target.className.split(' ')[0]
                 curClassName == 'comp_calYear'    ? tempDate.setFullYear(evt.target.value)
                :curClassName == 'comp_calPrevMth' ? tempDate.setMonth(now().getMonth()-1)
                :curClassName == 'comp_calNextMth' ? tempDate.setMonth(now().getMonth()+1)
                :curClassName == 'comp_calMonth'   ? tempDate.setMonth(evt.target.value)
                :''
                 curClassName == 'comp_calDate'    ? tempDate.setDate(evt.target.innerHTML)
                :curClassName == 'comp_calPrevMth' || curClassName == 'comp_calNextMth' ? tempDate.setDate(evt.target.innerHTML)
                :curClassName == 'comp_calToday'   ? tempDate = new Date()
                :curClassName == 'comp_calPrev'    ? tempDate.setDate(now().getDate()-1)
                :curClassName == 'comp_calNext'    ? tempDate.setDate(now().getDate()+1)
                :''
            } 
            now(tempDate)
        }
        function redraw (writeVal){
            writeVal? el.val(now().getDateFormat()):''
            el.siblings('table').find('.comp_calMonth').val(now().getMonth())
            el.siblings('table').find('.comp_calYear').val(now().getFullYear())
            el.siblings('table').find('.comp_calBody').html(ko.bindingHandlers.calender.calendarString(now()))
        }
        function refresh (evt,writeVal){
            setDate(evt)
            var temp = now().setDateBounds({
                    min:ko.isObservable(valueAccessor().min)? valueAccessor().min(): valueAccessor().min
                    ,max:ko.isObservable(valueAccessor().max)? valueAccessor().max(): valueAccessor().max
                })
            now(temp); 
            if (evt.target.value == ''){
                redraw(0)
            } else {
                redraw(1)
                ko.isObservable(valueAccessor().date)? valueAccessor().date(temp.getDateFormat()):''
            }
        }
        if (ko.isObservable(valueAccessor().min)) {
            valueAccessor().min.subscribe(function (newValue) {
                if ( newValue.validateDateFormat()){
                    now( now().setDateBounds({max:newValue}) )
                    if ( valueAccessor().date() !='' ) { 
                        valueAccessor().date( now().getDateFormat() )
                    } 
                }
            })
        }
        if ( ko.isObservable(valueAccessor().max) ) {
            valueAccessor().max.subscribe(function (newValue) {
                if ( newValue.validateDateFormat()){
                    now( now().setDateBounds({max:newValue}) )
                    if ( valueAccessor().date() !='' ) { 
                        valueAccessor().date( now().getDateFormat() )
                    } 
                }
            })
        }

        var el = $(element); 
        el.wrap( "<span class='comp_cal' ></span>").after( "<span class='comp_calPrev comp_clickable'>&nbsp;&laquo;&nbsp;</span> <input type='button' value='Calendar' class='toggler'> <span class='comp_calNext comp_clickable'>&nbsp;&raquo;&nbsp;&nbsp;&nbsp;</span> <br> <table style='display:none'><tbody><tr><td colspan=7 style='background-color:#eee'> <select class='comp_calMonth'> <option value=0>Jan</option> <option value=1>Feb</option> <option value=2>Mar</option> <option value=3>Apr</option> <option value=4>May</option> <option value=5>Jun</option> <option value=6>Jul</option> <option value=7>Aug</option> <option value=8>Sep</option> <option value=9>Oct</option> <option value=10>Nov</option> <option value=11>Dec</option> </select> <input type='text' style='width:3em' class='comp_calYear' /> <span class='comp_calToday comp_clickable'>Today</span> </td> </tr> </tbody> <tbody class='comp_calBody'></tbody></table> ")

        var tempNow = ko.isObservable( valueAccessor().date )? valueAccessor().date():valueAccessor().date
        ,tempNow = tempNow==''||tempNow==undefined? '':tempNow
        ,now = ko.observable( tempNow==''?new Date():new Date().setDateFormat(tempNow) )
        redraw()
        
        //registering event handlers
        el.siblings('.toggler').on('click', function(evt){
            el.siblings().each(function(){
                var el = $(this);
                el.prop('tagName') == 'BR' || ['toggler','comp_calNext','comp_calPrev'].indexOf(el.prop('class').split(' ')[0]) > -1?'':el.toggle()
            })
        })
        el.on('change',refresh)
        el.siblings('table').find('.comp_calBody').on('click','td',refresh)
        el.siblings('table').find('.comp_calMonth').on('change',refresh)
        el.siblings('table').find('.comp_calYear').on('change',refresh)
        el.siblings('table').find('.comp_calToday').on('click',refresh)
        el.siblings('.comp_calPrev').on('click',refresh)
        el.siblings('.comp_calNext').on('click',refresh)
    }
}       

ko.bindingHandlers.collapsable={
    init: function (element,valueAccessor,allBindings,viewModel,bindingContext){
        //valueAccessor
        //handle: all html el passed in as raw but processed internally in jq
        var self = this
        ,flag = ko.observable(false)
        ,_handle = valueAccessor().handle? valueAccessor().handle:element
        ,_handle = _handle instanceof jQuery? _handle: $(_handle)
        ,_target = valueAccessor().target instanceof jQuery? valueAccessor().target: $(valueAccessor().target)

        flag.subscribe(function(newValue){
            if (newValue) {
                _handle.children('.comp_collapsableHide').hide()
                _handle.children('.comp_collapsableShow').show()
                _target.hide()
            } else{
                _handle.children('.comp_collapsableHide').show()
                _handle.children('.comp_collapsableShow').hide()
                _target.show()
            }
        })
        _handle.prepend('<span class="comp_collapsableHide" style="cursor:pointer">[&nbsp;-&nbsp;]</span><span class="comp_collapsableShow" style="cursor:pointer;display:none">[&nbsp;+&nbsp;]</span>&nbsp;')
        _handle.children('span[class^="comp_collapsable"]').on('click',function(evt){
            flag(!flag())
        })

    }
}  
ko.bindingHandlers.refresher = {
    init: function (element,valueAccessor,allBindings,viewModel,bindingContext){
    }
}

/*
ko.extenders.maxLength = function (target,config){
    target.errStat = ko.observable(target().length>config.length==""?1:0 )
    target.subscribe(function( newValue ) {
        target(newValue.slice(0,config.length))
    });
    return target;
} 
ko.extenders.pattern = function (target,config){
    function isIncorrect (item){
        var _item = isFunction(item)? item(): item;
        return _item == ""? false : !config.regex.test(_item)
    }
    target.errStat = ko.observable( isIncorrect(target) );
    target.errMsg = ko.observable('');
    target.subscribe(function( newValue ) {
        var isError = isIncorrect (newValue) 
        if (isError) { target.errStat(1); target.errMsg(config.msg?config.msg:'Pattern mismatch!'); }
        else { target.errStat(0); target.errMsg(''); }
    });
    return target;
} 
*/          
//<script type="text/javascript">
//var refresher_timestamp = document.getElementById('refresher_timeStamp')
//, refresher_container = document.getElementById('refresher_container')
//if (refresher_timestamp != null) {                    
//    if(refresher_timestamp.value == "") refresher_timestamp.value = new Date().getTime(); 
//    else if ( refresher_timestamp.value < new Date().getTime() ) {
//        var thisPageURL = window.location.href;
//        window.location.replace(thisPageURL);
//    }                                       
//}
//</script> 


