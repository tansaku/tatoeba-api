class Link < ActiveRecord::Base
  belongs_to :sentence
  belongs_to :translation, :class_name => "Sentence", :foreign_key => "translation_id"
end
