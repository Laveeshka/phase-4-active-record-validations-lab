class Post < ApplicationRecord
    validates :title, presence: true, exclusion: { in: ["True Facts"] }
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    validate :clickbaity_title?

    #validates :size, inclusion: { in: %w(small medium large),
    #message: "%{value} is not a valid size" }


    MATCHED_EXPRESSIONS = [/Won't Believe/i, /Secret/i, /Top \d/i, /Guess/i]

    def clickbaity_title?
        unless MATCHED_EXPRESSIONS.any?{ |regex| regex.match(title) }
            errors.add(:title, "title is not clickbait-y enough!")
        end
    end
end
