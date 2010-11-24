# app/views/sentences/index.atom.builder
atom_feed do |feed|
  feed.title("Sentences")
  #feed.updated(Sentence.first.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ"))

  for sentence in @sentences
    feed.entry([sentence], :url => v1_sentence_path(sentence)) do |entry|
      entry.title(sentence.sentence)
      entry.content(sentence.links.first.translation.sentence, :type => 'html')
      entry.translation_url((url_for v1_sentence_path(sentence.links.first.translation)))
      #entry.updated(sentence.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) # needed to work with Google Reader.
    end
  end
end