// jQuery(function() {
//   return $('#event_titles').autocomplete({
//     source: $('#event_titles').data('autocomplete-source')
//   });
// 

// $(function() {
//   $(“#event-autocomplete”).autocomplete({
//     source: ‘/tags’
//   })
// })

jQuery(function() {
  return $('#event_event_title').autocomplete({
    source: ['foo', 'food', 'four']
  });
});

// jQuery ->
//   $('#event_event_title').autocomplete
//     source: ['foo', 'food', 'four']