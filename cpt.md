1) count(//codeNGAP)
2) count(//categorie)
3) //categorie[i]/nom/text()
4) //codeNGAP[code/text()="MNO"]/montant/text()
5) count(//codeNGAP[montant<50])
6) //categorie[codeNGAP/code="MNO"]/nom/text()
7) //codeNGAP/montant[text()>65 and text()<70]