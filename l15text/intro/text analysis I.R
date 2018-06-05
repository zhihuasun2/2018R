#############################
# �ı���������
#############################
# �ı���������
a <-"ʮ�˴�������������ѡ�øɲ���˼·��ǿ������������¡�Ψ�����á�ע��ʵЧ����С�ִ˷�����������Ϊ���Ƿ���ʵ����Ҫ����ѡ����ν���Ͳ����ס�"
nchar(a) #�����ַ�������
strsplit(a,split="��") #�ַ����и�
avec <- unlist(strsplit(a,split="��"))  #�ַ���ƴ��
paste(avec,collapse=",")
substr(a, 1,13)  #�ַ�����ȡ

#############################
# jiebaR �ִ�
# http://www.open-open.com/lib/view/open1415086153728.html
# ��ͷִʴ����ŵ�ϲ��https://mp.weixin.qq.com/s/PJ5bCtodjxikcSbynEZ8Dw
# 
library(jiebaR)
engine<-worker()
words<-"��ѧR���ԣ��Ǿ͸Ͻ������ֻ�����΢�ţ���ע���ںš����Ų���һ��ѧR���ԡ������Ų���һ��ɡ�"
segment(words,engine)

engine<=words

engine<= "�����г������Ųμ��˳������ŵ�ͨ����ʽ"

# ���Ӵʿ�
engine_new_word<-worker()
new_user_word(engine_new_word, c("���ں�","R����"))
segment(words,engine_new_word)

#�������ļ�����
engine_user<-worker(user='dictionary.txt')
segment(words,engine_user)

#����
new_user_word(engine_new_word,
              scan("dictionary.txt",what="",sep="\n"))
segment(words,engine_new_word)

# ͣ�ô�
engine_s<-worker(stop_word = "stopword.txt")
segment(words,engine_s)

# ��Ƶͳ��
freq(segment(words,engine))

# ����ȷ��
qseg[words]
qseg<=words
#���Ա�עҲ����ʹ��worker������type������typeĬ��Ϊmix�����轫������Ϊtag���ɡ�
tagger<-worker(type="tag")
tagger<=words

#��ȡ�ؼ���
#������Ҫ��worker����Ĳ���type����Ϊkeyword����simhash��ʹ�ò���topn������ȡ�ؼ��ֵĸ�����Ĭ��Ϊ5����
#type=keywords
keys<-worker(type="keywords",topn=2)
keys<=words

#type=simhash
keys2<-worker(type="simhash",topn=2)
keys2<=words


###########
# ���ӣ�ʡ������
#ԭ�ļ��ĸ�ʽgb18030,�ֹ��ı��ļ��洢֮��õ����õ�
setwd("//Users/liding/E/Bdata/liding17/2018R/l14text/intro/data")
lecture<-read.csv("samgov1.csv",encoding="utf-8")

############################# 
# �ı�Ԥ����
head(lecture)
nchar(lecture) #�����ַ�������
n=length(lecture[,1]);  
print(n) 
# ɾ������
res=lecture[lecture!=" "]; 
ls()
#fix(res)
#�޳�URL  
res=gsub(pattern="http:[a-zA-Z\\/\\.0-9]+","",res);   

#�޳������  
res=gsub(pattern="[��|��|��|��|һ��|һ��|û��|����|����|ԭ��|����|����|��Ժ|���]","",res);

#�޳����� 
res=gsub(pattern="/^[^0-9]*$/","",res); 

# �����ĵ��ִ�
library(jiebaR)
engine<-worker()
words<-"��ѧR���ԣ��Ǿ͸Ͻ������ֻ�����΢�ţ���ע���ںš����Ų���һ��ѧR���ԡ������Ų���һ��ɡ�"
segment(words,engine)

seg <- qseg[res] #ʹ��qseg���ͷִʣ����ѽ�����浽����seg��
seg <- seg[nchar(seg)>1] #ȥ���ַ�����С��2�Ĵ���

seg <- table(seg) #ͳ�ƴ�Ƶ
seg <- seg[!grepl('[0-9]+',names(seg))] #ȥ������
seg <- seg[!grepl('[a-zA-Z]+',names(seg))] #ȥ����ĸ
length(seg) #�鿴�������ʣ��Ĵ���

seg <- sort(seg, decreasing = TRUE)[1:100] #�������򣬲���ȡ���ִ�������ǰ100������
seg #�鿴100����Ƶ��ߵ�

#############################
## ��������
library(wordcloud2)
wordcloud2(seg)
# �Ŵ���Կ���״
wordcloud2(seg,shape="diamond")
wordcloud2(seg,figPath="ma.jpg")

write.csv(seg, file="samgov2.csv", row.names=FALSE)  


