Rails.application.routes.draw do

  post '/images(/:imageable_id/:imageable_type)' => 'images#create', as: :md_editor_images_create

end
