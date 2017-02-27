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

    scenario "it does not permit the user to create a post without a caption" do
      visit '/posts'
      click_link 'Post something'
      click_button 'Create Post'
      expect(page).to have_content "Caption is too short"
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

  context 'editing posts' do
    scenario 'lets a user edit their posts' do
      post = Post.create(caption: "This is the original text")
      visit '/posts'
      click_link "Edit"
      fill_in 'Caption', with: "This is the revised text"
      click_button 'Update Post'
      expect(page).to have_content("This is the revised text")
      expect(current_path).to eq '/posts'
    end
  end

  context 'deleting posts' do
    scenario 'lets a user delete their posts' do
      post = Post.create(caption: "This is a test")
      visit '/posts'
      click_link "Delete"
      expect(page).to have_content "Post successfully deleted"
      expect(page).not_to have_content "This is a test"
    end
  end
end
