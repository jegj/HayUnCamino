# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
		$("#pikame").PikaChoose()

$ ->
		$("#menu li ").click ->
			$(this).addClass "current"
			
$ ->
		$("#datepicker").datepicker()

$ ->
		$("#tarifas_rutas").dataTable()

$	->
		$("#ofertas_usuario").dataTable()
		
