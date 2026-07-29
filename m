Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3103A6F0A;
	Wed, 29 Jul 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305203; cv=fail; b=IMyspV2yMaH3Ot6cZ7pI80VurklToxiGIZUloLEQ/TPziW+YnIOGWkBohe9nDPrh+gKOIhRzYGSbjbybgOlApv09yKkpKNu4+GBQNVkYKqDEQyAaF1u+o6NcvyRjB2Bh9D6ERpdkY8lmn4aVarY6NqkLXx7XbjB93VWpYE4w8Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305203; c=relaxed/simple;
	bh=HE2ZeMC2vDCcy3K4l4DMCSTo7K7fclFEuegM9NvLdws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MgNF+Wd9UzYWRR9zoDSUEUASAYcE78N7IJqvqcXD3yLa11Z7dkjtT2rsuzWJZtXTa9bbNVHuDj7jAJR2ESJRQC7Xoulpk2gViUZkcj9+APzDkgwEPbuqSslkc6VAGjBch8ss8V+UTyd+EpDdTsTwflPWL69wOc9xmwNTdaQ8Zkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=QFw7MNnj; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="QFw7MNnj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mxH9XrTFcIv+jvlnylDAALrSNEFa3LRAKsGsw1PxcE1sXcX9BtCPK4ibG2s7XGesqdY7NewIZyYy3bOPaFb7zMGXb8TZwFHgOHZ9HImvJphzuV6FtdUG+1tni6aT/9wakv4+yfeNU/WfVdGRPkMa2MS89+8YZjG2iBdyhQfN3+uP+Vzt9AfDqzEVSoJwZ5jtpbztTjsce8iNbWcWS3HVJaAEglrKsSHgkBEJPYhpBLXvf19zz0vy0GQ568hrncwt34nkCT9coyQiG8C4dfNlZdMv4pNG9MN7X6HGtBQ9hZeJUSvzO91OQbYRa0hnzUN57GEUMLkHfn/AA+CCXBc99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3P9YFEYQ22MDnaHK7wJlBUrJf+sCp2QUg1P3A8uDyg=;
 b=KodKGHuyatqt825QqImqdMeWy2kZN47uMURgHlHuz4Lw+/43cr1XZv6ZBlxqW7i0a92GmMdiYlKpRa042m5r/sky/rQh6RcmmwIOV8LH7bUdMRca7+gX6MoDrzhr1EQbTLxQIfZWdt9IZtkACqcpu5HQeeqkAEE4VJ68uxLViGLuPSfYrF7v4SJ+crX6QzFCftGJodP87uUK9z/FPgc8HKARe8jMRAVF37qwQbo1SAEpyu8mxWxxS6Uym/xijCmnyjX3x92gK/kk8/ktcJ0xicbx4NuDwVm008/+TAKt+s8UJQBB/vWDPYpVz7MK3UuecIAq3TkUGuZ6+MUZwf2CKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3P9YFEYQ22MDnaHK7wJlBUrJf+sCp2QUg1P3A8uDyg=;
 b=QFw7MNnjnLjGW+nxjbylENwv7EjQSHo4YUcis02VD9WZBmzXBNssS4fCyNCrDJr4neRgtz+w0/bAVUlqFZ/t4nJ+i/3BasIMmAUVNYtPjt+5p7G8F34vAbD/pLC3lnk7ccU6I4wuMJdiyp1MQuI5Mzqwc7Ax8OjFqnZQ19YCkUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:28 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:28 +0000
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
Subject: [PATCH v4 06/14] serial: 8250_mxpcie: add custom handle_irq callback
Date: Wed, 29 Jul 2026 14:05:54 +0800
Message-ID: <20260729060602.492430-7-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5479514c-ac2c-4bea-56b3-08deed378754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	QmRkK8Cs7YkBsed4gK0mBMtxEvI7OyuP3fATnyw7e1LfgJUG6aEfWXk6QL0VXegSiVYcRIXIUwX7lWAlGIFygc0eQ5nhmg3Jhl28XbOsUpIcxsO8thh9A2CW905UVw6EDVKBmVYSRWo5kF0wuhqU9M/UvcFFRmt3D3V2JiDfQg9Sm3H0XPzhD254FAB3X+y3/JdNxzlGNf9jSoG+pj/ayrBfF2eNg1dWzi3cMBLOtzterjFJ+t5yQ/pjUXo/4wq8aw3g/0hMtiYJR8T287+Ca5Ey9w+VqdpaJMZjsSMRcWftJrlfpvCQ4UYXIfn7oAHJ+BMLIvARkI3VC9WuUx0T8XJW8sA8gjfC5CtBgp/l+VG7S/t3B0kJtraTFxqjEYrYisoVCdtWqNow40DG7D99vZ/sV6JSWmbLmQtJxoaiZ2H6EYfylZ6uTkGrtyjJo7bTeiJZwKHDLN7q4XxT0KEzaPCvCtKajsoTiCPugVmTsNLAO8NZSQsuX+NvOAQ/L40EOyQIyPbQhc05oTjzOhRVZwWzsmn/E/gYjQkkvRoq6Iean2aKxL4reyiDF4JbfnnzPxxSyZSN575KoXewT3VrlQrmhY/Z6tIYAEOHB0SGSycNILDHC2OrIqbxlxdqQsZ4ALnazDjHSw2Yf67Cpz6euVtRxdSqdxZXicujKRdNOAB+T0L1fOT5xgO0KzcS/VvwzcTZim+0gLgWIUR8NigRqbxuZBwj+obMZwLt5MUobFY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UHUUzQiuNaVLNTvcUJDrdKGl4P0skDywoODKCuqALO/+xkrn4+iQ0YESLD10?=
 =?us-ascii?Q?7ifrBVzRKh/ySL1bz3x5t8tECD/4ThuI1wa5JU+x9lWroJvOkPo+2/hoDJxm?=
 =?us-ascii?Q?iHrzKX2ppLqtQaijAtu1VvqKX8OzNt4Fu2clCFDqjwtOwvwaDkaikmJWTkJj?=
 =?us-ascii?Q?V+QJKS5AObTs4aeueeorUH88ZCmu0ZVD+TNcqODIGzSwBW7LQcwFJcqD+BEM?=
 =?us-ascii?Q?8HUpNwh1fad+23ildLHIjZpSAQVUC/9cSF3+CMiRVa8RUOnX0OaLvBdpuOXL?=
 =?us-ascii?Q?atm4Vy1FHiR1DYVgdIRMgGEC5d0GDY0pMD7Lb/KQqzeAfMIh3VcqI5vNRLgB?=
 =?us-ascii?Q?UY+22lgRLk+02YFQF+YHqUvvQiwMB9Xz4W01NhIUnFbogbE3CsUvlxfclxyO?=
 =?us-ascii?Q?6llqORNUg1FeQp1zjR+XSvxNHdZ6W7KV89X4JdXTMlM+P5RUVrF0KHKAm2WZ?=
 =?us-ascii?Q?X/NOxqnYdvBz/pj/Q+mbqJAkXh6KBECNmwKQgegTorapsgnsZ2Yw+4lnIwYa?=
 =?us-ascii?Q?OOQCa2LncoYyI6QJHfSjLiSf8KUZtqpc3kPp8G3fKFdvON0y42tUsPL2VQZ8?=
 =?us-ascii?Q?7I5yX9Bte5YB23HeV5u7flNb61xtA1wawQbFqY+E9v6cMPretbUp8940lN67?=
 =?us-ascii?Q?AyY8/98sKrFtnh6YJ16LgxW0MAkS1cCComfP8Bk5d7df6IyKdD32yQIw2yUV?=
 =?us-ascii?Q?1H3UqfMOQf+85gX380tkZpzSCXsTsndr0RcISGdAMaOXJuAnwCVwPrXR6fR4?=
 =?us-ascii?Q?2RL9O61eYVmg0xm0s12CbMl+2mYNk4Kgu84Q8vsDlQf1De3vbX1BX6uB4RAG?=
 =?us-ascii?Q?PoV1Vx0MwTn830NYO8tL1swnTtuEuhlI7h5bInmviXom9e9GfbhPc9fKcUSC?=
 =?us-ascii?Q?Pe8j2qxkHQ/k/7w9hT5mgQYhsFEIowW7MTuTB2kG0cYCbs6FgX5co0ABT3WL?=
 =?us-ascii?Q?3qcbmtwJDqkdBf3zyNizBwWPQWFX8pRlknvcO86tRL07ImR/TvbUYzrDImKW?=
 =?us-ascii?Q?/W+/CY8yLVdhis0jgPnt5MU0hAUC0m+B7oV8UhKiFT0zpy3OEiMkqSlzJMgM?=
 =?us-ascii?Q?dZxgObZUxIBB+YHy3+WYtxdnL42KyL9MetbIR/gwNqfgMwW0zwftQZbMad8l?=
 =?us-ascii?Q?Dm6AWj2+rWHepXCP81t/jfWSpIzmoIHlJG86qSBbCfwfeyKUY5JLC4kIWOaE?=
 =?us-ascii?Q?Ezud+4cnhdv9N/gis/yEv1bkCFVNMkHKwEJlvaoQuxMxt84jc6cKTUD/uyBS?=
 =?us-ascii?Q?5qZfmO2rufsHrdGYozGuR85LpuDjkKcuFaw/eMpFQLaUN0PM/hYOiGv6V/Q0?=
 =?us-ascii?Q?rZAmLc+tPSjVoZrUnuDFAAXYP1bvLwqxXle8pxgTdWJyfO1J3n0zu9OwHkk1?=
 =?us-ascii?Q?OSxLsIidcsIuWBqz93ySlU6tD8UJ2n9M+wGB/DcmBnvj/L/LGiUF1cDHCCI+?=
 =?us-ascii?Q?g2cTe7tpvRfN3K5f+NffMsJAsKKcZF6puvNDBZeTNGgpnimNWmU59jrQKw6P?=
 =?us-ascii?Q?0nIm39bEDTGvJQmGQv2063JO1iRs+7MvM/96YLEJYxmGzsBak5Vo/wucnR11?=
 =?us-ascii?Q?3CXquh+th1Y4s2qVBvNqKKS1ydbxeyK/KvTjZF2PR6wMVpZ6AbVyOtnxZW5V?=
 =?us-ascii?Q?ethAEqTAKi16jAubvaVzgeUbSR3eUFG7aihUg2u2f5XuJ3xm/I/lxKzws3Fm?=
 =?us-ascii?Q?6kVReSxihhiszmmSdpEY1wokE1+5L0kjOG0Hc/lMqgyc6nUE39BTOw6fmYdw?=
 =?us-ascii?Q?j/Vwqy9SEJEfLWN9gflnXQKd6ieN0Qo=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5479514c-ac2c-4bea-56b3-08deed378754
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:28.4687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/mkckU77bxcnh8jiOa6Zc20RTm8neaqJ2vipk6JgY0Pc+d+m/u2eJLEioZP4Ocl1EcnrPYzyPHS0KBn4huoQYQVThW0/nmjoRlxc3Kz5L8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

