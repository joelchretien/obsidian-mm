module FeatureSpecHelpers
  def find_by_data_id(data_id)
    find_string = "[data-id=\"#{data_id.to_s}\"]"
    tr = find(find_string)
    tr
  end
end
