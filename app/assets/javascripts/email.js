$(function () {
  $('#emails th a, #emails .pagination a').live('click', function () {
    $.getScript(this.href);
    return false;
  });
  // Search form
  $('#emails_search').submit(function () {
    $.get(this.action, $(this).serialize(), null, 'script');
    return false;
  });
  // Search input box
  $('#emails_search input').keyup(function () {
    $.get($('#emails_search').attr('action'), 
      $('#emails_search').serialize(), null, 'script');
    return false;
  });
})