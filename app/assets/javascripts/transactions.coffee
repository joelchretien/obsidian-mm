jQuery ->
  selects = $('.select-budget-assignment')
  selects.select2
    width: '300px'
    ajax: {
      url: '/budgeted_line_items'
      dataType: 'json'
      delay: 500
      processResults: (data, params) ->
        {
          results: data
        }
    }
    escapeMarkup: (markup) -> markup
    templateResult: (item) -> item.description
    templateSelection: (item) -> item.description
#   selects.on('change', (e) -> $(this).closest('form')[0].submit()
