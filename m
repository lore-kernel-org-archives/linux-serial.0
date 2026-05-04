Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013022.outbound.protection.outlook.com [40.107.44.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53F34C80D;
	Mon,  4 May 2026 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884630; cv=fail; b=KmX087LgL++4CNL06SXTXbMXdKVXbXs0kLd7c+xpLtc0dmi2RmlzmW12NhXdUtcg+fYgNvSX4FnwrdPf1Hak5ideZm1M4lrpp9Fw9jnNQyzrZEMHtJ1t84e6dGycsZOD62T9Fe4zQDEwrYPh8JDq0ucyV/nbGZ3rmzLIpCkfBeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884630; c=relaxed/simple;
	bh=jLO65BFNX8Jwmu/xi+EhkhWMkw2m0mHKwMhN+h2xCPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kSV6TTq9ZtciqCcVH3XSuLB4yo3bi3t0A+dR2UiSYI1q4A/JsARLPLJ6/n+c7+6s8RUMcTY1xKTNzjelj7pZOhQa5x65viL1/0ldRoHLp9mI4V/TfN86/gohrT1xqS4L8WhEISdJhlkzsbldV34DOHSFRQHtirMaXN+tO2nbp/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=ZTsoPOvG; arc=fail smtp.client-ip=40.107.44.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="ZTsoPOvG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIQhstjx/LHRFDF+YYbM2g8bYgGYSVr76Nk4xpmd/ELTHcJii/bQEKZGq6X0yJ31E3peNLUl5204FDkw4fen85ZovwSQKnY1ALpyTExpcZeYqTvFzc5OkB06OfVH2e/URdCBsofKJ8tLTDUX4pbieK0cggIPpaOyS8L1XCPuDTd4tUqKwZeb0vEWLeBVslKE/et/zpCzFMqGVSkOVdF8Tus7Ze4nlc5vcVYrKphSzuD0IBRfugCkT4fu0gV7no9Ycd7xuepRAbwaoy4DYbokryN/F6IXdZIkPMtrjrx6UzA+q+8kOSoiUexPR9hzXUaf2CLzFCmjpBcAcNZDLhJHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3oZI0JiCiXp/6MO1OOVjOY1MlKKTG5Q2es6MtYitfiA=;
 b=ZTq732pCiU4UCUEPCxUFx8IDR15nyDalzxYlBfOGBWuCtArtSUC/UqbZAfkpRvQVyTyXC9S5iPe5XfvNKJRzI2tacWiUvc589HA9JyFJ/5fVk7GMvKUbrq4pTX1lN8MJEHq/BDxM72XsEvGqppiNZWQgXTWOZ6D0BMb/uIgHSpcvH1KZekeYPyNwrnClZlR+hw+FpV1RfOFhHk3u8r/wmLlQe3kRoB79+rQEuhMFt2Jan5s2voDzAMAeC7wub7SKroHTWX+dpo7sCqxWuxEy0gZf6O9WQnzhfM5tL7lD8a9UmFp7dQxuNr3UhPdJzK+DtkOGC506Itee53d5fC2sTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oZI0JiCiXp/6MO1OOVjOY1MlKKTG5Q2es6MtYitfiA=;
 b=ZTsoPOvGG5mBvAXVlgLzIdpv5LzZOlbytvwLbF+rzdcLeG6+gbZY/qIZD1lVelOmCJ/JQqa14pdtQZP8hhqEf/Aql5AK2t3w7wecm5QcOPRGJF/KNYaassfhUoUNrVExTXetClw3jEchuK2cIPY5sUc353ZNyc4/YuZSV0pNLf4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:27 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:26 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 08/15] serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
