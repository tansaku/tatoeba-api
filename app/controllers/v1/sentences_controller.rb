class V1::SentencesController < ApplicationController

  # this query does what I want:
  # SELECT s.id, s.language, s.sentence, t.language, t.sentence FROM "sentences" AS s
  # JOIN links AS l ON s.id = l.sentence_id
  # JOIN sentences AS t ON t.id = l.translation_id AND t.language = 'jpn'
  # WHERE (s.sentence LIKE '%friend%') AND s.language = 'eng' LIMIT 10


  # GET /sentences
  # GET /sentences.xml
  # GET /sentences.xml?q=friend&language=eng
  def index
    if params[:q]
      params[:language] = 'eng' unless params[:language]
      params[:translation_language] = 'jpn' unless params[:translation_language]
      @sentences = Sentence.select('s.id, s.language, s.sentence, t.id AS translation_id, t.language AS translation_language, t.sentence AS translation').
        where('s.sentence LIKE ? AND s.language = ? AND t.language = ?',"%#{params[:q]}%",params[:language],params[:translation_language]).
        joins('AS s JOIN links AS l ON s.id = l.sentence_id').
        joins('JOIN sentences AS t ON t.id = l.translation_id').
        limit(10)
    else
      @sentences = Sentence.limit(10)
    end
    # currently grabbing the translation counts in template is inefficient
    # if we really need that make query above a join ...

    # I am imagining main query is one like return me all sentences of one language
    # that contain a word, that have translations of another specified language
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sentences }
      format.json { render :json => @sentences }
      format.js { render_jsonp @sentences.to_json }
    end
  end

  # GET /sentences/1
  # GET /sentences/1.xml
  def show
    @sentence = Sentence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sentence }
    end
  end

  # GET /sentences/new
  # GET /sentences/new.xml
  def new
    @sentence = Sentence.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sentence }
    end
  end

  # GET /sentences/1/edit
  def edit
    @sentence = Sentence.find(params[:id])
  end

  # POST /sentences
  # POST /sentences.xml
  def create
    @sentence = Sentence.new(params[:sentence])

    respond_to do |format|
      if @sentence.save
        format.html { redirect_to(@sentence, :notice => 'Sentence was successfully created.') }
        format.xml  { render :xml => @sentence, :status => :created, :location => v1_sentence_path(@sentence) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sentence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sentences/1
  # PUT /sentences/1.xml
  def update
    @sentence = Sentence.find(params[:id])

    respond_to do |format|
      if @sentence.update_attributes(params[:sentence])
        format.html { redirect_to(@sentence, :notice => 'Sentence was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sentence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sentences/1
  # DELETE /sentences/1.xml
  def destroy
    @sentence = Sentence.find(params[:id])
    @sentence.destroy

    respond_to do |format|
      format.html { redirect_to(sentences_url) }
      format.xml  { head :ok }
    end
  end
end
