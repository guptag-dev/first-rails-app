class Product < ActiveRecord::Base
  attr_accessible :description, :image, :price, :title

  validates :description, :image, :price, :title, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :image, :format => {
      :with => %r{\.(gif|png|jpg)}i,
      :message => 'must be a URL for GIF, PNG or JPG'
  }
end
