require 'rails_helper'

feature 'pictures' do
  context 'no photos have been added' do
    scenario 'should ask the user to add pictures' do
      visit '/pictures'
      expect(page).to have_content('No pictures yet')
      expect(page).to have_link('Post a picture')
    end
  end
end
