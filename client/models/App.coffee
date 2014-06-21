#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  checkBust: ->
    pScore = (@get 'playerHand').scores()
    if pScore[0] > 21
      @gameOver()

    dScore = (@get 'dealerHand').scores()
    if dScore[0] > 21
      @gameOver()

  dealerTurn: ->
    (@get 'dealerHand').reveal()
    dHand = @get("dealerHand")
    dScore = dHand.scores()
    while dScore[0] <= 16
      dHand.hit()
      dScore = dHand.scores()
    @checkBust()
    @gameOver()

  gameOver: ->
    pScores = (@get 'playerHand').scores()
    dScores = (@get 'dealerHand').scores()

    pFinal = (if pScores[1] <= 21 then pScores[1] else pScores[0])
    dFinal = (if dScores[1] <= 21 then dScores[1] else dScores[0])

    if pFinal <= 21
      console.log "snoopy"
      if dFinal <= 21
        if pFinal > dFinal
          console.log "You win!"
        else if pFinal is dFinal
          console.log "Push!"
        else
          console.log "Dealer wins"
      else
          console.log "You win!"
    else
      console.log "Dealer wins"
    console.log "GAME OVER"

  newGame: ->
    console.log "new game!"
    @initialize();
    @trigger "newGame"
