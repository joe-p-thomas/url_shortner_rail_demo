# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


u1 = User.create!(email: "appstudent1@app.com")
u2 = User.create!(email: "appstudent2@app.com")
u3 = User.create!(email: "appstudent3@app.com")
u4 = User.create!(email: "appstudent4@app.com")
u5 = User.create!(email: "appstudent5@app.com", premium: true)

url1 = ShortenedUrl.create_for_user_and_long_url!(u1, "random1.com")
url2 = ShortenedUrl.create_for_user_and_long_url!(u1, "random2.com")
url3 = ShortenedUrl.create_for_user_and_long_url!(u1, "random3.com")
url4 = ShortenedUrl.create_for_user_and_long_url!(u2, "random4.com")
url5 = ShortenedUrl.create_for_user_and_long_url!(u2, "random5.com")
url6 = ShortenedUrl.create_for_user_and_long_url!(u3, "random6.com")
url7 = ShortenedUrl.create_for_user_and_long_url!(u3, "random7.com")
url8 = ShortenedUrl.create_for_user_and_long_url!(u4, "random8.com")
url9 = ShortenedUrl.create_for_user_and_long_url!(u4, "random9.com")
url10 = ShortenedUrl.create_for_user_and_long_url!(u5, "random10.com")

Visit.record_visit!(u1, url1)
Visit.record_visit!(u1, url2)
Visit.record_visit!(u1, url3)
Visit.record_visit!(u1, url3)
Visit.record_visit!(u1, url3)

Visit.record_visit!(u2, url4)
Visit.record_visit!(u2, url5)
Visit.record_visit!(u2, url1)

Visit.record_visit!(u3, url1)
Visit.record_visit!(u3, url2)
Visit.record_visit!(u3, url3)
Visit.record_visit!(u3, url4)
Visit.record_visit!(u3, url5)

Visit.record_visit!(u4, url5)
Visit.record_visit!(u4, url4)
Visit.record_visit!(u4, url3)
Visit.record_visit!(u4, url2)
Visit.record_visit!(u4, url1)

Visit.record_visit!(u5, url1)
Visit.record_visit!(u5, url2)
Visit.record_visit!(u5, url2)
Visit.record_visit!(u5, url3)
Visit.record_visit!(u5, url3)
Visit.record_visit!(u5, url5)
Visit.record_visit!(u5, url5)

tt1 = TagTopic.create!(topic: "sports")
tt2 = TagTopic.create!(topic: "news")
tt3 = TagTopic.create!(topic: "music")
tt4 = TagTopic.create!(topic: "science")
tt5 = TagTopic.create!(topic: "business")

Tagging.create_taggings!(tt1, url1)
Tagging.create_taggings!(tt2, url1)
Tagging.create_taggings!(tt3, url1)
Tagging.create_taggings!(tt4, url1)
Tagging.create_taggings!(tt5, url1)
Tagging.create_taggings!(tt1, url2)
Tagging.create_taggings!(tt4, url3)
Tagging.create_taggings!(tt5, url5)
