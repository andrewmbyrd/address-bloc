require_relative '../models/address_book'

 RSpec.describe AddressBook do
   describe "attributes" do
     it "responds to entries" do
       book = AddressBook.new
       expect(book).to respond_to(:entries)
     end

     it "initializes entries as an array" do
       book = AddressBook.new
       expect(book.entries).to be_an(Array)
     end

     it "initializes entries as empty" do
       book = AddressBook.new
       expect(book.entries.size).to eq(0)
     end
   end

   describe "#add_entry" do
     it "adds an only one entry to the array" do
       book = AddressBook.new
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')

       expect(book.entries.size).to eq(1)
     end

     it "adds the correct information to entries" do
       book = AddressBook.new
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       new_entry = book.entries[0]

       expect(new_entry.name).to eq("Ada Lovelace")
       expect(new_entry.phone_number).to eq("010.012.1815")
       expect(new_entry.email).to eq("augusta.king@lovelace.com")

     end
   end

   describe "#remove_entry" do
     it "only removes one entry" do
       book = AddressBook.new
       book.add_entry('Ada Lovelace', '010.012.1815', 'augusta.king@lovelace.com')
       book.add_entry('Vince McMahon', '555.111.2222', 'boss@wwe.com')
       size = book.entries.size

       book.remove_entry('Vince McMahon', '555.111.2222', 'boss@wwe.com')
       expect(book.entries.size).to eq(size-1)
       expect(book.entries[0].name).to eq("Ada Lovelace")


     end
   end

 end