Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3DF3B71C5;
	Wed, 29 Jul 2026 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305210; cv=fail; b=bYGAaCcXvFx9xsBud8XnH6WID/CDP0oxG//PnsXRmyVgoqLlVbbmI3Okn+A2BB0VIXmRmhE4HDcP+cYwGKWaVrVDtBmt+KJh1ax8WGsYOqOMFdWyFnoVfV+4Sv8d6rZvySoaB2Zg/6uJ/rnVBYWlu/OFMf1sdTcRQlT1pvt92jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305210; c=relaxed/simple;
	bh=j03blmsuu1CYf209KENiW9YlTD7ntuORBtsrRSFr0tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhlF9cYm9gQhJn770zt2r31lLgzAXtA492cvtogATJOvQ+qlLUSLenTW8XI81+qKoJYrCadKm/IoLCxgVo5vc+YJfdUswc1hQO0Nid9kTqxePBUJlfG1o3KAnWte6aQrOUjd5XGZL0TTa9lJgxwkeNR0aJXvlAVpSNVn7h14Exk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=URuXwSfo; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="URuXwSfo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJagtrfUjJhDu7WVzkD8gnrYvxcjoCQ4UqsC9Ak2iuqqs2haV+37lwf0z3BWdmQU/+P0x5MoBa8yOBBI0yHjW7+qPXBAxwVHtJ1TRQK4AwaS69IrqJwLnvBdpBCFn3grvoGjp1ItG92rqEelkOo0ySzIb1smA75H2Llmg9zPCRGp0mpJoEUNn8SZ8XG7ZuiVfS+m5/KMNBeIyR382BIzKszppZ/6JXO7/WWUU92IaK0kJObeuMSpLn8xLbT+zg4H7du87YeA6CEkREOgUajuGEJgAuEkalRRGYM8I6hOc/FuMrq1BKhNOO414NNm1Xee3+rtxSDLTXU8wODuryTe3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WT2bszEiIXxUTlJLjs4ux1mlGYZklohC7lcUNThH4KA=;
 b=fsaXKVdvvVEMhb/OEVHE5iDg0Dial6ooyhzYeCMGrUkf0jSeIoYIH0/DKx5X41S33cYORBHpgtTIMPVj6S/9VARrz1aX3QEYWjQnHko4S/cRSb5cx/EtQApR/qdOTYLlmT0+axmZuYSSdz2opE/8RwQA4F4/04GfZziqyPvUdQIKd8Mzoeqe0Chy0e6+LLsdKeIfrKgAUCA0nSDCIqz33PuK7upNqh+bn5w53ZwJ1uyV8vKPMJEgWD5MdWA0L/ln9f78Q3od3oLYjt4UnjC/O5L0DGq5H44sgN91dYpIgQo8WW6vsod/Md5HikT3GqZPI76ieF92vUx/M0JD6WFxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WT2bszEiIXxUTlJLjs4ux1mlGYZklohC7lcUNThH4KA=;
 b=URuXwSfoLsE9ZbiUM/j89nWsjF+LDkNBP9HCQhfle8G2WqCZ6byOwWKp+EFo3VD+ONU3+PPAUYKdGyyvJChgqloLdvu3vbmmRWQ0bVDVYbowEQcHw5su/tyZQailGvGYHMEAPaVePy191HeG/PugZdTCah0APPkr8unyDtTZcZE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:35 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:35 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v4 14/14] serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL
