## Project : Spontanouse occurance of avian atherosclerosis
*Mehdi Nojoumi*

**Project idea :**
My project is about the spontanous occurance of atherosclerosis in birds. Occurance of atherosclerosis is high among mammals and birds.
We have conducted a systematic review of all reported cases of spontanous atherosclerosis in birds. We are collecting the papers, 
species name and the order of the bird in each citation, whether athero was induced, whether the animals were captive and whether 
there is a mention of succeptibility or resistance to athero in each citation. 

The aim of the project is to first visualize the phylogenetic map of spontanouse atherosclerosis in birds and determine whether the 
differences in occurance of athero in different avian orders represent inherent succeptibility or resistance in particular bird orders. 
So, I need to extract the number of occurances of athero in every avian order and format it to visualize it in R.
Finally I will analyze the relationship between various potential factors such as body mass, captivity and 
average flight altitude, and ocrrurance of spontanouse atherosclerosis. Although I'm not quite sure what statistical tool I will be using for
this part of analysis yet, I am assuming it might involve R or other programs like Pyrate to be able to make appropriate graphs and statistical
tests to assess the results.

This research take an evolutionary medicine approach to the question of occuranc of the most common and fatal "human" diease in animals. 
The succeptibility or resistence found in parituclar avian groups can point to the inherent evolutionary causes of athero in humans, which 
can provide valuable insight into how evolution has shaped the factors that has increased humas's scucceptibility to atherosclerosis.

***I have extracted the uniqe order in my dataset with the following shell command:***

*tail -n +2 athero.csv | cut -d "," -f 6 |sort|uniq*

**List of all uniqe orders:**


*1-Anseriformes
2-Accipitriformes
3-Ciconiiformes
4-Columbiformes
5-Falconiformes
6-Galliformes
7-Gruiformes
8-Pelecaniformes
9-Psittaciformes
10-Struthioniformes*





