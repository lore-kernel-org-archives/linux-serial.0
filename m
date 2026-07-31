Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D132F39EF05;
	Fri, 31 Jul 2026 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484153; cv=fail; b=AaTzHOCThqdRBFgrFn+vj/YnPayMSaHLoIjIB1ak+ce3ghu/3SYzRuXZ83csi2H5g/ovoqDD91qBgFrFtLhCXfjoVylh4DZlOE4ZcOkfemrNt1eON8Ly41d2pzcYAwLVbPndj+BY9NwhtEdPE7iUYwn+lWQI5DfX3DAuV3UaT18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484153; c=relaxed/simple;
	bh=YjKc6sTZwARs1Au/QREyQymgLnvldvDitibBaOOB89s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HCL/GVjNIZMMa2stRg4txeSJ/f0jOLwWauhI3RwIQj9+1XFloBNV1pYNg7sJUrLD1Y6A0Vs8kSrIWDc1IKv5fGq8z1/X0bDqVzlg2bck4kgAll0YTw9wZrxoFabmKwqrt8tFl5YzboKolPZrbZQFCb7lTkQmcoJHTmMRI/lMDPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=i8EHApnB; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="i8EHApnB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhFthz4KRdZWlWr7TaMVIuEfsbIwPWFDpvzTnWgmyaHYT4mzMxhCSJMqT4F+ZpA3K6Sm71em+BLtVbeOMlUPnUzf8k1DiuYO79YWUz3UFmdhQia+0Mrkoc04dtg6CGxY4Lmt5XSyVjv8sBQhrsNKr8rc4mThwu0O1HQQtsTDzil8A9gVSMq+4ODXsbaRRU5TqaVScVicK4okE82GPtzgq+qYVzZszIWvfASeOXWod5YoYUlhoHtaArtDv/1bZPn9HJxH4Z2htue+A+T2iSYZ3L1FclXvcE+x3gsx+Q2dopsLl3STvdGbih25d6kBeAUWFXFJNp68WbpW+bYjIAqXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zEXw6gf3IiwJvPU8NCq5cJNKPl89fCk4FWrdzD+ABlM=;
 b=vwz/jJcvm7VlADnHVh+CwwIbDEFgPt2QI//b9CuN83jzoNOlZ9lNKFiYQf0V8N3atArkii7HF3tl36nXhgsX7SW4mMKIwnLdoIJsjpJFR9Vl0BYJ7tWftXcGijKEXo2TjS6+Jwlo7CzFkFkEylgTiy89lUkT5v64dV98uWYI45snaAmvwEbMkoolH4ouxrQgua62zSsxY0dla1cFr5vHwAOIEffWTQDBJKaekklYYb81dJimhA29V/L8UT+4j8XMIKmmCRaIuEpPlTMANrx2rcHvbVYnViv5ghjfXBuk+th8BhupWjxYWcUQFIkmRuPAnrDVrfAkoYkffMigVIJJzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEXw6gf3IiwJvPU8NCq5cJNKPl89fCk4FWrdzD+ABlM=;
 b=i8EHApnBAOrdILS5OQ+JdTQ2QkHngdOqEDxIeLYCAZLtuPLXUvK6a309kxyOQEVtdrIexrrvrI/CgEcKB10PR95CI39UlXarfiZEJnKXcX6HuPkVws3F3B8+0KM34RMl+YNC+LHlHQ9hzuAtE6K1JHvI3t1CQ1m9o2Txud0XIfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:03 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:03 +0000
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
Subject: [PATCH v5 05/14] serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
Date: Fri, 31 Jul 2026 15:48:11 +0800
Message-ID: <20260731074820.735619-6-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc93cd3-fb99-4e87-38c7-08deeed830b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	k9OT3UhP2YWoUv0vTkwI8pJJ7+JRpk4OoloE5V7RBjhIhXTNANabaJXCAVPFL5lcj7+79fBisRmATXlJYNRM3gG2E00aBL8OQxKArr90LJesATDUpQk3RCg+W2reBr2ofVueULXPMysOiC6/QC+VZT0AWc/hEkSG0bpX6O2RVclxOs7zsb7JYXbuMmNjzYAdya1Rghi8EWrK9PB88HbyZ2zjODuAy7y/GIzgj5kfd8FsmKrM643fkRnQZHMZZ3r9heLeHRqUgIY/zhuoeSEIaXDdAF6FxkRExGE7zq1aUVhmkl1unOLoc3WdQIaJKjB8IfDiQqrzIlQ1ZHe1cB2NqBJ74FFaha9aK7+AYo7EanVlNjHb7okXzakBH7KYxQRLfQmbucOq5e8JooSwORw18WNyACAgEMHEnnCcXzfLhwds7e9M7vHD9LBvDy4C54l3aJG4drClqwBAyNLQibY0wxlAdhtzoYd/8gccYxA+s38Ay+kRses9CckTmnFm6EVMBZ9fd11EmeHOftSWfpzX+984neaPHygSLuOuzmhzJ8f9vM2+zNWReFVuptRYKPWtab3GD9a5XED6hOqSRZyHeQiJea57kPTBAm1MfmpdV+78vKglPYyEODRpDitUgi2zNHZjMMu25GJlg+mcUMGnhAUO55phgORtuyj+dVVcveI83CSfH+vqaGhYaJwOuHYceE94sELd6ir5Kr2xy4w1d96gRsZW/ZjKKQuK/SO+ZVY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CglvN7ikuIbjFuHVMBO9y+40y4/AQrCzhjF2eZybpbf9/9kdUugrKQANthse?=
 =?us-ascii?Q?xPS8Nwu2IM+ZfhZ0K/OsiBsyUm/tUTfC1iY8NV5Mjic1F3xGSvYWF/EZZfWK?=
 =?us-ascii?Q?naE/mUWVHAa6sE2Z5nqHxGZBSo2084m5UpzUv8lDt5n41s3l9kLVjituzvtw?=
 =?us-ascii?Q?NGLLzo2o2FkBRTezdBHc52oldbSWk0MTOMAm8qtorWvvYDqoGHhLKkkJlkqp?=
 =?us-ascii?Q?M8uwZZKO1drihktzxXWS1NC2yt8+M/+GdHB0mdpotMHWEznu8S1VU8iKLNR9?=
 =?us-ascii?Q?8Mp28hr3Lk6uVnwkX1MyzIIk318FcAwpYnElfwV3DbjiLGv87lgfDvJzYsMw?=
 =?us-ascii?Q?oIBCPBYZNgMXfgRtaLCnJAzNw7rcLZA7LZBBWuQcYeOF/hIjJWBE0afVU46E?=
 =?us-ascii?Q?dc1naBMVxUQVTm+A430YGNqlOq8Ba/AtgZZIG9UMFu8dvQbvQcf4/DxGgeK8?=
 =?us-ascii?Q?TWyBO+azNvhryX8enzOPwXXg1vgZwOwzvMPlm8OEakHVhuMSotQFkW+Um79q?=
 =?us-ascii?Q?CVKBTdDD84OLK/fsB6+YMmFvcyr0Z9m6BUDagHUxfaTPvrUnQuUah/hFHlMU?=
 =?us-ascii?Q?pLJ8KMP/H2C0YScrhZO4mLD6YVqijEv0hVe9SNPTTrqCq6fdoCyshq4B9AeW?=
 =?us-ascii?Q?vdOnVHiDCJuIismPyUkCdzQ11BXRDDX4GLsEm60170obfx3gCF1o8vYO67xy?=
 =?us-ascii?Q?k1zskyyLf+4jlWw8x7o4ITTy08Z+SfJKHqlXFcw56QPQ7KCmC7506DcZEtuO?=
 =?us-ascii?Q?ksfzRyupHTJEAlCMegNGp8MqkHK1jXc/tFUjJZuJeiJZIAPmhU3312j2HeCc?=
 =?us-ascii?Q?IzZxokh4dqJ43qXs02hRk9QmQL0iRv9XV8B7n769sgEwKd2BxtlFwxZt4CAe?=
 =?us-ascii?Q?gjxKcFWWHR/CR7skIoyKAEkNOgGLtriO7NAr2aE6wOrmH8936BPFEKToKi+q?=
 =?us-ascii?Q?EWvWIakaMlprwEaqSiboR1H7h2UYRh6ZswIqpBYPESuX3lb+TDVtXVG79hm4?=
 =?us-ascii?Q?Gr+15O5vsfEhXHcu7eL98rTaljA94CZFdFYIof0JlfJ8Y6sVISZcCsDCRvw4?=
 =?us-ascii?Q?RL+SDq+5Ciwp1KB/sjr75vjbIsS7yefbS+aSIux6DfppSn8/QMWU6ov9hhQs?=
 =?us-ascii?Q?A4pYEEUWiAvhMN+WRgtwhe6HlHTEAsOuA71Oh2G01rIF1jku8pcwGX8lHdVS?=
 =?us-ascii?Q?2GSBjau6ThDjk9XGrk5R8qWSrr6BWjuY0KSBtdSyo8NoeTMG5dOyfeLjcYnP?=
 =?us-ascii?Q?ypGDHUUvd1OmwD1bwPZgY+zvULK0NeUV0411Xnf71cKh+WQHNIeCm2TlV6ep?=
 =?us-ascii?Q?nxrTH/taB6yeCGKPva3KkkXwGfL8wEpx4/fhYColydDZJ7reMUlwV587eXbC?=
 =?us-ascii?Q?a0UzVb1wcWfL4/RvBV5M22ozjA+BXGnvwof+MW9YFDjYSH/qUt3SqMOMV6lM?=
 =?us-ascii?Q?P2onH1dXuF0wYh72nQUlyLTKtss7DbVPUChpQi9aDONTPSxLUfarH6urYVya?=
 =?us-ascii?Q?zXk9WsUMxirTLxyA8QRxGV461wfgpRHJCFkx1weoUmFPK4EFZWnZg1ZFfIIb?=
 =?us-ascii?Q?at8T5nLuXtIlF6mGhF1WdrMairZ/QP0yPV1aQ6WTCtFNqDSDA14SKEnSgEj5?=
 =?us-ascii?Q?WiYF0+gA60y+fN2u/g6nF1M4HBpyDq5Q3LVltqxC0lHus6+gHtCkFd3xWTjs?=
 =?us-ascii?Q?fXb1Pnss5EYVgw/2PejumKUW4O5ujczjuidKCh/88nMy9/2H3ypGnG0cAcob?=
 =?us-ascii?Q?w711dcnt3X24tgBzGDUbIEzw/nk1cMQ=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc93cd3-fb99-4e87-38c7-08deeed830b6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:03.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnG0gW+2ZmHUnl0WxmFryBEMH54NmJJ+qx9YblJUpwBPVj9Eap1q6odQBQlxy85vrltfx1hxMtxAhizS7THlSz11rwn3dOLuSLtf8kGq/Qc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

