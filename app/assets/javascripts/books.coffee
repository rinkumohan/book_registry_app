# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Book
  @_timer: null

$(document).on 'change', '#book_index_form select#sort_on,#book_index_form select#sort_by', ->
  ur = new Book
  $('#books_list').html ' '
  $.get($("#book_index_form").prop('action'), $("#book_index_form").serialize(), null, "script")
  return false

$(document).on 'change', '#home_index_form select#sort_on,#home_index_form select#sort_by', ->
  ur = new Book
  $('#index_list_page').html ' '
  $.get($("#home_index_form").prop('action'), $("#home_index_form").serialize(), null, "script")
  return false
