<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:DTSout_CU="urn:customs.ru:Information:CustomsDocuments:DTSout_CU:5.17.0" xmlns:catESAD_cu="urn:customs.ru:CUESADCommonAggregateTypesCust:5.17.0" xmlns:cat_EDTS_cu="urn:customs.ru:CUESADDTSCommonAggregateTypes:5.17.0" xmlns:cat_ru="urn:customs.ru:CommonAggregateTypes:5.10.0" xmlns:RUScat_ru="urn:customs.ru:RUSCommonAggregateTypes:5.16.0" xmlns:RUDECLcat="urn:customs.ru:RUDeclCommonAggregateTypesCust:5.17.0" xmlns:cltESAD_cu="urn:customs.ru:CUESADCommonLeafTypes:5.17.0" xmlns:clt_ru="urn:customs.ru:CommonLeafTypes:5.10.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="html" version="1.0"/>
	<!-- Версия 1.0 от 25.11.2008.  -->
	<!-- Для  xmlns=urn:customs.ru:Information:CustomsDocuments:DTSout_CU:4.7.0  -->
	<xsl:output encoding="UTF-8" indent="yes" method="html" version="1.0"/>
	<xsl:variable name="eng">
		ABCDIFG
    </xsl:variable>
	<xsl:variable name="rus">
		АБВГДЕЖ
    </xsl:variable>
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template name="get_xpath">
		<xsl:param name="node" select="."/>
		<xsl:variable name="xpath">
			<xsl:for-each select="$node/ancestor-or-self::*">
				<xsl:variable name="name">
					<xsl:value-of select="name()"/>
				</xsl:variable>
				<xsl:variable name="pos">
					<xsl:value-of select="count(node()/parent::*/preceding-sibling::*[name()=$name])"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="position()=last()">
						<xsl:value-of select="concat($name,'[',$pos,']')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat($name,'[',$pos,']','/')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
		</xsl:variable>
		<xsl:value-of select="$xpath"/>
	</xsl:template>
	<xsl:template match="//*[local-name()='DTSout_CU']//*" priority="-1">
		<xsl:variable name="xpath">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="current()"/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath}">
			<xsl:apply-templates/>
		</element>
	</xsl:template>
	<xsl:template match="*" mode="russian_date">
		<xsl:variable name="xpath_date">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_date}">
			<xsl:call-template name="russian_date">
				<xsl:with-param name="dateIn" select="."/>
			</xsl:call-template>
		</element>
	</xsl:template>
	<xsl:template match="*" mode="russian_date_gtd">
		<xsl:variable name="xpath_date">
			<xsl:call-template name="get_xpath">
				<xsl:with-param name="node" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<element xml_node="{$xpath_date}">
			<xsl:call-template name="russian_date_gtd">
				<xsl:with-param name="dateIn" select="."/>
			</xsl:call-template>
		</element>
	</xsl:template>
	<xsl:template match="DTSout_CU:DTSout_CU">
		<html>
			<head>
				<META CONTENT="text/html; charset=UTF-8" HTTP-EQUIV="Content-Type"/>
				<title>Декларация таможенной стоимости</title>
				<style type="text/css">
              body {
              background: #cccccc;
              }

              div.page {
              width: 210mm;
              height: 297mm;
              margin-top: 6pt;
              margin-bottom: 6pt;
              padding:	10mm;
              padding-left:	20mm;
              background: #ffffff;
              border: solid 1pt #000000;
              page-break-before: always;
              }

              div.page.nobreak {
              page-break-before: avoid;
              }

              /*Стиль для удаления чёрной границы вокруг нарисованной "страницы" при печати*/
              @media print {div.page {border: none; margin: 0; padding: 0;}}

              div.goods {
              background: #ffffff;
              }

              .bordered {
              border: solid 1pt #000000;
              padding-top:4pt;
              padding-bottom:4pt;
              font-family: Arial;
              font-size: 9pt;
              font-weight: bold;
              }

              .underlined {
              border-bottom: solid 0.8pt #000000;
              }

              p.NumberDate {
              font-weight: bold;
              }

              .graph {
              font-family: Arial;
              font-size: 7pt;
              }

              .graphBold {
              font-family: Arial;
              font-size: 7pt;
              font-weight: bold;
              }

              td {
              font-family:Courier;
              }

              .graphMain {
              font-family: Arial;
              font-size: 9pt;
              font-weight: bold;
              }

              .graphNo {
              font-size: 9pt;
              font-weight: bold;
              }					
              </style>
			</head>
			<body>
				<xsl:choose>
					<xsl:when test="DTSout_CU:FormDTS=1">
						<div class="page nobreak">
							<table cellpadding="5" cellspacing="0" style="width:100%; border:solid 0pt #000000;">
								<tbody>
									<tr>
										<td align="right" class="graphNo">ДЕКЛАРАЦИЯ ТАМОЖЕННОЙ СТОИМОСТИ</td>
									</tr>
									<tr>
										<td align="right" class="graph">Форма ДТС-1</td>
									</tr>
								</tbody>
							</table>
							<table cellpadding="5" cellspacing="0" style="width:100%;border:solid 0.8pt #000000;">
								<tbody>
									<tr>
										<td class="graph" style="width:100mm;border-left:solid 0.8pt #000000;border-top:solid 0.8pt #000000;">
											<span class="graphNo">1 </span>
											<span class="graph">Продавец</span>
											<br/>
											<xsl:apply-templates mode="org" select="DTSout_CU:DTSoutSeller"/>
										</td>
										<td class="graph" rowspan="3" style="width:80mm;border-left:solid 2pt #000000;border-top:solid 1.5pt #000000;border-right:solid 0.8pt #000000;border-bottom:solid 1.5pt #000000;" valign="top">
											<span class="graph">ДЛЯ ОТМЕТОК ТАМОЖЕННОГО ОРГАНА</span>
											<br/>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:GTDNumber"/>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:100mm;border-left:solid 0.8pt #000000;border-top:solid 0.8pt #000000;">
											<span class="graphNo">2 </span>
											<span class="graph">(а) Покупатель</span>
											<br/>
											<xsl:apply-templates mode="org" select="DTSout_CU:DTSoutBuyer"/>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:100mm;border-left:solid 0.8pt #000000;border-top:solid 0.8pt #000000;">
											<table cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="left" width="50%">
														<span class="graph">(б) Декларант</span>
													</td>
													<td align="right" class="graph" width="50%">
														<xsl:if test="DTSout_CU:DTSoutDeclarant/RUDECLcat:AEORegistryIdDetails/catESAD_cu:DocId">
															<xsl:text>№ </xsl:text>
															<xsl:apply-templates select="DTSout_CU:DTSoutDeclarant/RUDECLcat:AEORegistryIdDetails/catESAD_cu:DocId"/>
														</xsl:if>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:100mm;border-left:solid 0.8pt #000000;">
											<xsl:apply-templates mode="org" select="DTSout_CU:DTSoutDeclarant"/>
										</td>
										<td class="graph" style="width:80mm;border:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">3 </span>
											<span class="graph">Условия поставки</span>
											<br/>
											<xsl:for-each select="DTSout_CU:DeliveryTerms">
												<xsl:apply-templates select="cat_ru:DeliveryTermsStringCode"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:for-each select="cat_ru:DeliveryPlace">
													<xsl:apply-templates select="."/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:for-each>
												<xsl:for-each select="cat_ru:DeliveryTermsRBCode">
													<xsl:apply-templates select="."/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:for-each>
												<xsl:for-each select="cat_ru:TransferPlace">
													<xsl:apply-templates select="."/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:for-each>
											</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td class="graphBold" rowspan="2" style="width:100mm;border-left:solid 1.5pt #000000;border-top:solid 2pt #000000;border-right:solid 1.5pt #000000;border-bottom:solid 1.5pt #000000;">
											<xsl:text>ВАЖНАЯ ИНФОРМАЦИЯ</xsl:text>
											<br/>
											<xsl:text>Декларант несет ответственность в соответствии с законодательством </xsl:text>
											<br/>
											<xsl:text>государств - членов Евразийского экономического союза за неисполнение </xsl:text>
											<br/>
											<xsl:text>обязанностей, предусмотренных пунктом 2 статьи 84 Таможенного кодекса </xsl:text>
											<br/>
											<xsl:text>Евразийского экономического союза, за заявление в таможенной декларации </xsl:text>
											<br/>
											<xsl:text>недостоверных сведений, а также за представление таможенному </xsl:text>
											<br/>
											<xsl:text>представителю недействительных документов, в том числе поддельных</xsl:text>
											<br/>
											<xsl:text>и (или) содержащих заведомо недостоверные (ложные) сведения</xsl:text>
										</td>
										<td class="graph" style="width:80mm;border-left:solid 0.8pt #000000;border-right:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">4 </span>
											<span class="graph">Номер и дата счета (счетов)</span>
											<br/>
											<xsl:for-each select="DTSout_CU:DTSInvoiceDocuments">
												<xsl:if test="cat_EDTS_cu:PositionNumber = '4'">
													<xsl:apply-templates select="cat_EDTS_cu:PresentedDocumentModeCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													№ <xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentName"/>
													<br/>
												</xsl:if>
											</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:80mm;border-left:solid 0.8pt #000000;border-right:solid 0.8pt #000000;border-top:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">5 </span>
											<span class="graph">Номер и дата контракта (договора, соглашения)</span>
											<br/>
											<xsl:for-each select="DTSout_CU:DTSInvoiceDocuments">
												<xsl:if test="cat_EDTS_cu:PositionNumber = '5'">
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_EDTS_cu:PresentedDocumentModeCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentName"/>
													<br/>
												</xsl:if>
											</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td class="graph" colspan="2" style="width:180mm;border:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">6 </span>
											<span class="graph">Номера и даты документов, имеющих отношение к сведениям, указанным в графах 7 - 9</span>
											<br/>
											<xsl:for-each select="DTSout_CU:DTSInvoiceDocuments">
												<xsl:if test="cat_EDTS_cu:PositionNumber = '6'">
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_EDTS_cu:PresentedDocumentModeCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentName"/>
													<br/>
												</xsl:if>
											</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td class="graph" colspan="2" style="width:180mm;border:solid 0.8pt #000000;" valign="top">
											<table cellpadding="0" cellspacing="0" style="width:100%;">
												<tbody>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<span class="graphNo">7 </span>
															<span class="graph">(а) Имеется ли ВЗАИМОСВЯЗЬ между продавцом и покупателем в значении, указанном в статье 37<br/>Таможенного кодекса Евразийского экономичесого союза?*</span>
														</td>
														<td class="graph" colspan="4" style="width:40mm;" valign="top">
															<table cellpadding="0" cellspacing="0" style="width:100%;">
																<tbody>
																	<tr>
																		<td align="center" class="graph" style="width:30mm;border-left:solid 0.8pt #000000;border-bottom:solid 0.8pt #000000;" valign="top">
																			<span class="graphBold">Верное отметить</span>
																		</td>
																		<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
																			<span class="graphBold">х</span>
																		</td>
																		<td align="center" class="graph" style="width:5mm;border-bottom:solid 0.8pt #000000;">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<xsl:variable name="xpath_Column7A">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7A"/>
															</xsl:call-template>
														</xsl:variable>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column7A}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7A)=1) or (DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7A='t')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">ДА</span>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column7A}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7A)=0) or (DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7A='f')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">НЕТ</span>
														</td>
													</tr>
													<tr>
														<td colspan="5" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(б) Оказала ли взаимосвязь между продавцом и покупателем влияние на цену, </span>
														</td>
														<xsl:variable name="xpath_Column7B">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7B"/>
															</xsl:call-template>
														</xsl:variable>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column7B}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7B)=1) or (DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7B='t')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">ДА</span>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column7B}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7B)=0) or (DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7B='f')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">НЕТ</span>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">фактически уплаченную или подлежащую уплате за ввозимые товары?</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" colspan="5" valign="top">
															<span class="graph">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</span>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(в) Стоимость сделки с ввозимыми товарами близка к одной из возможных проверочных величин </span>
														</td>
														<xsl:variable name="xpath_Column7C">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7C"/>
															</xsl:call-template>
														</xsl:variable>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column7C}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7C)=1) or (DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7C='t')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">ДА</span>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column7C}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7C)=0) or (DTSout_CU:DTSBuyerSellerDependence/cat_EDTS_cu:Column7C='f')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">НЕТ</span>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">указанных в пункте 5 статьи 39 Таможенного кодекса Евразийского экономического союза?</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" colspan="5" style="width:180mm;border-top:solid 0.8pt #000000;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<span class="graphNo">8 </span>
															<span class="graph">(а) Имеются ли ОГРАНИЧЕНИЯ в отношении прав покупателя на пользование и распоряжение ввозимыми </span>
														</td>
														<xsl:variable name="xpath_Column8A">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8A"/>
															</xsl:call-template>
														</xsl:variable>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column8A}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8A)=1) or (DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8A='t')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">ДА</span>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column8A}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8A)=0) or (DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8A='f')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">НЕТ</span>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">товарами, за исключением ограничений, которые:</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">- ограничивают географический регион, в котором товары могут быть перепроданы;</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">- существенно не влияют на стоимость ввозимых товаров.</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">- установлены актами органов Евразийского экономического союза или законодательством государств - членов<br>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>Евразийского экономического союза </br>
															</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" colspan="5" style="width:180mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(б) Зависит ли продажа ввозимых товаров или их цена от соблюдения УСЛОВИЙ или ОБЯЗАТЕЛЬСТВ,</span>
														</td>
														<xsl:variable name="xpath_Column8B">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8B"/>
															</xsl:call-template>
														</xsl:variable>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column8B}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8B)=1) or (DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8B='t')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">ДА</span>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column8B}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8B)=0) or (DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:Column8B='f')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">НЕТ</span>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">оказывающих влияние на цену ввозимых товаров?</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<xsl:if test="DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:limitationDescription">
														<tr>
															<td class="graph" style="width:140mm;" valign="top">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:apply-templates select="DTSout_CU:DTSSellingLimitation/cat_EDTS_cu:limitationDescription"/>
															</td>
															<td align="center" class="graph" style="width:5mm;" valign="middle">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</td>
															<td class="graph" style="width:15mm;">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</td>
															<td align="center" class="graph" style="width:5mm;" valign="middle">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</td>
															<td class="graph" style="width:15mm;">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</td>
														</tr>
													</xsl:if>
													<tr>
														<td class="graph" colspan="5" style="width:180mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">Если влияние таких условий или обязательств на цену товаров может быть количественно определено, <br>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>сумма стоимостной оценки таких условий или обязательств указывается в разделе "б" графы 11</br>
															</span>
														</td>
													</tr>
													<tr>
														<td class="graph" colspan="5" style="width:180mm;border-top:solid 0.8pt #000000;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<span class="graphNo">9 </span>
															<span class="graph">(а) Предусмотрены ли ЛИЦЕНЗИОННЫЕ и иные подобные ПЛАТЕЖИ за использование объектов</span>
														</td>
														<xsl:variable name="xpath_Column9A">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9A"/>
															</xsl:call-template>
														</xsl:variable>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column9A}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9A)=1) or (DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9A='t')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">ДА</span>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column9A}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9A)=0) or (DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9A='f')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">НЕТ</span>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">ИНТЕЛЛЕКТУАЛЬНОЙ СОБСТВЕННОСТИ, которые относятся к ввозимым товарам и которые прямо  <br>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>или косвенно произвел или должен произвести покупатель в качестве условия продажи ввозимых товаров</br>
																<br>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>для вывоза на таможенную территорию Евразийского экономического союза?</br>
															</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" colspan="5" style="width:180mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(б) Зависит ли продажа от соблюдения условия, в соответствии с которым ЧАСТЬ ДОХОДА (ВЫРУЧКИ),</span>
														</td>
														<xsl:variable name="xpath_Column9B">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9B"/>
															</xsl:call-template>
														</xsl:variable>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column9B}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9B)=1) or (DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9B='t')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">ДА</span>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<element xml_node="{$xpath_Column9B}">
																<xsl:choose>
																	<xsl:when test="(number(DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9B)=0) or (DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:Column9B='f')">
																		<span class="graphBold">х</span>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	</xsl:otherwise>
																</xsl:choose>
															</element>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">НЕТ</span>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:140mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">полученного в результате ПОСЛЕДУЮЩЕЙ ПРОДАЖИ, РАСПОРЯЖЕНИЯ иным способом или ИСПОЛЬЗОВАНИЯ <br>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>ввозимых товаров, прямо или косвеннго причитается продавцу?</br>
															</span>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;" valign="middle">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td class="graph" style="width:15mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" colspan="5" style="width:180mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">В случае ответа "ДА" на вопросы в разделах "а" и (или) "б" в графах 15 и 16 указываются соответствующие величины</span>
															<xsl:if test="DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:PaymentDescription">
																<br/>
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:apply-templates select="DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:PaymentDescription"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:PaymentConditionDescription">
																<br/>
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:for-each select="DTSout_CU:DTSAdditionalPayments/cat_EDTS_cu:PaymentConditionDescription">
																	<xsl:apply-templates select="."/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:for-each>
															</xsl:if>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<td class="graph" rowspan="2" style="width:100mm;border-left:solid 0.8pt #000000;border-right:solid 0.8pt #000000;">
											<xsl:text>* Лица являются взаимосвязанными исключительно  в том случае, если они:</xsl:text>
											<br/>
											<xsl:text>(а) является сотрудниками или директорами (руководителями) организаций друг друга;</xsl:text>
											<br/>
											<xsl:text>(б) являются юридически признанными деловыми партнерами, т.е. связаны договорными отношениями, действуют в целях извлечения прибыли и совместно несут расходы и убытки, связанные с осуществлением совместной деятельности;</xsl:text>
											<br/>
											<xsl:text>(в) являются работодателем и работником;</xsl:text>
											<br/>
											<xsl:text>(г) какое-либо лицо прямо или косвенно владеет, контролирует или является держателем 5 или более процентов выпущенных в обращение голосующих акций обоих из них;</xsl:text>
											<br/>
											<xsl:text>(д) одно из них прямо или косвенно контролирует другое;</xsl:text>
											<br/>
											<xsl:text>(е) оба они прямо или косвенно контролируются третьим лицом;</xsl:text>
											<br/>
											<xsl:text>(ж) вместе они оба прямо или косвенно контролируют третье лицо;</xsl:text>
											<br/>
											<xsl:text>(з) являются родственниками или членами одной семьи.</xsl:text>
											<br/>
											<xsl:text>Факт взаимосвязи сам по себе не должен являться основанием для признания стоимости сделки неприемлимой для определения таможенной стоимости товаров (пункт 4 статьи 39 Таможенного кодекса Евразийского экономического союза).</xsl:text>
										</td>
										<td class="graph" valign="top" style="width:80mm;border-left:solid 0.8pt #000000;">
											<span class="graphNo">10 </span>
											<span class="graph">(а) Количество добавочных листов</span>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:AdditionalSheetNumber"/>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:80mm;border-left:solid 0.8pt #000000;border-right:solid 0.8pt #000000;" valign="top">
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<span class="graph">(б) Сведения о лице, заполнившем ДТС</span>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="russian_date"/>
											<xsl:if test="cat_EDTS_cu:RegNumberDoc"> исх. номер 
										<xsl:apply-templates select="cat_EDTS_cu:RegNumberDoc"/>
											</xsl:if>
											<xsl:if test="cat_EDTS_cu:SecurityLabelCode">код защитной наклейки
										<xsl:apply-templates select="cat_EDTS_cu:SecurityLabelCode"/>
											</xsl:if>
											<br/>
											<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:QualificationCertificate">Номер квалификационного аттестата специалиста по таможенному оформлению
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:QualificationCertificate"/>
											</xsl:if>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonSurname"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonName"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonMiddleName"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SignatoryPersonIdentityDetails">
												<xsl:for-each select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SignatoryPersonIdentityDetails">
													<xsl:apply-templates select="RUScat_ru:CountryCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:IdentityCardName"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:IdentityCardSeries"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:IdentityCardNumber"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:IdentityCardDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:OrganizationName"/>
												</xsl:for-each>
											</xsl:if>
											<xsl:text> </xsl:text>
											<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:CommunicationDetails">
												<span class="normal">
													<xsl:for-each select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:CommunicationDetails">
														<xsl:call-template name="CommunicationDetails"/>
													</xsl:for-each>
												</span>
											</xsl:if>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonPost"/>
											<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails">
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentName">
													<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentName"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:if>
												<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentNumber"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentDate">
													<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:if>
												<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/RUScat_ru:DocValidityDate" mode="russian_date"/>
											</xsl:if>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<xsl:variable name="HasCurrencyDate">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:CurrencyDate">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="CurrencyDate">
							<xsl:choose>
								<xsl:when test="$HasCurrencyDate">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost[DTSout_CU:CurrencyDate]/DTSout_CU:CurrencyDate"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneCurrencyDate">
							<xsl:choose>
								<xsl:when test="$HasCurrencyDate">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost[DTSout_CU:CurrencyDate != $CurrencyDate] or DTSout_CU:DTSout_CUGoodsCustomsCost[not(DTSout_CU:CurrencyDate)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="HasDealCode">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="HasDealDate">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyDate">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DealCode">
							<xsl:choose>
								<xsl:when test="$HasDealCode">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:DealCurrencyCode]/cat_EDTS_cu:DealCurrencyCode"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DealDate">
							<xsl:choose>
								<xsl:when test="$HasDealDate">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:DealCurrencyDate]/cat_EDTS_cu:DealCurrencyDate"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneDealCode">
							<xsl:choose>
								<xsl:when test="$HasDealCode">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:DealCurrencyCode != $DealCode] or DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[not(cat_EDTS_cu:DealCurrencyCode)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneDealDate">
							<xsl:choose>
								<xsl:when test="$HasDealDate">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:DealCurrencyDate != $DealDate] or DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[not(cat_EDTS_cu:DealCurrencyDate)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="HasDealIndirectCode">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="HasDealIndirectDate">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyDate">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DealCodeIndirect">
							<xsl:choose>
								<xsl:when test="$HasDealIndirectCode">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:IndirectCurrencyCode]/cat_EDTS_cu:IndirectCurrencyCode"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DealDateIndirect">
							<xsl:choose>
								<xsl:when test="$HasDealIndirectDate">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:IndirectCurrencyDate]/cat_EDTS_cu:IndirectCurrencyDate"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneDealIndirectCode">
							<xsl:choose>
								<xsl:when test="$HasDealIndirectCode">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:IndirectCurrencyCode != $DealCodeIndirect] or DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[not(cat_EDTS_cu:IndirectCurrencyCode)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneDealIndirectDate">
							<xsl:choose>
								<xsl:when test="$HasDealIndirectDate">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:IndirectCurrencyDate != $DealDateIndirect] or DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[not(cat_EDTS_cu:IndirectCurrencyDate)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DTS" select="current()"/>
						<xsl:for-each select="DTSout_CU:DTSout_CUGoodsCustomsCost[(position()) mod 3 = 1]">
							<!--<xsl:for-each select="DTSout_CU:DTSout_CUGoodsCustomsCost">-->
							<div class="page">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tbody>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<span class="graph">Форма ДТС-1</span>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Лист №  </span>
												<xsl:apply-templates select="DTSout_CU:SheetNumber"/>
											</td>
										</tr>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Метод 1</span>
											</td>
										</tr>
									</tbody>
								</table>
								<table cellpadding="5" cellspacing="0" style="width:100%;border:solid 0.8pt #000000;">
									<xsl:variable name="column2" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[1]"/>
									<xsl:variable name="column3" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[2]"/>
									<tbody>
										<tr>
											<td align="center" class="graph" colspan="2" rowspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ДЛЯ ОТМЕТОК ТАМОЖЕННОГО ОРГАНА</span>
												<br/>
												<br/>
												<xsl:apply-templates select="../DTSout_CU:GTDNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column2/DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column3/DTSout_CU:GTDGoodsNumber"/>
											</td>
										</tr>
										<tr>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="DTSout_CU:GoodsTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="$column2/DTSout_CU:GoodsTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="$column3/DTSout_CU:GoodsTNVEDCode"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="4" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ОСНОВА ДЛЯ РАСЧЕТА</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">11 </span>
												<span class="graph">(а) цена, фактически уплаченная или подлежащая уплате за товары в ВАЛЮТЕ СЧЕТА </span>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:if test="($HasDealDate and ($IsOneDealDate=1)) and ($HasDealCode and ($IsOneDealCode=1))">
													<xsl:text>(курс пересчета</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<u>
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode"/>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate">/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate"/>
														</xsl:if>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity"/> ед.
												</xsl:if>
													</u>
											)</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealNationalAmount"/>
												<xsl:if test="$IsOneDealDate=0 or ($IsOneDealCode=0)">
													<xsl:if test="DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode"/>
															<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate">/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity">
																<xsl:text> </xsl:text>/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity"/> ед.
												</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealNationalAmount"/>
												<xsl:if test="$IsOneDealDate=0 or ($IsOneDealCode=0)">
													<xsl:text> (курс пересчета </xsl:text>
													<u>
														<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode"/>
														<xsl:if test="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate">/<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate"/>
														</xsl:if>
														<xsl:if test="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity"/> ед.
												</xsl:if>
													</u>
													<xsl:text>)</xsl:text>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealNationalAmount"/>
												<xsl:if test="$IsOneDealDate=0 or ($IsOneDealCode=0)">
													<xsl:text> (курс пересчета </xsl:text>
													<u>
														<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode"/>
														<xsl:if test="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate">/<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate"/>
														</xsl:if>
														<xsl:if test="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity"/> ед.
												</xsl:if>
													</u>
													<xsl:text>)</xsl:text>
												</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) косвенные платежи (условия или обязательства) </span>
												<br>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</br>
												<xsl:text> </xsl:text>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:if test="($HasDealIndirectDate and ($IsOneDealIndirectDate=1)) and ($HasDealIndirectCode and ($IsOneDealIndirectCode=1))">
													<xsl:text>(курс пересчета</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<u>
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode"/>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate">/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate"/>
														</xsl:if>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity"/> ед.
												</xsl:if>
													</u>
											)</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectNationalPayment"/>
												<xsl:if test="$IsOneDealIndirectDate=0 or ($IsOneDealIndirectCode=0)">
													<br/>
													<xsl:text> (курс пересчета </xsl:text>
													<u>
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode"/>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate">/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate"/>
														</xsl:if>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity"/> ед.
												</xsl:if>
													</u>
													<xsl:text>)</xsl:text>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectNationalPayment"/>
												<xsl:if test="$IsOneDealIndirectDate=0 or ($IsOneDealIndirectCode=0)">
													<xsl:if test="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode"/>
															<xsl:if test="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate">/<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity">
																<xsl:text> </xsl:text>/<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity"/> ед.
												</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectNationalPayment"/>
												<xsl:if test="$IsOneDealIndirectDate=0 or ($IsOneDealIndirectCode=0)">
													<xsl:if test="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode"/>
															<xsl:if test="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate">/<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity">
																<xsl:text> </xsl:text>/<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity"/> ед.
												</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">12 </span>
												<span class="graph">Итого пр разделам "а" и "б" графы 11 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:BasisNationalAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:BasisNationalAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:BasisNationalAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="12" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ДОПОЛНИ- ТЕЛЬНЫЕ НАЧИСЛЕНИЯ: расходы в национальной валюте, которые не включены в графу 12*</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">13 </span>
												<span class="graph">Расходы, осуществленные покупателем на:</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) вознаграждения агенту (посреднику), брокеру за исключением вознаграждений за закупку ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:AgentBonus"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:AgentBonus"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:AgentBonus"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) тару и упаковку, в том числе стоимость упаковочных материалов и работ по упаковке</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:PackageExpenses"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:PackageExpenses"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:PackageExpenses"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">14 </span>
												<span class="graph">Соответствующим образом распределенная стоимость следующих товаров и услуг, прямо или косвенно предоставленных покупателем бесплатно или сниженной цене для использования в связи с  производством и продажей  ввозимых товаров для вывоза на единую таможенную территорию Евразийского экономичесого союза, в размере, не включенном в цену, фактически уплаченную или подлежащую уплате:</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) сырье, материалы, детали, полуфабрикаты и иные товары, из которых произведены (состоят) ввозимые товары</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:StoreCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:StoreCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:StoreCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) инструменты, штампы, формы и иные подобные товары, использованные при производстве ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(в) материалы, израсходованные при производстве ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:WorkingStockCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:WorkingStockCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:WorkingStockCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(г) проектирование, разработка, инженерная, конструкторская работа, художественное оформление, дизайн, эскизы и чертежи, выполненные вне таможенной территории Евразийского экономического союза и необходимые для производства ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:DesignPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:DesignPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:DesignPayment"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">15 </span>
												<span class="graph">Лицензионные и иные подобные платежи за использование объектов интеллектуальной собственности</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:IntellectualPropertyPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:IntellectualPropertyPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:IntellectualPropertyPayment"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">16 </span>
												<span class="graph">Часть дохода (выручки), полученного в результате последующей продажи, распоряжения иным способом или использования ввозимых товаров, которая прямо или косвенно причитается продавцу</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:SellerIncome"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:SellerIncome"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:SellerIncome"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">17 </span>
												<span class="graph">Расходы на перевозку (транспортировку) ввозимых товаров 
											</span>
												<xsl:text>до </xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<u>
													<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:BorderPlace"/>
												</u>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">18 </span>
												<span class="graph">Расходы на погрузку, разгрузку или перегрузку ввозимых и проведение иных операций, связанных с их перевозкой (транспортировкой) 
											</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:LoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:LoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:LoadCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">19 </span>
												<span class="graph">Расходы на страхование в связи с операциями, указанными в графах 17 и 18</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:InsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:InsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:InsuranceCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">20 </span>
												<span class="graph">Итого по графам 13-19 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:TotalAdditionalSum"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:TotalAdditionalSum"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:TotalAdditionalSum"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="4" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ВЫЧЕТЫ: расходы в национальной валюте, которые включены в графу 12*</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">21 </span>
												<span class="graph">Расходы на строительство, возведение, сборку, монтаж, обслуживание, или оказание технического содействия, производимые после ввоза товаров на единую таможенную территорию Евразийского экономического союза</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:BuildingAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:BuildingAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:BuildingAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">22 </span>
												<span class="graph">Расходы на перевозку (транспортировку) ввозимых товаров по таможенной территории Евразийского экономического союза</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">23 </span>
												<span class="graph">Сумма пошлин, налогов и сборов, уплачиваемых в связи с ввозом товаров на таможенную территорию Евразийского экономического союза или продажей товаров на такой таможенной территории</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">24 </span>
												<span class="graph">Итого по графам 21-23 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">25 </span>
												<span class="graph">Таможенная стоимость ввозимых товаров (12 + 20 - 24)</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="bottom">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) в ДОЛЛАРАХ США 
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="$HasCurrencyDate and ($IsOneCurrencyDate=1)">
														<xsl:text>(курс пересчета</xsl:text>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template>едн.
															</xsl:if>
														</u>
											)</xsl:if>
												</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column2/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column2/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column3/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column3/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="5" style="width:180mm;border:solid 0.8pt #000000;" valign="top">
												<table cellpadding="0" cellspacing="0" style="width:100%;">
													<tbody>
														<tr>
															<td class="graph" colspan="3" style="width:180mm;" valign="top">
																<xsl:text>* Если сумма оплачена в иностранной валюте, указывается сумма в иностранной валюте и курс пересчета по каждому товару и графе.</xsl:text>
															</td>
														</tr>
														<tr>
															<td class="graph" style="width:80mm;" valign="top">
																<span class="graph">Порядковый номер товара в ДТС-1 и номер графы ДТС-1</span>
															</td>
															<td class="graph" style="width:40mm;" valign="top">
																<span class="graph">Буквнный код валюты, сумма</span>
															</td>
															<td class="graph" style="width:40mm;" valign="top">
																<span class="graph">Курс пересчета</span>
															</td>
														</tr>
														<xsl:for-each select="DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" align="left" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
														<xsl:for-each select="$column2/DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="$column2/DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
														<xsl:for-each select="$column3/DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="$column3/DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
													</tbody>
												</table>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дополнительные данные</span>
												<br/>
												<xsl:variable name="GTDGoodsNumber1">
													<xsl:apply-templates select="DTSout_CU:GTDGoodsNumber"/>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber2">
													<xsl:choose>
														<xsl:when test="$column2">
															<xsl:value-of select="$column2/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber3">
													<xsl:choose>
														<xsl:when test="$column3">
															<xsl:value-of select="$column3/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:for-each select="DTSout_CU:AdditionalData">
													<br/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
													<xsl:if test="cat_EDTS_cu:PositionNumber">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
														<xsl:text> / </xsl:text>
														<xsl:variable name="xpath_KindCode">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
															</xsl:call-template>
														</xsl:variable>
														<element xml_node="{$xpath_KindCode}">
															<xsl:choose>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																	<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																	<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																	<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																	<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																</xsl:when>
															</xsl:choose>
														</element>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
													</xsl:if>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="cat_EDTS_cu:AdditionalInformation">
														<xsl:text>/ </xsl:text>
														<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
															<xsl:apply-templates select="."/>
															<xsl:if test="position()!=last()">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</xsl:if>
														</xsl:for-each>
													</xsl:if>
												</xsl:for-each>
												<xsl:if test="$column2">
													<xsl:for-each select="$column2/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode1">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode1}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="$column3">
													<xsl:for-each select="$column3/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode2">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode2}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="../DTSout_CU:AdditionalData">
													<br/>
													<br>
														<xsl:text>Дополнительная информация, относящаяся ко всем товарам:</xsl:text>
													</br>
													<xsl:for-each select="../DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:variable name="xpath_KindCode3">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode3}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
											</td>
											<td class="graph" colspan="3" style="width:70mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дата, подпись, печать</span>
												<br/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="russian_date"/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonSurname"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonMiddleName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonPost"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="DTSout_CU:FormDTS=2">
						<div class="page nobreak">
							<table cellpadding="5" cellspacing="0" style="width:100%;border:solid 0pt #000000;">
								<tbody>
									<tr>
										<td class="graph" rowspan="2" style="width:100mm;"/>
										<td align="right" class="graphNo" style="width:80mm;">ДЕКЛАРАЦИЯ ТАМОЖЕННОЙ СТОИМОСТИ</td>
									</tr>
									<tr>
										<td align="right" class="graph" style="width:80mm;">Форма ДТС-2</td>
									</tr>
								</tbody>
							</table>
							<table cellpadding="5" cellspacing="0" style="width:100%;border:solid 0.8pt #000000;">
								<tbody>
									<tr>
										<td class="graph" style="width:100mm;border-left:solid 0.8pt #000000;border-top:solid 0.8pt #000000;">
											<span class="graphNo">1 </span>
											<span class="graph">Продавец (отправитель)</span>
											<br/>
											<xsl:apply-templates mode="org" select="DTSout_CU:DTSoutSeller"/>
										</td>
										<td class="graph" rowspan="3" style="width:80mm;border-left:solid 2pt #000000;border-top:solid 1.5pt #000000;border-right:solid 0.8pt #000000;border-bottom:solid 1.5pt #000000;" valign="top">
											<span class="graph">ДЛЯ ОТМЕТОК ТАМОЖЕННОГО ОРГАНА</span>
											<br/>
											<br/>
											<xsl:apply-templates select="DTSout_CU:GTDNumber"/>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:100mm;border-left:solid 0.8pt #000000;border-top:solid 0.8pt #000000;">
											<span class="graphNo">2 </span>
											<span class="graph">(а) Покупатель (получатель)</span>
											<br/>
											<xsl:apply-templates mode="org" select="DTSout_CU:DTSoutBuyer"/>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:100mm;border-left:solid 0.8pt #000000;border-top:solid 0.8pt #000000;">
											<table cellpadding="0" cellspacing="0" width="100%">
												<tr>
													<td align="left" width="50%">
														<span class="graph">(б) Декларант</span>
													</td>
													<td align="right" class="graph" width="50%">
														<xsl:if test="DTSout_CU:DTSoutDeclarant/RUDECLcat:AEORegistryIdDetails/catESAD_cu:DocId">
															<xsl:text>№ </xsl:text>
															<xsl:apply-templates select="DTSout_CU:DTSoutDeclarant/RUDECLcat:AEORegistryIdDetails/catESAD_cu:DocId"/>
														</xsl:if>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:100mm;border-left:solid 0.8pt #000000;">
											<xsl:apply-templates select="DTSout_CU:DTSoutDeclarant" mode="org"/>
										</td>
										<td class="graph" style="width:80mm;border:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">3 </span>
											<span class="graph">Условия поставки</span>
											<br/>
											<xsl:apply-templates select="DTSout_CU:DeliveryTerms/cat_ru:DeliveryTermsStringCode"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DeliveryTerms/cat_ru:DeliveryPlace"/>
										</td>
									</tr>
									<tr>
										<td class="graphBold" style="width:100mm;border-left:solid 1.5pt #000000;border-top:solid 2pt #000000;border-right:solid 1.5pt #000000;border-bottom:solid 1.5pt #000000;">
											<xsl:text>ВАЖНАЯ ИНФОРМАЦИЯ</xsl:text>
											<br/>
											<xsl:text>Декларант несет ответственность в соответствии с законодательством </xsl:text>
											<br/>
											<xsl:text>государств - членов Евразийского экономического союза за неисполнение </xsl:text>
											<br/>
											<xsl:text>обязанностей, предусмотренных пунктом 2 статьи 84 Таможенного кодекса </xsl:text>
											<br/>
											<xsl:text>Евразийского экономического союза, за заявление в таможенной декларации </xsl:text>
											<br/>
											<xsl:text>недостоверных сведений, а также за представление таможенному </xsl:text>
											<br/>
											<xsl:text>представителю недействительных документов, в том числе поддельных</xsl:text>
											<br/>
											<xsl:text>и (или) содержащих заведомо недостоверные (ложные) сведения</xsl:text>
										</td>
										<td class="graph" style="width:80mm;border-left:solid 0.8pt #000000;border-right:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">4 </span>
											<span class="graph">Вид, номер и дата документа, являющегося основанием для поставки товара</span>
											<br/>
											<xsl:for-each select="DTSout_CU:DTSInvoiceDocuments">
												<xsl:if test="cat_EDTS_cu:PositionNumber=4">
													<xsl:if test="cat_ru:PrDocumentName">
														<xsl:apply-templates select="cat_ru:PrDocumentName"/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:PresentedDocumentModeCode">
														<xsl:apply-templates select="cat_EDTS_cu:PresentedDocumentModeCode"/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													</xsl:if>
													<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<br/>
												</xsl:if>
											</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td class="graph" colspan="2" style="width:180mm;border:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">5 </span>
											<span class="graph">Номер и дата документа с принятыми решениями (таможенными органами/судебными органами) по ранее ввезенным товарам по документу, указанному в графе 4</span>
											<br/>
											<xsl:for-each select="DTSout_CU:DTSInvoiceDocuments">
												<xsl:if test="cat_EDTS_cu:PositionNumber=5">
													<xsl:apply-templates select="cat_ru:PrDocumentName"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<br/>
												</xsl:if>
											</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td class="graph" colspan="2" style="width:180mm;border:solid 0.8pt #000000;" valign="top">
											<table cellpadding="0" cellspacing="0" style="width:100%;">
												<tbody>
													<tr>
														<td class="graph" style="width:130mm;" valign="top">
															<span class="graphNo">6 </span>
															<span class="graph">Таможенная стоимость декларируемых товаров определяется по методу</span>
														</td>
														<td class="graph" colspan="3" style="width:50mm;" valign="top">
															<table cellpadding="0" cellspacing="0" style="width:100%;">
																<tbody>
																	<tr>
																		<td align="center" class="graph" style="width:40mm;border-left:solid 0.8pt #000000;border-bottom:solid 0.8pt #000000;" valign="top">
																			<span class="graphBold">Верное отметить</span>
																		</td>
																		<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
																			<span class="graphBold">х</span>
																		</td>
																		<td align="center" class="graph" style="width:5mm;border-bottom:solid 0.8pt #000000;border-left:solid 0.8pt #000000">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</td>
																	</tr>
																</tbody>
															</table>
														</td>
													</tr>
													<tr>
														<td colspan="4" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:130mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(а) по стоимости сделки с идентичными товарами (метод 2)</span>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<xsl:choose>
																<xsl:when test="(DTSout_CU:CustomsCostMethodCode=2) or (DTSout_CU:BaseMethodCode=2)">
																	<span class="graphBold">х</span>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td colspan="4" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:130mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(б) по стоимости сделки с однородными товарами (метод 3)</span>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<xsl:choose>
																<xsl:when test="(DTSout_CU:CustomsCostMethodCode=3) or (DTSout_CU:BaseMethodCode=3)">
																	<span class="graphBold">х</span>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td colspan="4" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:130mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(в) по методу вычитания (метод 4)</span>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<xsl:choose>
																<xsl:when test="(DTSout_CU:CustomsCostMethodCode=4) or (DTSout_CU:BaseMethodCode=4)">
																	<span class="graphBold">х</span>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td colspan="4" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:130mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(г) по методу сложения (метод 5)</span>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<xsl:choose>
																<xsl:when test="(DTSout_CU:CustomsCostMethodCode=5) or (DTSout_CU:BaseMethodCode=5)">
																	<span class="graphBold">х</span>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td colspan="4" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:130mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(д)* по резервному методу (метод 6)</span>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<xsl:choose>
																<xsl:when test="((DTSout_CU:CustomsCostMethodCode=6) and not(DTSout_CU:BaseMethodCode=1))">
																	<span class="graphBold">х</span>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td colspan="4" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:130mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(е) по резервному методу (метод 6) на основе метода по стоимости сделки с ввозимыми товарами (метод 1)
