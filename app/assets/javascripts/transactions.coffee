# TODO: Delete me.  No longer in use
# jQuery ->
$(document).on "turbolinks:load", ->
  selects = $('.transaction_budgeted_line_item_id')
  selects.select2
    width: '300px'
    # ajax: {
    #   url: '/budgeted_line_items'
    #   dataType: 'json'
    #   delay: 500
    #   processResults: (data, params) ->
    #     {
    #       results: data
    #     }
    # }
    escapeMarkup: (markup) -> markup
    templateResult: (item) -> item.description
    templateSelection: (item) -> item.description