#############################
## ��������  ����2 
############################
# Rjava�İ�װ

## 1����Ҫ���ز���װjava���趨�û���������ע��macOS sierria����װjava jdk9,���װ�ˣ���Ҫж�أ������http://www.cnblogs.com/eadwin/p/7656310.html����
# ��װ�����û���������˵����mac http://www.cnblogs.com/zhangzhangwhu/p/7171735.html windows��

#  
#   https://www.java.com/en/download/
#   CMD�в鿴�汾��·����Ϣ
#   system("java -version")
#   $(/usr/libexec/java_home)

## 2����װrjava�����ⰲװ��·��: 
#   install.packages("rJava")
#   �����װ��������ɾ�� 
#   remove.packages("rJava")

## 3���趨��̬��λ�ã���Rjava�ܹ��ҵ�java
#    ��cmd ������
#   sudo ln -f -s $(/usr/libexec/java_home)/jre/lib/server/libjvm.dylib /usr/local/lib
#   ln -s $(/usr/libexec/java_home)/jre/lib/server/libjvm.dylib /Library/Frameworks/R.framework/Versions/3.4/Resources/lib/

# �ο�����
# https://stackoverflow.com/questions/37014340/installing-r-package-opennlp-in-r
# https://stackoverflow.com/questions/30738974/rjava-load-error-in-rstudio-r-after-upgrading-to-osx-yosemite

install.packages("rJava")
install.packages("openNLP")
require(rJava)
require(openNLP)

install.packages("Rwordseg", repos = "http://R-Forge.R-project.org")
install.packages("tmcn", repos="http://R-Forge.R-project.org")
install.packages("Rweibo", repos = "http://R-Forge.R-project.org")
############################


library(rJava); 
library(tmcn); 
library(Rwordseg); 
# ��װ�´ʵ�-sougou ���뷨
# ������������ֵ�
# http://pinyin.sogou.com/dict/
#�廪��ѧ�ʿ� http://thuocl.thunlp.org/
setwd("/Users/liding/E/Bdata/liding17/2018R/l15text/intro/data")
installDict("��ѧ��չ��.scel","kxfzg")
installDict("xinli.scel","xinli") # ����ѧ
installDict("zzx.scel","zzx") # ����ѧ
listDict()
uninstallDict()

# == ��ʱ�����´�  
insertWords("��æ֮��") 
insertWords("��æ") 


#############################
# �ִ�+Ƶ��ͳ��
# �����ĵ��ִ�
segmentCN("���ʳ·�������ι��������ɭ�ֹ����־ִ�ӳ���ӥ����ָʹ�˽���ľһ�����⵱������Ҵ����ᳫ�˸����֡����������������滷����ͬʱ����Ȼ�����ӷ��ɵ�ɭ�ֹ����־־��١���ɲ������������������ʹ�ĵĹ��������ҷ�����ƽ��ߡ������2007���˵�𣬽���ʡ�����г�������ɽ��·�����ίԱ�������XX�������ɭ�ֹ����־ִ�ӳ���X��������ɽ��ɽ�֣����ᣬָʾ�·���ί���ƺ��С����鳤лXX��лXX�Ⱥ����������������ˣ�����ƺ�����ɡ������ӵ�ɽ�ص���Ҷ��ľһ�����⡣����ʱ�䳤��1�ꡢ�漰ԭʼɭ�������Լ1800Ķ����ʱ�ļ�ֵԼ100����Ԫ���ݵ��ش�С��Ĵ���˵����Ƭɭ���ڹ���ʱ�ڶ�û�п����������ڽ���ʡ������Ȼ��Ҷ�ֱ������̣�ȫʡ������Ȼ��Ҷ��ľʱ��ȴ������һ��������1800��Ķ��ԭʼɭ�����Ǵ�����Ŀ������һƬ�����������ޱȵ���ʹ�������⹴��û�еõ�Ӧ�е��Ʋã������޷������ˡ�2008��7�£���������������Ŀ�ŵ��أ�������ƺ����һ�ü�����ĺ춹ɼ��Ȼ��ѷ��ϵĺ춹ɼ��Ȼ�����˻ظ������ڸ������˿�ʼ�˺춹ɼʱ�����д�ί��ĸɲ�����ӥ���棬��û���κν���������������ӥ�������춹ɼ���������ֳ�������ʧְ�𣿼�����ʡ������֪������ʡ������һ��ɽ�깵ĵط��������ϡ�Ĺ�ľ�أ��춹ɼ������һ������ֲ��С��ʯֲ�֮�ƣ��Ǳ�Σ���֣����ƺ�����ü�����ĺ춹ɼ������ϡ����ƺ���ֻ�������ͬ����ĺ춹ɼ����֪ʲôʱ����Ҫ���١���ʵ�����м��߲ɷù����󹫰��������˵�����顣��лXX����������������������ͨ������������ʡ��أ�����XX����X�����ṩ�ʽ�֧�֡��������ǻ�������˵��ʱ�������ߵ�ʱ��ÿ�˸���ʮ���Ǯ�������������������XX����Xȴ��������ļ�������ң���⡣�Ȿ���Ǻ�г���Ӧ���е�����ϣ�������������ӡ����򷨽������������������ط��ٷ�һ�����죬ɽ�߻ʵ�Զ�����������ң��������壬�������Ի�ʹ���������йز��ţ��������޷�����Ϊ��˽���ĵ�ľ�ߣ���������֮�ڷ���ʹ�����ִ����ɫ��԰���ٱ���!�������Ѿ���ȥ�����ˣ�����ũ��Ҳ��Ͷ�����ţ�ֻ�ܳ��ưͿ��ˣ����Ǹ���ɽ��ɽ�Ĵ�ׯ��û��ɽ�Ĵ���׷�������Ǩ�㣬���ڵĲ�ƺ���Ѿ�����һ�ˣ���ǰ�������Ĵ�ׯ�����������������ò����˺��ġ�")  
segmentCN("���ʳ·�������ι��������ɭ�ֹ����־ִ�ӳ���ӥ����ָʹ�˽���ľһ�����⵱������Ҵ����ᳫ�˸�����", nature=TRUE)  
insertWords(c("����","�·�","����ָʹ")) 
segmentCN("���ʳ·�������ι��������ɭ�ֹ����־ִ�ӳ���ӥ����ָʹ�˽���ľһ�����⵱������Ҵ����ᳫ�˸�����", nature=TRUE)  

