require_relative("entry")
require "csv"

class AddressBook
  #had to change this from a reader to an accessor so that you can set it to
  # the empty array in the destroy function in menu controller
  attr_accessor :entries

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

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers:true, skip_blanks: true)

    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  def binary_search(name)
    lower = 0
    upper = @entries.length

    while lower <= upper
      mid = (lower + upper) / 2
      mid_name = @entries[mid].name

      if mid_name == name
        return @entries[mid]
      elsif mid_name < name
        lower = mid + 1
      else
        upper = mid - 1
      end

    end

    return nil
  end

end