Date: Wed, 29 Jul 2026 14:06:02 +0800
Message-ID: <20260729060602.492430-15-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: a754e81a-4cb7-4de5-8f39-08deed378b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	BjPOTIpwlKtE8tzRNNnMNm72ToAJj6caMDidfd9uYiLbKQyNVzNGZ/Yc5B5LcjTemNOVQiezoJjXDg2TSAOzvGcajuQSIgzWF/ZLr85iWybuOd+E7D7t6Lj5msyP7Jj6RbDCy3Fd9NdX5M5Hd1AxfMQ0fYGcQy7E0V2oPhrAe7ifQJthedEUangUKbPM7kgxU/LGeN/u2m2y0AVKgbdbvT+dJZHJUnbmnKPIIqF2xkvgSqtGwcqflIQwULGGQmv6mZAB+dDTGevAM7sZ9f50ix7LzNNr0Ht8m73PqucaDh8uvjWI1qWg6KfTDCikUCbyV+8gYU/yR1it3F9pzJMjRk8AMbhTkiJ83LFnFTbQXKeNzlcrUeHECqcrZ+D3JB70a5z8s1Ip0XNnExm3SY5kdcokYSAdEx9cERlFdmdpFEhaYw6nIeqkD42awPe8TFJy1EvzLqnUagZAKBhLzskffdzee3T8joGhO+OhUCw6xyMKbeRz2NSlINsz1b119gfs826d14eKseqwtjjy9ToXSxAUgxYPsfdV02yhsdr+W0l2WuBaClNppp/0IpCKOCVSmbdeLyR1G9q86Vj1tOqBClkVfq+teXaKLp0gUUnQbbyrokaWXUVnHYR6YJq69baFS5NV+A3VhaVxLQe16H39pzGUynmmOnGWFx20SKMiechJyEDaSw9WsiNLO+5GlkbV5Sv/LDZYilq8xqRqGFscnetR+8mZHU58K3V7G4xYJIE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qqsqd96puuXeZGtryrLjqyBiPfLZXZPCP8MdGrBXrNO/dObw9TQm01q8on6s?=
 =?us-ascii?Q?3Vq0TUOpKoco0Dd0wcvLrjsM8XB4VN+K9d8DW7jLH5JewTnC87dzaASGVPcX?=
 =?us-ascii?Q?dLFPcrnSpFemEtES42C2LWzDwa7a9G13+r6tKgChIyEqkSolmIqsm4zP5FdJ?=
 =?us-ascii?Q?naqSHsea3rejVBwYRdIAnFGg04F6A2cVUjsTNsTFyIyGI7QBA3WI1PvOaM73?=
 =?us-ascii?Q?Uq8ZANb2cjT6qCLzzUw9WjqA3aBO6F8Vf+5kv/86HdoEBmJqzGSfhr0hvDxc?=
 =?us-ascii?Q?yVT54FR62Pt1bz8nx/nYJnwYolKIpw3R3fFSZhkOZW7PcjHQQ7IYnuwK0WBz?=
 =?us-ascii?Q?rpV+P0v2IMgqpwBZobIPJu/oUnwP3p+Kl8jsL5iRIDbOeGGJqfvLBuVI2O98?=
 =?us-ascii?Q?3OPAmfZPj+FcwRyXHlJmyWuWAD+p4PpU7auLHx7eMvx8R7K4LUr70FSIuzy4?=
 =?us-ascii?Q?0wKlzSbPBw7O/Nrl4jbCCIB+48Uwo+LMY++E3yOkZPD6Bu1y59Sz10GlV4J3?=
 =?us-ascii?Q?qYPBidbpBVtKR2Y6KNznZt2Nc9tlkybZT2HYs39ZLzVIIjPbAHxaMQFaL7iH?=
 =?us-ascii?Q?9WwbV1iTRvMqqpsKyL+3yQ5u2r55o0BShDZ75kLQulC0sfIH/hzGrOhzEq0J?=
 =?us-ascii?Q?gsdDjermBi3fO6fsl5RSRBu0dwichcAWyXgA6jt4uyZc/vTAy1TYs+WRBaF+?=
 =?us-ascii?Q?4fWqTnQ3tonuRcbR+qPVNp05o3Wdi6Ghd5W12H8f6ko+/DyinhGOYFLBTUuz?=
 =?us-ascii?Q?RExPUduBGKtvO9bTrxKQE2XgRz8wrirlVl//ZM0aVlWkCbDFofV9YopYlXy1?=
 =?us-ascii?Q?kU2NkRjVMf2RLdbF4v10LLOjE6uz51DoEp3gG6U3+Ymb8WrJIVZ7/uC8NQNO?=
 =?us-ascii?Q?FSxcduUj4yUU/VvD2kcwHH9uJwfoPsCdxCVHrtivRVEJrgj8wxbSFU4Z1AvE?=
 =?us-ascii?Q?ZJXYIy32uo686Dw6zV9Yd9RKuWUnCPkwjIKn4SmpBXgFC6qnKbNd0XWl92u+?=
 =?us-ascii?Q?r/3IAULANzJkdHc+4l81/qSkjTdFwMHYVtR1mUsYzi/hNawIKOuZ8x9pVBsm?=
 =?us-ascii?Q?pRbNI2nRrVX+CeSMPot24jcur/C8cwn7f2sdYVLr+vWp8rzn1VjC1tlcghR9?=
 =?us-ascii?Q?ivvjSogVECh30/CMOGVppdjrPRjLmm4Xslhvl1E2D45cwEfxfeXJgqdnAQ7B?=
 =?us-ascii?Q?DsAjRVWIj5bXyF2/lLmt//YzIw5GE3nQR1BaKVIvm67tygUOPZkNxYbeO1go?=
 =?us-ascii?Q?ijhNH8cdIlbt623DTxArqEScznytx7ITHnpnnHA5DoYOMAXUDuuZf0UmIrb1?=
 =?us-ascii?Q?Bj3W6szZ7f19v1codrgp6kl/xZpuyo7vM4S0Xf20Kdu/FUgzO0BtcCPQQd8w?=
 =?us-ascii?Q?ufknBGZiPCHYMWWq4jkQxB/aymYJErnBc+FU/1XxqSr3IeWdtga0C81R2mHh?=
 =?us-ascii?Q?rlfCP8ELAnsLvOde3sHtMGZskVlT0fpV0IKwfp7q3mzqoipHHA11FT0WXrBg?=
 =?us-ascii?Q?o1XHZZBu3PPQV3E7G3biPtbMR0oPkOWa1Gd+fAt2P+K2Z+FXoP6f/M4ccbJI?=
 =?us-ascii?Q?LpGff8zeJkdFzRVj3oCQ5ELuTC5cn25Xv70QY6+NeBhiCjjDy8IrdiULsbmr?=
 =?us-ascii?Q?msyx+996cEsCgEvU0CJM63jeksHBiOxtVVkyJjqG+lfOWi1VqMq4OazoVAIy?=
 =?us-ascii?Q?GQK/RfOPQxuwZyAOWzWhsNt36RLbw+Vkfj1Zkqzu/nZghPDz6tlXvf5IvZsw?=
 =?us-ascii?Q?7SoCLnLtAJClsLsKY6aWXCGitTVsnWg=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a754e81a-4cb7-4de5-8f39-08deed378b3c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:35.0510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0N4TF/p1/B1RCL2+NB42eXKFuNKeWbXWYnZW5UP9VuCDyFYgiG7wCnm1m5w/3IW7shAnB76TORwbWGCR9nyJNObPfji/vzTK8Tv5uGjLEPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

