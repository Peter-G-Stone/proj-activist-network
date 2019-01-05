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
    aqua = Group.create(name: "Aquatic Liberation Front", summary: "We take the plastic rings off of fish.")
    trees = Group.create(name: "Save the Christmas Trees", summary: "Every christmas, millions of trees are murdered in cold sap. This is wrong. It must stop now.")
    bears = Group.create(name: "Guitars for Bears", summary: "We give guitars to bears. Don't ask questions.")
    


    peter = User.create(name: "Peter", email: "pmail@gmail.com", password: "password", bio: "I am your creator.")
    david = User.create(name: "David", email: "dmail@gmail.com", password: "password", bio: "Loves fish but not to eat.")
    izaak = User.create(name: "Izaak", email: "imail@gmail.com", password: "password", bio: "River person.")
    john = User.create(name: "John", email: "jmail@gmail.com", password: "password", bio: "Plays too many video games.")

    emu.users << peter 
    peter.group_link(emu).admin = true

    peter.group_link(emu).save

    izaak.groups << Group.all
    izaak.groups_user.each do |g_u|
        if g_u.group_id == walrus.id || g_u.group_id == aqua.id || g_u.group_id == trees.id 
            g_u.admin = true
            g_u.save   
        end
    end


    bears.users << david
    david.group_link(bears).admin = true
    david.group_link(bears).save


    banjo.users << john
    john.group_link(banjo).admin = true
    john.group_link(banjo).save

    post1 = Post.create(content: "Welcome to PETE! We're so glad to have you in our group.", user: peter, group: emu)
    post2 = Post.create(content: "We need a meeting - please post your availability on Dec 29 and 30.", user: peter, group: emu)
    Post.create(content: "Please join! We need more members!!!", user: izaak, group: walrus)
    Post.create(content: "It takes a village to save walruses!", user: izaak, group: walrus)

    Comment.create(content: "We're glad to be here!", post: post1, user: izaak)
    Comment.create(content: "I'm not available", post: post2, user: izaak)
    Comment.create(content: "You're fired", post: post2, user: peter)


end

seed_me