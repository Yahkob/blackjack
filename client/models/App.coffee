#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  checkBust: ->
    if (@get 'playerHand').isBusted()
       @endRound()

  dealerTurn: ->
    (@get 'dealerHand').reveal()
    dHand = @get("dealerHand")
    dScore = dHand.scores()
    while dScore[0] <= 16
      dHand.hit()
      dScore = dHand.scores()
    @endRound()

  outcomeMsg: (msg, title) ->
    console.log('outcomeMsg')
    bootbox.dialog
      message: msg
      title: title
      buttons:
        #todo: add next round feature
        # success:
          # label: "Play again"
          # className: "btn-success"
          # callback: =>
          #   alert('this doesnt work!')
          #   return

        main:
          label: "New table"
          className: "btn-primary"
          callback: =>
            @newGame()
            return

  endRound: ->
    pFinal = (@get 'playerHand').getScore()
    dFinal = (@get 'dealerHand').getScore()
    if pFinal <= 21
      if dFinal <= 21 and dFinal > pFinal
        @outcomeMsg('You lose!','LOSER')
        return
      else if dFinal is pFinal
        @outcomeMsg('Push!','Try again!')
        return
      @outcomeMsg('You win!','WINNER!')
      return
    @outcomeMsg('You lose!','LOSER!')

  newGame: ->
    console.log "new game!"
    @initialize();
    @trigger "newGame"
