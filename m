Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61CE1F03C4;
	Fri, 21 Mar 2025 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542800; cv=fail; b=n+Rx04G5SQz9OA/YcjZqXiOJhCB0PNCjrsGSRCSL2EXQWbzi8nrwEP1RqxOZp5n6Wl0N2fNhRxN7bWA/9CezpVQfZMUWWuK8m7UPSSAuMBi0CD70prRRiY+ijwdmRlx5E39apFDZXIX00CzNb7LpA0l5qLapKHXUp1D0KKc9TbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542800; c=relaxed/simple;
	bh=yVKd9MvtG73SyQUX+gT+ZSjuflQtG0kywj7mWfGTlKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCBUAAwTLUz9nkDaF7a30YKJ6Vxppu2ePSZat4ce1c7xHscH1RzmmUV4b07E1BCm+hjJ2GmNzwhlKbEjybIBlimHRS6g9L8OIwjm7f+0iGPEQ7VBHMt9X41Rbq5ME5b4sU4XCWlK2Woomg87/qi0yBgZ/aBzZsVIqBPZgYZzHbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=esb041Yy; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="esb041Yy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4owKUamtxPGKesGsBIGvuzwsWAg6xLEbFKEKco0KJaaFxk+jTpCZYXQe2O2rEZFGq56fsZdHYId9/KRAQGqgemiO2DmcY9aeV3v1xBYadm/qrtMdEm1I2EQjeLiI03vlgszwKJOd951VYbiA8tURBGOk4Z0A+vbnn2jDddOvtg9t1awgt4Rrb+AhqvzMQTVwCiCbkUUFmCNPNrsnvwnW3QicEW2kdVc63RlUCfo4cbUven03qLoy839xBhkZHVmW+99lEdG94WAo0r4ZDd22SlEDZXUYgm33qEEoXQ/6pqw+9z0KFVIQ06mLXR/WPc8GXk49nGnpMhA9gH1J+d9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLsINaG0+OYS3qZ729ezuIevmcZ839S/U9uuebei5x0=;
 b=J4PVrU4iD3DGphKTDHMdqQQIy0LByh1lBljdLaSsUE9vZIkbe7jvZ+bzLKnwuCx9s0Z/vLUYIf+ZvMPwgeZ00n7/tYcxe2NSyxERA95y8bRBN6R+2L6nDA+GvXDSJVizTpkomBb+tEOryN2mrk+hn6N3tRPILM43Q+rpXh1uI/el1VpmhkAb7yCcKoPYokyi3Jqid84OnJvsSqphwAa3fZyHjRd9mxeIyLqnhMZBvr/NrsDEb6Ju1Tiobw5NTI2duL6typf8dgIhqs532MnkRg063y+NNHdpSrcwcn07g45CI5li0ku7cko/t2ESvdLlIrx9g7cAXXUK88dtY9XkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLsINaG0+OYS3qZ729ezuIevmcZ839S/U9uuebei5x0=;
 b=esb041Yyn7DtjbrtnXtQxRSZgfXvCFHnRyRkjrWQZd5nROrk2iahzsfJD2nsSzxNQWBvQlNgi6UdoyKYflEcvJJY1PDPtSimqiykAVmkbjxzGXlIM895/8DLLdAL/PmxOM9iVw8D2KRcdRcJSm/Z4f3d8uC8Z+v4xpMV1AmxxjbV640LiJfzBGAZk/miJXtEVLEJFEhdTVnqEWMRBOxkdhvf79XIKizRktDGT3APgloEOWd2vPo/QXRVhVwIz83fxJYEr5ZET+eV/ZhzJso0bN8RVyNNNefGT9+I5VKe7GTu0V4upArrUEake+YzdsX78OS42Nzlv/bArEgW5tGc8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 07:39:55 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:39:55 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V4 3/3] tty: serial: fsl_lpuart: rename register variables more specifically
Date: Fri, 21 Mar 2025 15:39:50 +0800
Message-Id: <20250321073950.108820-4-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321073950.108820-1-sherry.sun@nxp.com>
References: <20250321073950.108820-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0187.apcprd06.prod.outlook.com (2603:1096:4:1::19)
 To DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS8PR04MB7957:EE_
