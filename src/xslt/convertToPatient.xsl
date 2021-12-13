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
        <inf:patient><!--  xmlns="http://www.ujf-grenoble.fr/l3miage/patient">-->
            <!--On place le nom du patient dans la balise nom-->
            <inf:nom>
                <xsl:value-of select="$patient/inf:nom"/>
            </inf:nom>
            <!--On place le prénom du patient dans la balise prenom-->
            <inf:prénom><xsl:value-of select="$patient/inf:prénom"/></inf:prénom>
            <!--On place l'sexe du patient dans la balise sexe-->
            <inf:sexe><xsl:value-of select="$patient/inf:sexe"/></inf:sexe>
            <!--On place la date de naissance du patient dans la balise naissance-->
            <inf:naissance><xsl:value-of select="$patient/inf:naissance"/></inf:naissance>
            <!--On place le numéro de sécurité social dans la balise numéroSS-->
            <inf:numéroSS><xsl:value-of select="$patient/inf:numéro"/></inf:numéroSS>
            <!--On indique l'adresse du patient-->
            <inf:adresse>
                <inf:numéro>
                    <xsl:value-of select="$patient/inf:adresse/inf:numéro"/>
                </inf:numéro>
                <inf:rue>
                    <xsl:value-of select="$patient/inf:adresse/inf:rue"/>
                </inf:rue>
                <inf:codePostal>
                    <xsl:value-of select="$patient/inf:adresse/inf:codePostal"/>
                </inf:codePostal>
                <inf:ville>
                    <xsl:value-of select="$patient/inf:adresse/inf:ville"/>
                </inf:ville>
            </inf:adresse>
            <!-- on récupère toutes les visites du patient grace au modèles visites-->
            <xsl:apply-templates select="$patient/inf:visite" />
        </inf:patient>
    </xsl:template>

    <!-- template pour les visites-->
    <xsl:template match="inf:visite">
        <!-- création de la variable intervenant qui contient l"id de l'intervenant-->
        <xsl:variable name="intervenant" select="@intervenant"/>
        <inf:visite>
            <xsl:attribute name="date">
                <xsl:value-of select="@date"/>
            </xsl:attribute>
            <inf:intervenant>
                <inf:nom>
                    <!-- pour simplifier la selection xpath on utilise la variable intervenant-->
                    <xsl:value-of select="//inf:infirmier[@id=$intervenant]/inf:nom"/>
                </inf:nom>
                <inf:prénom>
                    <!-- pour simplifier la selection xpath on utilise la variable intervenant-->
                    <xsl:value-of select="//inf:infirmier[@id=$intervenant]/inf:prénom"/>
                </inf:prénom>
            </inf:intervenant>
            <xsl:variable name="ide" select="inf:acte/@id"/>
            <xsl:apply-templates select="$actes/act:actes/act:acte[@id=$ide]"/>
        </inf:visite>
    </xsl:template>

    <!-- template pour les actes-->
    <xsl:template match="act:acte" >
        <inf:acte>
            <xsl:value-of select="text()"/>
        </inf:acte>
    </xsl:template>

</xsl:stylesheet>