The MUEx50 UART can handle in-band software flow control (XON/XOFF)
directly in hardware.

Program the on-chip XON/XOFF characters from termios settings and enable
the corresponding MUEx50 flow control modes when IXON or IXOFF is
requested. Provide throttle and unthrottle callbacks so RX can be
stopped and resumed cleanly.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 53 +++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 25ca43225e7a..39eee8a9b82d 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -61,8 +61,20 @@
 #define MOXA_PUART_EFR_AUTO_RTS			BIT(6)
 #define MOXA_PUART_EFR_AUTO_CTS			BIT(7)
 #define MOXA_PUART_EFR_RX_FLOW_MASK		GENMASK(1, 0)
+#define MOXA_PUART_EFR_RX_FLOW_DISABLED		0x0
+#define MOXA_PUART_EFR_RX_FLOW_XON2_XOFF2	0x1
+#define MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1	0x2
+#define MOXA_PUART_EFR_RX_FLOW_COPY_TX		0x3
 #define MOXA_PUART_EFR_TX_FLOW_MASK		GENMASK(3, 2)
-
+#define MOXA_PUART_EFR_TX_FLOW_DISABLED		0x0
+#define MOXA_PUART_EFR_TX_FLOW_XON2_XOFF2	0x1
+#define MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1	0x2
+#define MOXA_PUART_EFR_TX_FLOW_RESERVED		0x3
+
+#define MOXA_PUART_XON1		0x0B
+#define MOXA_PUART_XON2		0x0C
+#define MOXA_PUART_XOFF1	0x0D
+#define MOXA_PUART_XOFF2	0x0E
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
@@ -159,11 +171,11 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct tty_struct *tty = port->state->port.tty;
 	unsigned int cflag = tty->termios.c_cflag;
