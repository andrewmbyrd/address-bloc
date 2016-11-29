require_relative("entry")

class AddressBook
  attr_reader :entries

  def initialize
    @entries=[]
  end


  def add_entry(name, phone_number, email)
     index = 0
     entries.each do |entry|
       if name < entry.name
         break
       end
       index+= 1
     end

     entries.insert(index, Entry.new(name, phone_number, email))
   end

  def remove_entry(name, phone_number, email)
    (0...@entries.length).each do |index|
      entry = @entries[index]
      delete = entry.name == name && entry.phone_number == phone_number && entry.email == email
      @entries.delete_at(index) if  delete
    end
  end

end
