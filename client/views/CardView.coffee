class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    imagefile = '<img src="img/card-back.png">';
    if @model.get 'revealed'
      imagefile = (@template @model.attributes).toLowerCase()
    @$el.children().detach().end().html
    @$el.html imagefile
    @$el.addClass 'covered' unless @model.get 'revealed'
