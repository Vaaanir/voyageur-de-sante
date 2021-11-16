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
    <xsl:variable name="actes" select="document('../xml/actes.xml', /)/act:ngap"/>
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Vos visites du jours</title>
                <script type="text/javascript" src="./js/script.js"></script>
                <link rel="stylesheet" href="./css/style.css"/>
            </head>
            <body>
                <p>Bonjour <xsl:value-of select="//inf:infirmier[@id=$destinedId]/inf:prénom"/><br/>
                   Aujourd'hui, vous avez <xsl:value-of select="count(//inf:patient[inf:visite[@intervenant=$destinedId]])"/> patient(s)
                </p>
                <xsl:apply-templates select="//inf:patient[inf:visite[@intervenant=$destinedId]]"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="inf:patient">
        <address>
            <xsl:value-of select="inf:nom"/><br/>
            
            <xsl:value-of select="concat(inf:adresse/inf:numéro,' ')"/>
            <xsl:value-of select="inf:adresse/inf:rue"/>&#160;
            <xsl:value-of select="inf:adresse/inf:codePostal"/>&#160;
            <xsl:value-of select="inf:adresse/inf:ville"/>
            <br/>
        </address>
        <xsl:variable name="ide" select="inf:visite/inf:acte/@id"/>
        <xsl:apply-templates select="$actes/act:actes/act:acte[@id=$ide]"/>
        <xsl:variable name="nom" select="inf:nom"/>
        <xsl:variable name="prenom" select="inf:prénom"/>
        <button>
            <xsl:attribute name="onclick">
                openFacture('<xsl:value-of select="$prenom"/>', 
                            '<xsl:value-of select="$nom"/>',
                            `<xsl:value-of select="$actes/act:actes/act:acte[@id=$ide]"/>`)
            </xsl:attribute>
            FAAAAACTURE !!!!
        </button>
    </xsl:template>
    
    <xsl:template match="act:acte">
        <p><xsl:value-of select="text()"/></p>
    </xsl:template>
    
</xsl:stylesheet>
