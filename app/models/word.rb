class Word < ApplicationRecord
  include Usable

  enum kind: [:adj, :fish]

  validates :word, uniqueness: { scope: :kind}
  class<< self
    def create_normalized(word, kind)
      kind = kind.to_i
      word = word.chomp.squish
      word = word[0..-3] + 'ая' if kind == 0
      self.find_or_create_by(word:  word.mb_chars.downcase, kind: kind)
    end

    def random_text
      fish = self.fish.unused.sample
      adj = self.adj.unused.sample
      fish.use! && adj.use!
      "#{adj.word} #{fish.word}"
    end
  end
end
