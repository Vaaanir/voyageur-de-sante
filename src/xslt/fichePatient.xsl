<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : fichePatient.xsl
    Created on : 16 novembre 2021, 18:43
    Author     : zaettal
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:inf="http://www.ujf-grenoble.fr/l3miage/medical">
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title>fichePatient</title>
            </head>
            <body>
                <h1>
                    <!-- On affiche le nom prenom du patient &#160; pour ajouter un espace-->
                    <xsl:value-of select="inf:patient/inf:nom"/>&#160;
                    <xsl:value-of select="inf:patient/inf:prénom"/>
                </h1>
                <p>
                    <!-- on affiche le numéro de sécurité sociale la date de naissence et le sexe du patient-->
                    <xsl:value-of select="inf:patient/inf:sexe"/>
                    <br/>
                    <xsl:value-of select="inf:patient/inf:naissance"/>
                    <br/> 
                    <xsl:value-of select="inf:patient/inf:numéroSS"/>
                    <br/> 
                </p>
                <address>
                    <!-- on affiche l'adresse du patient-->
                    <xsl:value-of select="concat(inf:patient/inf:adresse/inf:numéro,' ')"/>
                    <xsl:value-of select="inf:patient/inf:adresse/inf:rue"/>&#160;
                    <xsl:value-of select="inf:patient/inf:adresse/inf:codePostal"/>&#160;
                    <xsl:value-of select="inf:patient/inf:adresse/inf:ville"/>
                    <br/>
                </address>
                <!-- on prépare le tableau des visites-->
                <table>
                    <thead>
                        <tr>
                            <th>
                                Date
                            </th>
                            <th>
                                Libellé
                            </th>
                            <th>
                                Intervenant
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- on affiche les visites du patient en faisent appel au template du type visite-->
                        <xsl:apply-templates select="inf:patient/inf:visite"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
    <!-- appelet lors de la transformation d'une visite-->
    <xsl:template match="inf:visite">
        <!-- comme on est dans un tableau on utilise les balises tr et td-->
        <tr>
            <td>
                <!-- on affiche la date de la visite-->
                <xsl:value-of select="@date"/>
            </td>
            <td>
                <!-- on crée une liste non ordonnée pour afficher tous les actes-->
                <ul>
                    <!-- on affiche tous les actes de la visite en faire appel au template du type acte-->
                    <xsl:apply-templates select="inf:acte"/>
                </ul>
            </td>
            <td>
                <!-- on affiche l'intervenant de la visite-->
                <xsl:value-of select="inf:intervenant/inf:nom"/>
            </td>
        </tr>
    </xsl:template>

    <!-- appelet lors de la transformation d'un acte-->
    <xsl:template match="inf:acte">
        <li>
            <!-- on affiche le libellé de l'acte-->
            <xsl:value-of select="text()"/>
        </li>
    </xsl:template>
</xsl:stylesheet>
