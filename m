Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D0D1EEA42;
	Fri, 21 Mar 2025 07:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542797; cv=fail; b=LcXASGjTt2RfW/b4dkJPeUY1qslVu8bqd5dRR42wALNL9VNSiDbcVA4a7ONpsmfF6sQEOkr+tiWuZ2X+z8pqGPMdMdnPpR9VnFHs+lnN42Kzh4zmPVaLlBOIPuDiINNFPhnth8LYBQ7kJ8a3A38D/kFrO9fAsFXtLBSxkuoYvyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542797; c=relaxed/simple;
	bh=+1p1vcLcX/xUdc3M5gJ6In29WHa8NQ5FcnMyYSmr1gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBx19KmDHWNgXd4HOjZx5BwAhz8xABYYvkfx2KV6BgfWE3UNujutdsuT9+j2UpWaEhp21KOOYS6QnkEWB6NkS5oeVtKG4nepGmpQIFhiiDsmJJdL2ms6+FDg8ELDZdamJIU4dib3r8er2rCI5VZ93mqmO95kg1iiJ9vgmk/49YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AbHGfwQX; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AbHGfwQX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtcwX9GmFSMTtWgdKY9GFbs7zdvrXVYujYuYC5Z2tB0BOkR4TqKXSWGPIstMK1O5Fpw5ZPlmdlPVLtBsiMigZ6rshIyqty31+nHdw3JRyaczMziOlck2ptUkMQGThnjlkkX66Kqn13BSeubvrLDEgZGmS0QQLe1e4SdxGcGRAyvZBjMDCrYqL6QBTSg5JJGwCOIpIvjgxtGp5P3hKWuOrkvHB6OwSBOBgm7QgpIwrOWcNa11FHJw55gOXH+MybEgQZKAExQSIxQ4FCXvh2oyXUsOb0VGR7JtcfExa2FwK6sRYSDH9SvCHmOJncgjPLYvl7OFs+cOLvUEHfawjugXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA7XBEXQC+IUE+qfbd5gIVoWMSAwST6FIktW0DWlslI=;
 b=sKb2HYy6ncUHyNUtIgaBHEc2Jfui5HzIe3Zg25qwb/qE8kFXpo0FMFp+O09IxmVdx3QwShF8pIyYhw7Zso4SaTvkseURPEMSXmKQCvPnrpHxsyjkwYwTplE/XA7SbIIcloMaTGCccgb0b0ixgxEOV+BodDEa/13Rv3YjAUjtwtMlR/jyLKx2s4hlwDk+cfbrSJ7Kf9MOc4R9sI0E5zEcDcn3cAr+4sYMECBdcWUNnKlx9pQmtBgYYzbO52uXAusMDL9AkFaVf5o446/ebLeYm+P70VU5AGNtDc/qeTOVA6hybHeNZ7h89Wnl9X7wkOUZKHR/9dJezNQYdZ6Ai5zZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA7XBEXQC+IUE+qfbd5gIVoWMSAwST6FIktW0DWlslI=;
 b=AbHGfwQXta/QIgWqe4hQkS8RgpuKcuLSb0bTs989eIIvRBZBdwkjgqqCjhdx/mu2vdS/r8147Rm6W2VCJyZ4c0W1Qs83CFA6XNTCgb+FETSQ/wJV+/xG0klXAOUTT26dVvxY1e82V8w9xcFntVFMFczT4TL4BJbO/8wLO0H42cMONhh6V2g07kSZ7UYzV55TUeV692LQcR1ItvHwnYV4u5rhY8VYvABRAr0bXeSdFxJJVvTMcasaJk/LFYGAtfzv9R4KjeONSwZPcARi0nC5s2kZtvbhq5YZvrJNHz/ptAQh1/xLYE9z9Ct2hrIc9njrcmd5Gs02sMQVSKEFl8NWzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB7957.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 07:39:52 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:39:52 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V4 2/3] tty: serial: fsl_lpuart: use port struct directly to simply code
