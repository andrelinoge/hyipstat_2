class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String, localize: true
  field :content, type: String, localize: true
  field :meta_keywords, type: String, localize: true
  field :meta_description, type: String, localize: true
  field :reviews, type: Integer, localize: true, default: 0
  field :archive, type: Boolean, default: false
  field :comments_count, type: Integer, localize: true, default: 0
  field :last_commented_at, type: DateTime, localize: true

  slug :title, localize: true

  belongs_to :article_category

  def increase_reviews!
    self.inc(reviews: 1)
  end

  def increase_comments_count!
    self.inc(comments_count: 1)
  end
end
