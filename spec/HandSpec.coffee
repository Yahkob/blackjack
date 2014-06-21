assert = chai.assert

describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'isBusted', ->
    it "should return false when not busted", ->
      assert.equal hand.isBusted(), false
    it "should return true when busted", ->
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.last(), hand.hit()
      assert.equal hand.isBusted(), true
