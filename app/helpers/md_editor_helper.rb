# TODO - refactor

module MdEditorHelper
  require 'redcarpet'
  require 'font-awesome-rails'
  require 'md_builder'
  FontAwesome::Rails::IconHelper

  def self.md_to_html(md)
    options = { autolink: true,
                tables: true,
                hard_wrap: false,
                no_intra_emphasis: true,
                fenced_code: true,
                gh_blockcode: true }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(md).html_safe
  end

  def md_editor(klass='')
    @md_builder = MdBuilder.new(klass)
    content_tag(:div, :id => 'md-editor') do
      content_tag(:div, :class => 'btn-toolbar', role: 'toolbar') do
        content_tag(:div, class: 'btn-group btn-preview') do
          button_tag(:type => 'button', :class => "#{@md_builder.default_class} btn-primary preview_md") do
            'Preview'
          end
        end +
        header_tags + text_tools + link_and_image_tools
      end +
        content_tag(:div, :id => 'md-text') do
          yield
        end +
        content_tag(:div, class: 'panel panel-success preview-panel', hidden: true) do
          content_tag(:div, :id => 'md-preview', class: 'panel-body') do
          end
        end
    end
  end

  def header_tags
    content_tag(:div, :class => 'btn-group') do
      button_tag(type: 'button', class: "#{@md_builder.default_class} md_h1") do
        content_tag(:strong, 'H1')
      end +
        button_tag(type: 'button', class: "#{@md_builder.default_class} md_h2") do
          content_tag(:strong, 'H2')
        end +
        button_tag(type: 'button', class: "#{@md_builder.default_class} md_h3") do
          content_tag(:strong, 'H3')
        end +
        button_tag(type: 'button', class: "#{@md_builder.default_class} md_h4") do
          content_tag(:strong, 'H4')
        end +
        button_tag(type: 'button', class: "#{@md_builder.default_class} md_h5") do
          content_tag(:strong, 'H5')
        end +
        button_tag(type: 'button', class: "#{@md_builder.default_class} md_first_letter") do
          content_tag(:strong, 'A')
        end
    end
  end

  def link_and_image_tools
    content_tag(:div, :class => 'btn-group') do
      button_tag(:type => 'button', :class => "#{@md_builder.default_class} md_link") do
        fa_icon 'link'
      end +
        button_tag(:type => 'button', :class => "#{@md_builder.default_class} md_camera-retro") do
          fa_icon 'camera-retro'
        end
    end
  end

  def text_tools
    content_tag(:div, :class => 'btn-group') do
      button_tag(type: 'button', class: "#{@md_builder.default_class} md_italic") do
        fa_icon 'italic'
      end +
        button_tag(type: 'button', class: "#{@md_builder.default_class} md_bold") do
          fa_icon 'bold'
        end +
        button_tag(:type => 'button', class: "#{@md_builder.default_class} md_list-ul") do
          fa_icon 'list-ul'
        end +
        button_tag(:type => 'button', class: "#{@md_builder.default_class} md_list-ol") do
          fa_icon 'list-ol'
        end +
        button_tag(:type => 'button', class: "#{@md_builder.default_class} md_indent") do
          fa_icon 'indent'
        end +
        button_tag(:type => 'button', class: "#{@md_builder.default_class} md_underline") do
          fa_icon 'underline'
        end +
        button_tag(:type => 'button', class: "#{@md_builder.default_class} md_table") do
          fa_icon 'table'
        end +
        button_tag(:type => 'button', class: "#{@md_builder.default_class} md_square") do
          fa_icon 'square'
        end +
        button_tag(:type => 'button', class: "#{@md_builder.default_class} md_minus") do
          fa_icon 'minus'
        end
    end
  end
end