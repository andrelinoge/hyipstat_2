class ArticleCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String, localize: true

  has_many :articles

  validates_presence_of  :name

end
