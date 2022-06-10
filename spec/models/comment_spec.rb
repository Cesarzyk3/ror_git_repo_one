require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user)     { create(:user) }
  let!(:article)  { create(:article) }

  it "can't be blank" do
    comment = Comment.new(body: '', user: user, article: article)
    comment.save
    expect(comment).not_to be_valid
  end

  it "can't be longer than 100 characters" do
    comment = Comment.new(body: "a"*101, user: user, article: article)
    comment.save
    expect(comment).not_to be_valid
  end

  it "can't be shorter than 3 characters" do
    comment = Comment.new(body: "aa", user: user, article: article)
    comment.save
    expect(comment).not_to be_valid
  end
end
