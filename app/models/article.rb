class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  mount_uploader :cover, CoverUploader
  attr_accessor :cover_cache
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  field :cover, type: String, default: ''

  field :title, type: String, localize: true
  field :content, type: String, localize: true
  field :meta_keywords, type: String, localize: true
  field :meta_description, type: String, localize: true
  field :reviews, type: Integer, localize: true, default: 0
  field :archive, type: Boolean, default: false
  field :comments_count, type: Integer, localize: true, default: 0
  field :last_commented_at, type: DateTime, localize: true

  slug :title, localize: true

  after_save :crop_cover

  def crop_cover
    cover.recreate_versions! if crop_x.present?
  end

  def increase_reviews!
    self.inc(reviews: 1)
  end

  def increase_comments_count!
    self.inc(comments_count: 1)
  end

end
