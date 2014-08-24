//new since august 2014
ko.bindingHandlers.toggle = {
    init: function (element, valueAccessor, viewModel, bindingContext){
        var va = valueAccessor()
        ,JQel = $(element)
        va.selected.subscribe(function(newValue){
            if( va.type == 'invert' ){ 
                if( va.state.hasOwnProperty('css') ) va.target != newValue? JQel.addClass(va.state.css):JQel.removeClass(va.state.css)
                if( va.state.hasOwnProperty('style') ) va.target != newValue? JQel.css(va.state.style):''
                if( va.state.hasOwnProperty('styleDef') ) va.target == newValue? JQel.css(va.state.styleDef):''
            }
            else if( va.type == 'match' ){ 
                if( va.state.hasOwnProperty('css') ) va.target == newValue? JQel.addClass(va.state.css):JQel.removeClass(va.state.css)
                if( va.state.hasOwnProperty('style') ) va.target == newValue? JQel.css(va.state.style):''
                if( va.state.hasOwnProperty('styleDef') ) va.target != newValue? JQel.css(va.state.styleDef):''
            }
        })
    }
}    
// When the DOM is ready,
$(function() {
    // Do stuff;
});
