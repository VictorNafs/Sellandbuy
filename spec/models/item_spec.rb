require 'rails_helper'



RSpec.describe Item, type: :model do

    describe "#validation_length" do    

        it "should not be greater that 50 characters" do
        invalid_description = Item.create(description: "JohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnhnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnhnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnhnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohnJohn")
        expect(invalid_description).not_to be_valid
        expect(invalid_description.errors.include?(:description)).to eq(true)
        end

        it "should not be greater that 27 characters" do
            invalid_title = Item.create(title: "JohnJohnJJohnJJohnJJohnJJohnJJohnJJohnJJohnJohn")
            expect(invalid_title).not_to be_valid
            expect(invalid_title.errors.include?(:title)).to eq(true)
        end
 
    end

end