X-MS-Office365-Filtering-Correlation-Id: d68c78a6-0acf-4436-b947-08dd684b92c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZqlp3RtAEbid8vIFOEwxY8wAsq0Vy8Felvm+8YliSq8JSRa5zzKMAugwhFr?=
 =?us-ascii?Q?PPVJJZXxpN8MQpVEbh/hqnN9rmE7RvuBGjZ41tIXKNfGQpMTqI0xKOKCyYal?=
 =?us-ascii?Q?MUXWPRaWFKSXlxVR36S/JZA9LrNTs5H7Wbnmb7BQ+3nPYqrp4Nt7IgauY+Jk?=
 =?us-ascii?Q?xZIq0m5BlrEY680HClgWSJXHiT7SB1v/RFKmQZLQjCPJZWRh0m1WyNOfgIqT?=
 =?us-ascii?Q?H5PYqs2mSp6b3+wsETfLhnCYqgsc84IduYI65onalM+8Plxh3k3majSm/oJ2?=
 =?us-ascii?Q?5+zpBMce68+kapP9BYgIRdMYM7Rp0KKI9qR6wDcsMkScII4rtVjbgSeOq2Q5?=
 =?us-ascii?Q?p9FJ5NwOfXVZn1tbUny1EUfW/iRloJETSFHGOK/zFw+9FQMnfvGxYugA0MpB?=
 =?us-ascii?Q?3GzvcKd+WyXwe0Kxh58gTQHwrrChWR6gMgx6TMAFgVAue4cmRAw89ODExtuu?=
 =?us-ascii?Q?p0Ojl4NM2k6CcL976FfwHI6pbCXTahq0sdZWijawevTh98XCBtcyv/ksKZ4v?=
 =?us-ascii?Q?17SqDAnRBKWwnDl1BzgpkAhDlUv7dIUfrjps8cwoW8czKwNhLVIlcOMn0CuF?=
 =?us-ascii?Q?USTHEWOHjixwK8Tct/huzyfy5oeduJZ1H8GZEy1RCqqe+/unwazbiUevZ0zi?=
 =?us-ascii?Q?L3J5d/jM6piWXf2PZRANt22MN2jwodTuFCtT8h6XYLr8+NQUS/a9CeV8SJXV?=
 =?us-ascii?Q?ll5D+B97oyw/sKjMV6FTEobug2WJMj8DWLZYJukO9XGoSNsvOuJ0ZmT7ok6z?=
 =?us-ascii?Q?/SuYlDv9YaaKMXQkjAWoJaCsj/PtTfUXYA2GRZFjDrpe+n+YE1rW9+dYVzBy?=
 =?us-ascii?Q?zYTxBOTCbVAdZQ0yKP7XH3LzyvVpJmkXRrCdWFwIyNaCUlzILxo5Xmd0z4Qa?=
 =?us-ascii?Q?Rm3CVGMHFqZ30yEQYZ0PzRqS5IVyZozKlTYrDtx2WkdGabzPXeZSmqxockfM?=
 =?us-ascii?Q?PLzMfIQZzJai+HOKNBZb8ecc+Jl3VVyCSCCxdsWm0V9VfInFH3QpvaFeSAUb?=
 =?us-ascii?Q?N/pm00h6XGbAHC8JM0ewH7s3aqT1itesTqvb/tZ9fdUcRmmVuKzRCDIMR46v?=
 =?us-ascii?Q?rHzT+imxO5iwXRNsAB14fHTdwrd9HRndp9paoj3vk5h0hHS1j36sgmAYMkqh?=
 =?us-ascii?Q?P/mPszAcBubQIwqhyLrvlXL14DSAHGlnF2YqqbuWljlpirh3nCgicWN577V9?=
 =?us-ascii?Q?nQdVykze337VVDlHiwb7/+MzDXLYrBCYMB/eKe+f1gPwNp++AsrI3bgu5r5z?=
 =?us-ascii?Q?qrhlAqT+uN3VRIQ+rvTgzSPcHbjYLgHHH+ApguHxjUP2pWMlESoZWRUsiETF?=
 =?us-ascii?Q?O7Com0VlPik6tK+61FyiWm85xDMTqrylRGC5sB005GH3ke5PkbFKI3//qFRV?=
 =?us-ascii?Q?n3MPv/tJau0dUThWQRJTvW7HD3xfQYMNxTHEvk6pr/t4ijZ8GjWGHz/O3glg?=
 =?us-ascii?Q?kLmBk5ioar58Znidf1QBAytJLnDSrQyc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ssTxILMB/M9wJfvV62lsokhjH4VPc9+uUvKvaSFrOAQmDoRfy34P8OdPFmZ?=
 =?us-ascii?Q?EFPSnJEy4B5HU1iBsxc+Nd32lxQ8DYbk/JMcz6x83aB2iX4HaPvtG1CPzOsd?=
 =?us-ascii?Q?X0+UoEju7j0IkOQAQPphbyKYlVgj4XlizUeY3H0fYP5j2T6+9DZaJREUSaWe?=
 =?us-ascii?Q?2fCEWeAa9zg/eAvK3VTz0uSJC27Ki0SVO4/hop56VX+F8WNwHjQGG1tAIevG?=
 =?us-ascii?Q?BY6Qp6tPDfdFBx34yF7YRbO5AVOPJtr6zDqNYf6mQkyPlLjlUfEOBd04rNPb?=
 =?us-ascii?Q?QOly3XVo7w9RSL9slPCar03jq2m/BqdYwjS1CXKB+Kq6i3P8Rn/TwYhhy4k7?=
 =?us-ascii?Q?PxQlmu8iB/3B4fYA0yLtCsCC/XPIYlqIQ+FpTR+GGA447mUZAkmhSeOjwJOR?=
 =?us-ascii?Q?4TdA3D6GAnacJlheTEkSbwviGqjcVi6eEDSFH5zdOXKKHEA4bpBrlWYcAy4X?=
 =?us-ascii?Q?bAjPZNPdz/0KOoC0Tl/rMvW+T/fmcneYOssZ2ikUjnzc1j7vfiynC2iXfdoC?=
 =?us-ascii?Q?O6tYpVq5A/tsPsDR+SPbQ+zVxXpNhBy6anm2kVmvxZQcuJmG5nZaFSgd2CmF?=
 =?us-ascii?Q?eig51DWX4nX1uOvw5IowogYYtKbEkjibWB3gCOZ3a4KF4WaZQXeT2ImgQ1yT?=
 =?us-ascii?Q?fbMJLV+tq2fSacUIIw620D5qf+kvcZeu41+OmXFm+O6dxJX4o3Xv9W8wOPF6?=
 =?us-ascii?Q?2mZHvRmIqJzFeDrSFDB29y9K69jkACJvaecEQnUb2u0yOkPbyrCHofJZ5S0a?=
 =?us-ascii?Q?9IHmEgREaUGR4JECX2UXwrH43MRQGG7sV45QPxDi12sN7zPzJIMX73xfJQy+?=
 =?us-ascii?Q?ufiH6SDM0Ckr8FgaFlS7bc+0pRT0lHN8R6vHAqFmHyILVPFXL+cAWklUvF9m?=
 =?us-ascii?Q?cfX6WGDDp84SXqM6hL6jyKYS9L76ZMzJQ3wjjcZZ/FcRV7EkbQ/eMiUJr4Zf?=
 =?us-ascii?Q?iSK+sbLOOjnph7k3UW/pKCO7OIxFQhJhJ1M4meCs/ps5BdMZArIg2GJhpMaX?=
 =?us-ascii?Q?ppQ7etCtxICbQr8ZO3wNfexJRxTw9biG+OepPBbtNl1TRy3XAmG0eEijOjfZ?=
 =?us-ascii?Q?WvNTZMx7fOrtwXo6DG1+nmIJB0FG/4Dg0RDZ7PEMrkNq9UTv6BCzTzbCTkAB?=
 =?us-ascii?Q?Jy4uvZWJvJH07tCve9mq+d8RVo/Pz8pM1vpotZW5a6eX/r+F5w0KceXMSrgk?=
 =?us-ascii?Q?GPrbK4f7HbX8Sepz13iuMlIWtmq2y6pSuv2Pwf2xSwFdl0+AaNg835tchpj4?=
 =?us-ascii?Q?XGtunkLRQ4eEyklFSvcdRM5ewGwabJj/I4TnqbYXFUNt5hb15F4QckVG2TAl?=
 =?us-ascii?Q?2b7eG6YkuXfOyZvC8s8zBaggnexZTJhU9kPui6FKtyJrcV9qIyiR1KqbPkXE?=
 =?us-ascii?Q?bx/P05UzRTWLMYYIX3SsQzh2dduliNiJx/KSOIZi52KUHq3+Hz8lP/izyrYu?=
 =?us-ascii?Q?WVSmtGGLGwhbNTVIq/zBDk2nXiRGwTj3rh2PkAKFBFSTt3CeScqOqQKMOlCz?=
 =?us-ascii?Q?KGzIOf71a7gkcmtPa87IQhCUqO33/7PEvpwWHn95YpOJg3YwS3hb13Hm6ON4?=
 =?us-ascii?Q?PUhKTQIEJ0kcjDvXaylYRaerrn8RH4USwcyb3PFP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68c78a6-0acf-4436-b947-08dd684b92c1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:39:55.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+z7y1LEIv/+iSLLH3SXhOR0/rzFlEYlyQlGHg6tndinzZnM+4wrluD8f44igQp69JDjSx+PDhtgzjSsBsQpog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

