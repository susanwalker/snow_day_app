class Location < ApplicationRecord
  validates :zip_code, uniqueness: true, presence: true

  # Credit: https://stackoverflow.com/a/17980948
  validates_format_of :zip_code,
    with: /\A\d{5}-\d{4}|\A\d{5}\z/,
    message: "should be 12345 or 12345-1234"

  def maybe_update_max_report(new_report)
    if max_inches_of_snow.nil? || new_report > max_inches_of_snow
      self.max_inches_of_snow = new_report
      save
    else
      return nil
    end
  end
end
