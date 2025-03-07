Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E1D18785D;
	Fri,  7 Mar 2025 02:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314400; cv=fail; b=nE5i3zUOidnAMLLVDJPYHo5FNvOjLyta2aD5m4aZIB+6nWVLxjTfXbqx6Cpo/nVg4lhJND/wcbUgN4/cMpvw5uu+rBVUZpJ8upz5wwugb8cOLKPu+R/Hml5jCu9y8ipZLNPafPKgw7i3i2oBUt77kHtWZAVy+suyxyslrw9sQhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314400; c=relaxed/simple;
	bh=SvAxeCPVLz+oJH7VkWcKjMhd6EbTOT6cxWeKn9FnT20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kOrHLRkB0ts/Achh2i7ll8opfAap2AVgu5VZkcIgI+MfPtAgWJ9Cr3D9pLf/cImIlyts2Y446RGpDagDO03RijYkQU1JC2+ZnO64nNgxXMBpZ93J6gjfCQeg6jW7FHB51rruLVvVz7zTOmo8HtLE7eNKpZCJH8WdzYtCV9GJa98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G3I7CKQg; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G3I7CKQg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqIhy1oW3d5wWFaKK3L6LkP9jZngEzgF5iQA9Q6aIJTrw8WgZw9tv2yd5qidUtVUouko8e94jYMx2zpcqAkW5gmHhuODZS0E5lE9ML2ZU0uNgAbqOY8KQVKIuGj/hh7LDNsie3EARiIj7YJ6952EssPYbl08mJYt2b3C7EUhrZKTfsOGHWy/TTBF0WrGW+pQdYyuKgGS7KNFfJ9nrflRRoQlSUMfxhDgFnKXAgAqCTAr0rJQRE3sKSqO1KuVHo9HGOL9iJ38Dn2sDfp6bITEfURFzXIC/VhrEhON3RFkWS/Y2PsP8M7tbUgelPWNUqllCIuoLCjJHxGEQRumPlTJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4+NNzrrxQT2smN3zgbk/Q/gYfXX5ykBgT47gqx1vJE=;
 b=TDSuYI1UycIYE37UbRUNtUftZtjRtN9Utrf43f0JXCV0s6FW342FKfU24rYdZlmz01Q1nPU5HDFFD1TKICZd/dzmiCL44SkWJiaRQCmwwMk/OKbbUV98bthOpnXrcwPQE2ovmKGVJ0CPmbS0BBI7zAfhbmTtIAtbP3NYZEDPtWnrRskPpTexh6If0e24tFfvPgSCcPdVneioY1wGmN6696pLnWd5zJQ8uRcjYiexR/PZth07mbOwdQHO/nb+fhjko82504OHLvXcwZ7iPrAWAFBo0afHm/e49sqVgJ9+F4+fxisWbFfJETQuS7kAvwdn36L3zWlrm1lNP1Rrt9q+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4+NNzrrxQT2smN3zgbk/Q/gYfXX5ykBgT47gqx1vJE=;
 b=G3I7CKQg3JJ4Fqj/TSmF1mP2+6gds52z5gHDTj2Hq92JDNCLkp7j23KnyPvEFJ0XH15GBs378B978vPVx6PwHkpCtaV8ptt7UIhFyM1NG0pH0pHvOWVYii4Xx87pLMlcBVjhhzd1TVuBtoYr/C/guh4hC9SJYddH4Ng5La3ecsmnQjU5kgQWBwV9eLi+ypC+ITvYqpE6ntT3kmF6VT3QZ68O+OijVnH7DLtRKIY9/qFkVlNgAoW/gJaB8PxoolGr5Gw2Use8eZeBTKY+ogQGUsQo0GbY/WJ2YBv5yyV2tLJec+SYS6EJO68t5cr7QF+UeMnszGNAAbhUFN8dQj5LdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 02:26:34 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:26:34 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH 1/2] tty: serial: fsl_lpuart: Use u32 for register variables
