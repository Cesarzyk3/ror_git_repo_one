require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:title) { "a"*20 }
  let!(:body)  { "a"*50 }
  let!(:user)  { create(:user) }

  it "can't have blank title" do
    article = Article.new(title: '', body: body, user: user)
    article.save
    expect(article).not_to be_valid
  end

  it "can't have blank body" do
    article = Article.new(title: title, body: '', user: user)
    article.save
    expect(article).not_to be_valid
  end

  it "can't have body longer than 500 characters" do
    article = Article.new(title: title, body: "a"*501, user: user)
    article.save
    expect(article).not_to be_valid
  end

  it "can't have body shorter than 3 characters" do
    article = Article.new(title: title, body: "aa", user: user)
    article.save
    expect(article).not_to be_valid
  end

  it "can't have title longer than 100 characters" do
    article = Article.new(title: "a"*101, body: body, user: user)
    article.save
    expect(article).not_to be_valid
  end

  it "can't have title shorter than 3 characters" do
    article = Article.new(title: "aa", body: body, user: user)
    article.save
    expect(article).not_to be_valid
  end
end
