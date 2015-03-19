require_relative '../config'

class CreateTweets < ActiveRecord::Migration
    def change
        create_table :tweets do |t|
            t.string :tweet_id
            t.string :tweet_text, :limit => 140
            t.integer :congress_member_id, index: true
            # Same as "t.belongs_to :congress_member, index: true"
            t.timestamps null: false
        end
    end
end