library(tm)
library(wordcloud)
stopwords_id = c('di', 'ke', 'ini', 'dengan', 'untuk', 'yang', 'tak', 'tidak', 'gak',
                 'dari', 'dan', 'atau', 'bisa', 'kita', 'ada', 'itu',
                 'akan', 'jadi', 'menjadi', 'tetap', 'per', 'bagi', 'saat',
                 'tapi', 'bukan', 'adalah', 'pula', 'aja', 'saja',
                 'kalo', 'kalau', 'karena', 'pada', 'kepada', 'terhadap',
                 'amp', 'iya' # &amp;
                 )
df <- read.csv('~/backupBBM/anal.csv')
corpus <- Corpus(VectorSource(df$text))
corpus <- tm_map(corpus, content_transformer(function(x) gsub('http\\S+t.co\\S+', '', x)))
tdm <- TermDocumentMatrix(corpus,
  control = list(stripWhitespace = TRUE, tolower = TRUE,
                 removeNumbers = TRUE,
                 removePunctuation = TRUE,
                 stopwords = c(stopwords_id, 'dakwatuna') ))

m <- as.matrix(tdm)
wf <- sort(rowSums(m), decreasing=TRUE)
wf <- wf[wf > 0]
dm <- data.frame(word=names(wf), freq=wf)

head(dm)
wordcloud(head(dm$word, 5), head(dm$freq, 5),
          random.order=FALSE, colors=brewer.pal(8, 'Dark2'))
