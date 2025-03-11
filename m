Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011061.outbound.protection.outlook.com [52.101.65.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D61E3DC4;
	Tue, 11 Mar 2025 03:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741664219; cv=fail; b=u4vv9NjWoRvU/T9kFIH5zIm1g74P/EAPVL3roZ7n7suV3YoojK4yS+pNuTb6W1odAwHMBky/nO623R+YxobETP4PNQ0nTUCXoXy7IoDMLKdQ+Kj6eRfLqci3CqgONUU7ToAw1pd8I6grSAYpohkO7g+Jg2XivsXd0mhJYIRNZAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741664219; c=relaxed/simple;
	bh=OraOtfrNs3/IB4HX5vjr43b/E24RmkpHPKHmGp3AYos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Olqs50V3+zjE1b/kM57YfljEATimsbW0ILq4mrCQnmW6TCiDQ61Ilkeim06pWkQ9cA2CgXBXi35zp310KBEBVyrhvBf5UYI1SfwP4by7agoCwd1Jj9yxn5U9gg5CHKLQgwjez38V0CC6d2p5Yb7BoxfVyk4uh5Z4BceEjvMq2tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y4jjgisJ; arc=fail smtp.client-ip=52.101.65.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y4jjgisJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPmgqrWA7ocDaFF3N66Xpv7yPOIiKCCx83fETmJuOaBe+2ZuPmH0/NSWwc8s+bd4wUelc3i8IVFtZ92leQdbI+XAQkHab6/cX3+8vv6EB8xTy6VwwhxRWsQCy7Dyugq1sW7jUrUanq/uOMSZU0fvcsx97fmgk9yz7NO4FOK3H1NJA6hfIkZ+4MRhkjlq5toSC22V2KhSqiDkvqon73o91fpUTFIqaLBMLwhSPR8uHMBjjBZMNRn2Gx/69DpNmSiV8MF4Ou3wTZxWzZdt0q5PA31/U/JiP+r0TrMkrVgpSE0dc5O1KsmjUNMoS19mVNdRxWHyFLxKxMtre2cYria4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSbJ4osvESbe58shnoNOa7BwDukru3dPvBnylP6A4SI=;
 b=VlR8arohBmUrgTO8Q0fHYOGmJ2Gnv7VNEiTVnanscyd+ilvkk+ByX+NoUBDuELytHO+cu8slwOhXTGThLL1SKe0hFPPKMq5q2PmcDHWTqcsdTKUup0CRKT9QR4efoD7/RAa5PliGKRcQ8r/ueXLrsH0xwjn/kpfhwYnyMdvQV7kaFTJ+Mn+TMusbsHXinH1RSfJ8sAh7O6AA7JFVmuBDOI7IWBN1Iw1gznFaBg1ddq0hVS7WCO2Vt60STXBAVFj4Rws4MDXSKXL53lEHQH7q08SofKDhD7YiFxTP/yZW0ABrW520FxcuIwGvI+JQB355yRDBCSkOkrxNWQME07I36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSbJ4osvESbe58shnoNOa7BwDukru3dPvBnylP6A4SI=;
 b=Y4jjgisJwe6JWEDkaIG13PkQiBHlZXnXjw+zOxRTpxYK33f26bS3MRTiLo6lZkTEga9mJ1KpHJAjAkxLJKHa9gxax8hSnPmqDcAP0OO+InIYJjTnarOHpAVSwjQox6cllx3LHoef95Nsicz9uPUp0QZxh4X+SzrviOKGRC0yHLH5zPVYDmv1GroC5LIm2r/JQ8NltJ44tcq93cgdM9lC2++9MoTZTCqo0W2LVQ2ncNjtZOjIW4scesrZQafFsduTj58vT31XV/THogA1jwM4nTJSIp5gSsKXYJYpkmd7FKbpJ3ah2w4eNSnGX4KDjUrA0dLErNBgZXsqi87wNLMiDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS1PR04MB9480.eurprd04.prod.outlook.com (2603:10a6:20b:4d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 03:36:54 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 03:36:54 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: use port struct directly to simply code
Date: Tue, 11 Mar 2025 11:33:35 +0800
Message-Id: <20250311033336.1254842-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250311033336.1254842-1-sherry.sun@nxp.com>
References: <20250311033336.1254842-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS1PR04MB9480:EE_
X-MS-Office365-Filtering-Correlation-Id: 009d9ad1-82de-4c04-9379-08dd604df7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LE3Fjfh+MeRIUM2UH3mbUZehzXoH0FDU5qw78aHoORpU5FpMwVPSL/ztJXO2?=
 =?us-ascii?Q?uykdoTFz0xZQlx21R+oR/Q8PJ1GktZyYJdNC6J0iaQPj2h0S425zYXsW6Dr2?=
 =?us-ascii?Q?5TGNQPlRHHGNCj3a2NZIds1ktL45jOm4IlT5P1lCYYBftzRAbkXEo8gh8q3g?=
 =?us-ascii?Q?FHya20ah4Jdqfzfdq7WIDY6Urk3DV8g9aP8ndkYpX1S6U4P+XjS0eviDaSeW?=
 =?us-ascii?Q?imE6A0eHe9Jsq2uexqlcICvyNRpbhrwmFRk/dWRer4ASv1iDwkqXWKH4+Ugf?=
 =?us-ascii?Q?nejizQgWBIDLGyjvStmIFAIDeu8guhrSyvKaJ0iRP1s+PT4+Zp7NA0fOI+LY?=
 =?us-ascii?Q?/mEbS5ghFS9LukVK08tNGzs9tB1GoyXjsRu1F+2+Lr7lF7cugS6b2y9rTDj3?=
 =?us-ascii?Q?qR4W0oau7AFrjG0vMJ0UnWRlK68OIxdacf2KQ+WHf6KFrefiKl//Cmx6HEZ4?=
 =?us-ascii?Q?xU6qmdoXHOy7znTRXYCgzbIm28xI17Jer15agyhKWdNS4D5OSMAWWcBYtLFm?=
 =?us-ascii?Q?9+q+XNHLjIpPT9t5lCpnopeh69Y6I1snjwaKRhn8KGzbdjxRh3YyvPsfG0Fy?=
 =?us-ascii?Q?ImTZoouR/5Tao40B8GM5X5WHIxZwcJu+9U8xza0PFnthm4Lz74TPp2a2Q44o?=
 =?us-ascii?Q?ikWyAAbTqvUsDVPDxYiObgmHxaNnDk3AmvOh8nLH09mNBwRV4nwaPgLF3QXt?=
 =?us-ascii?Q?cAMI5pDFHHvNPpiy7MPkw8ZdwFDYi8yp0oaxyjut8TIno/cwaa6awkjB8iFF?=
 =?us-ascii?Q?5akacLhCsOedHMHlMU4gEFLXoVEg4dcGAauuQKEWO+nIosIYswW8hWAxYx2s?=
 =?us-ascii?Q?cat4105O2APHQ7sEuxN3hXS2f3lkUyL5qsVv543LQ4bIkwjQtsp0p4hMONEY?=
 =?us-ascii?Q?ZWp0APqZEzic2IOvV/kmi9g3zPeFJBUh+fQwldGW6tueAeuTRHpvauvI/Y71?=
 =?us-ascii?Q?V6QUTsdSRyL2KYidUntQYFqz2pAwGu45DkrkMqcoyjN9RARqQljG5TW9EbnB?=
 =?us-ascii?Q?CitQZJgjfV7iKQyptCC3JjbYS6/s7cqJtsnC+x8Zki0ZZ/rOsDqYHhC/qzih?=
 =?us-ascii?Q?xbUYhqk9q1ya7dMLEsGcT+Nit51UGGk5JPvHEWZ3GTnrwXpLk8mdjbaYKjwD?=
 =?us-ascii?Q?LF8zlqN8bdHSoSJ8koSL5bBq4B8s6Xk1aECvWpYuzVkaCc/yTHYsVBt2nfXC?=
 =?us-ascii?Q?raZsjaYDsF8ocAx46kWAu+ZCSlCtjAGBruhr1pBL5p86dfonqNZ/8Ez1X9YM?=
 =?us-ascii?Q?uWRrW0mupYdFyBPEYGmoTAlJYsYd5ZD2WBbt2idydNhKRYeTHSDBtRyPOWgr?=
 =?us-ascii?Q?203DAAqX14imVjITaey4wbPXZs23+Zisbk+zb1a7Sdkx1BiEOIpl73Gs7k+n?=
 =?us-ascii?Q?SxO6IWoLQelN58J58lqVXDvhkICwvr2RCxmR+mk2vHHqGauywAlOSZy+2ShE?=
 =?us-ascii?Q?1TFAxiHYEPeV3RbDUlhI9iv7Oc47Ng7C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uKtblF/vrWMyajbqJNlalJXA81iRQAx0SlXamMgOAvqp610YTCW3ljlmI1xH?=
 =?us-ascii?Q?cw7yepDJquBj8J/TNKNlHjx9flVtpyft+tks68g9IDbZNqHLu3GwtYoF8IVK?=
 =?us-ascii?Q?Q2DISaNHB3pEgi8LeauvzJNoTdfVuYtWmteaYq4WWHJsEChH7AJTeHRV4qs5?=
 =?us-ascii?Q?MzA3jeDs4puzoc9tRg8oivrXKXZi3HSYgGwC8Jjgos3bj4MPHxIsNzwnmDc9?=
 =?us-ascii?Q?HZBeppnfTnQGqfXlBNmw7BjpU1QF0HEukbTlXK2PHuNlwnRcPjBVFa2IYc8Z?=
 =?us-ascii?Q?Csi+0GW3MhK7E/h/MZ/8yiWeUE+PnY911KFsvX3WhRvOvba6ezeMmOOfyfvR?=
 =?us-ascii?Q?L/8Gkyt8T7ZGR+GhXUkYyAC4+idY51jW4h4jHhYNPoEFBLurTCh3c7ZIwJM/?=
 =?us-ascii?Q?k4e5i3t1DSTZSt4KJ1xdWcb4BmTrWMpmd76Jn96ClSac6lLW411Wfh/glLm7?=
 =?us-ascii?Q?ncIDgbyU8rYyt/7JmG20K8OsXGArf16nuXPxFyEJOiYv0H605AX8XtuRYPRH?=
 =?us-ascii?Q?gmDurac4B8ay5OUzdcW/UMGPKcexWnMAIfa5cnggJAfAhCtNs5Or3ieeB+u4?=
 =?us-ascii?Q?HWHN7eObt9pksBRtZlENNzKP/930DoraAZEYtXtUV7/6dhsmCA19zr5qXe1a?=
 =?us-ascii?Q?e/sa2zp9QbwGLsEv0BgN7mAntYcfWdI644CqdspiKKqZn03F8nag1susPJYo?=
 =?us-ascii?Q?YYERBOnWOT85O/GqD/0OK3QdE85IsE55AgrQqXflKoTG634LnByBuDxwLzq7?=
 =?us-ascii?Q?hl6xogV5aW/ZP4aznvie36WcDhY3mGy4tJv8Jc7RpNu2FAUSzPaLta7zC3X0?=
 =?us-ascii?Q?s/f3muNg/Xz4G+Zd5SAeaFA7VKVPAOWtzvKZZPXVxu3zuRBxZWcBbHiRCrcN?=
 =?us-ascii?Q?zmGWZCYUyznGPlrauuWS5oiK88MNre3SJD9E0lUfpYRQxp55Wbl5VrqgIv8K?=
 =?us-ascii?Q?gD6Vumsv+mTxzLI8adoFUgpHrFIKd8/es55bZS4ImnX8CY6SkGaTXwhOW930?=
 =?us-ascii?Q?UBzhU4S5hf67iVCKIRONL3y3USejHIpEdFEWO+EG+xRF94lQkKQ3GCDGH/Ko?=
 =?us-ascii?Q?M7rXb1p7f4YVecp8OtNglQAL2QUCVYWvFOQGTP3rU7QxKhUAi3yDQxh0kB7x?=
 =?us-ascii?Q?4H7i5Z3Fo5zFjZueLsJ1U5AuourLuBNvhxrlMARpEysLTv6IYL10zMmtJ8n1?=
 =?us-ascii?Q?HCMtMkpEO0ogKeeL8KRe/4iPZ3bcoO3EasyxcS8Hr6hJZF+H0IRYq5CZZFDN?=
 =?us-ascii?Q?uNS3HGg0QMVeTBppHBFNRpSI/8ZJOWJP3Ty2s6JiYeI5ta0WzJwC9KjO7V2e?=
 =?us-ascii?Q?Idzaa3EkjMRRjTjuvuKq7axLyEvDEI4I/OWGZNRLaa0EcuSvmG81JpdPxXh1?=
 =?us-ascii?Q?uFuyOv3HuClNmnK20hUkGr4M3zw89U9ZM6hfe5rFNYQ/n0pfKjQj8GlXV6gB?=
 =?us-ascii?Q?WoaCjY5FVN//aZ5SHoai6XCwZQKPrX0VNh6qaFIVI8K1Ih92tbIR8h1b4isb?=
 =?us-ascii?Q?Um2oUGV/025Co5ylV9GX9qt6bGh9rVx71OmFq0liypKnxMlESu29FC8fcdc+?=
 =?us-ascii?Q?+XT6r50Hmg6hY8a/nzIUWPm7NT2bJly+G4kRl6Ee?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009d9ad1-82de-4c04-9379-08dd604df7b2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 03:36:54.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1yn2pZf8kPo1IjHOeqqQVBn7d8DkhcQD1FixeC1Drmwi9JZcoNkIysxDbIII1cBSFpLQGErbJrQkanxG0SQdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9480

Most lpuart functions have the parameter struct uart_port *port, but
still use the &sport->port to get the uart_port instead of use it
directly, let's simply the code logic, directly use this struct instead
of covert it from struct sport.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 210 ++++++++++++++++----------------
 1 file changed, 102 insertions(+), 108 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 29ce9b25b796..f830b5a3ba8e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -581,7 +581,7 @@ static int lpuart_dma_tx_request(struct uart_port *port)
 	ret = dmaengine_slave_config(sport->dma_tx_chan, &dma_tx_sconfig);
 
 	if (ret) {
-		dev_err(sport->port.dev,
+		dev_err(port->dev,
 				"DMA slave config failed, err = %d\n", ret);
 		return ret;
 	}
@@ -611,13 +611,13 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 
 	if (lpuart_is_32(sport)) {
-		val = lpuart32_read(&sport->port, UARTFIFO);
+		val = lpuart32_read(port, UARTFIFO);
 		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
-		lpuart32_write(&sport->port, val, UARTFIFO);
+		lpuart32_write(port, val, UARTFIFO);
 	} else {
-		val = readb(sport->port.membase + UARTCFIFO);
+		val = readb(port->membase + UARTCFIFO);
 		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
-		writeb(val, sport->port.membase + UARTCFIFO);
+		writeb(val, port->membase + UARTCFIFO);
 	}
 }
 
@@ -644,33 +644,33 @@ static int lpuart_poll_init(struct uart_port *port)
 	unsigned long flags;
 	unsigned char temp;
 
-	sport->port.fifosize = 0;
+	port->fifosize = 0;
 
-	uart_port_lock_irqsave(&sport->port, &flags);
+	uart_port_lock_irqsave(port, &flags);
 	/* Disable Rx & Tx */
-	writeb(0, sport->port.membase + UARTCR2);
+	writeb(0, port->membase + UARTCR2);
 
-	temp = readb(sport->port.membase + UARTPFIFO);
+	temp = readb(port->membase + UARTPFIFO);
 	/* Enable Rx and Tx FIFO */
 	writeb(temp | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
-			sport->port.membase + UARTPFIFO);
+			port->membase + UARTPFIFO);
 
 	/* flush Tx and Rx FIFO */
 	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
-			sport->port.membase + UARTCFIFO);
+			port->membase + UARTCFIFO);
 
 	/* explicitly clear RDRF */
