#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  checkBust: ->
    pScore = (@get 'playerHand').scores()
    if pScore[0] > 21 then console.log 'you lose'
    dScore = (@get 'dealerHand').scores()
    if dScore[0] > 21 then console.log 'you win'

  dealerTurn: ->
    (@get 'dealerHand').reveal()
    dScore = (@get 'dealerHand').scores()
    if dScore[0] <= 16 then (@get 'dealerHand').hit()

