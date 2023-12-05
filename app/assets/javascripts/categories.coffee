# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Category
  @_timer: null

$(document).on 'change', '#categories_index_form select#sort_on,#categories_index_form select#sort_by', ->
  ur = new Category
  $('#category_list').html ' '
  $.get($("#categories_index_form").prop('action'), $("#categories_index_form").serialize(), null, "script")
  return false
