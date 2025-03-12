Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A851925A2;
	Wed, 12 Mar 2025 02:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747167; cv=fail; b=mIX8cmGQ1+iKmlLXBdnvhrOvMfa5Xc6lOM3MIcvq/cCG9BYqhyUpxLSVoTOG+9BgDhYOPoOuJJGaki2D7uMYlk2JYM22tZXoZ+GolzQprmQ0PGAHtyLl5TCs/LmtvX1p52ZUbCdkvnmVQfqbR2bm4WWxxQWFpH1477DGRQ/TP5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747167; c=relaxed/simple;
	bh=neBQigtES77ZVRDOj3AvJi/9tvjuttC5hgjQ44GMbgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lE9Goanc5icKaNPn6+uz9sW4tXaDxNKQSSl3jwuNvCtC2dc2YxzEibWDjgYvhbpI99/5jAyctYmN077B1IYetD2V/qIk4EzhRvNwKyJTgdkXMPbQSrPrCMg94TXkjeb128e+/tM2nk4zTfVNQhq9CFisQH/tJCes6V1W/7P31ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pf49gTYc; arc=fail smtp.client-ip=52.101.65.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pf49gTYc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytymWMRXP9/yNm1lbVkNla/VSTiy3Dys+71rRXA7Sul5eFoq2ZhipP4xnEjfjqxdCEILK7gxCGNy/eZMf8AmK03KNAlxz+Hyv1dMatfkGL0ALaH49sPMZXKLggOikDBN3YxmiXvCfg0J6bS9e6sFGqjo4tfZ+7k8sqgVQUeZXWHo8rOJxcptCrobiVHv4hliDrGx8MbDxwelxzj4LvBGiRGhJkuzl7YE75QanvTj/znmjrZsrC35SwVMDmq1Jkmf0aExW7HrcGmGEyph0vz79F2a21mFGXSBmg1ThFGcVxvwvKA7HNab3PqtyesDYpLUSDknKnXjR5FcQEUAWKNVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xd8lW38KYoSkUNmPwoOyv195BABSiubP8pdyK1nOHA=;
 b=f3CoPyqvdeXpHUZtb3RX/FnXh+5FidqRT8kpvSKRztim3x1++IufZcudoemfAewkHMNUOUhVffZwoKzbaHIRLaUqOJhWSOhVI8iEV0JQ5BD8bgKNaylZiOSzl+3JIIcJ4tbvbjLLTyj4EoaaVT+U+n8ggb13hYGdtx7oDuLzmTs+fXpmdK1+xayoGLcjU6neHJ23e6g6KzChwHQGOAyq/LNkElLRbHisoBW8KnDplS1TcNUitn8zesqJh6sIOgrvcaSAUw7HLL/gwhp6mCjGPBykbqPpU8q1DFHts+2AchpmAQW02ghAvUopmLZzPGK1FvCE3Pzf6zFN2pXOpoDnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xd8lW38KYoSkUNmPwoOyv195BABSiubP8pdyK1nOHA=;
 b=Pf49gTYciufteCLjeqYBn9/hywcw835E7GJS2tbqVjheKbQ5g1dU61OQg64FZszwKMnhzxECE074yH43wb8Ab1UhU6yjJ//XDOsRQj2mY8x0k0kvsC+mJd0SlCdWEM0aNObsdyRtGA8B++rxTsd0pXYQEyG0K7fD86nTQD6bo7wPGppRWkMYGjSJZjSiMvzhBKOctL/qubcXU+5IBLb+Dgz9QpwwZnJQyUfqnu/sDiTTQ+OU2NNgbH7H7UsZ2vXYjSg3yZVcAHLy0duRYN0ihDRXi21WbvdcBRAR5tzg4hpfHZaRlN3Kn8Lhp1mIzLFryW6Gn19TF09cAQwmaIyaDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:39:23 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:39:23 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH V3 2/3] tty: serial: fsl_lpuart: use port struct directly to simply code