Date: Fri, 21 Mar 2025 15:39:49 +0800
Message-Id: <20250321073950.108820-3-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4be35af5-8050-4d76-34d9-08dd684b90cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h8cuVcQbxC/rEI/s7lJAkkgwGj1NqHNO0x9YzV/+AC4kvDcjAN8NAtxKNR6i?=
 =?us-ascii?Q?1bWccDBw23YPBAyyrSYR7FVEZBITOk7LGEnASuNdR2Li+10pZXU16XTsNggz?=
 =?us-ascii?Q?O14jPWi07VFit0j/fDjSqHNv7xG6yLebcN2C49M9hghepi0HqKnCLw0C6Wmw?=
 =?us-ascii?Q?KYo/h09q884yvzSaz5DjsUeAJfM9CfNjxck5UmzA1rdKfoilOJp83hAY3Q6W?=
 =?us-ascii?Q?WNApBNSVMZFzNfZVHPfRvNDUAkR4Zn6zbdBMO3iM7HIB3gleIfKsWL9ZCPni?=
 =?us-ascii?Q?CLE/pjU+41bhGWN28jJs6I0m/cCpy9TRCuRt3vCz9b/MF7S6BLAzPWRhe19H?=
 =?us-ascii?Q?Xp38ycPWLHp6iCtYmtXhl9mZZWAJCNd08LpOeDxpQii3yJ0V7NQqpTLfxUpH?=
 =?us-ascii?Q?ZGOCkzBtvekDpj7HTNOqbfRThkJ/giAx6FRio1nP6NxQv7NUc6Vw+J6fmPuD?=
 =?us-ascii?Q?FObjWvpEPRN8bNZ8u57XdtKDQIbwDC+Dndp+rbqf7Xwbfg2h1NDZqsp8CNRl?=
 =?us-ascii?Q?gtnnyaIb3ESyIpNqVgk4kLkpFkmDrf+mMfIWLmV73uqdtRVPDcsW7k6L6KwJ?=
 =?us-ascii?Q?k+Y7nMlAemIVNCyLorpoo8vx3iLojhjl0AMFmSdSsLbMk7MFPM0+Qs8wKCeF?=
 =?us-ascii?Q?dU23nMe3gtvxUG2fX0alTs/heofElmR0TpxKwzjBCD3SrmlUuiQLW3kCohwU?=
 =?us-ascii?Q?EVBArMFSmheJ7BCgedA52DwYepwWzw8sYxwqKDaL6UKhuif1FzJtwdMJV9Rl?=
 =?us-ascii?Q?HlxEnsUDr72/cJEO5FF5A4Gs5c0R8EUzLyF+czKcY2P3y2HlHOap8+Mw/dgg?=
 =?us-ascii?Q?d5+tcSzpiiFjQHrRSnsxAWgJzhP0kUbb/sXUuwSXyDy4I/i0iiuxhbFLYQ9U?=
 =?us-ascii?Q?+pD4P77rywiR29Z2Yv8QuT4hEU+4/929kxscNC7Fkcr5A8nHzkrLUkFI7WIz?=
 =?us-ascii?Q?zDT8bhe8UbAudc+NfznXY3LX4lojeeluBkxV0C3O3dVnRL059D2+bi1c02ma?=
 =?us-ascii?Q?2b5E/+a0c+ttHGVdzoPe8IokOIEuFVyxVBHsZ0Om/sKJ86KSQgddJrcLZkgL?=
 =?us-ascii?Q?39dxvKp/gGvpiFGgyo2W1w2UTgbQdBeEXYq0m6GqJy6XrSzCppOo2A7B1S+0?=
 =?us-ascii?Q?s8DbGfK9hcX2t5oXRNLWVICwmxhA4zL4lhSH9E0sTVtI+AejRNtpmZuNPkED?=
 =?us-ascii?Q?uYA7fub+jGeeBeCHlJV704IvfpsuXOrOl5uOGGXi8LgGoJ3beiWG2sP1slAt?=
 =?us-ascii?Q?P+SQJ513ePTpJc3aQF8c/AQyquKY6BqAAfq9KpSSZVMxM4kXtx/eyIQf+ebL?=
 =?us-ascii?Q?iMBhIkZhvahatKPiOMyypF9R6NliUtrwIRHG0lfX9c9/Ub4rr19LM5s/yxUQ?=
 =?us-ascii?Q?9AX/bzget/JQhmPF2Yf6IvRxtubtgkUMscM6ghNcF0lR2Qp3YSpauM/dmBBX?=
 =?us-ascii?Q?83lckGbhGjVaKYJqwSCgvgnh9Xg9Cq4I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEJgmPy2deyHGdDhNUaVarcCfQ3Wbyr4ZzNWkgADiVZSY72J8Q1X9799ITx8?=
 =?us-ascii?Q?ZxA0wRfp4QDK3KJGjatJNFUM2SH5ibX9Tgjo64myX8BnSbfl8YBpb6YUV3r0?=
 =?us-ascii?Q?hgr0C/ChXwpFDWOD4YXQC5LoVSh2tptt0jKN1GIbWRKVxQD0+NThs1TaKFTv?=
 =?us-ascii?Q?B/OTbUSnT7C5ob8/wPAu1O/Z8LPXoR7ZPrqnYc2Ox+bmRV2FnpdmlqpLj4Ly?=
 =?us-ascii?Q?/+nrBx4Xr+2TMw6yLjzifdzLJwOCSEcjLxAyo/+EN0HNr2yave0wbk1OjG2R?=
 =?us-ascii?Q?JYdGf8q3yqLDASCVcsqraSRHfVQH0pnk9U3WZU2DVI9bp1Fp5tT3nn5DCITp?=
 =?us-ascii?Q?hR3Z7KImgAroZ4mcrlode/HY+xQHYhjPTxAPrpR0gc9Pejbt5BUJNHlaJUeG?=
 =?us-ascii?Q?6lI4OJ1M9U0oINozl62bfgLowP64pJ5N+7qlcpv/AjqXZGk3VBK96NRDmzj1?=
 =?us-ascii?Q?w9iI56sodmL5VP5jR0dQLkt90OGqLEtxcRXzM1mrZ0/cAb2Vv5ZW5n+zRNVz?=
 =?us-ascii?Q?ynYBTxjgdToeqpTaMtE5PK03yT3Qsp5wQc0xZL+IEIPGT3eNpxKFnzB+yf/a?=
 =?us-ascii?Q?unbTISI/HdmboMPOfEjdh+wsEdd4nrrMqjuVxST9akhvCYP8yDhvz8SjGnyD?=
 =?us-ascii?Q?8dkfz1EcUeVgAZuivzGjMiqCV3Vx/UiBbEP1SxZJ69SxoFII3RI3SUD1Rh2A?=
 =?us-ascii?Q?Sv8vLN2OxAPAlU4ZTvfLgPPMxWXYcFt/zvowU7r0vWrjpItZKtGnACcO3M8x?=
 =?us-ascii?Q?Ft5wx7Gbrn2IPhxVoZni+EPmkdAXG0VtFYKFwkObHLryfqPd5msTam4L2LSq?=
 =?us-ascii?Q?rjop0S1MM6XUuCGohsel+FxUzYTprUNobKdoDufj47NvNCzw/qMzFpa00ay9?=
 =?us-ascii?Q?B0kFZb+yRWq+d/Mt9UH0FkOo+XtSQI4z3JBmkgXaq2hhu9kQYo3/5E43oawd?=
 =?us-ascii?Q?TIg3alpnlek5NS4rma0Tey/XTkYDWTXOljWz4VGeOtB3hsXM2Awmv4iERRsu?=
 =?us-ascii?Q?xl2dxbIqKx44B/ZtyxkjumIHXe5Oi5xmt8N/IFD5bXFIHTcLQOc2/ndTIbHY?=
 =?us-ascii?Q?kWTsgPKRcKSwAXCjdD0VHWKodHIChJcsPDXYQOeWwS01D7gN8y4sV3/KrJwy?=
 =?us-ascii?Q?CKHyc6/fXBzrtpjonTQShw6WCR3sF5JE6OtCGgD1nd282Omm1/YhzCXCn32Z?=
 =?us-ascii?Q?ZYcnuqnwdh3rJIKyU3mrDh4jLrh8ZP+lkn1+rel+nvPlG/1vFtb39FrVVH8X?=
 =?us-ascii?Q?Vy6kKOQqAI6JJJrcYsLrNFSuDobwuyaP3mqy4wJXghFG3/u6gsELWxqJmLZF?=
 =?us-ascii?Q?YyTmSnfoCQtFUEno2fZ1iT7CvM695Ux6g2fR7H5LB7YUWo561Z4DPIQxqUo+?=
 =?us-ascii?Q?7ttA0qTeYDs7PAevNnqN1dEkr9JG5dZZBuXsxyfOHNSLh5PMBq1mIg2ZBmsj?=
 =?us-ascii?Q?Zd8AGkEhM1GpeWJk4HhnuEjl1CmA2DGgdZVOQCmDymVR0RqwBc25nkvTeKHG?=
 =?us-ascii?Q?U2KxGZpGMqZypIYtmALuANiJJU2TTlbDsTesOBlMuOu+Y65Oew8YSgNdwgJ6?=
 =?us-ascii?Q?MZTc0sdWx+/6xaAieg7azJaa5ykXvVKyqzNv3Uia?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be35af5-8050-4d76-34d9-08dd684b90cd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:39:52.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xk8mpdpS5FNsXgV+8PSzsphzUuV7Lr48zKMiUPm2jOJ14GcOHouQC1Gnx7FQhvgOZXr5XYlMpGmPVJDrfoENTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7957