-	u8 efr;
+	u8 efr, val;
 
 	serial8250_do_set_termios(port, new, old);
 
-	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS | UPSTAT_AUTOXOFF);
 
 	efr = serial_in(up, MOXA_PUART_EFR);
 	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
@@ -172,6 +184,21 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
 		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
 	}
+	/* Set on-chip software flow control character */
+	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
+	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
+	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
+	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
+
+	val = I_IXON(tty) ? MOXA_PUART_EFR_RX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_RX_FLOW_DISABLED;
+	FIELD_MODIFY(MOXA_PUART_EFR_RX_FLOW_MASK, &efr, val);
+
+	val = I_IXOFF(tty) ? MOXA_PUART_EFR_TX_FLOW_XON1_XOFF1 : MOXA_PUART_EFR_TX_FLOW_DISABLED;
+	FIELD_MODIFY(MOXA_PUART_EFR_TX_FLOW_MASK, &efr, val);
+
+	if (I_IXOFF(tty))
+		up->port.status |= UPSTAT_AUTOXOFF;
+
 	serial_out(up, MOXA_PUART_EFR, efr);
 }
 
@@ -218,6 +245,24 @@ static void mxpcie8250_shutdown(struct uart_port *port)
 	serial8250_do_shutdown(port);
 }
 
+static void mxpcie8250_throttle(struct uart_port *port)
+{
+	guard(uart_port_lock_irqsave)(port);
+
+	port->ops->stop_rx(port);
+}
+
+static void mxpcie8250_unthrottle(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	guard(uart_port_lock_irqsave)(port);
+
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	port->read_status_mask |= UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -315,6 +360,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
+	up.port.throttle = mxpcie8250_throttle;
+	up.port.unthrottle = mxpcie8250_unthrottle;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