Date: Wed, 12 Mar 2025 10:39:03 +0800
Message-Id: <20250312023904.1343351-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312023904.1343351-1-sherry.sun@nxp.com>
References: <20250312023904.1343351-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: b227c662-6f9e-4229-345a-08dd610f18f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DHZdXOBPD+JHkZutYbf0uG+YT8sZUSHL+GQQDCxS8+Cun/EJvq/Xe12D4Wch?=
 =?us-ascii?Q?aDvXtkecEs2JMkB2M7g3aPdtCVx6JRMYEEc8zXFUgDHR59fov9TKLeNtQGPD?=
 =?us-ascii?Q?MetIMdqr/ShWZb9H7babGnRK2trANh01kmTNqllkYmiem3nmIIAGFiDNxtjz?=
 =?us-ascii?Q?NEOCKlZIzbtvjCC/lvBtaicrGrfDuL0CVzfIVe/+Lw6IRVxYPw3iQdt32UW0?=
 =?us-ascii?Q?H4Lzq9I6AJuxTj+AQAXPE0ON1dBAkw9wQOn/Ih5b0dBun3VSa6Mfiy5gOnjr?=
 =?us-ascii?Q?hmf6n8EJ8weHs2bbDev4S3lTqRsezUI8OP92fkKd0bvlvXTyf5PtlnoYaP11?=
 =?us-ascii?Q?tYEelhbL5//jJ+OjzX5LbypzVO9GEMC9hkcf1YInw1vgDLlQ+p+rElFJvtRn?=
 =?us-ascii?Q?DddJTH7Gd1hWixDCqYlYLSQBNKRkbKoJt5fc1hc1pgbEumJ9Oe3s0AuPWdSE?=
 =?us-ascii?Q?3qqdQqpO4B/6YknreEOAZXeieRUud88muo4lec+7gU4lauNYQZXto0W5h5Xi?=
 =?us-ascii?Q?6fzLWS9Z4dLKuMWYWurDnINGUrGmoLkIIW2uFNKkEF+ZKjF+COPLZERH8TKv?=
 =?us-ascii?Q?veJYj8nUSTLXj4S44krAaqjgy5xMI3T9TM/9NN8bZ/5QEgXtXGfHJph/w45O?=
 =?us-ascii?Q?xFpRhT4IsUHdR15vV5pnu5xW6tZ2shqTw1mi5xqTga/tAXwoXzH5mSGMhoz2?=
 =?us-ascii?Q?/prw2VJT5DBs/Akqc5vPUucOff3UI48kwhSEN+PZ0sHAvak/lHzofj4ZwOgx?=
 =?us-ascii?Q?UBrcSgsfITiD9DBUlKGJmkLFMxaEX8HXED8Ac3e2Yz50Mg9//lw2BhY5CgwC?=
 =?us-ascii?Q?/ErxCYVM12kFnji2Y7vUTcpoWU3kBkwkBIwx5+xKDiEccScecu5wDQV1n95R?=
 =?us-ascii?Q?GPtyi0gAmT+KqYclpBjBrsqP96aFKr6r437ebd9p6qqIoB6kuhd1/T8ktsxh?=
 =?us-ascii?Q?BM3go5X4C1pIrELAHivwYzcN4MooZryEE5Pz/HAeFx+kolUTqtVScVxOXhVt?=
 =?us-ascii?Q?JZOPLzgoDL5NTVvjy1FPfdfTBo9Z/Ts3+zbN8jAcZdvpgz1d3urkWKBay4Rq?=
 =?us-ascii?Q?okSaAeoJ1Z4GBWNvz6zllwAIXYmUvJ/FZIHpUaqcxS9K07bABqmn7TqPDi8N?=
 =?us-ascii?Q?Tb9wODjEshWmFsbbHZFwpqdDnbnAHJ4oEY7n6CqEX73GME2neIDF7tBx1HN5?=
 =?us-ascii?Q?tFtnk3scVcI6BpmnB8Z4q56bDJQDkfb2c7ewDgEuEvLUT2VnB/0oaePRjl7d?=
 =?us-ascii?Q?YHvqkekuGX00bsRWcvD/Tnuliwy6UwG68wOOJjD5EFX2e6wFgN67dviNZojp?=
 =?us-ascii?Q?yrGfCrbPKpsT7prUye6fHbvMvhy3e3UCMMSajJUiNtyFTgVLqEudqfYnWtQf?=
 =?us-ascii?Q?iEotms2HPLQ7nZEWWzl7MD1kcRoHqXKH6SH+uIekKju20PxykN5z/q0BtMFr?=
 =?us-ascii?Q?A662WqymYbD/UjPhkGI6xhrFqpxfAQvo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50+RMdBvvblbQibFsZidQb7Bj6WmATyOllJJNfnwJxnlb0TqpCTomM3px0cs?=
 =?us-ascii?Q?ofZg91h+bwgH6eVZqLLXFW/pbC6/hOvaSp3jivHe/4MQUBFOlVrPWT1nCAQR?=
 =?us-ascii?Q?UNBMZVVvSPAIysgGBBFghc3ZZukzfzTfLBLNvp8uwJxohZUTz1zO5B3yeaWz?=
 =?us-ascii?Q?EZT+qr7nRmmLtRTjcW0cCxZnhi9oXeniEOXo9FnZRLGu2toKgL2MQRjDNmSK?=
 =?us-ascii?Q?KzMwOXmVZ06LIiDKJo/VpITZtYB3wDU6Y7j0ku7c1/ADxAvPc4v9goIX2fQ1?=
 =?us-ascii?Q?20/lyKJYPLe1qsB/qUlHrMjmy3Gh8SpC+muD8RdVBYteEcG/3vIuPVd3caNL?=
 =?us-ascii?Q?YKopZjBwNG+qsJS7EptsWwzBViLd1jHkea3hFJ4TRt/fGmc45mtHKu8Uvlie?=
 =?us-ascii?Q?1/ihnP8G+Kh7HLN3WWTer0it+fMTC1P3Lxk50Ew3MHAMrkUin8ruhbt067At?=
 =?us-ascii?Q?rGXY1rSZlUfNciboflLlbNSeiq/jCE+sKAJQiCtTI8Eumfk7znPdri6jLMK3?=
 =?us-ascii?Q?ROq3YrBygjx6EkKBhyf+vHFiDVMUEwhlba3d7izxwVMWKNbvsfELxsBVI1Ng?=
 =?us-ascii?Q?yyVPk+MPWE2ZzPe9KiFXoLIAozgPRLcpONU4GZJqWoJs3wbxyDODMhIbdpZq?=
 =?us-ascii?Q?eM1SkG+sCOn+l7ii+LZ7PG8OSgTi/Y2q/7qDPpw56Yrdp5Zcqc4YnaUlZfNb?=
 =?us-ascii?Q?Ns17A/MGYFLndv6uqFw4/CRvuZT3jZqmgA//bk1Ithk3nJCQ7CP8Vv6wHH2a?=
 =?us-ascii?Q?6AUTo07RJAXjNSHYtkmkuqSbuosJrlBaRY21QOyJii0oH2/67qu4KkesU9Zu?=
 =?us-ascii?Q?/S9pYgXhGUrfGahzlIdTWrcFYZtqLY7QLLor7QykhEg7UrCQ+ER62PumLxrW?=
 =?us-ascii?Q?Qx+z5qT77bKVN29sEchGG4d0VqRo1GV5kyf14Y6qQETX7ib0n/ZzA5JxwYtX?=
 =?us-ascii?Q?6cev5VuKekhnhukJOwOCHTffzeSpC9JLn6nLJTKZx1HgooZi7Te85VCmcAJ/?=
 =?us-ascii?Q?pFU5OhW/ySkdMKju+cRtlyPBUCu4Mh9Pi86JV8N3eweZEpb7zT5IZyO1eIpb?=
 =?us-ascii?Q?q4w+TNx7qCVVMPNjwL8KvLvElYGC26Ilx26dndqOL0mbsfJgeL9xBA9yL8f6?=
 =?us-ascii?Q?yLbGQwfDvArtbLePjOCD2boTOW/thxzFqGL/i9GZeZ7dTSKc8kWof2IN7I0i?=
 =?us-ascii?Q?yCwadalpkU/79AJigCPKwxl1bQM0YiOlpzYLtFnzjYAuoUKRpvZjbBsB7Ifx?=
 =?us-ascii?Q?kLF8FV51/OOvkgj69OIk+h0E/lWGbNq+7muaIgXsbtCe+/bpjnjmKjGnbHpd?=
 =?us-ascii?Q?VUDZ91+wky2bCrLdzN+bmku8+TKKJgyaBOD+78giAZ/gaLABVJok1pcsn95Z?=
 =?us-ascii?Q?CaBlHmXdB0PTmVL/KO/A71sn222INPqyKjqdyiWauKYZaIG9i9/6ReUNY3sv?=
 =?us-ascii?Q?1ni0CE86H87ypaQlszKpalr0ITl+tdOrI/+D4laairSpBNI9GLPaV9rMCw75?=
 =?us-ascii?Q?DYCCNvVJpJnAKSmCP81QgZNQj//FMWgeXPpyONNkTx33IBN01GXakqKL+/o+?=
 =?us-ascii?Q?jQP5YHeeMs8zCRJKvmtIY9HVFzAFtwpyiTfbABxj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b227c662-6f9e-4229-345a-08dd610f18f4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:39:23.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVSslnNytx2XOoLS8ww1HLHRZr+DfSV8wIFvJkntvZvsWjlTyMgr4cVxmquGG/kHhZNnNAz/itmIDwguZIX7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794

