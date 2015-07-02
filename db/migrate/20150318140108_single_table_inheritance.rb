require_relative '../config'

class SingleTableInheritance < ActiveRecord::Migration
    def change
        rename_column :congress_members, :title, :type
    end
end