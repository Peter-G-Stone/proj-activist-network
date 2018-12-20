# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_me
    emu = Group.create(name: "People for the Ethical Treatment of Emus", summary: "Emus are being mistreated. We are helping emus.")
    walrus = Group.create(name: "Walrus Relocation Angels", summary: "We find and relocate beached walruses.")
    banjo = Group.create(name: "Banjo Revival", summary: "We provide banjos to struggling schoolchildren in Appalachia.")
    Group.create(name: "Aquatic Liberation Front", summary: "We take the plastic rings off of fish.")
    Group.create(name: "Save the Christmas Trees", summary: "Every christmas, millions of trees are murdered in cold sap. This is wrong. It must stop now.")
    Group.create(name: "Hippies Must Go", summary: "Hippies are giving all leftists a bad name with their unscientific beliefs.")
    bears = Group.create(name: "Guitars for Bears", summary: "We give guitars to bears. Don't ask questions.")



    peter = User.create(name: "Peter", email: "pedrostone@gmail.com", password: "password", bio: "I am your creator.")
    david = User.create(name: "David", email: "dmail@gmail.com", password: "password", bio: "Loves fish but not to eat.")
    izaak = User.create(name: "Izaak", email: "imail@gmail.com", password: "password", bio: "River person.")
    john = User.create(name: "John", email: "jmail@gmail.com", password: "password", bio: "Plays too many video games.")

    emu.users << peter 
    izaak.groups << Group.all
    bears.users << david
    banjo.users << john
end

seed_me