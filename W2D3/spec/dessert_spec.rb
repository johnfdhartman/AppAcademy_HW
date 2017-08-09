require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }

  describe "#initialize" do
    d = Dessert.new('chocolate', 50, :chef)
    it "sets a type" do
      expect(d.type).to be_truthy
    end

    it "sets a quantity" do
      expect(d.quantity).to be_truthy
    end

    it "starts ingredients as an empty array" do
      expect(d.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect {Dessert.new('b','b','b')}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    d = Dessert.new('chocolate', 50, :chef)
    it "adds an ingredient to the ingredients array" do
      d.add_ingredient('sand')
      expect(d.ingredients.include?('sand')).to be true
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      d = Dessert.new('chocolate', 50, :chef)
      ('a'..'z').to_a.each do |letter|
        d.add_ingredient(letter)
      end
      initial_ingredients = d.ingredients.dup
      d.mix!
      expect(d.ingredients).not_to eql(initial_ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      d = Dessert.new('chocolate', 50, :chef)
      d.eat(10)
      expect(d.quantity).to eq(40)
    end

  it "raises an error if the amount is greater than the quantity" do
    expect{d.eat(100)}.to raise_error
  end
end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Xavier")
      d = Dessert.new('chocolate', 50, chef)
      expect(d.serve).to match(/Xavier/)
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake).and_return("Xavier")
      d = Dessert.new('chocolate', 50, chef)

      expect(chef).to receive(:bake).with(d)
      d.make_more
    end
  end
end