Date: Fri,  7 Mar 2025 10:25:46 +0800
Message-Id: <20250307022547.1000293-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307022547.1000293-1-sherry.sun@nxp.com>
References: <20250307022547.1000293-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b6b323-d9b7-4a8a-b942-08dd5d1f7a89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yCTMFZpr79PYHPqdzlXwcbNz2fgWGDMGDqwPf+f7IPZn8x8ctk8WoNh1ZGVT?=
 =?us-ascii?Q?klKCxoxy/eDaqDZIepGYNYCaYYppDCCU8M76Z7zyLiEXlPeqylu3H++2rs9B?=
 =?us-ascii?Q?GqP1ytqi0caF+JQArGLuiXIdeQZDoShv+ZxYpNLYX3y5fMhCKzU9Qm6OcHb5?=
 =?us-ascii?Q?k6I/hY9fDJ5bwzSAgUtzEAky4ViuRmgPuWCVnJJhvFm5AHg8kKnjgmIutAKG?=
 =?us-ascii?Q?SzHMGP4I2o+BmEMBRvXLeQOyiaYEiJXuLwxbpHHtiPXoIoCyT5H0/Rvj8yOw?=
 =?us-ascii?Q?yrR1Kw688/RSMBnhLcGOegf0C08ul5BAzSofmQdA2xVt9/rsf9tz4KqQvXzZ?=
 =?us-ascii?Q?S5w4wzIfznw/Qw1OXlGBrOoIDLKNiGmpsRyvpfSwhcqTCSTnqe23I5hA6EYG?=
 =?us-ascii?Q?/9RLhCjUCS+5UITBopVZ5CdkiUgCAYYhveaZsB2ywP6iSN7chLou19Q5Y96N?=
 =?us-ascii?Q?9z4qsp8G5Y1ShmklCThSLanRDLvO6+iRwq6btawMud2gKniocP8aCIFocpnD?=
 =?us-ascii?Q?7Uz2y4/fjf+uIpVxUq66wiN/nuCvv8+ZXeL4r0M8ryV3fGHoWvZiN1V0CGIU?=
 =?us-ascii?Q?+JG+4Y+SjlnUJ3LHw/EcB2L+upap4lNuL5SXLMAqtgdz+EBms/o9KI62cnjc?=
 =?us-ascii?Q?GQWJntQOoffRNOj8EZ3NmCGmgoRJleSaJIoNKfKLfbe3p8w+RH/ZDKoUsBAE?=
 =?us-ascii?Q?NsVeYl46c0CkU2B97FeM0vFwTezhVGDlxBVkDOHEOQpuuPs8q++iepD6/AUf?=
 =?us-ascii?Q?liJLWQzEA/iRKTyqp+5137zMSneHjmZdAKTftK2bnGr9OmUqioEP08AiV/wO?=
 =?us-ascii?Q?6eqkiODyc4RD2zgjXkWxdpNY5iKgl+Nqei9x1DbSWhcLGRNEPGjHfBJ9n+SS?=
 =?us-ascii?Q?yx/ltlWOpJyQjzA1fVLAw2aXnFhhGxsxpNX3Awc3yAXQCIp7OzslmkSoJX65?=
 =?us-ascii?Q?tpyw+zSFnePRKfWSGCLp5NO+pFSzbmoL2TGoemCaIo4u8YzQ/fTLKh7eb87E?=
 =?us-ascii?Q?266LdDqa4miURVfQ7Y6LkFC7QHlA1w8P6mzuka8lUOgVCBP8BJN7PFoQf+Zu?=
 =?us-ascii?Q?1i45k1ZqThEObVLdjfM5J0JdrktauzIsFC35vu51FUJ+PVxxEWlbCpU1gdp/?=
 =?us-ascii?Q?TEwdFvDxZLLIUvOINLUGSr6TggKSZX+zHmtYIjX50F5YtmGAxR7m0O+s3dCK?=
 =?us-ascii?Q?Z3OP8zH8CcM4nhGwtpPZPzlpTVEi/Y5LcRWGW+eeS9HeYnn5U5HMEPm77/5v?=
 =?us-ascii?Q?VPm0fXQyfKFsDpHqMa/iv2jWS0p008F086kCpCbzfYBH4EhWtZ//XGW2hbga?=
 =?us-ascii?Q?IAqZMmvX/+wWKgYfKYcoJfRSSS46kGJoybz6+Q3GRQJHHhk1EdglyXM/V+N3?=
 =?us-ascii?Q?2QGDRVaDmfiZTHLi3QxzgGJeSh7gRC8hlIwBC8Y2v5oxpxfdBb8m0EH91KL5?=
 =?us-ascii?Q?gdCjJ4A+QiUAdlI7nrIhtzHk9BgGyDJi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9tdawlYikfp0N7ckBkxugOs8X0keyCwulqFPQpGXhvcgywU8Sbsu/x/BYc2d?=
 =?us-ascii?Q?xRQOv51mHTGxE3MsUVWLJHl3Q5RXPosOJYCSl8otweJ1wpY9cXBMMm4Pj5l9?=
 =?us-ascii?Q?FH/wotTfAiIze3KdEt2c2McIvdqcJ8RkJnqNSvRdnsTiwZc9AeJrBhl9HGQT?=
 =?us-ascii?Q?TWGNIR1WCqpe7c2iHFvW/VuyhD8INKnTJM7eHapD43jQQ2E8GpgebmqK/oLM?=
 =?us-ascii?Q?J0u18PfwWA9Bu74KKDOqzg8SzgglrqDJtXsLRNSeCC8zqeuhz2Frv21JBEZ2?=
 =?us-ascii?Q?5+/73QQ1uFA4RefN1lmAMOJryrGNbYoctDS7j8a9ntyFqQRL8bmO5YaGfIvX?=
 =?us-ascii?Q?YzNsq/AI8CiiYrIEwiH9PIv6GYJ0R8x2cwVFLVz2brYL6pOgy1P7Zswkr2Dx?=
 =?us-ascii?Q?5zvw3jFryGwQna1nK3t9ZBcBGn2hN8Yf4dz4B7klo8iYcVnUMpMRTKKy94gC?=
 =?us-ascii?Q?iJB1SAn+Lzt5t69Yu00QH+ao+pI4Nim3YZ8EGcUjd+Fy7Q+KnGsRbb7DF0c1?=
 =?us-ascii?Q?gXH7F+8vWB8ssdsqp1ZWXZyIqGVf4/L5yxn9PH7cFtXrlIeBbSunRgBIyDC2?=
 =?us-ascii?Q?549TCpKF3av1x6wOU3F0WeD28COzJeGRkcN15U5+Dg9nkAnM6/0wlgPLn73u?=
 =?us-ascii?Q?89OhTMUQVDoeQUw+UqT+moUrZGC5PBlFLz/oBoXQu0nTfYQRXIoUw4xr9Ldf?=
 =?us-ascii?Q?TLjSIJ+dcak6vlOZwWOtA9jaRHkD4W6rYvx2F1ztPc2R0fzBOKcMo5493vun?=
 =?us-ascii?Q?7/n4gB182rm5WChvHp620EhCb/3uHGFyKiU4bdEjBv4rxTupuzU8NfaP0jaE?=
 =?us-ascii?Q?UubrHSZyCQovWc+ADwLx/FzeyPreMiiQkhYrDOtj4inzA+pU7MQTkyA71Hdb?=
 =?us-ascii?Q?BFE25emeJgQfOnzDl8hV1haRuydgQ5hTyH/TO2cSYDq0A0D48tG1Ie1Zdk3v?=
 =?us-ascii?Q?8bfeu1Itfnmi+TiPHpJwnWVz1DmeVBsbPQEM27ApG5rPmcv31YJ/wPGyfEW6?=
 =?us-ascii?Q?TOm2QXtRgvMeABnWT4GL6rvinrvgGFwkRtrshBHHE+2m0q3GpPyAVeUkeumX?=
 =?us-ascii?Q?q5FxQgPCtU76U0UadB19265U/yfhDVPRSVMmTPTvz2+qvvhqFI78ppBoeaav?=
 =?us-ascii?Q?wlD3bLU+o61xCJIHoqoFHK3f23xkW3hciP+Q6saGQ0P3x7z72Kzmp0mq5GJa?=
 =?us-ascii?Q?cLNJcQroIiP0N6l/oLs9Ck12t8wFHYI2ObhZXcWx18aS73geDi+M4JoQtCsQ?=
 =?us-ascii?Q?ilc/i8Oxcg89YFUem7tkRpvgYK6hYlUsuMytfLIvU0t/payrPfmDmHTlfzDd?=
 =?us-ascii?Q?3e+YiL/uxKKVKB/ZB7WSafYlOzWnbrXIUo0Qi0uWQOtdLeJYqyM4s8zrufPL?=
 =?us-ascii?Q?eqG+/EN0U2lte4+F2kaVUsg0iYTmIIzWR1g/uwlAghLgpJJlxmE30GY0vz7S?=
 =?us-ascii?Q?JlHkia5yZEl6B/5PP5sp2QgqGdclGbHVGmTZ0hWvp7LIU/42+tlZqUeB249b?=
 =?us-ascii?Q?mcOFG35fyAp8mS3ItPd+8dzukaWV3W0ZJenqEfRLe+Hh8PPfy0DKrdwbSH2A?=
 =?us-ascii?Q?GkK3Wbasi30RdSHBUYV1qREsS1pls14UaEWPOXs8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b6b323-d9b7-4a8a-b942-08dd5d1f7a89
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:26:33.9531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0x87s/vfvHv1Hq0r46z2YHFU8y4F3ZBA1OWSd6XxsCzNeR5S3yVjJ0oP5SuLtGCpX5FSgKZcx6NcOQCIHXbGRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628

