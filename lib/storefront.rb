require 'mongoid'

module Storefront
  module Components
    class Form
      class Input < Storefront::Components::Form::Base
        class << self
          attr_accessor :resolves
        
          def resolves(*input_types)
            @resolves ||= []
            @resolves = @resolves.concat(input_types.flatten.compact).uniq
          end
        
          def resolves?(name)
            @resolves ||= []
            @resolves.include?(name)
          end
        
          def registry
            @registry ||= Dir[::File.join(::File.dirname(__FILE__), "inputs", "*")].map do |path|
              next unless ::File.extname(path) == ".rb"
              "Storefront::Components::Form::#{::File.basename(path, ::File.extname(path)).camelize}".constantize
            end.compact
          end
        
          def find(name)
            registry.detect do |input_class|
              input_class.resolves?(name)
            end
          end
        end
      
        def initialize(options = {})
          super
        
          # input type
          options[:as]    ||= attribute.input_type(options)
          @input_type     = options[:as]
          @include_blank  = options[:include_blank] != false
          @value          = options[:value]
          @dynamic        = options[:dynamic] == true
          @rich_input     = options.has_key?(:rich_input) ? !!options[:rich_input] : config.rich_input
        
          @validate       = attributes.delete(:validate) != false
        
          classes = [input_type, self.class.name.split("::").last.underscore, attribute.name.to_s.underscore.strip.gsub(/[_\s]+/, config.separator)]
        
          if options[:input_html].present?
            classes << options[:input_html].delete(:class)
          end
        
          unless [:submit].include?(input_type)
            classes += [
              attribute.required? ? config.required_class : config.optional_class, 
              attribute.errors? ? config.error_class : config.valid_class,
              "input"
            ]
          
            if @validate && attribute.validations.present?
              classes << config.validate_class
            end
          end
        
          # class
          merge_class! attributes, *classes.compact.uniq.map(&:to_s)
        
          # id
          attributes[:id] ||= attribute.to_id(:index => index, :parent_index => parent_index) if config.id_enabled_on.include?("input")
        
          # validations
          if @validate
            attributes.merge!(attribute.validations) if config.inline_validations && attribute.validations.present?
          end  
          attributes[:placeholder] = options[:placeholder] if options[:placeholder].present?
        
          # name
          attributes[:name]     ||= attribute.to_param(:index => index, :parent_index => parent_index)
        
          # value
          attributes[:value]    ||= attribute.value(options[:value])
        
          # attributes[:tabindex]      = @tabindex
          attributes[:maxlength]       = options[:max] if options[:max].present?
        
          # expressions
          pattern                      = options[:match]
          pattern                      = pattern.source if pattern.is_a?(::Regexp)
          attributes[:"data-match"]    = pattern if pattern.present?
          attributes[:"aria-required"] = attribute.required.to_s if attribute.required?
        
          # access key
          access_key                   = attributes[:accesskey] || attribute.access_key
          attributes[:accesskey]       = access_key
        
          attributes.merge!(options[:input_html]) if options[:input_html]
        
          attributes.delete :include_blank
          attributes.delete :input_html
          attributes.delete :include_template
          attributes.delete :as
          attributes.delete :dynamic
          attributes.delete :parent_index
        
          attributes[:required] = "true" if attributes.delete(:required) == true
          attributes[:disabled] = "true" if attributes.delete(:disabled) == true
          attributes[:autofocus] = "true" if attributes.delete(:autofocus) == true
          attributes[:"data-dynamic"] = "true" if @dynamic
        
          attributes[:title] ||= attributes[:placeholder] if attributes[:placeholder].present?
        
          autocomplete = attributes.delete(:autocomplete)
          if autocomplete && config.include_aria
            attributes[:"aria-autocomplete"] = case autocomplete
            when :inline, :list, :both
              autocomplete.to_s
            else
              "both"
            end
          end
        end
      
        def render(&block)
          send(:"#{@input_type}_input")
        end
      
        protected
        attr_reader :include_blank
      
        def simple_input(type, options = {}, &block)
          template.capture_haml do
            template.haml_tag :input, extract_attributes!(type, options), &block
            if @dynamic
              template.haml_tag :ul, :class => "buttons" do
                template.haml_tag :li do
                  template.haml_tag :a, config.add_label, :class => :add, :role => :button, :type => :button, :href => "#"
                end
                template.haml_tag :li do
                  template.haml_tag :a, config.remove_label, :class => :remove, :role => :button, :type => :button, :href => "#"
                end
              end
            end
          end
        end
      
        def rich_input(type, options = {}, &block)
          template.capture_haml do
            result = template.rich_button :inner_html => extract_attributes!(type, options), :as => :input
            template.haml_concat result.gsub(/\n$/, "") if result
          end
        end
      
        def extract_attributes!(type, options = {})
          if [:numeric, :string, :password, :text, :phone, :url, :email].include?(type)
            attributes = model.default_string_options(attribute.name, type).merge(self.attributes)
          else
            attributes = self.attributes
          end

          merge_class! attributes, options.delete(:class)

          attributes[:type] = input_type_for(type)

          attributes.merge(options)
        end
      
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
        
        def input_type_for(type)
          case type
          when :password, :text, :url, :email, :file, :textarea, :search, :submit, :radio, :checkbox
            type
          when :phone, :tel
            :tel
          else
            :string
          end
        end
      end
    end
  end
end
