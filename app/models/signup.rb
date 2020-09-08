class Signup < ApplicationRecord
  has_one_attached :selfie
  has_one_attached :photo_id
  validate :acceptable_image

  def acceptable_image
    return unless selfie.attached?

    unless selfie.byte_size <= 1.megabyte
      errors.add(:selfie, "is too big")
    end

    unless photo_id.byte_size <= 1.megabyte
      errors.add(:photo_id, "is too big")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(selfie.content_type)
      errors.add(:selfie, "must be a JPEG or PNG")
    end

    unless acceptable_types.include?(photo_id.content_type)
      errors.add(:photo_id, "must be a JPEG or PNG")
    end
  end

end
