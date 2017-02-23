require 'rails_helper'

RSpec.describe Wiki, type: :model do
  #let(:wiki) { create(:wiki) }
  
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:private) { false }
  let(:wiki) { Wiki.create!(title: title, body: body) }
  
  describe "attributes" do
      it "has title, body, and private attributes" do
          expect(wiki).to have_attributes(title: title, body: body)
      end
      
      it "is public by default" do
          expect(wiki.private).to be(false)
      end
  end
  
end
