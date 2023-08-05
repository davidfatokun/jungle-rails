describe('Product details', () => {
  beforeEach(() => {
    cy.visit('/')
  })

  it('should navigate to the product detail page by clicking on a product', () => {
    cy.get('.products > article > a').first().click()

    cy.url().should('include', '/products/')

    const categories = ['Evergreens', 'Shrubs', 'Trees']

    cy.get('.page-header > h1').should(($h1) => {
      const text = $h1.text()
      expect(categories.some(word => text.includes(word))).to.be.true
    })
    cy.get('.product-detail > .main-img').should("be.visible")
    cy.get('.product-detail > div > h1').should("be.visible")
    cy.get('.product-detail > div > p').should("be.visible")
    cy.get('.product-detail > div > .quantity').should("be.visible")
    cy.get('.product-detail > div > .price').should("be.visible")
  })
})