Date: Mon,  4 May 2026 16:48:53 +0800
Message-ID: <20260504084900.22380-9-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: dd16dc1b-99af-4f04-6175-08dea9ba2ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	oUhsmRmeurrm0MFsAiAyxwlKRE4A1A/kDg04PMuckAq73y08hAeydtTtC1luyhc0Zh0hhJs1pDJdowI1jV/sijGAbclXmwFkI9asky+y5yfgBKW7btefPwF9b+eEWVxHcQV1Nb7CldzbpgGDBLEeVARU7WDR22UAOHy3hCeqJimPLx5Jagg3va1i/vtXHZnTNVV7jPLJ1NJ8Xw7BjwxWSCLRlBmST+l+ArZh1gyyRYKVJTCDXsH2XNrVRzU4p9bYAWl5hKPPP1twShChdP1Yq6PMbTuygisPRp/2qTbKOZT+zDN7O4Mj3F8A5gCPxZpxvHbvTthjk5iMyjlw+/3mCQ8JSQAe6rwKcLOc0l/QgsUtP7D4dy9NR1JNeNPZtfelFt3wn+oqhphRHNQX/WKXDw+AMoS5GEVGmVDZYA0emJ+a6TGUOSCUtyx3VHQ6pU69mshxZMiv9h/o9Y83cAngAaXzZzCO1+aOp64pIkG4xYahwvgQJ58bI2sm3IYSB1f77KLI25hlCslgYoEn8c3H5/FMDYvrl/z1eq5lNCRIUPKcPVHuCbH/9QppB6+MIVR0rm4A+5ashaOJGR8QRf6Q+Z4pTYEjAWB0Rizsax1sawKnePTuztFdL0ah9owIKtVBR+9/nsI+h6s8ocMQ7gw6tc80iIstro9KnJd0gb2LP1iyPK2ZifXt0IPo7woCVkIFCdToRWPgylNQcH+GmWzIip1jH7V+Js5mtRWEd/uIOQrAK1nZw4ah1NFIbHCeT1K9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQpyJzTD36AfWtvwNSC/U7TjlQeXpmxHmS3b5ubfFEHoHz4r3aS2MaFLyzar?=
 =?us-ascii?Q?VvPuAYoFyXEE1WWHnxzEGX8udfHkRo9MeUwpWcH3SK67t/KFKB12ZmUiQwVZ?=
 =?us-ascii?Q?wD3SRf3Ky0l3u8JDZJxtyutuq0JHhfw9mUg6+EYf43XdDvYD9eWZLFMBvPEL?=
 =?us-ascii?Q?Xseep3r2n/QEQs+7ch/MxD8VCahsSmfgE5BhaisQaE1sCmdmOcyiRtno7V0+?=
 =?us-ascii?Q?9kqTJI6Cw/Ys9O7fe9E1ziRFmCkJQ8bVILcZip3UQfu0ZWuaWo5zlpcKcA6r?=
 =?us-ascii?Q?f+JEMXzLPr9cCSx7CJXpUGw5/v5r7YDILgcudZiXUf/cqza7pUJSdH7HmGyM?=
 =?us-ascii?Q?8Otg+ixzzh86tKiJm4cPAu4w5UfZG9DMedLLAHIoTuLEWQw5nioRe6Nkxo1F?=
 =?us-ascii?Q?94PcPlOYxVCihK0tuQM/PRCddsKNVhiFZxrPugN892iE6wic1BubofXNp6C/?=
 =?us-ascii?Q?VptS1NgX7+CabCVlTCwHmx5T82ETHjq1jis4YsV6c8tVyK9lUUV1uzwgoAwY?=
 =?us-ascii?Q?in/+6xq1DKby2C9DVTEvCLbm8dcl3hQ7RZzLAcQ2DM2l3oTarRe1Khgx5Zk9?=
 =?us-ascii?Q?0nAOpmfgs3CvU/9mcjBRB7wb72oEcIbtyISh1HdNaOlrUIgG+ss0QdwoZsuR?=
 =?us-ascii?Q?ENNNR7zPDHbZdSSbop606B2JFHB/Jyc70dwglbo6b27pX8gp4ir6+v0gMdie?=
 =?us-ascii?Q?FyY6TgSf2JSNMi4IC7ekUk6Ip3RD4djeZLxyr1ptMCupw5YS5n5bBGrxK8Yf?=
 =?us-ascii?Q?dDXlcdtjDvFCsYiwnUMfS+1KkppOV/UoI88abcITAEjz0yU0n9WN1UAwyvrc?=
 =?us-ascii?Q?XpZzJSTshhinXaucZAxt9iZlLf3iUXErBDHsMyGC8n8/U8mLIIo8MskXYtAg?=
 =?us-ascii?Q?hUsxMZdkySLfVP/2kLe9iaIA634XcDbInWiCtAITZHMGz5/wls8wGTbWmjco?=
 =?us-ascii?Q?miMzqDec0i9qPDJ5m7AZr0mgewV+ph3IWpc/zNB6Pgk9WsboZENYgrjqly9O?=
 =?us-ascii?Q?w9V5QGl9Bgtjn57tICttvCReo7dRRscvZ9He9YChKn6SWWm6wfme3/oQi6zV?=
 =?us-ascii?Q?phy0L26m5ozrme3lKdm6Mln0GWVdxw9++DFBi1g+g2tgsHdcfSpdOC63epf9?=
 =?us-ascii?Q?zgIoIWuHr8N9cIvh63cJPgOzWm+Pt01fKiEs2uHmp+FNPjMFcfNjDw+ma9cV?=
 =?us-ascii?Q?ZVQO97nhaoR71Df92lLmEMu8rzGUe8Kf0dDD0MP1zJDBhBuyNQxbxa8pMW68?=
 =?us-ascii?Q?wSZN06wEtfAsObF6LyjvDbGb+jdEJxvmgbf+/d4ljZ1kzT0AY+Dt8Boqjfu8?=
 =?us-ascii?Q?7uEgzG9nt4OICSY89o8M5VfrP1l20LsVCIBc05aLMBTzcidVYaInyTeq8uBO?=
 =?us-ascii?Q?tQCQZ+LUU9woEBFWnjJ4gKimbdjR/u/i3WFEdR25xFRT0ytHk/dHv4NqA75o?=
 =?us-ascii?Q?WW/7AbOUSBVSVV7L11J2x4ChLALkVL1ba2XukwdR29EGcvw6ennSqN/Y8z32?=
 =?us-ascii?Q?BMluLqFE67A2lD1Op+XGIJacLwMv++FIA8YVbRVzzHg0Z5IbaaVX7IHUWK6t?=
 =?us-ascii?Q?UujNK1uNuggvq9YEjVmKrWAIP8XxZ+Zccp/Uj1G7yOdfpg/10IJx0zYS0Y5r?=
 =?us-ascii?Q?qzef9KJjJDAr7N+DeX2gl4P9+mI8vMrywjKulS9sRPtAC7ZEOq/rFfT/fm8w?=
 =?us-ascii?Q?WHQ4arxNs85G6yaS4qep02K55/73wzizTfpc+nd9FjAkB+aM8VBD2akyBSb3?=
 =?us-ascii?Q?z9QqA2VIxHYx0G3ouS1uWLxj+d5mExY=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd16dc1b-99af-4f04-6175-08dea9ba2ff5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:26.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSDhAisls4aqwFQCLpG2izjVlG85Dxa7wNCxFCxD9lZvJEaY2rkaaUtPAUdoFYObMYxa4VeDvj0nfolDr75hR9Gfrx8XitsCApEyXX8QlpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

