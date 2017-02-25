require 'rails_helper'

feature 'commenting' do
  before { Post.create caption: "A test" }

  scenario 'allows users to leave a review using a form' do
    visit '/posts'
    click_link 'Comment'
    fill_in 'Body', with: "This is a comment"
    click_button 'Leave Comment'
    expect(current_path).to eq '/posts'
    expect(page).to have_content("This is a comment")
  end
end
