<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : newstylesheet.xsl
    Created on : 16 novembre 2021, 17:58
    Author     : zaettal
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:inf="http://www.ujf-grenoble.fr/l3miage/medical" xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:param name="destinedName" select="'Alécole'"/>
    <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap"/>
    <xsl:variable name="patient" select="//inf:patient[inf:nom/text()=$destinedName]"/>
    <xsl:output method="xml"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <patient  xmlns="http://www.ujf-grenoble.fr/l3miage/medical">
            <nom>
                <xsl:value-of select="$patient/inf:nom"/>
            </nom>
            <prénom><xsl:value-of select="$patient/inf:prénom"/></prénom>
            <sexe><xsl:value-of select="$patient/inf:sexe"/></sexe>
            <naissance><xsl:value-of select="$patient/inf:naissance"/></naissance>
            <numéroSS><xsl:value-of select="$patient/inf:numéro"/></numéroSS>
            <adresse>
                <numéro>
                    <xsl:value-of select="$patient/inf:adresse/inf:numéro"/>
                </numéro>
                <rue>
                    <xsl:value-of select="$patient/inf:adresse/inf:rue"/>
                </rue>
                <codePostal>
                    <xsl:value-of select="$patient/inf:adresse/inf:codePostal"/>
                </codePostal>
                <ville>
                    <xsl:value-of select="$patient/inf:adresse/inf:ville"/>
                </ville>
            </adresse>
            <xsl:apply-templates select="$patient/inf:visite" />
        </patient>
    </xsl:template>
    
    <xsl:template match="inf:visite">
        <xsl:variable name="intervenant" select="@intervenant"/>
        <visite>
            <xsl:attribute name="date">
                <xsl:value-of select="@date"/>
            </xsl:attribute>
            <intervenant>
                <nom>
                    <xsl:value-of select="//inf:infirmier[@id=$intervenant]/inf:nom"/>
                </nom>
                <prénom>
                    <xsl:value-of select="//inf:infirmier[@id=$intervenant]/inf:prénom"/>
                </prénom>
            </intervenant>
            <xsl:variable name="ide" select="inf:acte/@id"/>
            <xsl:apply-templates select="$actes/act:actes/act:acte[@id=$ide]"/>
        </visite>
    </xsl:template>
    
    <xsl:template match="act:acte" >
        <acte>
            <xsl:value-of select="text()"/>
        </acte>
    </xsl:template>

</xsl:stylesheet>
