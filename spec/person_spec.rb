require 'active_record'
require 'rspec'

require_relative '../app/models/person'

database_configuration = YAML::load(File.open('../config/database.yml'))
configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(configuration)

RSpec.configure do |config|
  config.after(:each) do
    Person.all.each { |person| person.destroy}
  end
end

describe Person do
  it 'has a given name' do
    a = Person.new
    a.given_name = "Joe"
    a.save
    expect(a.given_name).to eq("Joe")
  end

  it 'has a family name' do
    a = Person.new
    a.family_name = "Blow"
    a.save
    expect(a.family_name).to eq("Blow")
  end

  it "has a mother (maybe)" do
    momPerson = Person.new
    momPerson.given_name = "Mom"
    momPerson.save
    child = Person.new
    child.given_name = "Sonny"
    child.mother = momPerson
    child.save
    expect(child.mother).to eq momPerson
    expect(momPerson.mother).to eq nil
  end

  it "has a father (maybe)" do
    dadPerson = Person.new
    dadPerson.given_name = "Mom"
    dadPerson.save
    child = Person.new
    child.given_name = "Sonny"
    child.father = dadPerson
    child.save
    expect(child.father).to eq dadPerson
    expect(dadPerson.father).to eq nil
  end

  it "lists ancestors of a person" do
    gggm11 = Person.new(:given_name => "bessie")
    gggm11.save
    gggd11 = Person.new(:given_name => "oliver")
    gggd11.save
    gggm12 = Person.new(:given_name => "virginia")
    gggm12.save
    gggd12 = Person.new(:given_name => "lenny")
    gggd12.save
    gggm13 = Person.new(:given_name => "liz")
    gggm13.save
    gggd13 = Person.new(:given_name => "francis")
    gggd13.save
    gggm14 = Person.new(:given_name => "chantal")
    gggm14.save
    gggd14 = Person.new(:given_name => "adam")
    gggd14.save
    gggm15 = Person.new(:given_name => "victoria")
    gggm15.save
    gggd15 = Person.new(:given_name => "ken")
    gggd15.save
    gggm16 = Person.new(:given_name => "irene")
    gggm16.save
    gggd16 = Person.new(:given_name => "cooper")
    gggd16.save
    gggm17 = Person.new(:given_name => "rose")
    gggm17.save
    gggd17 = Person.new(:given_name => "dan")
    gggd17.save
    gggm18 = Person.new(:given_name => "florence")
    gggm18.save
    gggd18 = Person.new(:given_name => "sammy")
    gggd18.save

    ggm3 = Person.new(:given_name => "gayle", :mother => gggm11, :father => gggd11)
    ggm3.save
    ggd4 = Person.new(:given_name => "arthur", :mother => gggm12, :father => gggd12)
    ggd4.save
    ggm5 = Person.new(:given_name => "donna", :mother => gggm13, :father => gggd13)
    ggm5.save
    ggd6 = Person.new(:given_name => "karl", :mother => gggm14, :father => gggd14)
    ggd6.save
    ggm7 = Person.new(:given_name => "bessie", :mother => gggm15, :father => gggd15)
    ggm7.save
    ggd8 = Person.new(:given_name => "tristan", :mother => gggm16, :father => gggd16)
    ggd8.save
    ggm9 = Person.new(:given_name => "elise", :mother => gggm17, :father => gggd17)
    ggm9.save
    ggd10 = Person.new(:given_name => "wilbur", :mother => gggm18, :father => gggd18)
    ggd4.save

    gm1 = Person.new(:given_name => "laurie", :mother => ggm3, :father => ggd4)
    gm1.save
    gd1 = Person.new(:given_name => "bill", :mother => ggm5, :father => ggd6)
    gd1.save
    gm2 = Person.new(:given_name => "jane", :mother => ggm7, :father => ggd8)
    gm2.save
    gd2 = Person.new(:given_name => "bob", :mother => ggm9, :father => ggd10)
    gd2.save

    m = Person.new(:given_name => "mary", :mother => gm1, :father => gd1)
    m.save
    d = Person.new(:given_name => "john", :mother => gm2, :father => gd2)
    d.save

    child = Person.new(:given_name => "baby", :mother => m, :father => d)
    child.save

    expect(child.find_ancestors).to match_array [m, d, gm1, gd1, gm2, gd2, ggm3, ggd4, ggm5, ggd6, ggm7, ggd8, ggm9, ggd10, gggm11, gggd11, gggm12, gggd12, gggm13, gggd13, gggm14, gggd14, gggm15, gggd15, gggm16, gggd16, gggm17, gggd17, gggm18, gggd18]

  end
end