Most lpuart functions have the parameter struct uart_port *port, but
still use the &sport->port to get the uart_port instead of use it
directly, let's simply the code logic, directly use this struct instead
of covert it from struct sport.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 210 ++++++++++++++++----------------
 1 file changed, 102 insertions(+), 108 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 6f64a3300a38..3b48e320e7f4 100644
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
@@ -1829,11 +1823,11 @@ static int lpuart_startup(struct uart_port *port)
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
@@ -1889,11 +1883,11 @@ static int lpuart32_startup(struct uart_port *port)
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
@@ -1906,7 +1900,7 @@ static int lpuart32_startup(struct uart_port *port)
 	if (is_layerscape_lpuart(sport)) {
 		sport->rxfifo_size = 16;
 		sport->txfifo_size = 16;
-		sport->port.fifosize = sport->txfifo_size;
+		port->fifosize = sport->txfifo_size;
 	}
 
 	lpuart_request_dma(sport);
@@ -1966,8 +1960,8 @@ static void lpuart32_shutdown(struct uart_port *port)
 	uart_port_lock_irqsave(port, &flags);
 
 	/* clear status */
-	temp = lpuart32_read(&sport->port, UARTSTAT);
-	lpuart32_write(&sport->port, temp, UARTSTAT);
+	temp = lpuart32_read(port, UARTSTAT);
+	lpuart32_write(port, temp, UARTSTAT);
 
 	/* disable Rx/Tx DMA */
 	temp = lpuart32_read(port, UARTBAUD);
