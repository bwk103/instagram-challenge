require 'rails_helper'

feature 'posts' do
  context 'no posts have been added' do
    scenario 'should ask the user to add posts' do
      visit '/posts'
      expect(page).to have_content('No posts yet')
      expect(page).to have_link('Post something')
    end
  end

  context 'post has been added' do

    before do
      Post.create(caption: 'This is a random post')
    end

    scenario 'should display posts' do
      visit '/posts'
      expect(page).to have_content('This is a random post')
      expect(page).not_to have_content('No posts yet')
    end
  end

  context 'creating post' do
    scenario 'prompts user to complete form and then displays the post' do
      visit '/posts'
      click_link 'Post something'
      fill_in 'Caption', with: "This is a test"
      click_button 'Create Post'
      expect(page).to have_content "This is a test"
      expect(current_path).to eq '/posts'
    end
  end

  context 'viewing posts' do
    scenario 'lets a user select a post to view' do
      post = Post.create(caption: "This is a test")
      visit '/posts'
      click_link 'This is a test'
      expect(current_path).to eq "/posts/#{post.id}"
    end
  end
end
