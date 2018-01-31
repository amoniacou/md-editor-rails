# MdEditorRails
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'md_editor_rails'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install md_editor_rails
```

## ActiveAdmin example

active_admin.scss

```
@import "md_editor_rails/md_editor";
@import "md_editor_rails/markdown";
@import "dropzone/dropzone";
```

active_admin.js.coffee

```
#= require dropzone
#= require md_editor_rails/md_editor
```


admin/post.rb

```
ActiveAdmin.register Post do
    form partial: 'posts/form'
end
```


posts/_form.slim

```
= semantic_form_for [:admin, @post], builder: ActiveAdmin::FormBuilder do |f|
  = f.inputs "Details" do
    = f.input :title
    = f.input :intro
    = f.input :employee_id, as: :select, collection: ::Employee.all
    = f.input :tags, as: :tags, collection: ::BlogCategory.pluck(:slug), input_html: { value: f.object.tags.join(',') }
    = f.input :top_image, as: :file, label: 'Top Image', :hint => f.object.top_image.present? ? image_tag(f.object.top_image.try(:thumb).try(:url)) : content_tag(:span, 'no image yet')
    = f.input :blog_image, as: :file, label: 'Blogs Image', :hint => f.object.blog_image.present? ? image_tag(f.object.blog_image.try(:thumb).try(:url)) : content_tag(:span, 'no image yet')

    .js_wrap_dropzone_editor
      = md_editor do
        = f.text_area :body, rows: 16
        .dropzone.js_editor_dropzone
          .fallback
            input name="file" type="file"

    = f.input :likes
    = f.input :comments
    = f.input :views


  = f.actions
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

