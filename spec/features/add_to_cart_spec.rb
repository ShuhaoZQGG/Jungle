require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can sign up and add products to carts" do
    # ACT
    visit '/signup'
    fill_in 'user_name', with: 'zsh'
    fill_in 'user_email', with: 'zsh@gmail.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'Submit'
    first('.product' ).click_button('Add')

    # DEBUG / VERIFY
    save_screenshot
    expect(page).to have_link(text: "My Cart (1)")
    expect(page).to have_content("zsh")
    expect(page).to have_content("Logout")
  end
end