There are many fuzzy register variables in the lpuart driver, such as
temp, tmp, val, reg. Let's give these register variables more specific
names.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 220 ++++++++++++++++----------------
 1 file changed, 110 insertions(+), 110 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f3f5d7e21693..434f42ec2a5b 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -441,36 +441,36 @@ static unsigned int lpuart_get_baud_clk_rate(struct lpuart_port *sport)
 
 static void lpuart_stop_tx(struct uart_port *port)
 {
-	u8 temp;
+	u8 cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	temp &= ~(UARTCR2_TIE | UARTCR2_TCIE);
-	writeb(temp, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	cr2 &= ~(UARTCR2_TIE | UARTCR2_TCIE);
+	writeb(cr2, port->membase + UARTCR2);
 }
 
 static void lpuart32_stop_tx(struct uart_port *port)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
-	temp &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
-	lpuart32_write(port, temp, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
+	ctrl &= ~(UARTCTRL_TIE | UARTCTRL_TCIE);
+	lpuart32_write(port, ctrl, UARTCTRL);
 }
 
 static void lpuart_stop_rx(struct uart_port *port)
 {
-	u8 temp;
+	u8 cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	writeb(temp & ~UARTCR2_RE, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	writeb(cr2 & ~UARTCR2_RE, port->membase + UARTCR2);
 }
 
 static void lpuart32_stop_rx(struct uart_port *port)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
-	lpuart32_write(port, temp & ~UARTCTRL_RE, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
+	lpuart32_write(port, ctrl & ~UARTCTRL_RE, UARTCTRL);
 }
 
 static void lpuart_dma_tx(struct lpuart_port *sport)
@@ -599,7 +599,7 @@ static void lpuart_flush_buffer(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	struct dma_chan *chan = sport->dma_tx_chan;
-	u32 val;
+	u32 fifo;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (sport->dma_tx_in_progress) {
@@ -611,13 +611,13 @@ static void lpuart_flush_buffer(struct uart_port *port)
 	}
 
 	if (lpuart_is_32(sport)) {
-		val = lpuart32_read(port, UARTFIFO);
-		val |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
-		lpuart32_write(port, val, UARTFIFO);
+		fifo = lpuart32_read(port, UARTFIFO);
+		fifo |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
+		lpuart32_write(port, fifo, UARTFIFO);
 	} else {
-		val = readb(port->membase + UARTCFIFO);
-		val |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
-		writeb(val, port->membase + UARTCFIFO);
+		fifo = readb(port->membase + UARTCFIFO);
+		fifo |= UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH;
+		writeb(fifo, port->membase + UARTCFIFO);
 	}
 }
 
@@ -640,7 +640,7 @@ static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
 static int lpuart_poll_init(struct uart_port *port)
 {
 	unsigned long flags;
-	u8 temp;
+	u8 fifo;
 
 	port->fifosize = 0;
 
@@ -648,9 +648,9 @@ static int lpuart_poll_init(struct uart_port *port)
 	/* Disable Rx & Tx */
 	writeb(0, port->membase + UARTCR2);
 
-	temp = readb(port->membase + UARTPFIFO);
+	fifo = readb(port->membase + UARTPFIFO);
 	/* Enable Rx and Tx FIFO */
-	writeb(temp | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
+	writeb(fifo | UARTPFIFO_RXFE | UARTPFIFO_TXFE,
 			port->membase + UARTPFIFO);
 
 	/* flush Tx and Rx FIFO */
@@ -691,7 +691,7 @@ static int lpuart_poll_get_char(struct uart_port *port)
 static int lpuart32_poll_init(struct uart_port *port)
 {
 	unsigned long flags;
-	u32 temp;
+	u32 fifo;
 
 	port->fifosize = 0;
 
@@ -700,10 +700,10 @@ static int lpuart32_poll_init(struct uart_port *port)
 	/* Disable Rx & Tx */
 	lpuart32_write(port, 0, UARTCTRL);
 
-	temp = lpuart32_read(port, UARTFIFO);
+	fifo = lpuart32_read(port, UARTFIFO);
 
 	/* Enable Rx and Tx FIFO */
-	lpuart32_write(port, temp | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
+	lpuart32_write(port, fifo | UARTFIFO_RXFE | UARTFIFO_TXFE, UARTFIFO);
 
 	/* flush Tx and Rx FIFO */
 	lpuart32_write(port, UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH, UARTFIFO);
@@ -786,10 +786,10 @@ static void lpuart_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port,
 			struct lpuart_port, port);
-	u8 temp;
+	u8 cr2;
 
-	temp = readb(port->membase + UARTCR2);
-	writeb(temp | UARTCR2_TIE, port->membase + UARTCR2);
+	cr2 = readb(port->membase + UARTCR2);
+	writeb(cr2 | UARTCR2_TIE, port->membase + UARTCR2);
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
@@ -803,14 +803,14 @@ static void lpuart_start_tx(struct uart_port *port)
 static void lpuart32_start_tx(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 temp;
+	u32 ctrl;
 
 	if (sport->lpuart_dma_tx_use) {
 		if (!lpuart_stopped_or_empty(port))
 			lpuart_dma_tx(sport);
 	} else {
-		temp = lpuart32_read(port, UARTCTRL);
-		lpuart32_write(port, temp | UARTCTRL_TIE, UARTCTRL);
+		ctrl = lpuart32_read(port, UARTCTRL);
+		lpuart32_write(port, ctrl | UARTCTRL_TIE, UARTCTRL);
 
 		if (lpuart32_read(port, UARTSTAT) & UARTSTAT_TDRE)
 			lpuart32_transmit_buffer(sport);
@@ -1408,9 +1408,9 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	dma_async_issue_pending(chan);
 
 	if (lpuart_is_32(sport)) {
-		u32 temp = lpuart32_read(&sport->port, UARTBAUD);
+		u32 baud = lpuart32_read(&sport->port, UARTBAUD);
 
-		lpuart32_write(&sport->port, temp | UARTBAUD_RDMAE, UARTBAUD);
+		lpuart32_write(&sport->port, baud | UARTBAUD_RDMAE, UARTBAUD);
 
 		if (sport->dma_idle_int) {
 			u32 ctrl = lpuart32_read(&sport->port, UARTCTRL);
@@ -1517,10 +1517,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
 	unsigned int mctrl = 0;
-	u8 reg;
+	u8 cr1;
 
-	reg = readb(port->membase + UARTCR1);
-	if (reg & UARTCR1_LOOPS)
+	cr1 = readb(port->membase + UARTCR1);
+	if (cr1 & UARTCR1_LOOPS)
 		mctrl |= TIOCM_LOOP;
 
 	return mctrl;
@@ -1529,10 +1529,10 @@ static unsigned int lpuart_get_mctrl(struct uart_port *port)
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
 	unsigned int mctrl = TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
-	u32 reg;
+	u32 ctrl;
 
-	reg = lpuart32_read(port, UARTCTRL);
-	if (reg & UARTCTRL_LOOPS)
+	ctrl = lpuart32_read(port, UARTCTRL);
+	if (ctrl & UARTCTRL_LOOPS)
 		mctrl |= TIOCM_LOOP;
 
 	return mctrl;
@@ -1540,49 +1540,49 @@ static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	u8 reg;
+	u8 cr1;
 
-	reg = readb(port->membase + UARTCR1);
+	cr1 = readb(port->membase + UARTCR1);
 
 	/* for internal loopback we need LOOPS=1 and RSRC=0 */
-	reg &= ~(UARTCR1_LOOPS | UARTCR1_RSRC);
+	cr1 &= ~(UARTCR1_LOOPS | UARTCR1_RSRC);
 	if (mctrl & TIOCM_LOOP)
-		reg |= UARTCR1_LOOPS;
+		cr1 |= UARTCR1_LOOPS;
 
-	writeb(reg, port->membase + UARTCR1);
+	writeb(cr1, port->membase + UARTCR1);
 }
 
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	u32 reg;
+	u32 ctrl;
 
-	reg = lpuart32_read(port, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
 
 	/* for internal loopback we need LOOPS=1 and RSRC=0 */
-	reg &= ~(UARTCTRL_LOOPS | UARTCTRL_RSRC);
+	ctrl &= ~(UARTCTRL_LOOPS | UARTCTRL_RSRC);
 	if (mctrl & TIOCM_LOOP)
-		reg |= UARTCTRL_LOOPS;
+		ctrl |= UARTCTRL_LOOPS;
 
-	lpuart32_write(port, reg, UARTCTRL);
+	lpuart32_write(port, ctrl, UARTCTRL);
 }
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
 {
-	u8 temp;
+	u8 cr2;
 
-	temp = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
+	cr2 = readb(port->membase + UARTCR2) & ~UARTCR2_SBK;
 
 	if (break_state != 0)
-		temp |= UARTCR2_SBK;
+		cr2 |= UARTCR2_SBK;
 
-	writeb(temp, port->membase + UARTCR2);
+	writeb(cr2, port->membase + UARTCR2);
 }
 
 static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(port, UARTCTRL);
+	ctrl = lpuart32_read(port, UARTCTRL);
 
 	/*
 	 * LPUART IP now has two known bugs, one is CTS has higher priority than the
@@ -1599,22 +1599,22 @@ static void lpuart32_break_ctl(struct uart_port *port, int break_state)
 		 * Disable the transmitter to prevent any data from being sent out
 		 * during break, then invert the TX line to send break.
 		 */
-		temp &= ~UARTCTRL_TE;
-		lpuart32_write(port, temp, UARTCTRL);
-		temp |= UARTCTRL_TXINV;
-		lpuart32_write(port, temp, UARTCTRL);
+		ctrl &= ~UARTCTRL_TE;
+		lpuart32_write(port, ctrl, UARTCTRL);
+		ctrl |= UARTCTRL_TXINV;
+		lpuart32_write(port, ctrl, UARTCTRL);
 	} else {
 		/* Disable the TXINV to turn off break and re-enable transmitter. */
-		temp &= ~UARTCTRL_TXINV;
-		lpuart32_write(port, temp, UARTCTRL);
-		temp |= UARTCTRL_TE;
-		lpuart32_write(port, temp, UARTCTRL);
+		ctrl &= ~UARTCTRL_TXINV;
+		lpuart32_write(port, ctrl, UARTCTRL);
+		ctrl |= UARTCTRL_TE;
+		lpuart32_write(port, ctrl, UARTCTRL);
 	}
 }
 
 static void lpuart_setup_watermark(struct lpuart_port *sport)
 {
-	u8 val, cr2, cr2_saved;
+	u8 fifo, cr2, cr2_saved;
 
 	cr2 = readb(sport->port.membase + UARTCR2);
 	cr2_saved = cr2;
@@ -1622,8 +1622,8 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 			UARTCR2_RIE | UARTCR2_RE);
 	writeb(cr2, sport->port.membase + UARTCR2);
 
-	val = readb(sport->port.membase + UARTPFIFO);
-	writeb(val | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
+	fifo = readb(sport->port.membase + UARTPFIFO);
+	writeb(fifo | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
 			sport->port.membase + UARTPFIFO);
 
 	/* flush Tx and Rx FIFO */
@@ -1693,14 +1693,14 @@ static void lpuart32_setup_watermark(struct lpuart_port *sport)
 
 static void lpuart32_setup_watermark_enable(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
 	lpuart32_setup_watermark(sport);
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp |= UARTCTRL_RE | UARTCTRL_TE;
-	temp |= FIELD_PREP(UARTCTRL_IDLECFG, 0x7);
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl |= UARTCTRL_RE | UARTCTRL_TE;
+	ctrl |= FIELD_PREP(UARTCTRL_IDLECFG, 0x7);
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void rx_dma_timer_init(struct lpuart_port *sport)
@@ -1817,16 +1817,16 @@ static void lpuart_hw_setup(struct lpuart_port *sport)
 static int lpuart_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u8 temp;
+	u8 fifo;
 
 	/* determine FIFO size and enable FIFO mode */
-	temp = readb(port->membase + UARTPFIFO);
+	fifo = readb(port->membase + UARTPFIFO);
 
-	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_TXSIZE_OFF) &
+	sport->txfifo_size = UARTFIFO_DEPTH((fifo >> UARTPFIFO_TXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
 	port->fifosize = sport->txfifo_size;
 
-	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &
+	sport->rxfifo_size = UARTFIFO_DEPTH((fifo >> UARTPFIFO_RXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
 
 	lpuart_request_dma(sport);
@@ -1837,24 +1837,24 @@ static int lpuart_startup(struct uart_port *port)
 
 static void lpuart32_hw_disable(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
-	temp &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl &= ~(UARTCTRL_RIE | UARTCTRL_ILIE | UARTCTRL_RE |
 		  UARTCTRL_TIE | UARTCTRL_TE);
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void lpuart32_configure(struct lpuart_port *sport)
 {
-	u32 temp;
+	u32 ctrl;
 
-	temp = lpuart32_read(&sport->port, UARTCTRL);
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
 	if (!sport->lpuart_dma_rx_use)
-		temp |= UARTCTRL_RIE | UARTCTRL_ILIE;
+		ctrl |= UARTCTRL_RIE | UARTCTRL_ILIE;
 	if (!sport->lpuart_dma_tx_use)
-		temp |= UARTCTRL_TIE;
-	lpuart32_write(&sport->port, temp, UARTCTRL);
+		ctrl |= UARTCTRL_TIE;
+	lpuart32_write(&sport->port, ctrl, UARTCTRL);
 }
 
 static void lpuart32_hw_setup(struct lpuart_port *sport)
@@ -1877,16 +1877,16 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 static int lpuart32_startup(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u32 temp;
+	u32 fifo;
 
 	/* determine FIFO size */
-	temp = lpuart32_read(port, UARTFIFO);
+	fifo = lpuart32_read(port, UARTFIFO);
 
-	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_TXSIZE_OFF) &
+	sport->txfifo_size = UARTFIFO_DEPTH((fifo >> UARTFIFO_TXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
 	port->fifosize = sport->txfifo_size;
 
-	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTFIFO_RXSIZE_OFF) &
+	sport->rxfifo_size = UARTFIFO_DEPTH((fifo >> UARTFIFO_RXSIZE_OFF) &
 					    UARTFIFO_FIFOSIZE_MASK);
 
 	/*
@@ -1931,16 +1931,16 @@ static void lpuart_dma_shutdown(struct lpuart_port *sport)
 static void lpuart_shutdown(struct uart_port *port)
 {
 	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
-	u8 temp;
+	u8 cr2;
 	unsigned long flags;
 
 	uart_port_lock_irqsave(port, &flags);
 
 	/* disable Rx/Tx and interrupts */
-	temp = readb(port->membase + UARTCR2);
-	temp &= ~(UARTCR2_TE | UARTCR2_RE |
+	cr2 = readb(port->membase + UARTCR2);
+	cr2 &= ~(UARTCR2_TE | UARTCR2_RE |
 			UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_RIE);
-	writeb(temp, port->membase + UARTCR2);
+	writeb(cr2, port->membase + UARTCR2);
 
 	uart_port_unlock_irqrestore(port, flags);
 
@@ -2138,7 +2138,7 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 				     unsigned int baudrate, bool use_rx_dma,
 				     bool use_tx_dma)
 {
-	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, tmp;
+	u32 sbr, osr, baud_diff, tmp_osr, tmp_sbr, tmp_diff, baud;
 	u32 clk = port->uartclk;
 
 	/*
@@ -2167,9 +2167,9 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 		tmp_diff = clk / (tmp_osr * tmp_sbr) - baudrate;
 
 		/* select best values between sbr and sbr+1 */
-		tmp = clk / (tmp_osr * (tmp_sbr + 1));
-		if (tmp_diff > (baudrate - tmp)) {
-			tmp_diff = baudrate - tmp;
+		baud = clk / (tmp_osr * (tmp_sbr + 1));
+		if (tmp_diff > (baudrate - baud)) {
+			tmp_diff = baudrate - baud;
 			tmp_sbr++;
 		}
 
@@ -2191,23 +2191,23 @@ static void __lpuart32_serial_setbrg(struct uart_port *port,
 		dev_warn(port->dev,
 			 "unacceptable baud rate difference of more than 3%%\n");
 
-	tmp = lpuart32_read(port, UARTBAUD);
+	baud = lpuart32_read(port, UARTBAUD);
 
 	if ((osr > 3) && (osr < 8))
-		tmp |= UARTBAUD_BOTHEDGE;
+		baud |= UARTBAUD_BOTHEDGE;
 
-	tmp &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
-	tmp |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
+	baud &= ~(UARTBAUD_OSR_MASK << UARTBAUD_OSR_SHIFT);
+	baud |= ((osr-1) & UARTBAUD_OSR_MASK) << UARTBAUD_OSR_SHIFT;
 
-	tmp &= ~UARTBAUD_SBR_MASK;
-	tmp |= sbr & UARTBAUD_SBR_MASK;
+	baud &= ~UARTBAUD_SBR_MASK;
+	baud |= sbr & UARTBAUD_SBR_MASK;
 
 	if (!use_rx_dma)
-		tmp &= ~UARTBAUD_RDMAE;
+		baud &= ~UARTBAUD_RDMAE;
 	if (!use_tx_dma)
-		tmp &= ~UARTBAUD_TDMAE;
+		baud &= ~UARTBAUD_TDMAE;
 
-	lpuart32_write(port, tmp, UARTBAUD);
+	lpuart32_write(port, baud, UARTBAUD);
 }
 
 static void lpuart32_serial_setbrg(struct lpuart_port *sport,
@@ -3082,7 +3082,7 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
-	u32 val;
+	u32 stat;
 
 	pinctrl_pm_select_default_state(dev);
 
@@ -3091,8 +3091,8 @@ static int lpuart_resume_noirq(struct device *dev)
 
 		/* clear the wakeup flags */
 		if (lpuart_is_32(sport)) {
-			val = lpuart32_read(&sport->port, UARTSTAT);
-			lpuart32_write(&sport->port, val, UARTSTAT);
+			stat = lpuart32_read(&sport->port, UARTSTAT);
+			lpuart32_write(&sport->port, stat, UARTSTAT);
 		}
 	}
 
-- 
2.34.1

