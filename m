Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5023AEB4E;
	Thu,  9 Jul 2026 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575246; cv=fail; b=RQB2SLjMeMz9z/BCZqCUNaWQ45ID/+dQqa4gRcIv/CfZMwrbQbHVeewvRJ5ViNu/dMw5EJr+rzlvUO7FSLmSFtFv4xfspS9fiFO4dZdabvul78aibfjl1Txc5oS59duBHAHTZqd94QxiRSyvei3hxPHX43L/yl5xdIi4AW4kflo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575246; c=relaxed/simple;
	bh=Qzlwp9aTdnsT6yIyGNVGm50R7hpHnerx8C2B6Gkw91s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EotgfmZwpB3MTj22Ukwfz+yUjqZFqFnASYmCWcCc2aBDRMX3Tx8PSmcF20OvhQLS9MoCIq5lPAa3Yza7IpS4nbCpUQtU5h2e3OjmoWofysgyvmz4Es93OTHD0et38JTwB9oX6WU8yWa/FMXaGFWgFJzpqljUnug82t5dW0wt5tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=LllGImyO; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="LllGImyO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u++CpKGQ0vxSVJcL+R6S/6MEROvbqQU7RejnBvlX6XqlklOs01O1falD02EKrYCMc37KxzUQHXG6034rdch00ppD5chCXoP+BTbEm/IJRUTohzNjY1QVSvaUCKNojTLxedCdh8CynMuR8QfbVzJJ8oH6Ny7jzlK0dIt3k30aNJA1BdLhWCZXCYl2b5I0yoEC2lUj5mHac1/dLNmc5enkvji587+CXMmKfbDQZd2UOA9dhySeBAjzu1Q+xc9Wjhf0cYL1ZkvBmhoBaMrT/0i/oQpbs5UYkkDB7tWxWo3R2c8tbLFeKNLwQbDbSWAfqVW81puGFHOUO5QFMBxe+rusUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buA1QCjgMbn0dI2xLLvbaURLu2ATAespywaRfZkwTbI=;
 b=kahVvb8C6CUoGnNZOrBnZdvNRpv5UDGkYzKFAp/e0XBHhcEPbUHFPL6GnRDVOLWItTDY+OV3htIuc63MGe9jKC4K8mNNYowwuXW46dI1CPB3A7+jgv3VbPylut/lR42x7peH0B77Xgp5p2USaUBjBOVIsVUkp8lI7ZXylS/Veh6Rut0rDLtUI01lgU6vRb57jYz0BGbcAWeXK1tkn0zThdpxd9geMSdUJ5v/Uxt7yum7uZog3zJHoy+vVT8JuPLcWBDKf/HHnJdr5xtOQBozBdC5nzCP71NZMmKxr5PwgoTHtvvFn+hQ4oBRRxbk0DXxS2Cv74GDwvD6tTEm0C5lww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buA1QCjgMbn0dI2xLLvbaURLu2ATAespywaRfZkwTbI=;
 b=LllGImyO2/AtLNAkXpulXsyfa+7s3bJstETJd6qwnexh6iW/Nz5MifHSN9cbNkqGoxphtdWuceahTeteu7M7Rzvt2x6QPpbL+BsD2YgDpGC49uQIQbAD7k2UO1fCgDA1d0wk4AxEoarqb8z1HVVB5kHCztpLLXm6iwhncZoX4oU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:56 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:56 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 08/15] serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