Use u32 rather than unsigned long for register variables for clarity and
consistency.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 54 ++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 4dc2f3e2b8e0..888d744494d6 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -450,7 +450,7 @@ static void lpuart_stop_tx(struct uart_port *port)
 
 static void lpuart32_stop_tx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	temp &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
@@ -467,7 +467,7 @@ static void lpuart_stop_rx(struct uart_port *port)
 
 static void lpuart32_stop_rx(struct uart_port *port)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 	lpuart32_write(port, temp & ~UARTCTRL_RE, UARTCTRL);
@@ -752,7 +752,7 @@ static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
 {
 	struct tty_port *tport = &sport->port.state->port;
-	unsigned long txcnt;
+	u32 txcnt;
 	unsigned char c;
 
 	if (sport->port.x_char) {
@@ -806,7 +806,7 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
@@ -855,9 +855,9 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	unsigned long stat = lpuart32_read(port, UARTSTAT);
-	unsigned long sfifo = lpuart32_read(port, UARTFIFO);
-	unsigned long ctrl = lpuart32_read(port, UARTCTRL);
+	u32 stat = lpuart32_read(port, UARTSTAT);
+	u32 sfifo = lpuart32_read(port, UARTFIFO);
+	u32 ctrl = lpuart32_read(port, UARTCTRL);
 
 	if (sport->dma_tx_in_progress)
 		return 0;
@@ -961,7 +961,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 {
 	unsigned int flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
-	unsigned long rx, sr;
+	u32 rx, sr;
 	bool is_break;
 
 	uart_port_lock(&sport->port);
@@ -1113,7 +1113,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	int count, copied;
 
 	if (lpuart_is_32(sport)) {
-		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
+		u32 sr = lpuart32_read(&sport->port, UARTSTAT);
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_FE)) {
 			/* Clear the error flags */
@@ -1279,7 +1279,7 @@ static void lpuart32_dma_idleint(struct lpuart_port *sport)
 static irqreturn_t lpuart32_int(int irq, void *dev_id)
 {
 	struct lpuart_port *sport = dev_id;
-	unsigned long sts, rxcount;
+	u32 sts, rxcount;
 
 	sts = lpuart32_read(&sport->port, UARTSTAT);
 	rxcount = lpuart32_read(&sport->port, UARTWATER);
@@ -1411,12 +1411,12 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	dma_async_issue_pending(chan);
 
 	if (lpuart_is_32(sport)) {
-		unsigned long temp = lpuart32_read(&sport->port, UARTBAUD);
+		u32 temp = lpuart32_read(&sport->port, UARTBAUD);
 
 		lpuart32_write(&sport->port, temp | UARTBAUD_RDMAE, UARTBAUD);
 
 		if (sport->dma_idle_int) {
-			unsigned long ctrl = lpuart32_read(&sport->port, UARTCTRL);
+			u32 ctrl = lpuart32_read(&sport->port, UARTCTRL);
 
 			lpuart32_write(&sport->port, ctrl | UARTCTRL_ILIE, UARTCTRL);
 		}
@@ -1482,7 +1482,7 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
 
-	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
+	u32 modem = lpuart32_read(&sport->port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
 	u32 ctrl;
 
@@ -1586,7 +1586,7 @@ static void lpuart_break_ctl(struct uart_port *port, int break_state)
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(port, UARTCTRL);
 
@@ -1665,8 +1665,7 @@ static void lpuart_setup_watermark_enable(struct lpuart_port *sport)
 
 static void lpuart32_setup_watermark(struct lpuart_port *sport)
 {
-	unsigned long val, ctrl;
-	unsigned long ctrl_saved;
+	u32 val, ctrl, ctrl_saved;
 
 	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	ctrl_saved = ctrl;
@@ -1845,7 +1844,7 @@ static int lpuart_startup(struct uart_port *port)
 
 static void lpuart32_hw_disable(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
@@ -1855,7 +1854,7 @@ static void lpuart32_hw_disable(struct lpuart_port *sport)
 
 static void lpuart32_configure(struct lpuart_port *sport)
 {
-	unsigned long temp;
+	u32 temp;
 
 	temp = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
@@ -1885,7 +1884,7 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 
 	/* determine FIFO size */
 	temp = lpuart32_read(&sport->port, UARTFIFO);
@@ -1959,7 +1958,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport =
 		container_of(port, struct lpuart_port, port);
-	unsigned long temp;
+	u32 temp;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
@@ -2233,7 +2232,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	unsigned long flags;
-	unsigned long ctrl, old_ctrl, bd, modem;
+	u32 ctrl, old_ctrl, bd, modem;
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
@@ -2530,7 +2529,7 @@ static void
 lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct lpuart_port *sport = lpuart_ports[co->index];
-	unsigned long  old_cr, cr;
+	u32 old_cr, cr;
 	unsigned long flags;
 	int locked = 1;
 
@@ -2613,7 +2612,7 @@ static void __init
 lpuart32_console_get_options(struct lpuart_port *sport, int *baud,
 			   int *parity, int *bits)
 {
-	unsigned long cr, bd;
+	u32 cr, bd;
 	unsigned int sbr, uartclk, baud_raw;
 
 	cr = lpuart32_read(&sport->port, UARTCTRL);
@@ -2819,7 +2818,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 {
 	struct uart_port *port = &sport->port;
 	void __iomem *global_addr;
-	unsigned long ctrl, bd;
+	u32 ctrl, bd;
 	unsigned int val = 0;
 	int ret;
 
@@ -3025,7 +3024,7 @@ static int lpuart_runtime_resume(struct device *dev)
 
 static void serial_lpuart_enable_wakeup(struct lpuart_port *sport, bool on)
 {
-	unsigned int val, baud;
+	u32 val, baud;
 
 	if (lpuart_is_32(sport)) {
 		val = lpuart32_read(&sport->port, UARTCTRL);
@@ -3090,7 +3089,7 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned int val;
+	u32 val;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3110,7 +3109,8 @@ static int lpuart_resume_noirq(struct device *dev)
 static int lpuart_suspend(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	unsigned long temp, flags;
+	u32 temp;
+	unsigned long flags;
 
 	uart_suspend_port(&lpuart_reg, &sport->port);
 
-- 
2.34.1

