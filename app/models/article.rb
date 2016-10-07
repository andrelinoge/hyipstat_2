class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String, localize: true
  field :content, type: String, localize: true
  field :meta_keywords, type: String, localize: true
  field :meta_description, type: String, localize: true
  field :reviews, type: Integer, localize: true, default: 0
  field :archive, type: Boolean, default: false

  slug :name, localize: true

  belongs_to :article_category

  validates_presence_of :name, :content

  def increase_reviews!
    self.inc(reviews: 1)
  end
end
