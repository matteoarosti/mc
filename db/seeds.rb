# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ct = ChannelType.create(name: 'EBAY')
ch = Channel.create(channel_id: ct.id, name: 'Ebay ChicoBonitoShop')

Manufacturer.create(name: 'Fruit')
Manufacturer.create(name: 'Payper')