-	if (readb(sport->port.membase + UARTSR1) & UARTSR1_RDRF) {
-		readb(sport->port.membase + UARTDR);
-		writeb(UARTSFIFO_RXUF, sport->port.membase + UARTSFIFO);
+	if (readb(port->membase + UARTSR1) & UARTSR1_RDRF) {
+		readb(port->membase + UARTDR);
+		writeb(UARTSFIFO_RXUF, port->membase + UARTSFIFO);
 	}
 
-	writeb(0, sport->port.membase + UARTTWFIFO);
-	writeb(1, sport->port.membase + UARTRWFIFO);
+	writeb(0, port->membase + UARTTWFIFO);
+	writeb(1, port->membase + UARTRWFIFO);
 
 	/* Enable Rx and Tx */
-	writeb(UARTCR2_RE | UARTCR2_TE, sport->port.membase + UARTCR2);
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	writeb(UARTCR2_RE | UARTCR2_TE, port->membase + UARTCR2);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -696,30 +696,30 @@ static int lpuart32_poll_init(struct uart_port *port)
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	u32 temp;
 
-	sport->port.fifosize = 0;
+	port->fifosize = 0;
 
-	uart_port_lock_irqsave(&sport->port, &flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Disable Rx & Tx */
-	lpuart32_write(&sport->port, 0, UARTCTRL);
+	lpuart32_write(port, 0, UARTCTRL);
 
-	temp = lpuart32_read(&sport->port, UARTFIFO);
+	temp = lpuart32_read(port, UARTFIFO);
 
 	/* Enable Rx and Tx FIFO */
-	lpuart32_write(&sport->port, temp | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
+	lpuart32_write(port, temp | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
 
 	/* flush Tx and Rx FIFO */
-	lpuart32_write(&sport->port, UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH, UARTFIFO);
+	lpuart32_write(port, UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH, UARTFIFO);
 
 	/* explicitly clear RDRF */
-	if (lpuart32_read(&sport->port, UARTSTAT) & UARTSTAT_RDRF) {
-		lpuart32_read(&sport->port, UARTDATA);
-		lpuart32_write(&sport->port, UARTFIFO_RXUF, UARTFIFO);
+	if (lpuart32_read(port, UARTSTAT) & UARTSTAT_RDRF) {
+		lpuart32_read(port, UARTDATA);
+		lpuart32_write(port, UARTFIFO_RXUF, UARTFIFO);
 	}
 
 	/* Enable Rx and Tx */
-	lpuart32_write(&sport->port, UARTCTRL_RE | UARTCTRL_TE, UARTCTRL);
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	lpuart32_write(port, UARTCTRL_RE | UARTCTRL_TE, UARTCTRL);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -1449,12 +1449,9 @@ static void lpuart_dma_rx_free(struct uart_port *port)
 static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
 			struct serial_rs485 *rs485)
 {
-	struct lpuart_port *sport = container_of(port,
-			struct lpuart_port, port);
-
-	u8 modem = readb(sport->port.membase + UARTMODEM) &
+	u8 modem = readb(port->membase + UARTMODEM) &
 		~(UARTMODEM_TXRTSPOL | UARTMODEM_TXRTSE);
-	writeb(modem, sport->port.membase + UARTMODEM);
+	writeb(modem, port->membase + UARTMODEM);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
@@ -1472,32 +1469,29 @@ static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
 			modem &= ~UARTMODEM_TXRTSPOL;
 	}
 
-	writeb(modem, sport->port.membase + UARTMODEM);
+	writeb(modem, port->membase + UARTMODEM);
 	return 0;
 }
 
 static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termios,
 			struct serial_rs485 *rs485)
 {
-	struct lpuart_port *sport = container_of(port,
-			struct lpuart_port, port);
-
-	u32 modem = lpuart32_read(&sport->port, UARTMODIR)
+	u32 modem = lpuart32_read(port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
 	u32 ctrl;
 
 	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
-	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
 	if (ctrl & UARTCTRL_TE) {
 		/* wait transmit engin complete */
-		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
-		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
+		lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(port, ctrl & ~UARTCTRL_TE, UARTCTRL);
 
-		while (lpuart32_read(&sport->port, UARTCTRL) & UARTCTRL_TE)
+		while (lpuart32_read(port, UARTCTRL) & UARTCTRL_TE)
 			cpu_relax();
 	}
 
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
@@ -1515,10 +1509,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 			modem &= ~UARTMODIR_TXRTSPOL;
 	}
 
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if (ctrl & UARTCTRL_TE)
-		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+		lpuart32_write(port, ctrl, UARTCTRL);
 
 	return 0;
 }
@@ -1830,11 +1824,11 @@ static int lpuart_startup(struct uart_port *port)
 	unsigned char temp;
 
 	/* determine FIFO size and enable FIFO mode */
-	temp = readb(sport->port.membase + UARTPFIFO);
+	temp = readb(port->membase + UARTPFIFO);
 
 	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_TXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
-	sport->port.fifosize = sport->txfifo_size;
+	port->fifosize = sport->txfifo_size;
 
 	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
@@ -1890,11 +1884,11 @@ static int lpuart32_startup(struct uart_port *port)
 	u32 temp;
 
 	/* determine FIFO size */
-	temp = lpuart32_read(&sport->port, UARTFIFO);
+	temp = lpuart32_read(port, UARTFIFO);
 
 	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_TXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
-	sport->port.fifosize = sport->txfifo_size;
+	port->fifosize = sport->txfifo_size;
 
 	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_RXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
@@ -1907,7 +1901,7 @@ static int lpuart32_startup(struct uart_port *port)
 	if (is_layerscape_lpuart(sport)) {
 		sport->rxfifo_size = 16;
 		sport->txfifo_size = 16;
-		sport->port.fifosize = sport->txfifo_size;
+		port->fifosize = sport->txfifo_size;
 	}
 
 	lpuart_request_dma(sport);
@@ -1967,8 +1961,8 @@ static void lpuart32_shutdown(struct uart_port *port)
 	uart_port_lock_irqsave(port, &flags);
 
 	/* clear status */
-	temp = lpuart32_read(&sport->port, UARTSTAT);
-	lpuart32_write(&sport->port, temp, UARTSTAT);
+	temp = lpuart32_read(port, UARTSTAT);
+	lpuart32_write(port, temp, UARTSTAT);
 
 	/* disable Rx/Tx DMA */
 	temp = lpuart32_read(port, UARTBAUD);
@@ -2002,12 +1996,12 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 	unsigned int sbr, brfa;
 
-	cr1 = old_cr1 = readb(sport->port.membase + UARTCR1);
-	old_cr2 = readb(sport->port.membase + UARTCR2);
-	cr3 = readb(sport->port.membase + UARTCR3);
-	cr4 = readb(sport->port.membase + UARTCR4);
-	bdh = readb(sport->port.membase + UARTBDH);
-	modem = readb(sport->port.membase + UARTMODEM);
+	cr1 = old_cr1 = readb(port->membase + UARTCR1);
+	old_cr2 = readb(port->membase + UARTCR2);
+	cr3 = readb(port->membase + UARTCR3);
+	cr4 = readb(port->membase + UARTCR4);
+	bdh = readb(port->membase + UARTBDH);
+	modem = readb(port->membase + UARTMODEM);
 	/*
 	 * only support CS8 and CS7, and for CS7 must enable PE.
 	 * supported mode:
@@ -2039,7 +2033,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2080,59 +2074,59 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Need to update the Ring buffer length according to the selected
 	 * baud rate and restart Rx DMA path.
 	 *
-	 * Since timer function acqures sport->port.lock, need to stop before
+	 * Since timer function acqures port->lock, need to stop before
 	 * acquring same lock because otherwise del_timer_sync() can deadlock.
 	 */
 	if (old && sport->lpuart_dma_rx_use)
-		lpuart_dma_rx_free(&sport->port);
+		lpuart_dma_rx_free(port);
 
-	uart_port_lock_irqsave(&sport->port, &flags);
+	uart_port_lock_irqsave(port, &flags);
 
-	sport->port.read_status_mask = 0;
+	port->read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |= UARTSR1_FE | UARTSR1_PE;
+		port->read_status_mask |= UARTSR1_FE | UARTSR1_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		sport->port.read_status_mask |= UARTSR1_FE;
+		port->read_status_mask |= UARTSR1_FE;
 
 	/* characters to ignore */
-	sport->port.ignore_status_mask = 0;
+	port->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNPAR)
-		sport->port.ignore_status_mask |= UARTSR1_PE;
+		port->ignore_status_mask |= UARTSR1_PE;
 	if (termios->c_iflag & IGNBRK) {
-		sport->port.ignore_status_mask |= UARTSR1_FE;
+		port->ignore_status_mask |= UARTSR1_FE;
 		/*
 		 * if we're ignoring parity and break indicators,
 		 * ignore overruns too (for real raw support).
 		 */
 		if (termios->c_iflag & IGNPAR)
-			sport->port.ignore_status_mask |= UARTSR1_OR;
+			port->ignore_status_mask |= UARTSR1_OR;
 	}
 
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
-	lpuart_wait_bit_set(&sport->port, UARTSR1, UARTSR1_TC);
+	lpuart_wait_bit_set(port, UARTSR1, UARTSR1_TC);
 
 	/* disable transmit and receive */
 	writeb(old_cr2 & ~(UARTCR2_TE | UARTCR2_RE),
-			sport->port.membase + UARTCR2);
+			port->membase + UARTCR2);
 
