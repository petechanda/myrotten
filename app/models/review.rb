class Review < ActiveRecord::Base

	belongs_to :movie
	belongs_to :user

	validates :movie_id, :presence => true
	validates_associated :movie

	def each_comment
		self.each do |cm|
			if cm.comments != ""
				yield cm
			end
		end
	end

end
