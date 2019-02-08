# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def seed_me

    peter = User.create(name: "Peter", email: "pmail@gmail.com", password: "password", bio: "I am your creator.")
    david = User.create(name: "David", email: "dmail@gmail.com", password: "password", bio: "Loves fish but not to eat.")
    izaak = User.create(name: "Izaak", email: "imail@gmail.com", password: "password", bio: "River person.")
    john = User.create(name: "John", email: "jmail@gmail.com", password: "password", bio: "Plays too many video games.")

    emu = Group.create(name: "People for the Ethical Treatment of Emus", summary: "Emus are being mistreated. We are helping emus.", recent_activity: DateTime.current, users: [peter, izaak])
    walrus = Group.create(name: "Walrus Relocation Angels", summary: "We find and relocate beached walruses.", recent_activity: DateTime.current, users: [izaak])
    banjo = Group.create(name: "Banjo Revival", summary: "We provide banjos to struggling schoolchildren in Appalachia.", recent_activity: DateTime.current, users: [john, izaak])
    aqua = Group.create(name: "Aquatic Liberation Front", summary: "We take the plastic rings off of fish.", recent_activity: DateTime.current, users: [izaak])
    trees = Group.create(name: "Save the Christmas Trees", summary: "Every christmas, millions of trees are murdered in cold sap. This is wrong. It must stop now.", recent_activity: DateTime.current, users: [izaak])
    bears = Group.create(name: "Guitars for Bears", summary: "We give guitars to bears. Don't ask questions.", recent_activity: DateTime.current, users: [david, izaak])

    post1 = Post.create(content: "Welcome to PETE! We're so glad to have you in our group.", user: peter, group: emu)
    post2 = Post.create(content: "We need a meeting - please post your availability on Dec 29 and 30.", user: peter, group: emu)
    Post.create(content: "Please join! We need more members!!!", user: izaak, group: walrus)
    Post.create(content: "It takes a village to save walruses!", user: izaak, group: walrus)

    Comment.create(content: "We're glad to be here!", post: post1, user: izaak)
    Comment.create(content: "I'm not available", post: post2, user: izaak)
    Comment.create(content: "You're fired", post: post2, user: peter)


end

seed_me