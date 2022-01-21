class AlbumArtUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog # to store on a cloud "bucket"

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.name}_#{model.id}"
  end

  process resize_to_fit: [800, 800]
  def extension_allowlist
    %w(jpg jpeg gif png)
  end
end
