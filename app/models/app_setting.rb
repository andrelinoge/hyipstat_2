class AppSetting
  include Mongoid::Document

  field :key, type: String
  field :value, type: String
  
  validates_presence_of :key, :value

  def self.[](key)
    record = self.find_by(key: key)
    if record
      record.value
    else
      'key missing'
    end
  end
end
