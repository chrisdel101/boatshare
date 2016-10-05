class Voyage < ApplicationRecord
  belongs_to :captain, class_name: 'User', foreign_key: 'captain_id'
  has_many :reservations
  has_many :passengers, through: :reservations

  geocoded_by :location
  after_validation :geocode

  validates :title, presence: true

  validates :location, presence: true

  validates :start_time, presence: true

  validate :start_time_cannot_be_in_the_past

  validate :has_capacity?#validates capcity: if there is no space on boat then rollback reservation and display custom error.
  validates :capacity, presence: true

    def start_time_cannot_be_in_the_past #validation to make sure captains cannot create voyages in the past
     if start_time.present? && start_time < DateTime.now
       errors.add(:start_time, message: "You can't make a voyage in the past! Please try again.")
     end
   end

   def present_capacity
     self.capacity - self.reservations.count
   end

   def has_capacity?
     if present_capacity <= 0
       errors.add(:capacity, message: "Sorry, this trip is full. Choose another trip!")
     else
       return true
     end
   end

end
