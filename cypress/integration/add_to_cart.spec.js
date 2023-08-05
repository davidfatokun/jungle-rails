describe('Add to cart', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('should increase the cart count by one when clicking on the add to cart button for a product', () => {
    cy.get('.cart-count > .nav-link')
      .invoke('text')
      .then((text) => {
        const match1 = text.match(/\((\d+)\)/)
        const initialNumber = Number(match1[1])
        cy.get('article > div > form > button').first().click()      
        cy.get('.cart-count > .nav-link')
          .invoke('text')
          .then((text) => {
            const match2 = text.match(/\((\d+)\)/)
            const updatedNumber = Number(match2[1])
            expect(updatedNumber).to.equal(initialNumber + 1)
          })
      })
  })
})