The MUEx50 UART provides a memory-mapped TX FIFO data window along with
a TX FIFO level counter.

Fill the TX FIFO in bulk via the MMIO FIFO window based on available
FIFO space, and use this path from the mxpcie interrupt handler instead
of the generic serial8250_tx_chars() helper.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 35 ++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index f13fcb090df7..5fe07f6947ef 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -86,8 +86,10 @@
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
 #define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+#define MOXA_PUART_TX_FIFO_CNT	0x16	/* Tx FIFO Data Counter */
 
 #define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
+#define MOXA_PUART_TX_FIFO_MEM	0x100	/* Memory Space to Tx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -317,6 +319,37 @@ static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 	return serial8250_rx_chars(up, lsr);
 }
 
+static void mxpcie8250_tx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	unsigned int i, count, txsize;
+	unsigned char c;
+
+	if (port->x_char) {
+		uart_xchar_out(port, UART_TX);
+		return;
+	}
+	if (uart_tx_stopped(port) || kfifo_is_empty(&tport->xmit_fifo)) {
+		port->ops->stop_tx(port);
+		return;
+	}
+	txsize = serial_in(up, MOXA_PUART_TX_FIFO_CNT);
+	count = min(kfifo_len(&tport->xmit_fifo), port->fifosize - txsize);
+
+	for (i = 0; i < count; ++i) {
+		if (!uart_fifo_get(port, &c))
+			break;
+
+		serial_out(up, MOXA_PUART_TX_FIFO_MEM + i, c);
+	}
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
+		port->ops->stop_tx(port);
+}
+
 static int mxpcie8250_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -337,7 +370,7 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	serial8250_modem_status(up);
 
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+		mxpcie8250_tx_chars(up);
 
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
-- 
2.43.0

