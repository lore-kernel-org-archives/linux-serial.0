Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227716F282;
	Fri,  7 Mar 2025 02:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314402; cv=fail; b=H/dtlAOlr+2OUUgFSCAn6n2WKlX3N5dbLpwOJw43Dmmv4C0HC7hbwDX1PP0dA2wKuKLgIuatoLkxOwogknD3eazJLZozMenDWaynCujdHir1RbHyx4eJJkwK8NlI5FkabMtdiPfHS45320aFfLEv9P45mptN+QCcPpvXCqJV5qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314402; c=relaxed/simple;
	bh=Ak8/boKXPB5ZoBAGMIfTlTDOU5H8IsmrTOYvSJYIN7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/z6gFom+GKqrko4FTXlmzkeklnwrrnt2QH2lbRQxNN2rcL/y073K/xQPx2c5qpzSDlR8CLYEBo9Xv8MRbJobOrUv8RyjgNLXgJ8qWpI9G4hwTfuZdKuKsjJHCjrqZa3f5Yg7KM9gSCUS3FKxqOH5sdaCvViLK4rKxo3dqtQKPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kibbsBfp; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kibbsBfp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2sMYCpJm4M9cdW9cuu/6Grdak7oHZmFGTvHaoLaxHklB/mTlOX8eH67Cvg3NHs2bY/SeBYFd+ezHuS7A6Wl7n9tDZHiceheU8A47Onq5Ie3gTntqAUgZUosCOY/VheGZApU2X4y4sm+271aFsX/QxkKOg2yWA/gPUcYMzy51A4yUPPoNDzq3qpTxRi5jtT9uquPIN5iCnk+tBpRahcjCFPvzsfW9dOcxqyqpGKSrSG2Pzvnu0UVFrVuDGB7Qt0AXIBGYUkwWmU5Iw/WTLw02XTN5GyZ7Xrmu5ViVqD8yGNHoxKvd7XRuxXSnWfqI1eU0O+TF6w71ez/eOtgqXS/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2d0rQOBVw1zDir33v1ZWkGIuJSjpwI1CWr59WGmNarc=;
 b=mFHmfEO0YxU0f1qBzK3IzhNWzffrRAKfecU9Mc9nHsUI1/BtWq1Ua1Wyy0ThI73Ma044PoNrXocnfTjSkz1jIqaosXSBgqDDnBzMKy3LJ6O5/NxAnkJ+q5oyw3AuhPYXR1jcsTqiz5Vp6qG1u7X0tUb6CNAZs57UfyuiNO0c7e4hW27EnnVPVuqoEsOEzHUm1B/nb2lBpzji4VqStWFmw35BeOpW5R2LulFbz57IRE78eXhTqRaorvQ1R+5cZxX4zAlwifmkbG5j/LJmTiaDGkRx/jg1T3W/DO62jhLLSo4a3G8RVeb/VgG9rcYuJUeIzc67W4kCwG0Kxc/P7T5fmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2d0rQOBVw1zDir33v1ZWkGIuJSjpwI1CWr59WGmNarc=;
 b=kibbsBfpckC1KC33j+SEWN1uq7R32zDCl7vPVzmTL4nIHt63JifyyF79LvvShbmJdNkLKnXuRSwLOZ1CBBSVUNFca7vQfvXxsZ2QmvbdZydVlB94NG0DN6EM7dRYUgeyu8Yv9YtOe49FGRi61Xmu7fgGBJADNVsRRhw5SHHj2KMeZJEqGSO+ISphS1AV1tyNp2ORo21WkL4EvqHmCaTSvvvBRlWdXlktWfF2TpWe1EMnLC6pRAm53QMIAFfzySicT4bh0BjPRbrd5tRwUIUqwEpYoGdGcu7CrazIzqnsG35mB2N7mVsW0EivQd7y3jblVJTCXnRB9Jas4XqQEfXIwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 02:26:38 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:26:38 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH 2/2] tty: serial: fsl_lpuart: use port struct directly to simply code