-	sbr = sport->port.uartclk / (16 * baud);
-	brfa = ((sport->port.uartclk - (16 * sbr * baud)) * 2) / baud;
+	sbr = port->uartclk / (16 * baud);
+	brfa = ((port->uartclk - (16 * sbr * baud)) * 2) / baud;
 	bdh &= ~UARTBDH_SBR_MASK;
 	bdh |= (sbr >> 8) & 0x1F;
 	cr4 &= ~UARTCR4_BRFA_MASK;
 	brfa &= UARTCR4_BRFA_MASK;
-	writeb(cr4 | brfa, sport->port.membase + UARTCR4);
-	writeb(bdh, sport->port.membase + UARTBDH);
-	writeb(sbr & 0xFF, sport->port.membase + UARTBDL);
-	writeb(cr3, sport->port.membase + UARTCR3);
-	writeb(cr1, sport->port.membase + UARTCR1);
-	writeb(modem, sport->port.membase + UARTMODEM);
+	writeb(cr4 | brfa, port->membase + UARTCR4);
+	writeb(bdh, port->membase + UARTBDH);
+	writeb(sbr & 0xFF, port->membase + UARTBDL);
+	writeb(cr3, port->membase + UARTCR3);
+	writeb(cr1, port->membase + UARTCR1);
+	writeb(modem, port->membase + UARTMODEM);
 
 	/* restore control register */
