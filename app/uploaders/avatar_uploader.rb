# encoding: utf-8

class AvatarUploader < ImageUploader
  version :large do
    process :set_original_sha
    process convert: 'png'
    process resize_to_fill: [600, 600]
    process :set_content_type
  end

  version :medium do
    process :set_original_sha
    process convert: 'png'
    process resize_to_fill: [400, 400]
    process :set_content_type
  end

  version :small do
    process :set_original_sha
    process convert: 'png'
    process resize_to_fill: [200, 200]
    process :set_content_type
  end
end