Date: Fri,  7 Mar 2025 10:25:47 +0800
Message-Id: <20250307022547.1000293-3-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8124bc17-2583-4de1-3bf9-08dd5d1f7cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wEDAnVQ3RyAkNwnOYjzm+TEnEpCI2qr40evkj+dBJgoKe/+TeV6HzhfKLupe?=
 =?us-ascii?Q?ww3Wyj62g+7ZsW29fmArKrLTnqsDiLDQnWEEMCpr4ZqXt09ql9sqJw93sABM?=
 =?us-ascii?Q?w8t+k/QQunK6YWrv5N8N/n5Bc/i54HyXJDmd2e60Yd+2xBocrssWToG3U2rx?=
 =?us-ascii?Q?Ez20vwZdm5rI37KHg2NwWeoJHHCXGoEvfNwh3VSzF/bloaFpxFWdNIN6P+Ng?=
 =?us-ascii?Q?mN1C7EzHu6HEGjxL55yhf9MPf+79oAzBOT3+uDhg8QpX1UYUvV1cX8d3RrNj?=
 =?us-ascii?Q?elzTyYzMCjI3vumaw6VEB6avXjNirSfKJ6Bv0YYYLGeaum4hUbNn+ZKrmdPc?=
 =?us-ascii?Q?RNYPNYOrN7bPYznCUSadZb+YkEnmYfjoxodpadlLtv+D0xJ6jDv/tEk9Fc/G?=
 =?us-ascii?Q?jq3K6p93anFde1HqqTErFkIXhPJXrG1X4SfiL4Yh7CuIq8Y8UBTC0T/8Rzgo?=
 =?us-ascii?Q?niSHt1sJlf1xgV6rELw1aYKYe4qcsjqx3lk6tBcQ6tUvvp33B1Z2Tfszpwrj?=
 =?us-ascii?Q?BL7NTMdSXzCUXSFFqgWk0dPHeo8vL6cFLrSvLvKZMkgnUxYo6cH7JsYT4ME4?=
 =?us-ascii?Q?5+yxXdwK1vTE0U05rM3Dw9jhtX32mYjBaERG7yh9xv86kcg7hQKNMtUuVLf7?=
 =?us-ascii?Q?6xgc/ursAxR0vzSbbO6u+2jMcwC3JP4/TcKfhQD0PDouiutFpj7PoGc4jEUE?=
 =?us-ascii?Q?wWaafcBidc32jR5KXiDT7N0BrA7WOBNLmNx1YOFvKoRETYjou9mSF+ZL1cqp?=
 =?us-ascii?Q?7Q6jnGFiPTdN1D1Ky51nu4BsfSBNkiY6vyE+plqE6LmZCckeblU8uNm2zYXI?=
 =?us-ascii?Q?ROPAzEZYSTKKBDkL+4qiLdvLHBLOpscNbKarFp6K+tuP/rTlFzLGoBKz67So?=
 =?us-ascii?Q?ko5O6Tl4CG3sF3eM7Bse7iYNO0dPry4tFjDWh1b/rtCP5TSSQTBu8MfSPVIJ?=
 =?us-ascii?Q?OrmY1/puN1IdyfOUvJImqw9a3UEUsCi5wwqiSMLzTA89HchXtOaeBr4EZ0nA?=
 =?us-ascii?Q?1Vl0+kFxzA6JcUyknlHt9E+wsv9sXVppp0xO8dsyYmhFD6ONL/uhvQJx27qi?=
 =?us-ascii?Q?h2F5byMvF/Abf1ZqMxfqAhNrRgRE3qmt27f9Wq8tFb7dwdAUhMUAMZVG/ePS?=
 =?us-ascii?Q?5MQpa1RaZ+W2q0TwYrelWZDX6vICMW1WWLNgDM/RiNC5+g3/F7IdMB5iO5NT?=
 =?us-ascii?Q?WQXD66s0xGrqn7NF+1JutcR2Ucq2EH6qhLnjP3pybOoUObd4eBbc3A8+6Bby?=
 =?us-ascii?Q?Ave+XRIXLTr/jIUUU0cKIopmrDYhDbc/tEzm0Yju22tzUklUUVcphE0kI8aH?=
 =?us-ascii?Q?isKZc69qifcmpvJH+woR7T+lfnmPKumaLbL8bNOnIcHPGomgvHa4SyQ1Igbt?=
 =?us-ascii?Q?d/MjQmAOYpsZbEVVlYeJa/cb8H+o8aaKGvOP8ihi37dvkw0bGD7FEcoGgaqq?=
 =?us-ascii?Q?ljkP1mxqyINWF6mQ4o4PwASPajd2vJJR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LDDH4plJIL6OuUkdOPTIUDYM3t2LtZOJ9245X1nHAKfmIWNy2eMt0zi4XXYQ?=
 =?us-ascii?Q?kWYSS/jTJGjlzHs76iUugNd4oadNGPYH8g8qsb9Rq0uouKeMfGCyemrVbZvj?=
 =?us-ascii?Q?h2JRENWhXrqeuLJEGe7/odpkrGh/B8X12L3VMG3UEYwz46a+BNhLAl23NGEj?=
 =?us-ascii?Q?byUH0Qx+qAA6Esg4dCbC7vLl/ZJNnuhYlDQmc0BysDWQ2LLP/pYtp0ZzDpCG?=
 =?us-ascii?Q?cnzgRab/RmHTs9U4BJj3KCwzyeltXsJVUjOudeBJ7GOIWGmono8acsG0jczV?=
 =?us-ascii?Q?rS0HrPcKlR3zQWTff4kUAzxdJQPCb7GfENaJ4O2zvf3CbdY8v28INK3k3khE?=
 =?us-ascii?Q?y5vw933WG9B3EpJJ/P4wbqgiLm5JT7A83y9/xwJKA+nJ3Hk3qbyZb0lZXUWE?=
 =?us-ascii?Q?7w6i+hIBYlcX4KvlWD12Ku0LJGmMR4NQaZUmg+O0b6cfX4gAh5HsZMUrPW//?=
 =?us-ascii?Q?9b2lIbZxVRrBsiBVroG/VrMTpHnOeqLYE3h/89/lI1joizraVH/oPkha1nnr?=
 =?us-ascii?Q?uV7GPeR6r0qX3aTkVvq7HccTWlCJ4x32il072U1owwxzTDaZTWaywA0Kb2g5?=
 =?us-ascii?Q?zFbn/cSkFUK8o/BOznYb08vppuqi9gZ20/utsHUBw4i9Dpq2r2cgytdZTAki?=
 =?us-ascii?Q?dQr0Xg0zRAMjsXMc6BtnD/gNHKH0hHC3wGb1Zpfv7V05nliO4WWbuuJuGy8M?=
 =?us-ascii?Q?L/x9TDGI5H3ak3YPqK5F6WjscxuLrHmQiC8Y5KNkTrOAVwnCq1woChgsxpP1?=
 =?us-ascii?Q?yhmVxaOjDbp8cBOVTwb1stGuchnNMkL7s8RlG5tSQZ7IftvJg62a+tJ8p22x?=
 =?us-ascii?Q?h3iDr7WqFW0nUgsZgKW6B9GtbvmRrUfqXnFcBoilPT/w1IokWxInKL7dljuO?=
 =?us-ascii?Q?WH1XoIDTPm4Tw1Otl6oQPDjWTpY2ZzsXahQjsB2d6+00AIhY5qG6Qr6UbBGn?=
 =?us-ascii?Q?OxYJKZ4qtGb/pLE2PTljzvphRfBzY16MfTxYzRgxspbVUjWs2p7/FKZphnV5?=
 =?us-ascii?Q?dMz55oDr6vFmpy9EapT1YXrEXwpIAMb3YS24qY7Ha9LYcbAgj6voKj5nMoGZ?=
 =?us-ascii?Q?W4LfzNjORoH6pS2kjf6MM+bO1FXsV9GPZ3pEMTY9ycSB6ySq6HDp0i+tM7V3?=
 =?us-ascii?Q?XnoQ+YRlv5SSnRNquoK2gH7MV04IHo17+rfJcEe+zditPY/kO+8DXES8sRjx?=
 =?us-ascii?Q?nYe8amllH0TPaNlp216DhMqgsLGJwQpmNwrIroCiO2DdRL0K117xtm4mv8Se?=
 =?us-ascii?Q?m7ZDNRSlB4/X0VEA4sRsITvQ2Hrv1c1hmNRRuunqdWwtryVvB7VB6VV2aLqA?=
 =?us-ascii?Q?7ui8p+JT2+sk3yO+kGseDCgrb4XwMvQXtz0fu2ruzHVp5C6RmDL3vTNMSDvy?=
 =?us-ascii?Q?75BgaaMnFcn8Wb0M5mb5EFwAMP3tgFm1AuegTMlOHves10Sy7iUpfGpc+o8q?=
 =?us-ascii?Q?VWOLbJOps2qDMFH7+mWtUlJ2gk733tRHvur53KNXembUsDRTaFR75riCiqki?=
 =?us-ascii?Q?r2/jahJ/qQ8cRsSjZExyg9aeqyeqND5k8RyKSTT7NMDwFZwdDdkHDPWHtPSk?=
 =?us-ascii?Q?EsRfQgJwcWxiROPNh4fw+/usd7OUyxUKqawbXpHm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8124bc17-2583-4de1-3bf9-08dd5d1f7cdd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:26:37.9668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXP5LKB1KSNDKS7wrR1OHNOe1Cp2pOvZiOlieZ4nz2NGOdxu4NUPCMWykutrqU6OGHywqCWise4BGAIfkz3Uxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628

