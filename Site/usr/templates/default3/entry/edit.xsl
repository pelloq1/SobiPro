<?xml version="1.0" encoding="UTF-8"?><!--
 @package: SobiPro Component for Joomla!

 @author
 Name: Sigrid Suski & Radek Suski, Sigsiu.NET GmbH
 Email: sobi[at]sigsiu.net
 Url: https://www.Sigsiu.NET

 @copyright Copyright (C) 2006 - 2015 Sigsiu.NET GmbH (https://www.sigsiu.net). All rights reserved.
 @license GNU/GPL Version 3
 This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3
 as published by the Free Software Foundation, and under the additional terms according section 7 of GPL v3.
 See http://www.gnu.org/licenses/gpl.html and https://www.sigsiu.net/licenses.

 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:php="http://php.net/xsl" exclude-result-prefixes="php">
	<xsl:output method="xml" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" encoding="UTF-8" />
	<xsl:include href="../common/topmenu.xsl" />
	<xsl:include href="../common/messages.xsl" />

	<xsl:template match="/entry_form">
		<div class="spEntryEdit">
			<div>
				<xsl:call-template name="topMenu">
					<xsl:with-param name="searchbox">false</xsl:with-param>
				</xsl:call-template>
			</div>
			<xsl:apply-templates select="messages" />

            <xsl:variable name="form-orientation">
                <xsl:value-of select="//config/form-class/@value" />
            </xsl:variable>
			<div class="form-{$form-orientation}">
				<xsl:for-each select="entry/fields/*">
					<xsl:if test="( name() != 'save_button' ) and ( name() != 'cancel_button' )">
						<xsl:variable name="fieldId" select="name(.)" />
						<xsl:if test="string-length( fee )">
							<div class="control-group payment-message">
								<div class="control-label">
	    							<div class="paybox">
	    							    <span>
    									    <input name="{$fieldId}Payment" id="{$fieldId}-payment" value="" type="checkbox" class="payment-box" />
                                        </span>
                                    </div>
								</div>
								<div class="controls">
									<div class="alert spAlert span10">
										<xsl:value-of select="fee_msg" /><xsl:text> </xsl:text>
										<xsl:value-of select="php:function( 'SobiPro::Txt', 'TP.PAYMENT_ADD' )" />
									</div>
								</div>
							</div>
						</xsl:if>
						<div class="control-group {@css-edit}" id="{$fieldId}-container">
                            <xsl:if test="label/@show = 1">
                                <label class="control-label" for="{$fieldId}-input-container">
                                    <xsl:choose>
                                        <xsl:when test="string-length( description ) and //config/help-position/@value = 'popup'">
                                            <a href="#" rel="popover" data-placement="top" data-content="{description}" data-original-title="{label}">
                                                <xsl:value-of select="label" />
                                            </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="label" />
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:if test="@required = 1 and //config/required-star/@value = 1">
                                        <sup><span class="star"><i class="icon-star"></i></span></sup>
                                    </xsl:if>
                                </label>
							</xsl:if>

							<xsl:variable name="colwidth">
								<xsl:choose>
									<xsl:when test="string-length( @width )">
										<xsl:value-of select="@width" />
									</xsl:when>
									<xsl:otherwise>10</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>

							<div class="controls" id="{$fieldId}-input-container">
								<div class="span{$colwidth}">
									<xsl:if test="string-length( @suffix )">
										<xsl:attribute name="class">span<xsl:value-of select="$colwidth" /> input-append</xsl:attribute>
									</xsl:if>
									<xsl:if test="string-length( description ) and //config/help-position/@value = 'above'">
										<div class="help-block">
											<xsl:value-of select="description" />
										</div>
									</xsl:if>
									<div>
										<xsl:choose>
											<xsl:when test="data/@escaped">
												<xsl:value-of select="data" disable-output-escaping="yes" />
											</xsl:when>
											<xsl:otherwise>
												<xsl:copy-of select="data/*" />
											</xsl:otherwise>
										</xsl:choose>
										<xsl:choose>
											<xsl:when test="string-length( @suffix )">
												<span class="add-on">
													<xsl:value-of select="@suffix" />
												</span>
											</xsl:when>
										</xsl:choose>
									</div>
									<div id="{$fieldId}-message" class="hide message-lightbulb"></div>
									<xsl:if test="string-length( description ) and //config/help-position/@value = 'below'">
										<div class="help-block">
											<xsl:value-of select="description" />
										</div>
									</xsl:if>
								</div>
                            </div>
						</div>
					</xsl:if>
				</xsl:for-each>
			</div>
            <xsl:if test="//config/required-star/@value = 1">
                <div class="required-message">
                    <sup><span class="star"><i class="icon-star"></i></span></sup>
                    <xsl:value-of select="php:function( 'SobiPro::Txt', 'ENTRY_REQUIRED_MESSAGE' )" />
                </div>
            </xsl:if>
            <div class="clearfix" />
			<div class="pull-right">
				<button class="btn sobipro-cancel" type="button">
					<xsl:value-of select="entry/fields/cancel_button/data/button" />
				</button>
				<button class="btn btn-primary btn-sigsiu sobipro-submit" type="button" data-loading-text="Loading...">
					<xsl:value-of select="entry/fields/save_button/data/input/@value" />
				</button>
			</div>
			<div class="clearfix" />
		</div>
		<input type="hidden" name="method" value="xhr" />
		<input type="hidden" name="format" value="raw" />
	</xsl:template>
</xsl:stylesheet>