@@ -2001,12 +1995,12 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2038,7 +2032,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2079,59 +2073,59 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2140,7 +2134,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void __lpuart32_serial_setbrg(struct uart_port *port,
@@ -2238,9 +2232,9 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2274,7 +2268,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * When auto RS-485 RTS mode is enabled,
 	 * hardware flow control need to be disabled.
 	 */
-	if (sport->port.rs485.flags & SER_RS485_ENABLED)
+	if (port->rs485.flags & SER_RS485_ENABLED)
 		termios->c_cflag &= ~CRTSCTS;
 
 	if (termios->c_cflag & CRTSCTS)
@@ -2324,32 +2318,32 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2361,22 +2355,22 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
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
@@ -2388,7 +2382,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	uart_port_unlock_irqrestore(&sport->port, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *lpuart_type(struct uart_port *port)
@@ -2826,7 +2820,7 @@ static int lpuart_global_reset(struct lpuart_port *sport)
 
 	ret = clk_prepare_enable(sport->ipg_clk);
 	if (ret) {
-		dev_err(sport->port.dev, "failed to enable uart ipg clk: %d\n", ret);
+		dev_err(port->dev, "failed to enable uart ipg clk: %d\n", ret);
 		return ret;
 	}
 
@@ -2837,10 +2831,10 @@ static int lpuart_global_reset(struct lpuart_port *sport)
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
@@ -3192,7 +3186,7 @@ static void lpuart_console_fixup(struct lpuart_port *sport)
 	 * in VLLS mode, or restore console setting here.
 	 */
 	if (is_imx7ulp_lpuart(sport) && lpuart_uport_is_active(sport) &&
-	    console_suspend_enabled && uart_console(&sport->port)) {
+	    console_suspend_enabled && uart_console(uport)) {
 
 		mutex_lock(&port->mutex);
 		memset(&termios, 0, sizeof(struct ktermios));
-- 
2.34.1

