FactoryGirl.define do
  factory :card do
    name_en "Test"
    name_pt "Teste"
    card_type "Trainer"
    type_element "Item"
    rarity "Common"
    number "1/100"
    photo ""
    expansion
  end
end