</span>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<xsl:choose>
																<xsl:when test="((DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:BaseMethodCode='1'))">
																	<span class="graphBold">х</span>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td colspan="4" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td class="graph" style="width:130mm;" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<span class="graph">(ж) различным (если для разных товаров используются различные методы) </span>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
														<td align="center" class="graph" style="width:5mm;border:solid 1.5pt #000000;" valign="middle">
															<xsl:choose>
																<xsl:when test="(DTSout_CU:CustomsCostMethodCode='*' or DTSout_CU:CustomsCostMethodCode='9')">
																	<span class="graphBold">х</span>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:otherwise>
															</xsl:choose>
														</td>
														<td class="graph" style="width:22.5mm;">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
													<tr>
														<td colspan="4" class="graph" valign="top">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
									<tr>
										<td class="graph" colspan="2" style="width:180mm;border-left:solid 0.8pt #000000;border-right:solid 0.8pt #000000;border-bottom:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">7 </span>
											<span class="graph">Причины, в связи с которыми неприменимы  методы, предшествующие методу, указанному в графе 6</span>
											<br/>
											<xsl:for-each select="DTSout_CU:ReasonApplyMethod/cat_EDTS_cu:ReasonDescription">
												<xsl:apply-templates select="."/>
												<xsl:text> </xsl:text>
											</xsl:for-each>
										</td>
									</tr>
									<tr>
										<td class="graph" colspan="2" style="width:180mm;border-left:solid 0.8pt #000000;border-right:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">8 </span>
											<span class="graph">Наименование и реквизиты основных документов, представленных в подтверждение приводимых сведений</span>
											<br/>
											<xsl:choose>
												<xsl:when test="(DTSout_CU:CustomsCostMethodCode='2') or (DTSout_CU:CustomsCostMethodCode='3') or (DTSout_CU:CustomsCostMethodCode='6' and DTSout_CU:BaseMethodCode='2') or (DTSout_CU:CustomsCostMethodCode='6' and DTSout_CU:BaseMethodCode='3')">
													<xsl:for-each select="DTSout_CU:DTSInvoiceDocuments">
														<xsl:if test="cat_EDTS_cu:PositionNumber=8">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:ConsignmentItemOrdinal"/>
															<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:text>/</xsl:text>
																<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
															</xsl:if>
															<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:text>/</xsl:text>
																<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
															</xsl:if>
															<br/>
														</xsl:if>
													</xsl:for-each>
												</xsl:when>
												<xsl:otherwise>
													<xsl:for-each select="DTSout_CU:DTSInvoiceDocuments">
														<xsl:if test="cat_EDTS_cu:PositionNumber=8">
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:ConsignmentItemOrdinal"/>
															<xsl:if test="cat_ru:PrDocumentNumber">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:text>/</xsl:text>
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:apply-templates select="cat_ru:PrDocumentNumber"/>
															</xsl:if>
															<xsl:if test="cat_ru:PrDocumentDate">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:text>/</xsl:text>
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																<xsl:apply-templates select="cat_ru:PrDocumentDate" mode="russian_date"/>
															</xsl:if>
															<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															<xsl:apply-templates select="cat_ru:PrDocumentName"/>
															<br/>
														</xsl:if>
													</xsl:for-each>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</tr>
									<tr>
										<td class="graph" rowspan="2" style="width:100mm;border:solid 0.8pt #000000;">
											<xsl:text>* В СООТВЕТСТВИИ СО СТАТЬЕЙ 45 ТАМОЖЕННОГО КОДЕКСА </xsl:text>
											<br/>
											<xsl:text>ЕВРАЗИЙСКОГО ЭКОНОМИЧЕСКОГО СОЮЗА ТАМОЖЕННАЯ</xsl:text>
											<br/>
											<xsl:text>СТОИМОСТЬ ВВОЗИМЫХ ТОВАРОВ ПО МЕТОДУ 6 НЕ ДОЛЖНА</xsl:text>
											<br/>
											<xsl:text>ОПРЕДЕЛЯТЬСЯ НА ОСНОВЕ:</xsl:text>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:text>1) цены на товары на внутреннем рынке Евразийского экономического союза, на товары, произведенные на таможенной территории Евразийского экономического союза;</xsl:text>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:text>2) системы, предусматривающей принятие для таможенных целей более высокой из двух альтернативных стоимостей;</xsl:text>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:text>3) цены на товары на внутреннем рынке страны вывоза;</xsl:text>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:text>4) иных расходов, чем расходы, включенные в  расчетную стоимость, которая была определена для идентичных или однородных товаров в соответствии со статьей 44 Таможенного кодекса Евразийского экономического союза;</xsl:text>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:text>5) цены на товары, поставляемые из страны их вывоза в государства, не являющиеся членами Евразийского экономического союза;</xsl:text>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:text>6) минимальной таможенной стоимости товаров;</xsl:text>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:text>7) произвольной или фиктивной стоимости.</xsl:text>
										</td>
										<td class="graph" style="width:80mm;border:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">9 </span>
											<span class="graph">Число дополнительных листов</span>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:AdditionalSheetNumber"/>
										</td>
									</tr>
									<tr>
										<td class="graph" style="width:80mm;border:solid 0.8pt #000000;" valign="top">
											<span class="graphNo">10 </span>
											<span class="graph">Сведения о лице, заполнившем ДТС</span>
											<br/>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="russian_date"/>
											<xsl:if test="cat_EDTS_cu:RegNumberDoc"> исх. номер 
										<xsl:apply-templates select="cat_EDTS_cu:RegNumberDoc"/>
											</xsl:if>
											<xsl:if test="cat_EDTS_cu:SecurityLabelCode">код защитной наклейки
										<xsl:apply-templates select="cat_EDTS_cu:SecurityLabelCode"/>
											</xsl:if>
											<br/>
											<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:QualificationCertificate">Номер квалификационного аттестата специалиста по таможенному оформлению
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:QualificationCertificate"/>
											</xsl:if>
											<br/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonSurname"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonName"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonMiddleName"/>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SignatoryPersonIdentityDetails">
												<xsl:for-each select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SignatoryPersonIdentityDetails">
													<xsl:apply-templates select="RUScat_ru:CountryCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:IdentityCardName"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:IdentityCardSeries"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:IdentityCardNumber"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:IdentityCardDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="RUScat_ru:OrganizationName"/>
												</xsl:for-each>
											</xsl:if>
											<xsl:text> </xsl:text>
											<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:CommunicationDetails">
												<span class="normal">
													<xsl:for-each select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:CommunicationDetails">
														<xsl:call-template name="CommunicationDetails"/>
													</xsl:for-each>
												</span>
											</xsl:if>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonPost"/>
											<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails">
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentName">
													<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentName"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:if>
												<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentNumber"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:if test="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentDate">
													<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/cat_ru:PrDocumentDate" mode="russian_date"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:if>
												<xsl:apply-templates select="DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:PowerOfAttorneyDetails/RUScat_ru:DocValidityDate" mode="russian_date"/>
											</xsl:if>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<xsl:variable name="HasCurrencyDate">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:CurrencyDate">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="CurrencyDate">
							<xsl:choose>
								<xsl:when test="$HasCurrencyDate">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost[DTSout_CU:CurrencyDate]/DTSout_CU:CurrencyDate"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneCurrencyDate">
							<xsl:choose>
								<xsl:when test="$HasCurrencyDate">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost[DTSout_CU:CurrencyDate != $CurrencyDate] or DTSout_CU:DTSout_CUGoodsCustomsCost[not(DTSout_CU:CurrencyDate)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="HasDealCode">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="HasDealDate">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyDate">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DealCode">
							<xsl:choose>
								<xsl:when test="$HasDealCode">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:DealCurrencyCode]/cat_EDTS_cu:DealCurrencyCode"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DealDate">
							<xsl:choose>
								<xsl:when test="$HasDealDate">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:DealCurrencyDate]/cat_EDTS_cu:DealCurrencyDate"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneDealCode">
							<xsl:choose>
								<xsl:when test="$HasDealCode">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:DealCurrencyCode != $DealCode] or DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[not(cat_EDTS_cu:DealCurrencyCode)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneDealDate">
							<xsl:choose>
								<xsl:when test="$HasDealDate">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:DealCurrencyDate != $DealDate] or DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[not(cat_EDTS_cu:DealCurrencyDate)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="HasDealIndirectCode">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="HasDealIndirectDate">
							<xsl:choose>
								<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyDate">
									<xsl:value-of select="1"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="0"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DealCodeIndirect">
							<xsl:choose>
								<xsl:when test="$HasDealIndirectCode">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:IndirectCurrencyCode]/cat_EDTS_cu:IndirectCurrencyCode"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DealDateIndirect">
							<xsl:choose>
								<xsl:when test="$HasDealIndirectDate">
									<xsl:value-of select="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:IndirectCurrencyDate]/cat_EDTS_cu:IndirectCurrencyDate"/>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneDealIndirectCode">
							<xsl:choose>
								<xsl:when test="$HasDealIndirectCode">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:IndirectCurrencyCode != $DealCodeIndirect] or DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[not(cat_EDTS_cu:IndirectCurrencyCode)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="IsOneDealIndirectDate">
							<xsl:choose>
								<xsl:when test="$HasDealIndirectDate">
									<xsl:choose>
										<xsl:when test="DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[cat_EDTS_cu:IndirectCurrencyDate != $DealDateIndirect] or DTSout_CU:DTSout_CUGoodsCustomsCost/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis[not(cat_EDTS_cu:IndirectCurrencyDate)]">
											<xsl:value-of select="0"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="1"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="DTS" select="current()"/>
						<!--<xsl:for-each select="DTSout_CU:DTSout_CUGoodsCustomsCost">-->
						<xsl:for-each select="//DTSout_CU:DTSout_CUGoodsCustomsCost[(($DTS/DTSout_CU:CustomsCostMethodCode=6) and ($DTS/DTSout_CU:BaseMethodCode=1)) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=1)) or (($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=1))][(position() mod 3) = 1]">
							<!--<xsl:if test="(($DTS/DTSout_CU:CustomsCostMethodCode=6) and ($DTS/DTSout_CU:BaseMethodCode=1)) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=1)) or (($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=1))">-->
							<xsl:variable name="column_2" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[(($DTS/DTSout_CU:CustomsCostMethodCode=6) and ($DTS/DTSout_CU:BaseMethodCode=1)) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=1)) or (($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=1))][1]"/>
							<xsl:variable name="column_3" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[(($DTS/DTSout_CU:CustomsCostMethodCode=6) and ($DTS/DTSout_CU:BaseMethodCode=1)) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=1)) or (($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=1))][2]"/>
							<div class="page">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tbody>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<span class="graph">Форма ДТС-2</span>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Лист №  </span>
												<xsl:apply-templates select="DTSout_CU:SheetNumber"/>
											</td>
										</tr>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Метод 6 на основе метода 1</span>
											</td>
										</tr>
									</tbody>
								</table>
								<table cellpadding="0" cellspacing="0" style="width:100%;border:solid 0.8pt #000000;">
									<tbody>
										<tr>
											<td align="center" class="graph" colspan="2" rowspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ДЛЯ ОТМЕТОК ТАМОЖЕННОГО ОРГАНА</span>
												<br/>
												<br/>
												<xsl:apply-templates select="../DTSout_CU:GTDNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
											</td>
										</tr>
										<tr>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="DTSout_CU:GoodsTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="$column_2/DTSout_CU:GoodsTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="$column_3/DTSout_CU:GoodsTNVEDCode"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="4" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ОСНОВА ДЛЯ РАСЧЕТА</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">11 </span>
												<span class="graph">(а) основа для определения таможенной стоимости ввозимых товаров в ВАЛЮТЕ СЧЕТА </span>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:if test="($HasDealDate and ($IsOneDealDate=1)) and ($HasDealCode and ($IsOneDealCode=1))">
													<xsl:text>(курс пересчета</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<u>
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode"/>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate">/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate"/>
														</xsl:if>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity"/> ед.
												</xsl:if>
													</u>
											)</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealNationalAmount"/>
												<xsl:if test="$IsOneDealDate=0 or ($IsOneDealCode=0)">
													<xsl:if test="DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode"/>
															<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate">/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity">
																<xsl:text> </xsl:text>/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity"/> ед.
												</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealNationalAmount"/>
												<xsl:if test="$IsOneDealDate=0 or ($IsOneDealCode=0)">
													<xsl:text> (курс пересчета </xsl:text>
													<u>
														<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode"/>
														<xsl:if test="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate">/<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate"/>
														</xsl:if>
														<xsl:if test="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity"/> ед.
												</xsl:if>
													</u>
													<xsl:text>)</xsl:text>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealNationalAmount"/>
												<xsl:if test="$IsOneDealDate=0 or ($IsOneDealCode=0)">
													<xsl:text> (курс пересчета </xsl:text>
													<u>
														<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyCode"/>
														<xsl:if test="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate">/<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:DealCurrencyRate"/>
														</xsl:if>
														<xsl:if test="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:CurrencyQuantity"/> ед.
												</xsl:if>
													</u>
													<xsl:text>)</xsl:text>
												</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) косвенные платежи (условия или обязательства) </span>
												<br>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</br>
												<xsl:text> </xsl:text>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:if test="($HasDealIndirectDate and ($IsOneDealIndirectDate=1)) and ($HasDealIndirectCode and ($IsOneDealIndirectCode=1))">
													<xsl:text>(курс пересчета</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<u>
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode"/>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate">/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate"/>
														</xsl:if>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity"/> ед.
												</xsl:if>
													</u>
											)</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectNationalPayment"/>
												<xsl:if test="$IsOneDealIndirectDate=0 or ($IsOneDealIndirectCode=0)">
													<br/>
													<xsl:text> (курс пересчета </xsl:text>
													<u>
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode"/>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate">/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate"/>
														</xsl:if>
														<xsl:if test="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity">
															<xsl:text> </xsl:text>/<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity"/> ед.
												</xsl:if>
													</u>
													<xsl:text>)</xsl:text>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectNationalPayment"/>
												<xsl:if test="$IsOneDealIndirectDate=0 or ($IsOneDealIndirectCode=0)">
													<xsl:if test="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode"/>
															<xsl:if test="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate">/<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity">
																<xsl:text> </xsl:text>/<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity"/> ед.
												</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectNationalPayment"/>
												<xsl:if test="$IsOneDealIndirectDate=0 or ($IsOneDealIndirectCode=0)">
													<xsl:if test="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyCode"/>
															<xsl:if test="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate">/<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity">
																<xsl:text> </xsl:text>/<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:IndirectCurrencyQuantity"/> ед.
												</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">12 </span>
												<span class="graph">Итого пр разделам "а" и "б" графы 11 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:BasisNationalAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:BasisNationalAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1CalculationBasis/cat_EDTS_cu:BasisNationalAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="12" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ДОПОЛНИ- ТЕЛЬНЫЕ НАЧИСЛЕНИЯ: расходы в национальной валюте, которые не включены в графу 12*</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">13 </span>
												<span class="graph">Расходы, осуществленные покупателем на:</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) вознаграждения агенту (посреднику), брокеру за исключением вознаграждений за закупку ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:AgentBonus"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:AgentBonus"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:AgentBonus"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) тару и упаковку, в том числе стоимость упаковочных материалов и работ по упаковке</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:PackageExpenses"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:PackageExpenses"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:PackageExpenses"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">14 </span>
												<span class="graph">Соответствующим образом распределенная стоимость следующих товаров и услуг, прямо или косвенно предоставленных покупателем бесплатно или сниженной цене для использования в связи с  производством и продажей  ввозимых товаров для вывоза на единую таможенную территорию Евразийского экономичесого союза, в размере, не включенном в цену, фактически уплаченную или подлежащую уплате:</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) сырье, материалы, детали, полуфабрикаты и иные товары, из которых произведены (состоят) ввозимые товары</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:StoreCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:StoreCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:StoreCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) инструменты, штампы, формы и иные подобные товары, использованные при производстве ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(в) материалы, израсходованные при производстве ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:WorkingStockCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:WorkingStockCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:WorkingStockCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(г) проектирование, разработка, инженерная, конструкторская работа, художественное оформление, дизайн, эскизы и чертежи, выполненные вне таможенной территории Евразийского экономического союза и необходимые для производства ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:DesignPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:DesignPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:DesignPayment"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">15 </span>
												<span class="graph">Лицензионные и иные подобные платежи за использование объектов интеллектуальной собственности</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:IntellectualPropertyPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:IntellectualPropertyPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:IntellectualPropertyPayment"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">16 </span>
												<span class="graph">Часть дохода (выручки), полученного в результате последующей продажи, распоряжения иным способом или использования ввозимых товаров, которая прямо или косвенно причитается продавцу</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:SellerIncome"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:SellerIncome"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:SellerIncome"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">17 </span>
												<span class="graph">Расходы на перевозку (транспортировку) ввозимых товаров 
											</span>
												<xsl:text>до </xsl:text>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<u>
													<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:BorderPlace"/>
												</u>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">18 </span>
												<span class="graph">Расходы на погрузку, разгрузку или перегрузку ввозимых и проведение иных операций, связанных с их перевозкой (транспортировкой) 
											</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:LoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:LoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:LoadCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">19 </span>
												<span class="graph">Расходы на страхование в связи с операциями, указанными в графах 17 и 18</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:InsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:InsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:InsuranceCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">20 </span>
												<span class="graph">Итого по графам 13-19 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:TotalAdditionalSum"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:TotalAdditionalSum"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1AdditionalSum/cat_EDTS_cu:TotalAdditionalSum"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="4" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ВЫЧЕТЫ: расходы в национальной валюте, которые включены в графу 12*</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">21 </span>
												<span class="graph">Расходы на строительство, возведение, сборку, монтаж, обслуживание, или оказание технического содействия, производимые после ввоза товаров на единую таможенную территорию Евразийского экономического союза</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:BuildingAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:BuildingAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:BuildingAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">22 </span>
												<span class="graph">Расходы на перевозку (транспортировку) ввозимых товаров по таможенной территории Евразийского экономического союза</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">23 </span>
												<span class="graph">Сумма пошлин, налогов и сборов, уплачиваемых в связи с ввозом товаров на таможенную территорию Евразийского экономического союза или продажей товаров на такой таможенной территории</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">24 </span>
												<span class="graph">Итого по графам 21-23 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod1/cat_EDTS_cu:Method1Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">25 </span>
												<span class="graph">Таможенная стоимость ввозимых товаров (12 + 20 - 24)</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="bottom">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) в ДОЛЛАРАХ США 
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="$HasCurrencyDate and ($IsOneCurrencyDate=1)">
														<xsl:text>(курс пересчета</xsl:text>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template>едн.
															</xsl:if>
														</u>
											)</xsl:if>
												</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column_2/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column_3/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="5" style="width:180mm;border:solid 0.8pt #000000;" valign="top">
												<table cellpadding="0" cellspacing="0" style="width:100%;">
													<tbody>
														<tr>
															<td class="graph" colspan="3" style="width:180mm;" valign="top">
																<xsl:text>* Если сумма оплачена в иностранной валюте, указывается сумма в иностранной валюте и курс пересчета по каждому товару и графе.</xsl:text>
															</td>
														</tr>
														<tr>
															<td class="graph" style="width:80mm;" valign="top">
																<span class="graph">Порядковый номер товара в ДТС-2 и номер графы ДТС-2</span>
															</td>
															<td class="graph" style="width:40mm;" valign="top">
																<span class="graph">Буквнный код валюты, сумма</span>
															</td>
															<td class="graph" style="width:40mm;" valign="top">
																<span class="graph">Курс пересчета</span>
															</td>
														</tr>
														<xsl:for-each select="DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" align="left" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
														<xsl:for-each select="$column_2/DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
														<xsl:for-each select="$column_3/DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
													</tbody>
												</table>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дополнительные данные</span>
												<xsl:variable name="GTDGoodsNumber1">
													<xsl:apply-templates select="DTSout_CU:GTDGoodsNumber"/>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber2">
													<xsl:choose>
														<xsl:when test="$column_2">
															<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber3">
													<xsl:choose>
														<xsl:when test="$column_3">
															<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:for-each select="DTSout_CU:AdditionalData">
													<br/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
													<xsl:if test="cat_EDTS_cu:PositionNumber">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
														<xsl:text> / </xsl:text>
														<xsl:variable name="xpath_KindCode4">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
															</xsl:call-template>
														</xsl:variable>
														<element xml_node="{$xpath_KindCode4}">
															<xsl:choose>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																	<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																	<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																	<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																	<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																</xsl:when>
															</xsl:choose>
														</element>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
													</xsl:if>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="cat_EDTS_cu:AdditionalInformation">
														<xsl:text>/ </xsl:text>
														<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
															<xsl:apply-templates select="."/>
															<xsl:if test="position()!=last()">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</xsl:if>
														</xsl:for-each>
													</xsl:if>
												</xsl:for-each>
												<xsl:if test="$column_2">
													<xsl:for-each select="$column_2/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode5">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode5}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="$column_3">
													<xsl:for-each select="$column_3/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode6">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode6}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="../DTSout_CU:AdditionalData">
													<br/>
													<br>
														<xsl:text>Дополнительная информация, относящаяся ко всем товарам:</xsl:text>
													</br>
													<br/>
													<xsl:for-each select="../DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:variable name="xpath_KindCode7">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode7}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
											</td>
											<td class="graph" colspan="3" style="width:70mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дата, подпись, печать</span>
												<br/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="russian_date"/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonSurname"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonMiddleName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonPost"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!--</xsl:if>-->
						</xsl:for-each>
						<xsl:for-each select="//DTSout_CU:DTSout_CUGoodsCustomsCost[(($DTS/DTSout_CU:CustomsCostMethodCode=6) and ($DTS/DTSout_CU:BaseMethodCode=4)) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) 
                  and (DTSout_CU:BaseMethodNumberCode=4)) or (($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=4)) 
                  or ($DTS/DTSout_CU:CustomsCostMethodCode=4) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=4))][(position() mod 3) = 1]">
							<!--<xsl:if test="(($DTS/DTSout_CU:CustomsCostMethodCode=6) and ($DTS/DTSout_CU:BaseMethodCode=4)) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) 
                  and (DTSout_CU:BaseMethodNumberCode=4)) or (($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=4)) 
                  or ($DTS/DTSout_CU:CustomsCostMethodCode=4) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=4))">-->
							<xsl:variable name="column_2" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[(($DTS/DTSout_CU:CustomsCostMethodCode=6) and ($DTS/DTSout_CU:BaseMethodCode=4)) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) 
                  and (DTSout_CU:BaseMethodNumberCode=4)) or (($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=4)) 
                  or ($DTS/DTSout_CU:CustomsCostMethodCode=4) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=4))][1]"/>
							<xsl:variable name="column_3" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[(($DTS/DTSout_CU:CustomsCostMethodCode=6) and ($DTS/DTSout_CU:BaseMethodCode=4)) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) 
                  and (DTSout_CU:BaseMethodNumberCode=4)) or (($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=4)) 
                  or ($DTS/DTSout_CU:CustomsCostMethodCode=4) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=4))][2]"/>
							<div class="page">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tbody>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<span class="graph">Форма ДТС-2</span>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Лист № </span>
												<xsl:apply-templates select="DTSout_CU:SheetNumber"/>
											</td>
										</tr>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Методы 4, 6</span>
											</td>
										</tr>
									</tbody>
								</table>
								<table cellpadding="0" cellspacing="0" style="width:100%;border:solid 0.8pt #000000;">
									<tbody>
										<tr>
											<td align="center" class="graph" colspan="2" rowspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ДЛЯ ОТМЕТОК ТАМОЖЕННОГО ОРГАНА</span>
												<br/>
												<xsl:apply-templates select="../DTSout_CU:GTDNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
											</td>
										</tr>
										<tr>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД ЕАЭС</span>
												<br/>
												<xsl:apply-templates select="DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД ЕАЭС</span>
												<br/>
												<xsl:apply-templates select="$column_2/DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="$column_2/DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД ЕАЭС</span>
												<br/>
												<xsl:apply-templates select="$column_3/DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="$column_3/DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ОСНОВА ДЛЯ РАСЧЕТА</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">11 </span>
												<span class="graph">Цена единицы товара, по которой наибольшее совокупное количество ввозимых товаров либо идентичных ввозимым или однородным с ввозимыми товаров продаются на таможенной территории Евразийского экономического союза в том же состоянии, в котором они были ввезены на таможенную территорию Евразийского экономичесого союза, лицами, не являющимися взаимосвязанными с лицами, осуществляющими такую продажу на таможенной территории Евразийского экономического союза</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Basis/cat_EDTS_cu:IdenticalDealNationalPrice"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Basis/cat_EDTS_cu:IdenticalDealNationalPrice"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Basis/cat_EDTS_cu:IdenticalDealNationalPrice"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="5" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ВЫЧЕТЫ сумм, которые включены в графу 11 (в расчете на единицу товара)</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">12 </span>
												<span class="graph">Сумма вознаграждения агенту (посреднику), обычно выплачиваемого или подлежащего выплате, либо надбавки к цене, обычно производимой  для получения прибыли и покрытия  общих расходов (коммерческих и управленческих расходов)</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:AgentCharge"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:AgentCharge"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:AgentCharge"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">13 </span>
												<span class="graph">Сумма обычных расходов на осуществленные на таможенной территории Евразийского экоомического союза перевозку (транспортировку) и страхование и иных связанных с такими операциями расходов</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:UnionTransportCharge"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">14 </span>
												<span class="graph">Сумма таможенных пошлин, налогов, сборов, а также применяемых в соответствии с законодательством государств - членов Евразийского экономического союза иных налогов, подлежащих уплате в связи с ввозом и (или) продажей товаров на территории государств - членов Евразийского экономического союза, включая налоги и сборы субъектов государств - членов Евразийского экономического союзза и местные налоги и сборы</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:UnionTaxPayment"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">15 </span>
												<span class="graph">Стоимость, добавленная в результате переработки (обработки), в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:ProcessingAddedCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:ProcessingAddedCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:ProcessingAddedCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">16 </span>
												<span class="graph">Итого по графам 12-15 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:Method46Deduction/cat_EDTS_cu:TotalDeductionAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">17 </span>
												<span class="graph">Количество оцениваемых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="(DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or (DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														(
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="($column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or ($column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														(
														<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="($column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or ($column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														(
														<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod46/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">18 </span>
												<span class="graph">Таможенная стоимость ввозимых товаров ((11-16) х 17):</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="bottom">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) в ДОЛЛАРАХ США 
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="$HasCurrencyDate and ($IsOneCurrencyDate=1)">
														<xsl:text>(курс пересчета</xsl:text>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template>едн.
															</xsl:if>
														</u>
											)</xsl:if>
												</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column_2/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column_3/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="3" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дополнительные данные</span>
												<br/>
												<xsl:variable name="GTDGoodsNumber1">
													<xsl:apply-templates select="DTSout_CU:GTDGoodsNumber"/>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber2">
													<xsl:choose>
														<xsl:when test="$column_2">
															<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber3">
													<xsl:choose>
														<xsl:when test="$column_3">
															<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:for-each select="DTSout_CU:AdditionalData">
													<br/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
													<xsl:if test="cat_EDTS_cu:PositionNumber">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
														<xsl:text> / </xsl:text>
														<xsl:variable name="xpath_KindCode8">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
															</xsl:call-template>
														</xsl:variable>
														<element xml_node="{$xpath_KindCode8}">
															<xsl:choose>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																	<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																	<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																	<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																	<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																</xsl:when>
															</xsl:choose>
														</element>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
													</xsl:if>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="cat_EDTS_cu:AdditionalInformation">
														<xsl:text>/ </xsl:text>
														<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
															<xsl:apply-templates select="."/>
															<xsl:if test="position()!=last()">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</xsl:if>
														</xsl:for-each>
													</xsl:if>
												</xsl:for-each>
												<xsl:if test="$column_2">
													<xsl:for-each select="$column_2/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode9">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode9}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="$column_3">
													<xsl:for-each select="$column_3/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode10">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode10}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="../DTSout_CU:AdditionalData">
													<br/>
													<br>
														<xsl:text>Дополнительная информация, относящаяся ко всем товарам:</xsl:text>
													</br>
													<br/>
													<xsl:for-each select="../DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:variable name="xpath_KindCode11">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode11}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
											</td>
											<td class="graph" colspan="2" style="width:70mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дата, подпись, печать</span>
												<br/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="russian_date"/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonSurname"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonMiddleName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonPost"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- </xsl:if>-->
						</xsl:for-each>
						<xsl:for-each select="//DTSout_CU:DTSout_CUGoodsCustomsCost[($DTS/DTSout_CU:CustomsCostMethodCode=5) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=5)) or (($DTS/DTSout_CU:CustomsCostMethodCode=6) 
                  and ($DTS/DTSout_CU:BaseMethodCode=5)) or(($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) 
                  and (DTSout_CU:BaseMethodNumberCode=5))or(($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=5))][(position() mod 3) = 1]">
							<!--<xsl:if test="($DTS/DTSout_CU:CustomsCostMethodCode=5) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=5)) or (($DTS/DTSout_CU:CustomsCostMethodCode=6) 
                  and ($DTS/DTSout_CU:BaseMethodCode=5)) or(($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) 
                  and (DTSout_CU:BaseMethodNumberCode=5))or(($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=5))">-->
							<xsl:variable name="column_2" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[($DTS/DTSout_CU:CustomsCostMethodCode=5) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=5)) or (($DTS/DTSout_CU:CustomsCostMethodCode=6) 
                  and ($DTS/DTSout_CU:BaseMethodCode=5)) or(($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) 
                  and (DTSout_CU:BaseMethodNumberCode=5))or(($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=5))][1]"/>
							<xsl:variable name="column_3" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[($DTS/DTSout_CU:CustomsCostMethodCode=5) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=5)) or (($DTS/DTSout_CU:CustomsCostMethodCode=6) 
                  and ($DTS/DTSout_CU:BaseMethodCode=5)) or(($DTS/DTSout_CU:CustomsCostMethodCode='*') and (DTSout_CU:MethodNumberCode=6) 
                  and (DTSout_CU:BaseMethodNumberCode=5))or(($DTS/DTSout_CU:CustomsCostMethodCode='6') and (DTSout_CU:MethodNumberCode=6) and (DTSout_CU:BaseMethodNumberCode=5))][2]"/>
							<div class="page">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tbody>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<span class="graph">Форма ДТС-2</span>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Лист № </span>
												<xsl:apply-templates select="DTSout_CU:SheetNumber"/>
											</td>
										</tr>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Методы 5, 6</span>
											</td>
										</tr>
									</tbody>
								</table>
								<table cellpadding="0" cellspacing="0" style="width:100%;border:solid 0.8pt #000000;">
									<tbody>
										<tr>
											<td align="center" class="graph" colspan="2" rowspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ДЛЯ ОТМЕТОК ТАМОЖЕННОГО ОРГАНА</span>
												<br/>
												<xsl:apply-templates select="../DTSout_CU:GTDNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
											</td>
										</tr>
										<tr>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="$column_2/DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="$column_2/DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД</span>
												<br/>
												<xsl:apply-templates select="$column_3/DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="$column_3/DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="8" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">РАСХОДЫ на изготовление или приобретение материалов и расходы на производство*</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">11 </span>
												<span class="graph">Расходы на изготовление или приобретение материалов и расходы на производство, а также на иные операции, связанные с производством ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ProductionStoreExpense"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ProductionStoreExpense"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ProductionStoreExpense"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">12 </span>
												<span class="graph">Расходы, включенные в графу 11:</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">а) расходы на тару и упаковку, в том числе стоимость упаковочных материалов и работ по упаковке</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:PackageExpenses"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:PackageExpenses"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:PackageExpenses"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) стоимость проектирования, разработки, инженерной, конструкторской работы, художественного оформления, дизайна, эскизов и чертежей, произведенных (оказанных) на таможенной территории Евразийского экономического союза, в той степени, в которой эти товары и услуги оплачивались производителем</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:DesignPaymentProduction"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:DesignPaymentProduction"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:DesignPaymentProduction"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(в) стоимость сырья, материалов, деталей, полуфабрикатов и иных товаров, из которых произведены (состоят) ввозимые товары, прямо или косвенно предоставленных покупателем для использования в связи с производством ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:StoreCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:StoreCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56//cat_EDTS_cu:Method56Basis/cat_EDTS_cu:StoreCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(г) стоимость инструментов, штампов, форм и иных подобных товаров, использованных при производстве ввозимых товаров, прямо или косвенно предоставленных покупателем для использования в связи с производством ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ProductionToolkitCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(д) стоимость материалов, израсходованных при производстве ввозимых товаров, прямо или косвенно предоставленных покупателем для использования в связи с производством ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ConsumablesCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ConsumablesCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:ConsumablesCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(е) стоимость проектирования, разработки, инженерной, конструкторской работы, художественного оформления, дизайна, эскизов и чертежей, выполненных вне таможенной территории Евразийского экономического союза и необходимых для производства ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:DesignPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:DesignPayment"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:DesignPayment"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(ж) иные расходы, связанные с производством ввозимых товаров </span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:AddProductionValueAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:AddProductionValueAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:AddProductionValueAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">СУММА прибыли и общих расходов*</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">13 </span>
												<span class="graph">Сумма прибыли и коммерческих и общих расходов (коммерческих и управленческих расходов)</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:CommerceExpense"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:CommerceExpense"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:CommerceExpense"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="3" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ИНЫЕ РАСХОДЫ*</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">14 </span>
												<span class="graph">Расходы на перевозку (транспортировку) товаров до  
													<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:BorderPlace"/>
												</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:BorderTransportCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">15 </span>
												<span class="graph">Расходы на погрузку, разгрузку или перегрузку ввозимых товаров и проведение иных операций, связанным с их перевозкой (транспортировкой)</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:LoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:LoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:LoadCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">16 </span>
												<span class="graph">Расходы на страхование в связи с операциями, указанными в графах 14 и 15</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:InsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:InsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod56/cat_EDTS_cu:Method56Basis/cat_EDTS_cu:InsuranceCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">17 </span>
												<span class="graph">Таможенная стоимость ввозимых товаров (итого по графам 11, 13 - 16):</span>
												<br/>
												<span class="graph">(а) в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="bottom">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) в ДОЛЛАРАХ США 
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="$HasCurrencyDate and ($IsOneCurrencyDate=1)">
														<xsl:text>(курс пересчета</xsl:text>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template>едн.
															</xsl:if>
														</u>
											)</xsl:if>
												</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column_2/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column_3/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="5" style="width:180mm;border:solid 0.8pt #000000;" valign="top">
												<table cellpadding="0" cellspacing="0" style="width:100%;">
													<tbody>
														<tr>
															<td class="graph" colspan="3" style="width:180mm;" valign="top">
																<xsl:text>* Если сумма установлена в иностранной валюте, указываются сумма в иностранной валюте и курс пересчета по каждому товару и каждой графе.</xsl:text>
															</td>
														</tr>
														<tr>
															<td class="graph" style="width:80mm;" valign="top">
																<span class="graph">Порядковый номер товара в ДТС-2 и номер графы ДТС-2</span>
															</td>
															<td class="graph" style="width:40mm;" valign="top">
																<span class="graph">Буквнный код валюты, сумма</span>
															</td>
															<td class="graph" style="width:40mm;" valign="top">
																<span class="graph">Курс пересчета</span>
															</td>
														</tr>
														<xsl:for-each select="DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" align="left" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
														<xsl:for-each select="$column_2/DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
														<xsl:for-each select="$column_3/DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
													</tbody>
												</table>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="3" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дополнительные данные</span>
												<br/>
												<xsl:variable name="GTDGoodsNumber1">
													<xsl:value-of select="DTSout_CU:GTDGoodsNumber"/>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber2">
													<xsl:choose>
														<xsl:when test="$column_2">
															<xsl:value-of select="$column_2/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber3">
													<xsl:choose>
														<xsl:when test="$column_3">
															<xsl:value-of select="$column_3/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:for-each select="DTSout_CU:AdditionalData">
													<br/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
													<xsl:if test="cat_EDTS_cu:PositionNumber">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
														<xsl:text> / </xsl:text>
														<xsl:variable name="xpath_KindCode12">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
															</xsl:call-template>
														</xsl:variable>
														<element xml_node="{$xpath_KindCode12}">
															<xsl:choose>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																	<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																	<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																	<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																	<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																</xsl:when>
															</xsl:choose>
														</element>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
													</xsl:if>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="cat_EDTS_cu:AdditionalInformation">
														<xsl:text>/ </xsl:text>
														<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
															<xsl:apply-templates select="."/>
															<xsl:if test="position()!=last()">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</xsl:if>
														</xsl:for-each>
													</xsl:if>
												</xsl:for-each>
												<xsl:if test="$column_2">
													<xsl:for-each select="$column_2/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode13">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode13}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="$column_3">
													<xsl:for-each select="$column_3/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode14">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode14}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="../DTSout_CU:AdditionalData">
													<br/>
													<br>
														<xsl:text>Дополнительная информация, относящаяся ко всем товарам:</xsl:text>
													</br>
													<br/>
													<xsl:for-each select="../DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:variable name="xpath_KindCode15">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode15}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
											</td>
											<td class="graph" colspan="2" style="width:70mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дата, подпись, печать</span>
												<br/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="russian_date"/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonSurname"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonMiddleName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonPost"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!--   </xsl:if>-->
						</xsl:for-each>
						<xsl:for-each select="//DTSout_CU:DTSout_CUGoodsCustomsCost[($DTS/DTSout_CU:CustomsCostMethodCode=2) or ($DTS/DTSout_CU:CustomsCostMethodCode=3) 
                or ($DTS/DTSout_CU:CustomsCostMethodCode=6 and (($DTS/DTSout_CU:BaseMethodCode=2) or ($DTS/DTSout_CU:BaseMethodCode=3))) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') 
                and ((DTSout_CU:MethodNumberCode=2) or (DTSout_CU:MethodNumberCode=3))) or  ((DTSout_CU:MethodNumberCode=6) and ((DTSout_CU:BaseMethodNumberCode=2) 
                or (DTSout_CU:BaseMethodNumberCode=3)))][(position() mod 3) = 1]">
							<!-- <xsl:if test="($DTS/DTSout_CU:CustomsCostMethodCode=2) or ($DTS/DTSout_CU:CustomsCostMethodCode=3) or ($DTS/DTSout_CU:CustomsCostMethodCode=6 and (($DTS/DTSout_CU:BaseMethodCode=2) or ($DTS/DTSout_CU:BaseMethodCode=3))) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') and ((DTSout_CU:MethodNumberCode=2) or (DTSout_CU:MethodNumberCode=3))) or  ((DTSout_CU:MethodNumberCode=6) and ((DTSout_CU:BaseMethodNumberCode=2) or (DTSout_CU:BaseMethodNumberCode=3)))">-->
							<xsl:variable name="column_2" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[($DTS/DTSout_CU:CustomsCostMethodCode=2) or ($DTS/DTSout_CU:CustomsCostMethodCode=3) 
                     or ($DTS/DTSout_CU:CustomsCostMethodCode=6 and (($DTS/DTSout_CU:BaseMethodCode=2) or ($DTS/DTSout_CU:BaseMethodCode=3))) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') 
                     and ((DTSout_CU:MethodNumberCode=2) or (DTSout_CU:MethodNumberCode=3))) or  ((DTSout_CU:MethodNumberCode=6) and ((DTSout_CU:BaseMethodNumberCode=2) 
                     or (DTSout_CU:BaseMethodNumberCode=3)))][1]"/>
							<xsl:variable name="column_3" select="following-sibling::DTSout_CU:DTSout_CUGoodsCustomsCost[($DTS/DTSout_CU:CustomsCostMethodCode=2) or ($DTS/DTSout_CU:CustomsCostMethodCode=3) 
                     or ($DTS/DTSout_CU:CustomsCostMethodCode=6 and (($DTS/DTSout_CU:BaseMethodCode=2) or ($DTS/DTSout_CU:BaseMethodCode=3))) or (($DTS/DTSout_CU:CustomsCostMethodCode='*') 
                     and ((DTSout_CU:MethodNumberCode=2) or (DTSout_CU:MethodNumberCode=3))) or  ((DTSout_CU:MethodNumberCode=6) and ((DTSout_CU:BaseMethodNumberCode=2) 
                     or (DTSout_CU:BaseMethodNumberCode=3)))][2]"/>
							<div class="page">
								<table cellpadding="0" cellspacing="0" style="width:100%;">
									<tbody>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<span class="graph">Форма ДТС-2</span>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Лист № </span>
												<xsl:apply-templates select="DTSout_CU:SheetNumber"/>
											</td>
										</tr>
										<tr>
											<td align="right" class="graph" style="width:145mm;">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td align="right" class="graph" style="width:35mm;">
												<span class="graph">Методы 2, 3, 6</span>
											</td>
										</tr>
									</tbody>
								</table>
								<table cellpadding="0" cellspacing="0" style="width:100%;border:solid 0.8pt #000000;">
									<tbody>
										<tr>
											<td align="center" class="graph" colspan="2" rowspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ДЛЯ ОТМЕТОК ТАМОЖЕННОГО ОРГАНА</span>
												<br/>
												<br/>
												<xsl:apply-templates select="../DTSout_CU:GTDNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Товар № </span>
												<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
											</td>
										</tr>
										<tr>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД ЕАЭС</span>
												<br/>
												<xsl:apply-templates select="DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД ЕАЭС</span>
												<br/>
												<xsl:apply-templates select="$column_2/DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="$column_2/DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Код ТН ВЭД ЕАЭС</span>
												<br/>
												<xsl:apply-templates select="$column_3/DTSout_CU:GoodsTNVEDCode"/>
												<xsl:apply-templates select="$column_3/DTSout_CU:GoodsAddTNVEDCode"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Основа для расчета</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">11 </span>
												<span class="graph">Стоимость сделки с идентичными/однородными товарами в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2Basis/cat_EDTS_cu:IdenticalDealNationalAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2Basis/cat_EDTS_cu:IdenticalDealNationalAmount"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2Basis/cat_EDTS_cu:IdenticalDealNationalAmount"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="13" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">ПОПРАВКИ К СТОИМОСТИ СДЕЛКИ*</span>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">12 </span>
												<span class="graph">(а) поправка на количество</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusQuantityCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusQuantityCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusQuantityCorrect"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) поправка на коммерческий уровень</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusCommerceCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusCommerceCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusCommerceCorrect"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(в) поправка на разницу в расходах на перевозку (транспортировку) товаров до 
													<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusBorderPlace"/>
												</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusBorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusBorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusBorderTransportCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(г) поправка на разницу в расходах на погрузку, разгрузку или перегрузку товаров и проведение иных операций, связанных с перевозкой (транспортировкой) товаров						</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusLoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusLoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusLoadCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(д) поправка на разницу в расходах на страхование в связи с операциями, указанными в разделе "в" и "г" графы 12</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusInsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusInsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusInsuranceCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">13 </span>
												<span class="graph">Итого графа 12 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusTotalSum"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusTotalSum"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:MinusTotalSum"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">14 </span>
												<span class="graph">(а) поправка на количество</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusQuantityCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusQuantityCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusQuantityCorrect"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) поправка на коммерческий уровень</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusCommerceCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusCommerceCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusCommerceCorrect"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(в) поправка на разницу в расходах на перевозку (транспортировку) товаров до 
													<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusBorderPlace"/>
												</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusBorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusBorderTransportCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusBorderTransportCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(г) поправка на разницу в расходах на погрузку, разгрузку или перегрузку товаров и проведение иных операций, связанных с перевозкой (транспортировкой товаров) 		</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusLoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusLoadCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusLoadCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(д) поправка на разницу в расходах на страхование в связи с операциями, указанными в разделах "в" и "г" графы 14</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusInsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusInsuranceCharges"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusInsuranceCharges"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">15 </span>
												<span class="graph">Итого по графе 14 в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusTotalSum"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusTotalSum"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:PlusTotalSum"/>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">16 </span>
												<span class="graph">Стоимость сделки с учетом поправок (11-13+15) в национальной валюте</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:TotalDealCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:TotalDealCorrect"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:Method2DealCorrect/cat_EDTS_cu:TotalDealCorrect"/>
											</td>
										</tr>
										<tr>
											<td class="graph" rowspan="2" style="width:20mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</td>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">17 </span>
												<span class="graph">Количество</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) идентичных (однородных) товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="(DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or (DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														(
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="($column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or ($column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														(
														<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="($column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or ($column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														(
														<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:IdenticalGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" style="width:90mm;border:solid 0.8pt #000000;" valign="top">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) ввозимых товаров</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="(DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or (DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														 (
														<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="($column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or ($column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														(
														<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="$column_2/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:GoodsQuantity"/>
												<xsl:if test="($column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName) or ($column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode)">
														(
														<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierCode"/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="$column_3/DTSout_CU:DTS_CUCustomsCostCalculation/cat_EDTS_cu:DTSMethod236/cat_EDTS_cu:DeclaratedGoodsQuantity/cat_EDTS_cu:MeasureUnitQualifierName"/>
														)
													</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graphNo">18 </span>
												<span class="graph">Таможенная стоимость ввозимых товаров ((16x17б/17а) или (16)):</span>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(а) в НАЦИОНАЛЬНОЙ ВАЛЮТЕ</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:NationalDeclaredCustomsCost"/>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="bottom">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<span class="graph">(б) в ДОЛЛАРАХ США 
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="$HasCurrencyDate and ($IsOneCurrencyDate=1)">
														<xsl:text>(курс пересчета</xsl:text>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template>едн.
															</xsl:if>
														</u>
											)</xsl:if>
												</span>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_2/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column_2/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column_2/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
											<td align="center" class="graph" style="width:23mm;border:solid 0.8pt #000000;" valign="middle">
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$column_3/DTSout_CU:DollarDeclaredCustomsCost"/>
												<xsl:if test="$IsOneCurrencyDate=0">
													<xsl:if test="$column_3/DTSout_CU:ExchangeRate">
														<br/>
														<xsl:text> (курс пересчета </xsl:text>
														<u>
															<xsl:apply-templates select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyA3Code"/>
															<xsl:if test="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate">/<xsl:apply-templates select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:CurrencyRate"/>
															</xsl:if>
															<xsl:if test="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber">
																<xsl:text> </xsl:text>/<xsl:call-template name="power">
																	<xsl:with-param name="number" select="10"/>
																	<xsl:with-param name="topower" select="$column_3/DTSout_CU:ExchangeRate/RUScat_ru:ScaleNumber"/>
																</xsl:call-template> ед.
															</xsl:if>
														</u>
														<xsl:text>)</xsl:text>
													</xsl:if>
												</xsl:if>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="5" style="width:180mm;border:solid 0.8pt #000000;" valign="top">
												<table cellpadding="0" cellspacing="0" style="width:100%;">
													<tbody>
														<tr>
															<td class="graph" colspan="3" style="width:180mm;" valign="top">
																<xsl:text>* Если сумма оплачена в иностранной валюте, указывается сумма в иностранной валюте и курс пересчета по каждому товару и каждой графе.</xsl:text>
															</td>
														</tr>
														<tr>
															<td class="graph" style="width:80mm;" valign="top">
																<span class="graph">Порядковый номер товара в ДТС-2 и номер графы ДТС-2</span>
															</td>
															<td class="graph" style="width:40mm;" valign="top">
																<span class="graph">Буквнный код валюты, сумма</span>
															</td>
															<td class="graph" style="width:40mm;" valign="top">
																<span class="graph">Курс пересчета</span>
															</td>
														</tr>
														<xsl:for-each select="DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" align="left" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
														<xsl:for-each select="$column_2/DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="$column_2/DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
														<xsl:for-each select="$column_3/DTSout_CU:DTSCurrencyPayment">
															<tr>
																<td class="graph" style="width:80mm;" align="center" valign="top">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="$column_3/DTSout_CU:GTDGoodsNumber"/>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:text>/</xsl:text>
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																	<xsl:apply-templates select="cat_EDTS_cu:PositionsNumber"/>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:if test="cat_EDTS_cu:CurrencyCode">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyCode"/>
																	</xsl:if>
																	<xsl:if test="cat_EDTS_cu:CurrencyAmount">
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:text>/</xsl:text>
																		<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		<xsl:apply-templates select="cat_EDTS_cu:CurrencyAmount"/>
																	</xsl:if>
																</td>
																<td class="graph" style="width:40mm;" valign="top">
																	<xsl:choose>
																		<xsl:when test="cat_EDTS_cu:CurrencyRate">
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:apply-templates select="cat_EDTS_cu:CurrencyRate"/>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:text>/</xsl:text>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																			<xsl:if test="cat_EDTS_cu:CurrencyQuantity">
																				<xsl:text> </xsl:text>
																				<xsl:apply-templates select="cat_EDTS_cu:CurrencyQuantity"/>ед.
																			</xsl:if>
																		</xsl:when>
																		<xsl:otherwise>
																			<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																		</xsl:otherwise>
																	</xsl:choose>
																</td>
															</tr>
														</xsl:for-each>
													</tbody>
												</table>
											</td>
										</tr>
										<tr>
											<td class="graph" colspan="2" style="width:110mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дополнительные данные</span>
												<br/>
												<xsl:variable name="GTDGoodsNumber1">
													<xsl:value-of select="DTSout_CU:GTDGoodsNumber"/>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber2">
													<xsl:choose>
														<xsl:when test="$column_2">
															<xsl:value-of select="$column_2/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:variable name="GTDGoodsNumber3">
													<xsl:choose>
														<xsl:when test="$column_3">
															<xsl:value-of select="$column_3/DTSout_CU:GTDGoodsNumber"/>
														</xsl:when>
														<xsl:otherwise>-1</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:for-each select="DTSout_CU:AdditionalData">
													<br/>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
													<xsl:if test="cat_EDTS_cu:PositionNumber">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
														<xsl:text> / </xsl:text>
														<xsl:variable name="xpath_KindCode16">
															<xsl:call-template name="get_xpath">
																<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
															</xsl:call-template>
														</xsl:variable>
														<element xml_node="{$xpath_KindCode16}">
															<xsl:choose>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																	<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																	<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																	<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																</xsl:when>
																<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																	<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																</xsl:when>
															</xsl:choose>
														</element>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
													</xsl:if>
													<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
														<xsl:text> / </xsl:text>
														<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
													</xsl:if>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
													<xsl:if test="cat_EDTS_cu:AdditionalInformation">
														<xsl:text>/ </xsl:text>
														<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
															<xsl:apply-templates select="."/>
															<xsl:if test="position()!=last()">
																<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
															</xsl:if>
														</xsl:for-each>
													</xsl:if>
												</xsl:for-each>
												<xsl:if test="$column_2">
													<xsl:for-each select="$column_2/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode17">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode17}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="$column_3">
													<xsl:for-each select="$column_3/DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:apply-templates select="../DTSout_CU:GTDGoodsNumber"/>
														<xsl:if test="cat_EDTS_cu:PositionNumber">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:PositionNumber"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:text> / </xsl:text>
															<xsl:variable name="xpath_KindCode18">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode18}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='2'">
																		<xsl:text>суммарная величина лицензионных и иных подобных платежей добавлена к цене, фактически уплаченной или поджежащей уплате за ввозимый товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='3'">
																		<xsl:text>лицензионные и иные подобные платежи (платежи за патенты, платежи за товарные знаки и т.д.) не включены в таможенную стоимость товара в связи с добавлением суммарной величины таких платежей к цене, фактически уплаченной или подлежащей уплате за товар</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
												<xsl:if test="../DTSout_CU:AdditionalData">
													<br/>
													<br>
														<xsl:text>Дополнительная информация, относящаяся ко всем товарам:</xsl:text>
													</br>
													<br/>
													<xsl:for-each select="../DTSout_CU:AdditionalData">
														<br/>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:CVDAdditionalInformationKindCode">
															<xsl:variable name="xpath_KindCode19">
																<xsl:call-template name="get_xpath">
																	<xsl:with-param name="node" select="cat_EDTS_cu:CVDAdditionalInformationKindCode"/>
																</xsl:call-template>
															</xsl:variable>
															<element xml_node="{$xpath_KindCode19}">
																<xsl:choose>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='1'">
																		<xsl:text>стоимость сделки близка к стоимости с идентичными товарами</xsl:text>
																	</xsl:when>
																	<xsl:when test="cat_EDTS_cu:CVDAdditionalInformationKindCode='9'">
																		<xsl:text>иные дополнительные сведения или расчеты</xsl:text>
																	</xsl:when>
																</xsl:choose>
															</element>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:CustomsDocIdDetails">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:CustomsDocIdDetails"/>
														</xsl:if>
														<xsl:if test="cat_EDTS_cu:DTConsignmentItemOrdinal">
															<xsl:text> / </xsl:text>
															<xsl:apply-templates select="cat_EDTS_cu:DTConsignmentItemOrdinal"/>
														</xsl:if>
														<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
														<xsl:if test="cat_EDTS_cu:AdditionalInformation">
															<xsl:text>/ </xsl:text>
															<xsl:for-each select="cat_EDTS_cu:AdditionalInformation">
																<xsl:apply-templates select="."/>
																<xsl:if test="position()!=last()">
																	<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
																</xsl:if>
															</xsl:for-each>
														</xsl:if>
													</xsl:for-each>
												</xsl:if>
											</td>
											<td class="graph" colspan="3" style="width:70mm;border:solid 0.8pt #000000;" valign="top">
												<span class="graph">Дата, подпись, печать</span>
												<br/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/RUScat_ru:SigningDate" mode="russian_date"/>
												<br/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonSurname"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonMiddleName"/>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												<xsl:apply-templates select="$DTS/DTSout_CU:DTSout_CUFilledPerson/RUDECLcat:SigningDetails/cat_ru:PersonPost"/>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- </xsl:if>-->
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
			</body>
		</html>
	</xsl:template>
	<xsl:template name="russian_date">
		<xsl:param name="dateIn"/>
		<xsl:choose>
			<xsl:when test="substring($dateIn,5,1)='-' and substring($dateIn,8,1)='-'">
				<xsl:value-of select="substring($dateIn,9,2)"/>.<xsl:value-of select="substring($dateIn,6,2)"/>.<xsl:value-of select="substring($dateIn,1,4)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$dateIn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="russian_date_gtd">
		<xsl:param name="dateIn"/>
		<xsl:choose>
			<xsl:when test="substring($dateIn,5,1)='-' and substring($dateIn,8,1)='-'">
				<xsl:value-of select="substring($dateIn,9,2)"/>
				<xsl:value-of select="substring($dateIn,6,2)"/>
				<xsl:value-of select="substring($dateIn,3,2)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$dateIn"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Шаблон для типа cat_EDTS_cu:CustomDocIDType -->
	<xsl:template match="cat_EDTS_cu:CustomsDocIdDetails|DTSout_CU:GTDNumber">
		<xsl:apply-templates select="cat_ru:CustomsCode"/>
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:RegistrationDate" mode="russian_date_gtd"/>
		<xsl:text>/</xsl:text>
		<xsl:apply-templates select="cat_ru:GTDNumber"/>
	</xsl:template>
	<!-- Реквизиты организации -->
	<xsl:template match="*" mode="org">
		<xsl:apply-templates select="cat_ru:OrganizationName"/>
		<xsl:if test="cat_ru:ShortName">
			<span class="graph"> (</span>
			<xsl:apply-templates select="cat_ru:ShortName"/>
			<span class="graph">)</span>
		</xsl:if>
		<xsl:if test="cat_ru:RFOrganizationFeatures">
			<br/>
			<xsl:apply-templates select="cat_ru:RFOrganizationFeatures"/>
		</xsl:if>
		<xsl:if test="cat_ru:RKOrganizationFeatures">
			<br/>
			<xsl:apply-templates select="cat_ru:RKOrganizationFeatures"/>
		</xsl:if>
		<xsl:if test="cat_ru:RBOrganizationFeatures">
			<br/>
			<xsl:apply-templates select="cat_ru:RBOrganizationFeatures"/>
		</xsl:if>
		<xsl:if test="cat_ru:RAOrganizationFeatures">
			<br/>
			<xsl:apply-templates select="cat_ru:RAOrganizationFeatures"/>
		</xsl:if>
		<xsl:if test="cat_ru:KGOrganizationFeatures">
			<br/>
			<xsl:apply-templates select="cat_ru:KGOrganizationFeatures"/>
		</xsl:if>
		<xsl:if test="RUScat_ru:SubjectAddressDetails">
			<xsl:for-each select="RUScat_ru:SubjectAddressDetails">
				<br/>
				<xsl:apply-templates mode="ru_address" select="."/>
				<xsl:if test="position()!=last()">; </xsl:if>
			</xsl:for-each>
		</xsl:if>
		<xsl:if test="RUScat_ru:IdentityCard">
			<br/>
			<xsl:apply-templates mode="spaceSeparated" select="RUScat_ru:IdentityCard"/>
		</xsl:if>
		<xsl:if test="RUScat_ru:CommunicationDetails">
			<span class="normal">
				<xsl:for-each select="RUScat_ru:CommunicationDetails">
					<br/>
					<xsl:call-template name="CommunicationDetails"/>
				</xsl:for-each>
			</span>
		</xsl:if>
		<xsl:for-each select="RUScat_ru:SubjectBranch">
			<br/>
			<xsl:apply-templates select="cat_ru:OrganizationName"/>
			<xsl:if test="cat_ru:ShortName">
				<span class="graph"> (</span>
				<xsl:apply-templates select="cat_ru:ShortName"/>
				<span class="graph">)</span>
			</xsl:if>
			<xsl:if test="cat_ru:RFOrganizationFeatures">
				<br/>
				<xsl:apply-templates select="cat_ru:RFOrganizationFeatures"/>
			</xsl:if>
			<xsl:if test="cat_ru:RKOrganizationFeatures">
				<br/>
				<xsl:apply-templates select="cat_ru:RKOrganizationFeatures"/>
			</xsl:if>
			<xsl:if test="cat_ru:RBOrganizationFeatures">
				<br/>
				<xsl:apply-templates select="cat_ru:RBOrganizationFeatures"/>
			</xsl:if>
			<xsl:if test="cat_ru:RAOrganizationFeatures">
				<br/>
				<xsl:apply-templates select="cat_ru:RAOrganizationFeatures"/>
			</xsl:if>
			<xsl:if test="cat_ru:KGOrganizationFeatures">
				<br/>
				<xsl:apply-templates select="cat_ru:KGOrganizationFeatures"/>
			</xsl:if>
			<xsl:for-each select="RUScat_ru:SubjectAddressDetails">
				<br/>
				<xsl:apply-templates mode="ru_address" select="."/>
			</xsl:for-each>
			<xsl:if test="RUScat_ru:CommunicationDetails">
				<span class="normal">
					<xsl:for-each select="RUScat_ru:CommunicationDetails">
						<br/>
						<xsl:call-template name="CommunicationDetails"/>
					</xsl:for-each>
				</span>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<!-- Шаблон для типа cat_ru:RFOrganizationFeaturesType -->
	<xsl:template match="cat_ru:RFOrganizationFeatures">
		<xsl:text>№ </xsl:text>
		<xsl:if test="cat_ru:INN">
			<xsl:apply-templates select="cat_ru:INN"/>
		</xsl:if>
		<xsl:if test="cat_ru:KPP">
			<xsl:text> / </xsl:text>
			<xsl:apply-templates select="cat_ru:KPP"/>
		</xsl:if>
		<br>
			<xsl:apply-templates select="cat_ru:OGRN"/>
		</br>
	</xsl:template>
	<!-- Шаблон для типа cat_ru:RKOrganizationFeatures -->
	<xsl:template match="cat_ru:RKOrganizationFeatures">
		<xsl:text>№ </xsl:text>
		<xsl:if test="cat_ru:BIN">
			<xsl:apply-templates select="cat_ru:BIN"/>
		</xsl:if>
		<xsl:if test="cat_ru:IIN">
			<xsl:apply-templates select="cat_ru:IIN"/>
		</xsl:if>
		<br>
			<xsl:for-each select="cat_ru:ITN">
				<xsl:apply-templates select="cat_ru:CategoryCode"/>/<xsl:apply-templates select="cat_ru:KATOCode"/>/<xsl:apply-templates select="cat_ru:RNN"/>
				<xsl:if test="cat_ru:ITNReserv">/<xsl:apply-templates select="cat_ru:ITNReserv"/>
				</xsl:if>
			</xsl:for-each>
		</br>
	</xsl:template>
	<!-- Шаблон для типа cat_ru:RBOrganizationFeatures -->
	<xsl:template match="cat_ru:RBOrganizationFeatures">
		<xsl:text>№ </xsl:text>
		<xsl:if test="cat_ru:UNP">
			<xsl:apply-templates select="cat_ru:UNP"/>
		</xsl:if>
		<br/>
	</xsl:template>
	<!-- Шаблон для типа cat_ru:RAOrganizationFeatures -->
	<xsl:template match="cat_ru:RAOrganizationFeatures">
		<xsl:text>№ </xsl:text>
		<xsl:if test="cat_ru:UNN">
			<xsl:apply-templates select="cat_ru:UNN"/>
		</xsl:if>
		<br/>
	</xsl:template>
	<!-- Шаблон для типа cat_ru:KGOrganizationFeatures -->
	<xsl:template match="cat_ru:KGOrganizationFeatures">
		<xsl:text>№ </xsl:text>
		<xsl:if test="cat_ru:KGINN">
			<xsl:apply-templates select="cat_ru:KGINN"/>
		</xsl:if>
		<br/>
		<xsl:apply-templates select="cat_ru:KGOKPO"/>
	</xsl:template>
	<!-- Адрес -->
	<xsl:template match="*" mode="ru_address">
		<xsl:choose>
			<xsl:when test="RUScat_ru:AddressText">
				<xsl:if test="RUScat_ru:AddressKindCode">
					<xsl:variable name="xpath_AddressKindCode">
						<xsl:call-template name="get_xpath">
							<xsl:with-param name="node" select="RUScat_ru:AddressKindCode"/>
						</xsl:call-template>
					</xsl:variable>
					<element xml_node="{$xpath_AddressKindCode}">
						<xsl:choose>
							<xsl:when test="RUScat_ru:AddressKindCode='1'">Адрес регистрации: </xsl:when>
							<xsl:when test="RUScat_ru:AddressKindCode='2'">Фактический адрес: </xsl:when>
							<xsl:when test="RUScat_ru:AddressKindCode='3'">Почтовый адрес: </xsl:when>
						</xsl:choose>
					</element>
				</xsl:if>
				<xsl:apply-templates select="RUScat_ru:AddressText"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="last">
					<!-- надо через переменную, т.к. смещение на невыводимые KLADR, AOGUID, AOID -->
					<xsl:choose>
						<xsl:when test="local-name(*[last()])='KLADR' or local-name(*[last()])='AOGUID' or local-name(*[last()])='AOID'">
							<xsl:choose>
								<xsl:when test="RUScat_ru:KLADR and RUScat_ru:AOGUID and RUScat_ru:AOID">
									<xsl:value-of select="count(*) - 3"/>
								</xsl:when>
								<xsl:when test="(not(RUScat_ru:KLADR) and RUScat_ru:AOGUID and RUScat_ru:AOID) or (RUScat_ru:KLADR and not(RUScat_ru:AOGUID) and RUScat_ru:AOID) or (RUScat_ru:KLADR and RUScat_ru:AOGUID and not(RUScat_ru:AOID)) ">
									<xsl:value-of select="count(*) - 2"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="count(*) - 1"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="count(*)"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<xsl:for-each select="*">
					<xsl:if test="local-name()='OKTMO'">ОКТМО: </xsl:if>
					<xsl:if test="local-name()='OKATO'"> ОКАТО: </xsl:if>
					<!--xsl:if test="local-name()='KLADR'">Код КЛАДР: </xsl:if>
					<xsl:if test="local-name()='AOGUID'">Глобальный ИД по ФИАС: </xsl:if>
					<xsl:if test="local-name()='AOID'">Уникальный ИД по ФИАС: </xsl:if-->
					<xsl:if test="local-name()='TerritoryCode'">Код единицы административно - территориального деления: </xsl:if>
					<xsl:if test="local-name()='PostOfficeBoxId'">Номер а/я: </xsl:if>
					<xsl:choose>
						<xsl:when test="local-name()='AddressKindCode'">
							<xsl:variable name="xpath_AddressKindCode1">
								<xsl:call-template name="get_xpath">
									<xsl:with-param name="node" select="."/>
								</xsl:call-template>
							</xsl:variable>
							<element xml_node="{$xpath_AddressKindCode1}">
								<xsl:choose>
									<xsl:when test=".='1'">Адрес регистрации: </xsl:when>
									<xsl:when test=".='2'">Фактический адрес: </xsl:when>
									<xsl:when test=".='3'">Почтовый адрес: </xsl:when>
								</xsl:choose>
							</element>
						</xsl:when>
						<xsl:when test="local-name()='CountryCode'">
							<xsl:if test="not(../RUScat_ru:CounryName)">
								<xsl:apply-templates select="."/>
								<xsl:if test="position()!=$last">, </xsl:if>
							</xsl:if>
						</xsl:when>
						<xsl:when test="local-name()='KLADR' or local-name()='AOGUID' or local-name()='AOID'">
							<!--в этом случае ничего не выводим-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="."/>
							<xsl:if test="position()!=$last">, </xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="*" mode="spaceSeparated">
		<xsl:if test="position() > 1">
			<xsl:text> </xsl:text>
		</xsl:if>
		<xsl:apply-templates select="."/>
	</xsl:template>
	<xsl:template match="RUScat_ru:IdentityCard|RUScat_ru:IdentityCard">
		<xsl:for-each select="*">
			<xsl:choose>
				<xsl:when test="local-name()='IdentityCardDate'">
					<xsl:apply-templates select="." mode="russian_date"/>
				</xsl:when>
				<xsl:when test="local-name()='DocValidityDate'">
					<xsl:text>(окончание срока действия: </xsl:text>
					<xsl:apply-templates select="." mode="russian_date"/>
					<xsl:text>)</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="."/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="position()!=last()">
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="CommunicationDetails">
		<xsl:variable name="temp">
			<xsl:call-template name="RUScat_ru:CommunicationDetails"/>
		</xsl:variable>
		<xsl:value-of select="substring($temp,1,string-length($temp)-2)"/>
	</xsl:template>
	<xsl:template name="RUScat_ru:CommunicationDetails" match="RUScat_ru:CommunicationDetails">
		<xsl:if test="cat_ru:Phone">
			<span class="italic">Тел</span>
			<span class="normal">: </span>
			<span class="normal">
				<xsl:for-each select="cat_ru:Phone">
					<xsl:apply-templates select="."/>
					<span class="normal">, </span>
				</xsl:for-each>
			</span>
		</xsl:if>
		<xsl:if test="cat_ru:Fax">
			<span class="italic">Факс</span>
			<span class="normal">: </span>
			<span class="normal">
				<xsl:apply-templates select="cat_ru:Fax"/>
				<span class="normal">, </span>
			</span>
		</xsl:if>
		<xsl:if test="cat_ru:Telex">
			<span class="italic">Телекс</span>
			<span class="normal">: </span>
			<span class="normal">
				<xsl:apply-templates select="cat_ru:Telex"/>
				<span class="normal">, </span>
			</span>
		</xsl:if>
		<xsl:if test="cat_ru:E_mail">
			<span class="italic">Email</span>
			<span class="normal">: </span>
			<span class="normal">
				<xsl:for-each select="cat_ru:E_mail">
					<xsl:apply-templates select="."/>
					<span class="normal">, </span>
				</xsl:for-each>
			</span>
		</xsl:if>
	</xsl:template>
	<!-- возведение в степень -->
	<xsl:template name="power">
		<xsl:param name="number"/>
		<xsl:param name="topower"/>
		<xsl:param name="curvalue" select="1"/>
		<xsl:param name="curpower" select="1"/>
		<xsl:choose>
			<xsl:when test="$curpower &gt; $topower">
				<xsl:value-of select="$curvalue"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="power">
					<xsl:with-param name="number" select="$number"/>
					<xsl:with-param name="topower" select="$topower"/>
					<xsl:with-param name="curvalue" select="$curvalue * $number"/>
					<xsl:with-param name="curpower" select="$curpower + 1"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
