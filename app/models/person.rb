require 'active_record'
class Person < ActiveRecord::Base
  belongs_to :mother, :class_name => 'Person'
  belongs_to :father, :class_name => 'Person'


// returns a list of all the ancestors of a Person
  def ancestors
    parents = []
    if self.mother != nil
        parents << (self.mother)
        parents += self.mother.find_parents
    end
    if self.father != nil
        parents << (self.father)
        parents += self.father.find_parents
    end
    return parents
  end






end
