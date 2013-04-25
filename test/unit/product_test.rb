require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  # test "the truth" do
  #   assert true
  # end

  test "Product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:price].any?
  end

  test "Product price must be positive" do
    product = Product.new(:title => "Hello wordl",
                          :description => "First unit test",
                          :image => "test_image.jpg"
    );

    product.price = -1
    assert product.invalid?

    assert_equal "must be greater than or equal to 0.01",
                 product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert "must be greater than or equal to 0.01",
           product.errors[:price].join('; ')

    product.price = 1
    product.valid?
  end

  def get_product(image_url)
    product = Product.new(:title => "Hello wordl",
                          :description => "First unit test",
                          :image => image_url,
                          :price => 1
    );
  end

  test "image url validation" do
  correct = %w{a.gif b.png c.jpg}
    wrong = %w{a a.tiff b.exe}

    correct.each do |name|
      assert get_product(name).valid?, "#{name} shouldn't be invalid"
    end

    wrong.each do |name|
      assert get_product(name).invalid?, "#{name} shouldn't be vaild"
    end

  end

  test "product is not valid without unique title" do
    product = Product.new(:title => products(:ruby).title,
                          :description => "First unit test",
                          :image => "test_image.jpg",
                          :price =>10)

    assert !product.save
    assert_equal "has already been taken", product.errors[:title].join('; ')
  end
end

