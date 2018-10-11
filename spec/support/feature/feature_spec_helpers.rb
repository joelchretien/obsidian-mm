def find_by_data_id(data_id)
  find_string = "[data-id=\"#{data_id}\"]"
  tr = find(find_string)
  tr
end
