require 'rspec'
require 'date'
require_relative '../app/models/student'


describe Student, "#name and #age" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless expect(ActiveRecord::Base.connection.table_exists?(:students)).to eq(true)
    Student.delete_all

    @student = Student.new
    @student.assign_attributes(
      :first_name => "Happy",
      :last_name => "Gilmore",
      :gender => 'male',
      :birthday => Date.new(1970,9,1)
    )
  end

  it "should have name and age methods" do
    [:name, :age].each { |mthd| @student.should respond_to mthd }
  end

  it "should concatenate first and last name" do
    expect(@student.name).to eq "Happy Gilmore"
  end

  it "should be the right age" do
    now = Date.today
    age = now.year - @student.birthday.year - ((now.month > @student.birthday.month || (now.month == @student.birthday.month && now.day >= @student.birthday.day)) ? 0 : 1)
    expect(@student.age).to eq age
  end

end

describe Student, "validations" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless expect(ActiveRecord::Base.connection.table_exists?(:students)).to eq true
    Student.delete_all
  end

  before(:each) do
    @student = Student.new
    @student.assign_attributes(
      :first_name => "Kreay",
      :last_name => "Shawn",
      :birthday => Date.new(1989,9,24),
      :gender => 'female',
      :email => 'kreayshawn@oaklandhiphop.net',
      :phone => '(510) 555-1212 x4567'
    )
  end

  it "should accept valid info" do
    expect(@student).to be_valid
  end

  it "shouldn't accept invalid emails" do
    ["XYZ!bitnet", "@.", "a@b.c"].each do |address|
      @student.assign_attributes(:email => address)
      expect(@student).to_not be_valid
    end
  end

  it "should accept valid emails" do
    ["joe@example.com", "info@bbc.co.uk", "bugs@devbootcamp.com"].each do |address|
      @student.assign_attributes(:email => address)
      expect(@student).to be_valid
    end
  end

  it "shouldn't accept toddlers" do
    @student.assign_attributes(:birthday => Date.today - 3.years)
    expect(@student).to_not be_valid
  end

  it "shouldn't allow two students with the same email" do
    another_student = Student.create!(
      :birthday => @student.birthday,
      :email => @student.email,
      :phone => @student.phone
    )
    expect(@student).to_not be_valid
  end

end

describe Student, "advanced validations" do

  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless expect(ActiveRecord::Base.connection.table_exists?(:students)).to eq(true)
    Student.delete_all
  end

  before(:each) do
    @student = Student.new
    @student.assign_attributes(
      :first_name => "Kreay",
      :last_name => "Shawn",
      :birthday => Date.new(1989,9,24),
      :gender => 'female',
      :email => 'kreayshawn@oaklandhiphop.net',
      :phone => '(510) 555-1212 x4567'
    )
  end

  it "should accept valid info" do
    expect(@student).to be_valid
  end

  it "shouldn't accept invalid phone numbers" do
    @student.assign_attributes(:phone => '347-8901')
    expect(@student).to_not be_valid
  end

end
