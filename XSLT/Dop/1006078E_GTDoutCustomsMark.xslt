<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:catESAD_cu="urn:customs.ru:CUESADCommonAggregateTypesCust:5.17.0" xmlns:catESAD_ru="urn:customs.ru:RUCommonAggregateTypes:5.17.0" xmlns:cat_ru="urn:customs.ru:CommonAggregateTypes:5.10.0" xmlns:goom="urn:customs.ru:Information:CustomsDocuments:GTDOutCustomsMark:5.17.0" xmlns:RUScat_ru="urn:customs.ru:RUSCommonAggregateTypes:5.16.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output encoding="UTF-8" indent="yes" method="html" version="1.0"/>
	<xsl:template match="/">
		<xsl:apply-templates/>
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
	<xsl:template name="russian_date2">
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
	<xsl:template match="goom:GTDoutCustomsMark">
		<html>
			<head>
				<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
				<title>Служебные отметки ДТ</title>
				<style type="text/css">
                    body {
                        text-align: center;
                        background: #cccccc;
                    }

                    div.page {
                        margin-top: 6pt;
                        margin-bottom: 6pt;
                        padding: 10mm;
                        padding-left: 20mm;
                        background: #ffffff;
                        border: solid 1pt #000000;
                    }

					/*Стиль для удаления чёрной границы вокруг нарисованной "страницы" при печати*/
					@media print {div.page {border: none; margin: 0; padding: 0;}}

                    div.goods {
                        background: #ffffff;
                    }

                    .bordered {
                        border: solid 1pt #000000;
                        padding-top: 4pt;
                        padding-bottom: 4pt;
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
                        font-family: Courier New;
                    }

                    .graphBody {
                        font-family: Arial;
                        font-size: 8pt;
                    }

                    .graphGTD {
                        font-family: Arial;
                        font-size: 9pt;
                    }

                    .graphTable {
                        font-family: Arial;
                        font-size: 7pt;
                    }

                    .graphHead {
                        font-family: Arial;
                        font-size: 10pt;
                    }

                    .graphMain {
                        font-family: Arial;
                        font-size: 9pt;
                        font-weight: bold;
                    }

                    .graphNo {
                        font-size: 10pt;
                        font-weight: bold;
                    }
                </style>
			</head>
			<body>
				<div class="page">
					<table border="0" width="100%">
						<tbody>
							<tr>
								<td align="center" height="36">
									<span style="font-size:20; font-weight:bold; text-decoration:underline; ">Служебные
                                        отметки ДТ
                                    </span>
								</td>
							</tr>
						</tbody>
					</table>
					<p align="left">
						<span style="font-size:16; font-weight:bold;">Регистрационный номер ДТ</span>
						<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
						<xsl:apply-templates select="goom:GTDID"/>
					</p>
					<xsl:if test="goom:AddID">
						<p align="left">
							<span style="font-size:16; font-weight:bold;">Регистрационный номер связанного документа</span>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
							<xsl:apply-templates select="goom:AddID"/>
						</p>
					</xsl:if>
					<br/>
					<p align="left">
						<span style="font-size:16; font-weight:bold; ">Принятые решения по ДТ</span>
					</p>
					<table border="0" width="100%">
						<tbody>
							<tr class="graphBody">
								<xsl:if test=" goom:GTDOutResolution/catESAD_ru:DecisionCode">
									<td>Код</td>
									<td align="center">
										<xsl:for-each select=" goom:GTDOutResolution/catESAD_ru:DecisionCode">
											<xsl:apply-templates/>
										</xsl:for-each>
									</td>
								</xsl:if>
								<xsl:if test=" goom:GTDOutResolution/goom:ResolutionDescription">
									<td align="center">Описание</td>
									<td>
										<xsl:for-each select=" goom:GTDOutResolution/goom:ResolutionDescription">
											<xsl:apply-templates/>
										</xsl:for-each>
									</td>
								</xsl:if>
								<xsl:if test=" goom:GTDOutResolution/catESAD_ru:DateInf">
									<td align="center">Дата</td>
									<td align="center">
										<xsl:call-template name="russian_date">
											<xsl:with-param name="dateIn" select=" goom:GTDOutResolution/catESAD_ru:DateInf"/>
										</xsl:call-template>
									</td>
								</xsl:if>
								<xsl:if test=" goom:GTDOutResolution/catESAD_ru:TimeInf">
									<td align="center">Время</td>
									<td align="center">
										<xsl:for-each select=" goom:GTDOutResolution/catESAD_ru:TimeInf">
											<xsl:apply-templates/>
										</xsl:for-each>
									</td>
								</xsl:if>
								<xsl:if test=" goom:GTDOutResolution/catESAD_ru:Foundation">
									<td align="center">Обоснование</td>
									<td>
										<xsl:for-each select=" goom:GTDOutResolution/catESAD_ru:Foundation">
											<xsl:apply-templates/> 
                                        </xsl:for-each>
									</td>
								</xsl:if>
							</tr>
						</tbody>
					</table>
					<br/>
					<p align="left">
						<span style="font-size:16;  font-weight:bold; ">Служебные отметки ДТ (Графы A, C, D)</span>
					</p>
					<table border="1" cellspacing="0">
						<thead class="graphTable">
							<tr>
								<td align="center" width="50">Номер графы (A, C, D)</td>
								<td align="center" width="100">Иденти- фикатор простав- ленной тех. отметки - 1. Номер
                                    этапа
                                </td>
								<td align="center">Дата предъявления товаров</td>
								<td align="center">Время предъявления  товаров</td>
								<td align="center" width="100">Иденти- фикатор простав- ленной тех. отметки - 2. Тип
                                    примечания. (Код)
                                </td>
								<td align="center" width="100">Порядковый номер записи по идентифи- катору тех. отметки
                                </td>
								<td align="center" width="100">Код типа инфор- мации</td>
								<td align="center">Служебная запись / номер документа</td>
								<td align="center" width="100">Дата / Дата принятия решения о продлении срока проверки
                                </td>
								<td align="center">Время</td>
								<td align="center">Сумма денежных средств / Суммарный объем отделений транспортных
                                    средств
                                </td>
								<td align="center">Код вида платежа (пени, штрафы)</td>
								<td align="center" width="100">Процент за предос- тавление отсрочки / рассрочки</td>
								<td align="center">Код валюты денежных средств / Код единицы измерения / код валюты
                                    денежных средств / Код единицы измерения / Код страны / Код основания продления срока выпуска товаров
                                </td>
								<td align="center">Наименование валюты денежных средств / Краткое наименование единицы
                                    измерения
                                </td>
								<td align="center">ФИО инспектора, заверивше- го запись</td>
								<td align="center">ЛНП инспектора, заверивше- го запись</td>
								<td align="center">Дата завершения разделения товарной партии на отдельные товары</td>
								<td align="center">Время</td>
								<xsl:if test="//goom:GTDOutCommonMark/catESAD_ru:Deadline">
									<td align="center">Дата / Срок сдачи</td>
								</xsl:if>
								<xsl:if test="goom:GTDOutCommonMark/goom:PaymentWayCode">
									<td align="center">Код способа обеспечения уплаты </td>
								</xsl:if>
								<xsl:if test="goom:GTDOutCommonMark/goom:GuaranteeFoundation">
									<td align="center">Основание предоставления обеспечения уплаты таможенных  пошлин </td>
								</xsl:if>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="goom:GTDOutCommonMark">
								<xsl:sort select="catESAD_ru:DateInf"/>
								<xsl:sort select="catESAD_ru:TimeInf"/>
								<tr class="graphBody">
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:GRNumber">
												<xsl:value-of select="catESAD_ru:GRNumber"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:StageMarkIdentifier">
												<xsl:value-of select="catESAD_ru:StageMarkIdentifier"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="goom:GoodsPresentDate">
												<xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="goom:GoodsPresentDate"/>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="goom:GoodsPresentTime">
												<xsl:value-of select="substring(goom:GoodsPresentTime,1, 8)"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:NoteMarkIdentifier">
												<xsl:value-of select="catESAD_ru:NoteMarkIdentifier"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<!-- ??? Куда делся -->
										<!-- 10.12.2010: я тоже не нашла :) -->
										<!-- 18.02.2015: в схемен отсутствует -->
										<!--xsl:choose>
                                 <xsl:when test="catESAD_ru:RecordNumber">
                                    <xsl:value-of select="catESAD_ru:RecordNumber"/>
                                 </xsl:when>
                                 <xsl:otherwise-->
										<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										<!--/xsl:otherwise>
                              </xsl:choose-->
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:InformationTypeCode">
												<xsl:value-of select="catESAD_ru:InformationTypeCode"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:MarkDescription">
												<xsl:value-of select="catESAD_ru:MarkDescription"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center" width="100">
										<!--span style="background-color:#C0C0C0; width:2 cm; "-->
										<xsl:choose>
											<xsl:when test="catESAD_ru:DateInf">
												<xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="catESAD_ru:DateInf"/>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:TimeInf">
												<xsl:value-of select="catESAD_ru:TimeInf"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:Amount">
												<xsl:value-of select="catESAD_ru:Amount/RUScat_ru:Amount"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:PaymentTypeCode">
												<xsl:value-of select="catESAD_ru:PaymentTypeCode"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:PostponementProcent">
												<xsl:value-of select="catESAD_ru:PostponementProcent"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:Code">
												<xsl:value-of select="catESAD_ru:Code"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:Amount/RUScat_ru:CurrencyCode">
												<xsl:value-of select="catESAD_ru:Amount/RUScat_ru:CurrencyCode"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:PersonName">
												<xsl:value-of select="catESAD_ru:PersonName"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:LNP">
												<xsl:value-of select="catESAD_ru:LNP"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:GoodsDevisionDate">
												<xsl:call-template name="russian_date">
													<xsl:with-param name="dateIn" select="catESAD_ru:GoodsDevisionDate"/>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="catESAD_ru:GoodsDevisionTime">
												<xsl:value-of select="catESAD_ru:GoodsDevisionTime"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<xsl:if test="//goom:GTDOutCommonMark/catESAD_ru:Deadline">
										<td>
											<xsl:choose>
												<xsl:when test="catESAD_ru:Deadline">
													<xsl:call-template name="russian_date">
														<xsl:with-param name="dateIn" select="catESAD_ru:Deadline"/>
													</xsl:call-template>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</xsl:if>
									<xsl:if test="//goom:PaymentWayCode">
										<td align="center">
											<xsl:choose>
												<xsl:when test="goom:PaymentWayCode">
													<xsl:value-of select="goom:PaymentWayCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</xsl:if>
									<xsl:if test="//goom:GuaranteeFoundation">
										<td align="center">
											<xsl:choose>
												<xsl:when test="goom:GuaranteeFoundation">
													<xsl:value-of select="goom:PaymentWayCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</xsl:if>
									<!--td align="center" width="100">
                              <span style="background-color:#C0C0C0; width:2 cm; ">
                           </td-->
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
					<br/>
					<p align="left">
						<span style="font-size:16; font-weight:bold;">Принятые решения по товарам</span>
					</p>
					<table border="1" cellspacing="0" width="100%">
						<thead>
							<tr class="graphTable">
								<td align="center">Номер товара по ДТ</td>
								<td align="center">Код</td>
								<td align="center">Описание</td>
								<td align="center">Дата / Дата принятия решения<br/>о продлении срока проверки</td>
								<td align="center">Время</td>
								<td align="center">Обоснование</td>
								<td align="center">ЛНП инспектора</td>
								<td align="center">ФИО инспектора</td>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="goom:GTDOutGoodsResolution">
								<xsl:variable name="rowspan" select="count(goom:GTDOutGoodsResult)"/>
								<tr class="graphBody">
									<td align="center" width="50" rowspan="{$rowspan}">
										<xsl:value-of select="goom:GoodsNumeric"/>
									</td>
									<xsl:apply-templates select="goom:GTDOutGoodsResult[position() = 1]"/>
								</tr>
								<xsl:for-each select="goom:GTDOutGoodsResult[position() > 1]">
									<tr class="graphBody">
										<xsl:apply-templates select="."/>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</tbody>
					</table>
					<br/>
					<p align="left">
						<span style="font-size:16; font-weight:bold; ">Служебные отметки по товарам</span>
					</p>
					<table border="1" cellspacing="0" width="100%">
						<thead>
							<tr class="graphTable">
								<td align="center">Номер товара по ДТ</td>
								<td align="center" width="100">Иденти- фикатор простав- ленной тех. отметки - 1. Номер
                                    этапа
                                </td>
								<td align="center" width="100">Иденти- фикатор простав- ленной тех. отметки - 2. Тип
                                    примеча- ния
                                </td>
								<td align="center" width="100">Описание тех. отметки</td>
								<td align="center" width="100">Порядко- вый номер записи по иденти- фикатору тех.
                                    отметки
                                </td>
								<td align="center" width="100">Код типа инфор- мации</td>
								<td align="center">Служебная запись / номер документа</td>
								<td align="center">Дата / Дата принятия решения о продлении срока проверки</td>
								<td align="center">Время</td>
								<xsl:if test="//goom:GTDOutGoodsResolution/goom:GTDOutGoodsMark/goom:Code">
									<td align="center">Код основания <br/>продления срока <br/>выпуска товаров</td>
								</xsl:if>
								<td align="center">ФИО инспектора, заверивше- го запись</td>
								<td align="center" width="100">ЛНП инспектора заверивше- го запись</td>
								<td align="center" width="100">Дата выполнения требований Декларан - том/ Дата, по
                                    которой приоста- новлен выпуск товаров
                                </td>
								<td align="center">Время</td>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="goom:GTDOutGoodsResolution">
								<xsl:variable name="GTDOutGoodsResolution" select="current()"/>
								<xsl:for-each select="goom:GTDOutGoodsMark">
									<tr class="graphBody">
										<td align="center" width="50">
											<xsl:value-of select="$GTDOutGoodsResolution/goom:GoodsNumeric"/>
										</td>
										<td align="center">
											<xsl:choose>
												<xsl:when test="catESAD_ru:StageMarkIdentifier">
													<xsl:value-of select="catESAD_ru:StageMarkIdentifier"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td align="center">
											<xsl:choose>
												<xsl:when test="catESAD_ru:NoteMarkIdentifier">
													<xsl:value-of select="catESAD_ru:NoteMarkIdentifier"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td>
											<xsl:choose>
												<xsl:when test="catESAD_ru:IdentifierDescription">
													<xsl:value-of select="catESAD_ru:IdentifierDescription"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td align="center">
											<!-- 18.02.2015: в схеме отсутствует -->
											<!--xsl:choose>
                                    <xsl:when test="catESAD_cu:RecordNumber">
                                       <xsl:value-of select="catESAD_cu:RecordNumber"/>
                                    </xsl:when>
                                    <xsl:otherwise-->
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											<!--/xsl:otherwise>
                                 </xsl:choose-->
										</td>
										<td align="center">
											<xsl:choose>
												<xsl:when test="catESAD_ru:InformationTypeCode">
													<xsl:value-of select="catESAD_ru:InformationTypeCode"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td>
											<xsl:choose>
												<xsl:when test="catESAD_ru:MarkDescription">
													<xsl:value-of select="catESAD_ru:MarkDescription"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td align="center" width="100">
											<xsl:call-template name="russian_date">
												<xsl:with-param name="dateIn" select="catESAD_ru:DateInf"/>
											</xsl:call-template>
											<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
										</td>
										<td align="center">
											<xsl:choose>
												<xsl:when test="catESAD_ru:TimeInf">
													<xsl:value-of select="substring(catESAD_ru:TimeInf,1,8)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<xsl:if test="//goom:GTDOutGoodsResolution/goom:GTDOutGoodsMark/goom:Code">
											<td align="center">
												<xsl:choose>
													<xsl:when test="catESAD_ru:Code">
														<xsl:value-of select="catESAD_ru:Code"/>
													</xsl:when>
													<xsl:otherwise>
                                                     
                                                </xsl:otherwise>
												</xsl:choose>
											</td>
										</xsl:if>
										<td align="center">
											<xsl:choose>
												<xsl:when test="catESAD_ru:PersonName">
													<xsl:value-of select="catESAD_ru:PersonName"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td align="center">
											<xsl:choose>
												<xsl:when test="catESAD_ru:LNP">
													<xsl:value-of select="catESAD_ru:LNP"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td align="center" width="100">
											<xsl:choose>
												<xsl:when test="catESAD_ru:ReqCompletionDate">
													<xsl:call-template name="russian_date">
														<xsl:with-param name="dateIn" select="catESAD_ru:ReqCompletionDate"/>
													</xsl:call-template>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
										<td align="center">
											<xsl:choose>
												<xsl:when test="catESAD_ru:ReqCompletionDate">
													<xsl:value-of select="substring(catESAD_ru:ReqCompletionDate,12,8)"/>
												</xsl:when>
												<xsl:otherwise>
													<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
												</xsl:otherwise>
											</xsl:choose>
										</td>
									</tr>
								</xsl:for-each>
							</xsl:for-each>
						</tbody>
					</table>
					<br/>
					<p align="left">
						<span style="font-size:16; font-weight:bold; ">Метод определения и признак корректировки
                            таможенной стоимости
                        </span>
					</p>
					<table border="1" cellspacing="0" width="100%">
						<thead>
							<tr class="graphTable">
								<td align="center">Номер товара по ДТ</td>
								<td align="center">Признак</td>
								<td align="center">Метод</td>
							</tr>
						</thead>
						<tbody>
							<xsl:for-each select="goom:GTDOutGoodsResolution">
								<tr class="graphBody">
									<td align="center">
										<xsl:value-of select="goom:GoodsNumeric"/>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="goom:CustCostMethod/goom:CustomsCostCorrectMark">
												<xsl:value-of select="goom:CustCostMethod/goom:CustomsCostCorrectMark"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</td>
									<td align="center">
										<xsl:choose>
											<xsl:when test="goom:CustCostMethod/goom:CustomsCostCorrectMethod">
												<xsl:value-of select="goom:CustCostMethod/goom:CustomsCostCorrectMethod"/>
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
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="goom:GTDID| goom:AddID">
		<span class="graphGTD">
			<xsl:value-of select="cat_ru:CustomsCode"/>
			<xsl:text>/</xsl:text>
			<xsl:call-template name="russian_date2">
				<xsl:with-param name="dateIn" select="cat_ru:RegistrationDate"/>
			</xsl:call-template>
			<xsl:text>/</xsl:text>
			<xsl:choose>
				<xsl:when test="goom:AddNumber = 'ЗВ'">В</xsl:when>
				<xsl:otherwise><xsl:value-of select="goom:AddNumber"/></xsl:otherwise>
			</xsl:choose>
			<xsl:value-of select="cat_ru:GTDNumber"/>
		</span>
	</xsl:template>
	<xsl:template match="goom:GTDOutGoodsResult">
		<td align="center">
			<xsl:choose>
				<xsl:when test="catESAD_ru:DecisionCode">
					<xsl:value-of select="catESAD_ru:DecisionCode"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td>
			<xsl:choose>
				<xsl:when test="goom:ResolutionDescription">
					<xsl:value-of select="goom:ResolutionDescription"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td align="center" width="100">
			<xsl:choose>
				<xsl:when test="catESAD_ru:DateInf">
					<xsl:call-template name="russian_date">
						<xsl:with-param name="dateIn" select="catESAD_ru:DateInf"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td align="center">
			<xsl:choose>
				<xsl:when test="catESAD_ru:TimeInf">
					<xsl:value-of select="substring(catESAD_ru:TimeInf,1,8)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td>
			<xsl:choose>
				<xsl:when test="catESAD_ru:Foundation">
					<xsl:for-each select="catESAD_ru:Foundation">
						<xsl:value-of select="."/> </xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</td>
		<td align="center">
			<xsl:value-of select="catESAD_ru:LNP"/>
		</td>
		<td align="center">
			<xsl:value-of select="goom:PersonName"/>
		</td>
	</xsl:template>
</xsl:stylesheet>