Most lpuart functions have the parameter struct uart_port *port, but
still use the &sport->port to get the uart_port instead of use it
directly, let's simply the code logic, directly use this struct instead
of covert it from struct sport.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 208 ++++++++++++++++----------------
 1 file changed, 101 insertions(+), 107 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 888d744494d6..740de74e9f0a 100644
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
@@ -1472,29 +1469,26 @@ static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
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
 	}
 
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
 		/* Enable auto RS-485 RTS mode */
@@ -1512,10 +1506,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 			modem &= ~UARTMODIR_TXRTSPOL;
 	}
 
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if (ctrl & UARTCTRL_TE)
-		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+		lpuart32_write(port, ctrl, UARTCTRL);
 
 	return 0;
 }
@@ -1827,11 +1821,11 @@ static int lpuart_startup(struct uart_port *port)
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
@@ -1887,11 +1881,11 @@ static int lpuart32_startup(struct uart_port *port)
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
@@ -1904,7 +1898,7 @@ static int lpuart32_startup(struct uart_port *port)
 	if (is_layerscape_lpuart(sport)) {
 		sport->rxfifo_size = 16;
 		sport->txfifo_size = 16;
-		sport->port.fifosize = sport->txfifo_size;
+		port->fifosize = sport->txfifo_size;
 	}
 
 	lpuart_request_dma(sport);
