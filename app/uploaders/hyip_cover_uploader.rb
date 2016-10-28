# encoding: utf-8

class HyipCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  version :large do
    process crop: [640,480]
    process resize_to_limit: [640, 480]
  end

  version :thumb do
    process crop: [100,100]  ## Crops this version based on original image
    resize_to_limit(100,100)
  end

end