# ����ĵ��ִ�
segmentCN(c("ϰ��ƽǰ��������ϯ���Ľ�˰�ȫ���", "���ǿ���ƽ��Ϻ�����Ƽ���������", "���������ι�����ϯ �����½�֤�鼰ӡ��"))  
#�����ı�
lecture<-read.csv("samgov1.csv",encoding="utf-8")

############################# 
# �ı�Ԥ����
head(lecture)
nchar(lecture) #�����ַ�������
n=length(lecture[,1]);  
print(n) 
# ɾ������
res=lecture[lecture!=" "]; 
ls()
#fix(res)
#�޳�URL  
res=gsub(pattern="http:[a-zA-Z\\/\\.0-9]+","",res);   

#�޳������  
res=gsub(pattern="[��|��|��|��|һ��|һ��|û��|����|����|ԭ��|����|����|��Ժ|���]","",res);

#�޳����� 
res=gsub(pattern="/^[^0-9]*$/","",res); 

words=unlist(lapply(X=res, FUN=segmentCN));  
word=lapply(X=words, FUN=strsplit, " ");  
v=table(unlist(word));    
summary(v)

# ��������  
v=rev(sort(v));   
d=data.frame(word=names(v), freq=v);   
head(d)

# ��Ƶͳ��
# ���˵�1���ֺʹ�ƵС��2�ļ�¼  
d=subset(d, nchar(as.character(d$word))>1 & d$freq.Freq>=2)  
names(d)<-c("word","var","freq")
require(scales)
library(RColorBrewer)
library(wordcloud)
par(bg = "black")
wordcloud(names(seg), seg, colors = rainbow(100), random.order=F)

# ��������
par(family="SimSun") 

# ǰ100����
wordcloud(d$word,d$freq,random.order=FALSE,rot.per=.45,col=rainbow(length(d$freq)),max.words=100)

# ���д�
wordcloud(d$word,d$freq,random.order=FALSE,rot.per=.45,col=brewer.pal(9,"Set1"))

# ��ת����
wordcloud(d$word,d$freq,random.order=FALSE,rot.per=.45,col=rainbow(length(d$freq)))

# ��Դ�С
wordcloud(d$word, d$freq, min.freq=100, scale=c(5,.1), colors=brewer.pal(6, "Dark2")) 

# ǰһ�ٸ��ʣ���ת����
wordcloud(d$word, d$freq, max.words=100, rot.per=0.2, colors=brewer.pal(8, "Dark2"))  

#############################
##  wordcloud2��������
library(wordcloud2)
d <- d[,-2]
wordcloud2(d)
# �Ŵ���Կ���״
wordcloud2(d,shape="diamond")
wordcloud2(d, figPath="niu.jpg") # û�гɹ�
# �ο�
#http://www.dataguru.cn/article-9524-1.html?utm_source=tuicool&utm_medium=referral
## ������  