Most lpuart functions have the parameter struct uart_port *port, but
still use the &sport->port to get the uart_port instead of use it
directly, let's simply the code logic, directly use this struct instead
of covert it from struct sport.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 213 +++++++++++++++-----------------
 1 file changed, 102 insertions(+), 111 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6f64a3300a38..f3f5d7e21693 100644
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
 
@@ -639,38 +639,36 @@ static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
 
 static int lpuart_poll_init(struct uart_port *port)
 {
-	struct lpuart_port *sport = container_of(port,
-					struct lpuart_port, port);
 	unsigned long flags;
 	u8 temp;
 
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
@@ -693,33 +691,32 @@ static int lpuart_poll_get_char(struct uart_port *port)
 static int lpuart32_poll_init(struct uart_port *port)
 {
 	unsigned long flags;
-	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
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
@@ -1449,12 +1446,9 @@ static void lpuart_dma_rx_free(struct uart_port *port)
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
@@ -1472,32 +1466,29 @@ static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
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
 		/* wait for the transmit engine to complete */
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
@@ -1515,10 +1506,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 			modem &= ~UARTMODIR_TXRTSPOL;
 	}
 
-	lpuart32_write(&sport->port, modem, UARTMODIR);
+	lpuart32_write(port, modem, UARTMODIR);
 
 	if (ctrl & UARTCTRL_TE)
-		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+		lpuart32_write(port, ctrl, UARTCTRL);
 
 	return 0;
 }
