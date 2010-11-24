class Sentence < ActiveRecord::Base
  has_many :links
  has_many :trans, :class_name => "Link",:foreign_key => "translation_id"
end
