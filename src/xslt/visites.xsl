<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : newstylesheet.xsl
    Created on : 16 novembre 2021, 15:24
    Author     : zaettal
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:inf="http://www.ujf-grenoble.fr/l3miage/medical" xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:param name="destinedId" select="001"/>
    <xsl:variable name="visitesDuJour" select="//inf:visite[@intervenant=$destinedId]"/>
    <!-- récupération de tous les actes -->
    <xsl:variable name="actes" select="document('../xml/actes.xml', /)/act:ngap"/>
    <xsl:output method="html"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Vos visites du jour</title>
                <script type="text/javascript" src="./js/script.js"/>
                <link rel="stylesheet" href="./css/style.css"/>
            </head>
            <body>
                <!-- récupération du nom et du prénom de l'intervenant -->
                <p>Bonjour <xsl:value-of select="//inf:infirmier[@id=$destinedId]/inf:prénom"/><br/>
                    <!-- comptage du nombre de visites de l'intervenant -->
                   Aujourd'hui, vous avez <xsl:value-of select="count(//inf:patient[inf:visite[@intervenant=$destinedId]])"/> patient(s)
                </p>
                <!--- affichage des visites de l'intervenant en faisant appel au template patient -->
                <xsl:apply-templates select="//inf:patient[inf:visite[@intervenant=$destinedId]]"/>
            </body>
        </html>
    </xsl:template>

    <!--- template patient -->
    <xsl:template match="inf:patient">
        <address>
            <!-- récupération du nom du patient -->
            <xsl:value-of select="inf:nom"/><br/>

            <!-- récupération de la date de la visite -->
            <xsl:value-of select="concat(inf:adresse/inf:numéro,' ')"/>
            <xsl:value-of select="inf:adresse/inf:rue"/>&#160;
            <xsl:value-of select="inf:adresse/inf:codePostal"/>&#160;
            <xsl:value-of select="inf:adresse/inf:ville"/>
            <br/>
        </address>
        <!-- affichage des actes du patient en faisant appel au template acte
            Pour se faire on récupère les id des actes du patient dans une valiables
            On utilise ensuite cette variable pour récupérer les actes dans le fichier actes.xml
        -->
        <xsl:variable name="ide" select="inf:visite/inf:acte/@id"/>
        <xsl:apply-templates select="$actes/act:actes/act:acte[@id=$ide]"/>
        <!-- affichage du nom et prénom du patient -->
        <xsl:variable name="nom" select="inf:nom"/>
        <xsl:variable name="prenom" select="inf:prénom"/>
        <button>
            <!-- appel au xslt pour afficher le formulaire de facture dans un boutton -->
            <xsl:attribute name="onclick">
                openFacture('<xsl:value-of select="$prenom"/>', 
                            '<xsl:value-of select="$nom"/>',
                            `<xsl:value-of select="$actes/act:actes/act:acte[@id=$ide]"/>`)
            </xsl:attribute>
            FACTURE !
        </button>
    </xsl:template>

    <!--- template acte -->
    <xsl:template match="act:acte">
        <p><xsl:value-of select="text()"/></p>
    </xsl:template>
    
</xsl:stylesheet>