@@ -1829,11 +1820,11 @@ static int lpuart_startup(struct uart_port *port)
 	u8 temp;
 
 	/* determine FIFO size and enable FIFO mode */
-	temp = readb(sport->port.membase + UARTPFIFO);
+	temp = readb(port->membase + UARTPFIFO);
 
 	sport->txfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_TXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
-	sport->port.fifosize = sport->txfifo_size;
+	port->fifosize = sport->txfifo_size;
 
 	sport->rxfifo_size = UARTFIFO_DEPTH((temp >> UARTPFIFO_RXSIZE_OFF) &
 					    UARTPFIFO_FIFOSIZE_MASK);
@@ -1889,11 +1880,11 @@ static int lpuart32_startup(struct uart_port *port)
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
@@ -1906,7 +1897,7 @@ static int lpuart32_startup(struct uart_port *port)
 	if (is_layerscape_lpuart(sport)) {
 		sport->rxfifo_size = 16;
 		sport->txfifo_size = 16;
-		sport->port.fifosize = sport->txfifo_size;
+		port->fifosize = sport->txfifo_size;
 	}
 
 	lpuart_request_dma(sport);
@@ -1966,8 +1957,8 @@ static void lpuart32_shutdown(struct uart_port *port)
 	uart_port_lock_irqsave(port, &flags);
 
 	/* clear status */
-	temp = lpuart32_read(&sport->port, UARTSTAT);
-	lpuart32_write(&sport->port, temp, UARTSTAT);
+	temp = lpuart32_read(port, UARTSTAT);
+	lpuart32_write(port, temp, UARTSTAT);
 
 	/* disable Rx/Tx DMA */
 	temp = lpuart32_read(port, UARTBAUD);
@@ -2001,12 +1992,12 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2038,7 +2029,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2079,59 +2070,59 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2140,7 +2131,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void __lpuart32_serial_setbrg(struct uart_port *port,
@@ -2238,9 +2229,9 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2274,7 +2265,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2324,32 +2315,32 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2361,22 +2352,22 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2388,7 +2379,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *lpuart_type(struct uart_port *port)
@@ -2826,7 +2817,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 
 	ret = clk_prepare_enable(sport->ipg_clk);
 	if (ret) {
-		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
+		dev_err(port->dev, "failed to enable uart ipg clk: %d\n", ret);
 		return ret;
 	}
 
@@ -2837,10 +2828,10 @@ static int lpuart_global_reset(struct lpuart_port *sport)
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
@@ -3192,7 +3183,7 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
 	 * in VLLS mode, or restore console setting here.
 	 */
 	if (is_imx7ulp_lpuart(sport) && lpuart_uport_is_active(sport) &&
-	    console_suspend_enabled && uart_console(&sport->port)) {
+	    console_suspend_enabled && uart_console(uport)) {
 
 		mutex_lock(&port->mutex);
 		memset(&termios, 0, sizeof(struct ktermios));
-- 
2.34.1

