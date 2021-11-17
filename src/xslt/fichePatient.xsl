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
                    <xsl:value-of select="inf:patient/inf:nom"/>&#160;
                    <xsl:value-of select="inf:patient/inf:prénom"/>
                </h1>
                <p>
                    <xsl:value-of select="inf:patient/inf:sexe"/>
                    <br/>
                    <xsl:value-of select="inf:patient/inf:naissance"/>
                    <br/> 
                    <xsl:value-of select="inf:patient/inf:numéroSS"/>
                    <br/> 
                </p>
                <address>
                    <xsl:value-of select="concat(inf:patient/inf:adresse/inf:numéro,' ')"/>
                    <xsl:value-of select="inf:patient/inf:adresse/inf:rue"/>&#160;
                    <xsl:value-of select="inf:patient/inf:adresse/inf:codePostal"/>&#160;
                    <xsl:value-of select="inf:patient/inf:adresse/inf:ville"/>
                    <br/>
                </address>
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
                        <xsl:apply-templates select="inf:patient/inf:visite"/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    
    
    <xsl:template match="inf:visite">
        <tr>
            <td>
                <xsl:value-of select="@date"/>
            </td>
            <td>
                <ul>
                    <xsl:apply-templates select="inf:acte"/>
                </ul>
            </td>
            <td>
                <xsl:value-of select="inf:intervenant/inf:nom"/>
            </td>
        </tr>
    </xsl:template>
    
    <xsl:template match="inf:acte">
        <li>
            <xsl:value-of select="text()"/>
        </li>
    </xsl:template>
</xsl:stylesheet>
