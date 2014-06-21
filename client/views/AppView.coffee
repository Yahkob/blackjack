class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": ->
      @model.get('playerHand').hit()
      @model.checkBust()

    "click .stand-button": ->
      @model.get('playerHand').stand()
      @model.dealerTurn()

  initialize: ->
    @render()
    @model.on 'newGame', =>
      @render()

  render: ->
    console.log "rendering full app"
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
