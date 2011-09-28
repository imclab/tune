require 'mongoid'

Storefront::Components::Form::Input.class_eval do
  def base_input(tag, *args, &block)
    options    = args.extract_options!
    attributes = self.attributes
    text       = args.shift
  
    template.capture_haml do
      if block_given?
        template.haml_tag tag, attributes, &block
      else
        if text.present?
          template.haml_concat template.content_tag(tag, text, attributes)
        else
          template.haml_tag tag, attributes
        end
      end
    end
  end
end
