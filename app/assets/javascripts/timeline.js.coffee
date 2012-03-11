# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

items = []
uid = 0
renderLoop = ->
  item = items.shift()
  return unless item?
  uid += 1
  times = 0
  series = []
  while times < 100
    times++
    series.push Math.round(Math.random() * 20)
  item.attr "id", "item_#{uid}"
  r = Raphael "item_#{uid}"
  r.linechart(0, 0, 120, 48, [], series)

  setTimeout renderLoop, 1000

$(document).ready ->
  controllerList = $('.controllers .list')
  gutter = $(".actions .gutter")
  gutterCursor = gutter.find( ".cursor" )
  offset = gutterCursor.width()/2
  actions = $('.actions')
  list = $(".actions .list")
  listCursor = list.find(".cursor")
  summary = $('.summary')
  list.scroll ->
    scrollTop = $(this).scrollTop()
    scrollLeft = $(this).scrollLeft()
    controllerList.scrollTop(scrollTop)
    gutter.scrollLeft(scrollLeft)

  listCursor.height(list[0].scrollHeight)
  moveTo = (left) ->
    listCursor.css left: left+"px"
    leftScrollPut = Math.round(list.scrollLeft() + actions.width() - 20)
    if left >= leftScrollPut
      list.scrollLeft(list.scrollLeft()+1)
  gutter.click (e) ->
    gutterCursor.css left: e.offsetX - offset
    moveTo e.offsetX
  gutterCursor.draggable
    axis: "x"
    scroll: true
    containment: "parent"
    drag: (event, ui) ->
      left = ui.position.left + offset + 1
      moveTo(left)    

  list.find(".item").each ->
    item = $(this)
    items.push item

  #$('.timeline .controllers').resizable
  #  containment: 'parent'
  #  handles: "e"
  #  grid: 25
  #  resize: (event, ui) ->
  #    actions.css left: (ui.size.width)+"px"
  #timeline = $('.timeline')
  #timeline.resizable
  #  handles: "s"
  #  grid: 25
  #  resize: (event, ui) ->
  #    summary.css top: (timeline.position().top + ui.size.height)+"px"
  #renderLoop()

    