The MUEx50 UART exposes a programmable RX trigger level via the RTL
register.

Implement uart_port RX trigger set/get callbacks for the mxpcie driver
and wire them up to the generic rx_trig_bytes sysfs interface. Store the
configured trigger level in the per-port private data.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index ce0ab5c1df52..d97cf062908e 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -103,6 +103,7 @@
 
 struct mxpcie8250_port {
 	int line;
+	u8 rx_trig_level;
 };
 
 struct mxpcie8250 {
@@ -251,8 +252,27 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 	serial_out(up, MOXA_PUART_EFR, efr);
 }
 
+static int mxpcie8250_get_rxtrig(struct uart_port *port)
+{
+	return serial_port_in(port, MOXA_PUART_RTL);
+}
+
+static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+{
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
+
+	if (bytes > port->fifosize)
+		return -EINVAL;
+
+	serial_port_out(port, MOXA_PUART_RTL, bytes);
+	priv->port[port->port_id].rx_trig_level = bytes;
+
+	return 0;
+}
+
 static int mxpcie8250_startup(struct uart_port *port)
 {
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
 	struct uart_8250_port *up = up_to_u8250p(port);
 	int ret;
 
@@ -277,7 +297,7 @@ static int mxpcie8250_startup(struct uart_port *port)
 	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
 
 	serial_out(up, MOXA_PUART_TTL, MOXA_PUART_TX_TRIG_DEFAULT);
-	serial_out(up, MOXA_PUART_RTL, MOXA_PUART_RX_TRIG_DEFAULT);
+	serial_out(up, MOXA_PUART_RTL, priv->port[port->port_id].rx_trig_level);
 	serial_out(up, MOXA_PUART_FCL, MOXA_PUART_RX_FLOW_LOW_DEFAULT);
 	serial_out(up, MOXA_PUART_FCH, MOXA_PUART_RX_FLOW_HIGH_DEFAULT);
 
@@ -536,6 +556,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.regshift = 0;
 
 	up.port.set_termios = mxpcie8250_set_termios;
+	up.port.get_rxtrig = mxpcie8250_get_rxtrig;
+	up.port.set_rxtrig = mxpcie8250_set_rxtrig;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
@@ -557,6 +579,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 				up.port.iotype, priv->port[i].line);
 			break;
 		}
+		priv->port[i].rx_trig_level = MOXA_PUART_RX_TRIG_DEFAULT;
 	}
 	pci_set_drvdata(pdev, priv);
 
-- 
2.45.2