-	writeb(old_cr2, sport->port.membase + UARTCR2);
+	writeb(old_cr2, port->membase + UARTCR2);
 
 	if (old && sport->lpuart_dma_rx_use) {
 		if (!lpuart_start_rx_dma(sport))
@@ -2141,7 +2135,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void __lpuart32_serial_setbrg(struct uart_port *port,
@@ -2239,9 +2233,9 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
-	ctrl = old_ctrl = lpuart32_read(&sport->port, UARTCTRL);
-	bd = lpuart32_read(&sport->port, UARTBAUD);
-	modem = lpuart32_read(&sport->port, UARTMODIR);
+	ctrl = old_ctrl = lpuart32_read(port, UARTCTRL);
+	bd = lpuart32_read(port, UARTBAUD);
+	modem = lpuart32_read(port, UARTMODIR);
 	sport->is_cs7 = false;
 	/*
 	 * only support CS8 and CS7
@@ -2275,7 +2269,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2325,32 +2319,32 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Need to update the Ring buffer length according to the selected
 	 * baud rate and restart Rx DMA path.
 	 *
-	 * Since timer function acqures sport->port.lock, need to stop before
+	 * Since timer function acqures port->lock, need to stop before
 	 * acquring same lock because otherwise del_timer_sync() can deadlock.
 	 */
 	if (old && sport->lpuart_dma_rx_use)
-		lpuart_dma_rx_free(&sport->port);
+		lpuart_dma_rx_free(port);
 
-	uart_port_lock_irqsave(&sport->port, &flags);
+	uart_port_lock_irqsave(port, &flags);
 
-	sport->port.read_status_mask = 0;
+	port->read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
-		sport->port.read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;
+		port->read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;
 	if (termios->c_iflag & (IGNBRK | BRKINT | PARMRK))
-		sport->port.read_status_mask |= UARTSTAT_FE;
+		port->read_status_mask |= UARTSTAT_FE;
 
 	/* characters to ignore */
-	sport->port.ignore_status_mask = 0;
+	port->ignore_status_mask = 0;
 	if (termios->c_iflag & IGNPAR)
-		sport->port.ignore_status_mask |= UARTSTAT_PE;
+		port->ignore_status_mask |= UARTSTAT_PE;
 	if (termios->c_iflag & IGNBRK) {
-		sport->port.ignore_status_mask |= UARTSTAT_FE;
+		port->ignore_status_mask |= UARTSTAT_FE;
 		/*
 		 * if we're ignoring parity and break indicators,
 		 * ignore overruns too (for real raw support).
 		 */
 		if (termios->c_iflag & IGNPAR)
-			sport->port.ignore_status_mask |= UARTSTAT_OR;
+			port->ignore_status_mask |= UARTSTAT_OR;
 	}
 
 	/* update the per-port timeout */
@@ -2362,22 +2356,22 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * asserted.
 	 */
 	if (!(old_ctrl & UARTCTRL_SBK)) {
-		lpuart32_write(&sport->port, 0, UARTMODIR);
-		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(port, 0, UARTMODIR);
+		lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TC);
 	}
 
 	/* disable transmit and receive */
-	lpuart32_write(&sport->port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
+	lpuart32_write(port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
 		       UARTCTRL);
 
-	lpuart32_write(&sport->port, bd, UARTBAUD);
+	lpuart32_write(port, bd, UARTBAUD);
 	lpuart32_serial_setbrg(sport, baud);
 	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
-	lpuart32_write(&sport->port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+	lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	/* restore control register */
-	lpuart32_write(&sport->port, ctrl, UARTCTRL);
+	lpuart32_write(port, ctrl, UARTCTRL);
 	/* re-enable the CTS if needed */
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if ((ctrl & (UARTCTRL_PE | UARTCTRL_M)) == UARTCTRL_PE)
 		sport->is_cs7 = true;
@@ -2389,7 +2383,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *lpuart_type(struct uart_port *port)
@@ -2827,7 +2821,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 
 	ret = clk_prepare_enable(sport->ipg_clk);
 	if (ret) {
-		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
+		dev_err(port->dev, "failed to enable uart ipg clk: %d\n", ret);
 		return ret;
 	}
 
@@ -2838,10 +2832,10 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 		 */
 		ctrl = lpuart32_read(port, UARTCTRL);
 		if (ctrl & UARTCTRL_TE) {
-			bd = lpuart32_read(&sport->port, UARTBAUD);
+			bd = lpuart32_read(port, UARTBAUD);
 			if (read_poll_timeout(lpuart32_tx_empty, val, val, 1, 100000, false,
 					      port)) {
-				dev_warn(sport->port.dev,
+				dev_warn(port->dev,
 					 "timeout waiting for transmit engine to complete\n");
 				clk_disable_unprepare(sport->ipg_clk);
 				return 0;
@@ -3193,7 +3187,7 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
 	 * in VLLS mode, or restore console setting here.
 	 */
 	if (is_imx7ulp_lpuart(sport) && lpuart_uport_is_active(sport) &&
-	    console_suspend_enabled && uart_console(&sport->port)) {
+	    console_suspend_enabled && uart_console(uport)) {
 
 		mutex_lock(&port->mutex);
 		memset(&termios, 0, sizeof(struct ktermios));
-- 
2.34.1

