### Loop for reading multiple pdf files using pdf tools
## Getting all my literature in my folder
file_dir<-c("D:/Master/Thesis/PhylogeneticDiversity/PD_as_response_var") # literature directory
file_vector<-list.files(file_dir) # list of file names

document <- Corpus(DirSource(file_dir), readerControl = list(reader = read))
doc <- content(document[[1]])
head(doc)

## this will assign all the documents on a list of lists (WARNING: this will take a while)
document_text<-vector("list", length(file_vector))
for (i in 1:length(file_vector)){
  document_text[[i]] <- pdf_text(paste(file_dir,"/",file_vector[i], sep = "")) %>% strsplit(split="\n")} # a list form

## this will name the different pdfs with its title
for (i in 1:length(document_text)){
  names(document_text)[i]<-file_vector[i]
}

## Naming every page with pdf title
for (i in 1:length(document_text)){
  for (j in 1:length(document_text[[i]])){
    names(document_text[[i]])[j]<-file_vector[i]
  }
}

## Converting the list to a dataframe (WARNING: this will take a while)
## This code will take a really long time as it binds 112 papers into one dataframe
file_df<-data.frame("title"=c(),"content"=c())
corpus_pd<-data.frame("title"=c(),"content"=c())
for (i in 1:length(document_text)){
  for (j in 1:length(document_text[[i]])){
    text_df<-data.frame(title=names(document_text[[i]])[j],
                        content=document_text[[i]][j])
    colnames(text_df)[2]<-"content"
    file_df<-rbind(file_df,text_df)} # a data.frame form for each pdf
  corpus_pd<-rbind(corpus_pd,file_df)  # binding the whole pdfs in one dataframe
}

corpus_pd$content<-as.character(corpus_pd$content)