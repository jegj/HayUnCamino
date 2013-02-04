# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
		$("#ofertas").dataTable()

$ ->
		$("#oferta_fecha_Inicio").datepicker
			dateFormat: 'yy-mm-dd'

$ ->
		$("#oferta_fecha_Fin").datepicker
			dateFormat: 'yy-mm-dd'