Date: Thu,  9 Jul 2026 13:33:07 +0800
Message-ID: <20260709053314.435629-9-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f43d8f4-4937-4838-585b-08dedd7bab6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|3023799007|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	w2TkgasMwd7ocqVW7B4gJSm+d1aPa4JN1HOryJ44J1Ko6fbG+XgR0D6Z4NWVi9sHufpaDzv6G58DRNht01bYQQIZ3fX5sY8baLTZPJZvU8Jo1nIMkaxHsiKHB/62DlKpXv2Hyd3CSSaKaxWMMVx9S3vi/QWV0WImlNMrQMtgmaw3POXZtjrVJhcfYTUF+eNqXO0sm2T7EtKc7Uflt+rNB+Y5i2B+lefPDMjB0o3x9Gq6NUbpNNX7pSed8iSKTxKPLvSWvptjW+vDFD77dhzb8qNxiodZrd8dUbQlkrt59rX4L02A/Pa5zPvd8Q7a5n6gHHZdeTUEl5ygGXtQdAq9/pLIRCM0J8OoICzlQfjP3bpPwTxxMfDPSZndrLYnE5N+TiDtvVxPS9yI2VdNS34jVHc87EqMkYtBobthon8JUPxOEFmMELu9TUjJMzlG6VKutLZil4aGzKZCOZjZ9bokl5TWCAZO+Q7IlicMOCxgWWiwVSy/ao5r1CUboWpDM0de4jNu57M4qLIJwyctsEnIMYN77SDawrXHt7Yt82LkimJ/BemFz9TUgQp2uis25I2UJYV62/Pb9A5725X4N6XShqc+F065ELGyxz6qU4ejSoRzUpRbZ6CnhNbETipxdOxNQj2eu3KA873Jk/1oC4FRGIxqWtEeufEFzUSORbC9q02ZWWrAT5FImmSjVOHi/Fwn35jDluzg0LXYiJQbCxqGnlDtmvJgp51N4VQHhsqtEec=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(3023799007)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWyM46qMN8bY1aOrJThlNChokXnDEDyHmxw48JWWBEuFC1+sqfktLZE/+4Cj?=
 =?us-ascii?Q?dTl6rLSik5g9Ax73eXDSpQ5OmKBZOO9t9vWDlbIcibWTzNIjuaUIrvkXfbiA?=
 =?us-ascii?Q?Vne25qDB01weLroZ7VMPRRqMmwnrJt5pirwQOd1g1qPiexAZlzrmYgusfCUI?=
 =?us-ascii?Q?QiSoBENV+KXahFV3ZrKUuKHUEbEknjn/VB484fUD6mrhJKewt0ng+FvzF4NR?=
 =?us-ascii?Q?HgyyfeTEgsEkSOqIXiHeYICpbLOOyhCCMNpw41clzchVeQzWVI/jfAhdfZaG?=
 =?us-ascii?Q?xxo9tHjtEKIACdgu0kERVFUDNknWW+TSKJjp9xXjOYFheIot/FZQPz/aYpGq?=
 =?us-ascii?Q?xYHOl3U1VtKQKDw2LW7OAimTE41lYmYdF804A75HRU/HVSHNXeXqEX4D8Vnh?=
 =?us-ascii?Q?TTQA3Act7IGzXZWl9H6XOKO9krEGApIACiSWVwoH1WiW/BGJmDSZG7pQUC0j?=
 =?us-ascii?Q?RNA6eKSs7U9Xav621OhjSek/tKdXiBR7prd1V07Qva08Cqa9BBldsBC/gQ4w?=
 =?us-ascii?Q?YBOiBEZGaG8du74GgzUgqspZDSji0TUXKwSIZQ/dQqb0vxpxJuPK7s8g8vIj?=
 =?us-ascii?Q?fxaQTEgvo9uQKsxVHSmcbE0oFENL3kXr5wWkt89xU0GFNQF9jtDNH1YWKApy?=
 =?us-ascii?Q?Ie8P5sxJLnMQ/7BtWUQDXuaEp4ZV0eC4w7lyyCdIC1N/ITQ5kZyljOHUIOAx?=
 =?us-ascii?Q?LJiMFrJEW/Uubu6V9OrO0ehUYYhMBKITzq2A7v34quSC0+FJTxGmqY43on/4?=
 =?us-ascii?Q?AUF4mob5rc4duihRPiZP/+xOvmu3j840b2azjUN3OHCZc+kAEKoKiFX5V6/0?=
 =?us-ascii?Q?vRKTPGuZqJDrVs8lx3X1j9wNefUh6ifu1q/OZLL/oJzcAmgLVwCUPKr8M0rp?=
 =?us-ascii?Q?h9ou3dZ/pj/iIINQFrJQZs/ZanJC8vjPHMpnPPVz5WXo84lB8bD8YvvKG096?=
 =?us-ascii?Q?UfI+MMNtrGbJfd+3BiSjM6uGQBLbbInUgM9saNJNA514/dvBpgE5ziF9bS2o?=
 =?us-ascii?Q?HThbPzbF5Lr+EAr79nM/p/1iSaETEhKKwaMU1EBwPp3YHLnx28Pl+o5Rxof4?=
 =?us-ascii?Q?vjLtlLp88weQEYGKF8TeA2281g43xdhD/uIMRSiq9q4z5wvf/JcCi27hsCIC?=
 =?us-ascii?Q?+7SQmA4RMp530U9vmhTY9yxhq/9Dih3cn2QvwgyhH6UFiYYUyeani4Lf6XHp?=
 =?us-ascii?Q?8iKtBcNIMCcLQwM/DCCTY7TOzbjA9TcuwVBn7Wf5m1EimTUcscw+rsyVLVv+?=
 =?us-ascii?Q?uWaXOzIuobn/lQ5U4a4qHOm78LqTywf461tY/iLQ2YWEdIzUS3dqvK73ZrRR?=
 =?us-ascii?Q?N+6gAWAx/0GEiDFcXGqgZfDEf0ctwwr5RCpn7pDFycHKNZ7tk/Pe15RI2gqU?=
 =?us-ascii?Q?1ApF5iGducAFxjeVR5KwmwwRWTIIx40prl2p3NkZyLXrT9QhSDgXw/Ekbk6t?=
 =?us-ascii?Q?XaLwvE2lFPYHa5nXOcgR2EVVHXzT5pntjVIqJbuGMrPop/36q6BR3yxP4Lwt?=
 =?us-ascii?Q?81tPibpuZFrbiieyWLe17b1CMjxfj4n9Pl9vj3fsDrQ5c1sB/DHzwRfXhnMr?=
 =?us-ascii?Q?M7M5JJmH0mDLgfxhxjHLrtDLvCS1PBuq91m0mewVOVm8NUrCE0P/DPeHb3Sz?=
 =?us-ascii?Q?tE3EFSDvzDGSlKSRoehQJJRroxl5OdYY+J1cyZx95G3BA3DrjpfTBOwvNveA?=
 =?us-ascii?Q?L8+i2VbXnC1lmaUk9C3ZQCi6iRsX6dvR4sdtUHzLvTLxbgqMY8t8Iz1mDvPK?=
 =?us-ascii?Q?YtAIdoedGFOMZwpN1JmbmBk0pMyjvF8=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f43d8f4-4937-4838-585b-08dedd7bab6e
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:56.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K11ZNUdJw78Dld2G6hWfaB7lGWjFYhSKXC79vcQ7Pl+yskoxpuCkpPRxpCSX8kzmhGbD39A583kJgx6mwZMaaCUExbcb3TFq6hJbp3Gp9JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

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
index 01791c56d5f2..d710ace5d927 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -85,8 +85,10 @@
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
 #define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
 #define MOXA_PUART_RX_FIFO_CNT	0x15	/* Rx FIFO Data Counter */
+#define MOXA_PUART_TX_FIFO_CNT	0x16	/* Tx FIFO Data Counter */
 
 #define MOXA_PUART_RX_FIFO_MEM	0x100	/* Memory Space to Rx FIFO Data Register */
+#define MOXA_PUART_TX_FIFO_MEM	0x100	/* Memory Space to Tx FIFO Data Register */
 
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
@@ -318,6 +320,37 @@ static u16 mxpcie8250_rx_chars(struct uart_8250_port *up, u16 lsr)
 	return serial8250_rx_chars(up, lsr);
 }
 
+static void mxpcie8250_tx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	unsigned int count, txsize;
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
+	for (unsigned int i = 0; i < count; ++i) {
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
@@ -335,7 +368,7 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	serial8250_modem_status(up);
 
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+		mxpcie8250_tx_chars(up);
 
 	return 1;
 }
-- 
2.45.2