@@ -1964,8 +1958,8 @@ static void lpuart32_shutdown(struct uart_port *port)
 	uart_port_lock_irqsave(port, &flags);
 
 	/* clear status */
-	temp = lpuart32_read(&sport->port, UARTSTAT);
-	lpuart32_write(&sport->port, temp, UARTSTAT);
+	temp = lpuart32_read(port, UARTSTAT);
+	lpuart32_write(port, temp, UARTSTAT);
 
 	/* disable Rx/Tx DMA */
 	temp = lpuart32_read(port, UARTBAUD);
@@ -1999,12 +1993,12 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2036,7 +2030,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2077,59 +2071,59 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2138,7 +2132,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void __lpuart32_serial_setbrg(struct uart_port *port,
@@ -2236,9 +2230,9 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2272,7 +2266,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2322,32 +2316,32 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2359,22 +2353,22 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2386,7 +2380,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *lpuart_type(struct uart_port *port)
@@ -2824,7 +2818,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 
 	ret = clk_prepare_enable(sport->ipg_clk);
 	if (ret) {
-		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
+		dev_err(port->dev, "failed to enable uart ipg clk: %d\n", ret);
 		return ret;
 	}
 
@@ -2835,10 +2829,10 @@ static int lpuart_global_reset(struct lpuart_port *sport)
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
@@ -3190,7 +3184,7 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
 	 * in VLLS mode, or restore console setting here.
 	 */
 	if (is_imx7ulp_lpuart(sport) && lpuart_uport_is_active(sport) &&
-	    console_suspend_enabled && uart_console(&sport->port)) {
+	    console_suspend_enabled && uart_console(uport)) {
 
 		mutex_lock(&port->mutex);
 		memset(&termios, 0, sizeof(struct ktermios));
-- 
2.34.1