Add a mxpcie-specific handle_irq() implementation for Moxa PCIe serial
ports.

This keeps the interrupt handling self-contained in the driver and
provides a hook point for MUEx50-specific RX/TX paths added in subsequent
patches. The handler processes RX, updates modem status, and handles TX
when THRE is asserted.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 0517caaf2d26..2b177ed8ddc5 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -265,6 +265,47 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
+static bool mxpcie8250_should_rx(struct uart_8250_port *up, u16 lsr)
+{
+	struct uart_port *port = &up->port;
+
+	if (!(lsr & (UART_LSR_DR | UART_LSR_BI)))
+		return false;
+
+	if (!(port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)))
+		return true;
+	if (lsr & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS))
+		return true;
+	if (port->read_status_mask & UART_LSR_DR)
+		return true;
+
+	return false;
+}
+
+static int mxpcie8250_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u16 lsr;
+	u8 iir;
+
+	iir = serial_in(up, UART_IIR);
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	guard(uart_port_lock_check_sysrq_irqsave)(port);
+
+	lsr = serial_lsr_in(up);
+	if (mxpcie8250_should_rx(up, lsr))
+		lsr = serial8250_rx_chars(up, lsr);
+
+	serial8250_modem_status(up);
+
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
+		serial8250_tx_chars(up);
+
+	return 1;
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -364,6 +405,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
+	up.port.handle_irq = mxpcie8250_handle_irq;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

