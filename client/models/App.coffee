#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  checkBust: ->
    pScore = (@get 'playerHand').scores()
    if pScore[0] > 21
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
    # TODO remove debugging
    console.log "pFinal: #{pFinal}"
    console.log "dFinal: #{dFinal}"
    if pFinal <= 21
      if dFinal <= 21 and dFinal > pFinal
        bootbox.alert 'LOSER!'
        return
      else if dFinal == pFinal
        bootbox.alert 'Try again'
        return
      bootbox.alert 'You win!'
      return
    bootbox.alert 'LOSER!'

  newGame: ->
    console.log "new game!"
    @initialize();
    @trigger "newGame"
