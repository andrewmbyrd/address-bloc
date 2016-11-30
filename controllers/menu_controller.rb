require_relative '../models/address_book'

 class MenuController
   attr_reader :address_book

   def initialize
     @address_book = AddressBook.new
   end

   def main_menu

     puts "Main Menu - #{address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - Import entries from a CSV"
     puts "5 - Destroy every record in the address book!!!11!"
     puts "6 - Exit"
     print "Enter your selection: "


     selection = gets.to_i
     case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
         system "clear"
         create_entry
         main_menu
      when 3
         system "clear"
         search_entries
         main_menu
      when 4
         system "clear"
         read_csv
         main_menu
      when 5
        system "clear"
        destroy
        main_menu
      when 6
         puts "Good-bye!"
         exit(0)

       else
         system "clear"
         puts "Sorry, that is not a valid input"
         main_menu
     end
   end

  def view_all_entries
     puts "This wizard will take you through each entry one-by-one.\n\n"
     @address_book.entries.each do |entry|
       puts entry.to_s
       puts "\n"

       entry_submenu(entry)
     end

     system "clear"
     puts "End of entries"
  end

  def create_entry
    puts "New AddressBloc Entry"
    print "Name: "
    name = gets.chomp
    print 'Phone Number: '
    phone_number = gets.chomp
    print "Email: "
    email = gets.chomp

    address_book.add_entry(name, phone_number, email)
    system "clear"
    puts "New entry created"
  end

  def search_entries
    print "Search by entry name:"
    name = gets.chomp

    match = address_book.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  #search entries end
  end

  def read_csv
    print "Enter CSV file name to import:"
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    #we're trying to read a file which may or may not exist
    #begin protects us in case an exception would be thrown
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter a valid CSV file name"
      read_csv
    end
  #read_csv end
  end

  #DESTROY every record in the address book
  def destroy
    #ask the user to confirm the choice
    puts "You have selected to destroy everything. You sure??"
    killer = gets.chomp

    #ask the user to confirm the choice again because its a big deal
    if killer.downcase == "y" || killer.downcase == "yes"
      puts "Are you actually, really sure? (you can't get it back!)"
      true_killer = gets.chomp
      #if they said yes twice, then set the entries list to be empty
      if true_killer.downcase == "y" || true_killer.downcase == "yes"
        @address_book.entries = []
        puts "Well. They're all gone. You monster.\n"
        main_menu

      #if they said no either time, then we can put them back to the main menu
      else
        puts "Well alright. Let's go back to the menu then"
        gets
        system "clear"
        main_menu
      end
  else
    puts "Good, I knew that must have been a mistake"
    main_menu
  end

#end destroy
end

  def entry_submenu(entry)
    puts "Please make your selection"
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to the main menu"

    selection = gets.chomp
    case selection
    when "n"
       return
     when "d"
       delete_entry(entry)
     when "e"
       edit_entry(entry)
       entry_submenu(entry)
     when "m"
       system "clear"
       main_menu
    else
      puts "Invalid selection. Please try again"
      entry_submenu(entry)
    end
  #end submenu
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    # #13
    selection = gets.chomp

    # #14
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  #end search submenu
  end

  def delete_entry(entry)
    puts "Are you sure you want to delete this entry? (Y/N)"
    pick = gets.chomp
    if pick.downcase == "y" || pick.downcase == "yes"
      @address_book.remove_entry(entry.name, entry.phone_number, entry.email)
      system "clear"
      puts "Entry #{entry.name} has been deleted"
    else
      system "clear"
      puts "Ok select again"
      puts "Name: #{entry.name}"
      puts "Phone Number: #{entry.phone_number}"
      puts "Email: #{entry.email}"
      puts ""
      entry_submenu(entry)
    end
  #delete entry end
  end

  def edit_entry(entry)
    print "Updated name (hit enter if no change necessary):"
    name = gets.chomp

    print "Updated phone number (hit enter if no change necessary):"
    phone_number = gets.chomp

    print "Updated email (hit enter if no change necessary):"
    email = gets.chomp

    unless name == ""
      entry.name = name
    end

    unless phone_number == ""
      entry.phone_number = phone_number
    end

    unless email == ""
      entry.email = email
    end

    system "clear"
    puts "Updated entry:"
    puts entry
  end

#end program
 end
