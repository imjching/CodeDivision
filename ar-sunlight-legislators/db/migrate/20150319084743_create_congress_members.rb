require_relative '../config'

class CreateCongressMembers < ActiveRecord::Migration
    def change
        create_table :congress_members do |t|
            t.string :title, :limit => 3
            t.string :firstname, :limit => 16
            t.string :middlename, :limit => 16
            t.string :lastname, :limit => 16
            t.string :name_suffix, :limit => 10
            t.string :nickname, :limit => 16
            t.string :party, :limit => 1
            t.string :state, :limit => 2
            t.string :district, :limit => 16
            t.integer :in_office, :limit => 1
            t.integer :gender, :limit => 1
            t.string :phone, :limit => 10
            t.string :fax, :limit => 10
            t.string :website
            t.string :webform
            t.string :congress_office
            t.string :bioguide_id, :limit => 7
            t.integer :votesmart_id
            t.string :fec_id
            t.integer :govtrack_id, :limit => 6
            t.string :crp_id, :limit => 9
            t.string :twitter_id, :limit => 32
            t.string :congresspedia_url
            t.string :youtube_url
            t.string :facebook_id
            t.string :official_rss
            t.string :senate_class, :limit => 3
            t.string :birthdate, :limit => 10
            t.timestamps null: false
        end
    end
end