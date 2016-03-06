json.array!(@twzzlz) do |twzzl|
    json.extract! twzzl, :id
    json.image_url twzzl.image.url
end 