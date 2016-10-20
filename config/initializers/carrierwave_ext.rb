module CarrierWave
  module Crop
    module UploaderExtensions

      def crop(width = nil, height = nil)
        return unless model.crop_x.present?
        raise_missing_processor  unless defined?(CarrierWave::MiniMagick) || defined?(CarrierWave::RMagick)

        proc = ->(original_height, original_width) do
          if model.crop_w.present? && model.crop_h.present?
            w = model.crop_w
            h = model.crop_h
          else
            ratio = width.to_f / height
            orig_ratio = original_height / original_width

            w = h = [original_height, original_width].min
            if ratio < orig_ratio
              w = original_width * ratio
            elsif ratio > orig_ratio
              h = original_height * ratio
            end
          end

          { width: w, height: h }
        end

        if self.is_a?(CarrierWave::MiniMagick)
          begin
            manipulate! do |img|
              sizes = proc.call(img['width'], img['height'])
              h = sizes[:height]
              w = sizes[:width]

              if model.crop_x.blank? && model.crop_y.blank?
                img.combine_options do |op|
                  op.crop "#{w.to_i}x#{h.to_i}+0+0"
                  op.gravity 'Center'
                end
              else
                img.crop("#{w.to_i}x#{h.to_i}+#{model.crop_x.to_i}+#{model.crop_y.to_i}")
              end
              img.resize("#{width}x#{height}")
              img
            end

          rescue Exception => e
            raise CarrierWave::Crop::ProcessingError, "Failed to crop - #{e.message}"
          end

        elsif self.is_a?(CarrierWave::RMagick)
          begin
            manipulate! do |img|
              sizes = proc.call(img.columns, img.rows)
              h = sizes[:height]
              w = sizes[:width]

              if model.crop_x.blank? && model.crop_y.blank?
                img.crop! 'Center', 0, 0, w.to_i, h.to_i
              else
                img.crop! model.crop_x.to_i, model.crop_y.to_i, w.to_i, h.to_i
              end
              img.resize! width, height
            end

          rescue Exception => e
            raise CarrierWave::Crop::ProcessingError, "Failed to crop - #{e.message}"
          end
        else
          raise_missing_processor
        end
      end

      private

      def raise_missing_processor
        raise CarrierWave::Crop::MissingProcessorError, "Failed to crop #{attachment}. Add mini_magick or rmagick."
      end

    end ## End of UploaderExtensions
  end ## End of Crop
end ## End of CarrierWave

if defined? CarrierWave::Uploader::Base
  CarrierWave::Uploader::Base.class_eval do
    include CarrierWave::Crop::UploaderExtensions
  end
end

module CropFormHelpers
  # Form helper to render the preview of a cropped attachment.
  # Loads the actual image. Previewbox has no constraints on dimensions, image is renedred at full size.
  # By default box size is 100x100. Size can be customized by setting the :width and :height option.
  # If you override one of width/height you must override both.
  #
  #   previewbox :avatar
  #   previewbox :avatar, width: 200, height: 200
  #
  # @param attachment [Symbol] attachment name
  # @param opts [Hash] specify version or width and height options
  def previewbox(attachment, opts = {})
    attachment = attachment.to_sym
    attachment_instance = self.object.send(attachment)

    if(attachment_instance.is_a? CarrierWave::Uploader::Base)
      model_name = self.object.class.name.demodulize.underscore
      width, height = 100, 100
      if(opts[:width] && opts[:height])
        width, height = opts[:width].round, opts[:height].round
      elsif (sizes = find_output_sizes(attachment_instance))
        width, height = *sizes
      end
      wrapper_attributes = {id: "#{model_name}_#{attachment}_previewbox_wrapper", style: "width:#{width}px; height:#{height}px; overflow:hidden", class: 'previewbox_wrapper'}

      attachment_url = opts[:version].present? ? attachment_instance.send(opts[:version]).url : attachment_instance.url
      preview_image = @template.image_tag(attachment_url, id: "#{model_name}_#{attachment}_previewbox")
      @template.content_tag(:div, preview_image, wrapper_attributes)
    end
  end

  def find_output_sizes(attachment_instance)
    attachment_instance.class.processors.reverse.find{ |a| a[0].to_s.include?('crop') }.try(:[], 1)
  end

  # Form helper to render the actual cropping box of an attachment.
  # Loads the actual image. Cropbox has no constraints on dimensions, image is renedred at full size.
  # Box size can be restricted by setting the :width and :height option. If you override one of width/height you must override both.
  #
  #   cropbox :avatar
  #   cropbox :avatar, width: 550, height: 600
  #
  # @param attachment [Symbol] attachment name
  # @param opts [Hash] specify version or width and height options
  def cropbox(attachment, opts = {})
    attachment = attachment.to_sym
    attachment_instance = self.object.send(attachment)

    if(attachment_instance.is_a? CarrierWave::Uploader::Base)
      model_name = self.object.class.name.demodulize.underscore

      output = ActiveSupport::SafeBuffer.new
      [:crop_x ,:crop_y, :crop_w, :crop_h].each do |attribute|
        output << @template.hidden_field_tag("#{model_name}[#{attribute}]", nil, id: "#{model_name}_#{attachment}_#{attribute}")
      end

      wrapper_attributes = {id: "#{model_name}_#{attachment}_cropbox_wrapper", class: 'cropbox_wrapper'}
      if(opts[:width] && opts[:height])
        wrapper_attributes.merge!(style: "width:#{opts[:width].round}px; height:#{opts[:height].round}px; overflow:hidden")
      end

      width, height = 100, 100
      if (sizes = find_output_sizes(attachment_instance))
        width, height = *sizes
      end

      attachment_url = opts[:version].present? ? attachment_instance.send(opts[:version]).url : attachment_instance.url

      target_attributes = {id: "#{model_name}_#{attachment}_cropbox", data: { output_width: width, output_height: height }}
      # if(opts[:width] && opts[:height])
      #   target_attributes.merge!(style: "max-width: #{opts[:width].round}px; max-height: #{opts[:height].round}px;")
      # end

      output << @template.image_tag(attachment_url, target_attributes)

      @template.content_tag(:div, output, wrapper_attributes)
    end
  end
end


if defined? ActionView::Helpers::FormBuilder
  ActionView::Helpers::FormBuilder.class_eval do
    include CropFormHelpers
  end
end
