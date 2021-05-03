require 'rspec'
require_relative './customer'

describe Customer do
  let!(:customer) { Customer.new("john") }
  let! (:regular_movie) { Movie.new("regular", RegularPrice.new) }
  let! (:new_release_movie) { Movie.new("new release", NewReleasePrice.new) }
  let! (:children_movie) { Movie.new("children", ChildrenPrice.new) }
  it "rent regular movies" do
    rental = Rental.new(regular_movie, 4)

    customer.add_rental(rental)
    statement_should_be("Rental Record for john\n\tregular\t5.0\nAmount owed is 5.0\nYou earned 1 frequent renter points")
  end

  it "rent new release movie" do
    rental = Rental.new(new_release_movie, 4)

    customer.add_rental(rental)
    statement_should_be("Rental Record for john\n\tnew release\t12\nAmount owed is 12\nYou earned 2 frequent renter points")
  end

  it "rent children movie" do
    rental = Rental.new(children_movie, 4)

    customer.add_rental(rental)
    statement_should_be("Rental Record for john\n\tchildren\t3.0\nAmount owed is 3.0\nYou earned 1 frequent renter points")
  end

  it "rent multiple movie" do
    rental = Rental.new(children_movie, 4)
    rental2 = Rental.new(regular_movie, 2)

    customer.add_rental(rental)
    customer.add_rental(rental2)
    statement_should_be("Rental Record for john\n\tchildren\t3.0\n\tregular\t2\nAmount owed is 5.0\nYou earned 2 frequent renter points")
  end

  def statement_should_be(statement)
    expect(customer.statement).to eq statement
  end
end

