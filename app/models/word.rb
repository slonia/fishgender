class Word < ApplicationRecord
  include Usable

  enum kind: [:adj, :fish]

  validates :word, uniqueness: { scope: :kind }
  validates :word, presence: true

  class<< self
    def create_normalized(word, kind)
      kind = kind.to_i
      word = word.chomp.squish
      word = word.mb_chars.downcase
      word = feminize(word) if kind.to_i == 0
      self.find_or_create_by(word:  word, kind: kind)
    end

    def random_text
      fish = self.fish.unused.sample
      adj = self.adj.unused.sample
      fish.use! && adj.use!
      "#{adj.word} #{fish.word}"
    end

    private

    def feminize(word)
      word = word.sub(/ий/, "яя")
      word = word.sub(/ый/, "ая")
      word
    end
  end
end
