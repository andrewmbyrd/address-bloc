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
     puts "5 - View entry by number(position in the address book)"
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
      #moved goodbye down to 6 and added the new function at 5
      when 5
         system "clear"
         select_by_index
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
       puts ""

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
  end

  def read_csv
  end
  #this is the new function
  def select_by_index
    #introductory messages prompts the user to enter an entry number
    puts "Please select the number of the entry you would like to view.\nThere are currently #{@address_book.entries.count} entries.\nPlease input a NUMBER from 1 to #{@address_book.entries.count}."
    #this gets user input and converts it to an int. non numbers are 0 after the call to to_i
    index = gets.chomp
    index = index.to_i
    #this will reset the prompt if invalid entry is given
    unless index <= @address_book.entries.count && index>0
      puts "That is not a valid input. Please try again"
      gets
      system "clear"
      select_by_index
    #this codes is assuming the average user won't know that arrrays start at 0. So we do index -1 to get the correct position in the array
    else
      puts "\nHere is your requested entry. Press any key to continue:\n\n"
      puts @address_book.entries[index-1].to_s
      gets
      system "clear"
    end
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
       puts "\nAre you sure you want to delete this entry? (Y/N)"
       pick = gets.chomp
       if pick.downcase == "y" || pick.downcase == "yes"
         @address_book.remove_entry(entry.name, entry.phone_number, entry.email)
         system "clear"
         puts "Entry deleted"
       else
         system "clear"
         puts "Ok select again"
         puts "Name: #{entry.name}"
         puts "Phone Number: #{entry.phone_number}"
         puts "Email: #{entry.email}"
         puts ""
         entry_submenu(entry)
       end
     when "e"
     when "m"
       system "clear"
       main_menu
    else
      puts "Invalid selection. Please try again"
      entry_submenu(entry)
    end
  end
 end
