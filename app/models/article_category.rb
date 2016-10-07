class ArticleCategory
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String, localize: true
  slug :name, localize: true

  has_many :articles

  validates_presence_of  :name

end
