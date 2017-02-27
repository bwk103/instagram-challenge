require 'rails_helper'

describe Post, type: :model do
  it 'is not valid without a caption' do
    post = Post.new(caption: "")
    expect(post).to have(1).error_on(:caption)
    expect(post).not_to be_valid
  end
end
