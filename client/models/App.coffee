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

  endRound: ->
    pScores = (@get 'playerHand').scores()
    dScores = (@get 'dealerHand').scores()
    pFinal = (if pScores[1] <= 21 then pScores[1] else pScores[0])
    dFinal = (if dScores[1] <= 21 then dScores[1] else dScores[0])
    if pFinal <= 21
      if dFinal <= 21 and dFinal > pFinal
        bootbox.dialog
          message: "You lose!"
          title: "LOSER!"
          buttons:
            success:
              label: "Play again"
              className: "btn-success"
              callback: =>
                alert('this doesnt work!')
                return

            main:
              label: "New table"
              className: "btn-primary"
              callback: =>
                @newGame()
                return

        return
      else if dFinal == pFinal
        bootbox.dialog
          message: "Push!"
          title: "try again!"
          buttons:
            success:
              label: "Play again"
              className: "btn-success"
              callback: =>
                alert('this doesnt work!')
                return

            main:
              label: "New table"
              className: "btn-primary"
              callback: =>
                @newGame()
                return
        return
      bootbox.dialog
        message: "You win!"
        title: "WINNER!"
        buttons:
          success:
            label: "Play again"
            className: "btn-success"
            callback: =>
              alert('this doesnt work!')
              return

          main:
            label: "New table"
            className: "btn-primary"
            callback: =>
              @newGame()
              return
      return
    bootbox.dialog
        message: "You lose!"
        title: "LOSER!"
        buttons:
          success:
            label: "Play again"
            className: "btn-success"
            callback: =>
              alert('this doesnt work!')
              return

          main:
            label: "New table"
            className: "btn-primary"
            callback: =>
              @newGame()
              return

  newGame: ->
    console.log "new game!"
    @initialize();
    @trigger "newGame"
