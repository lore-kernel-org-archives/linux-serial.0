Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013010.outbound.protection.outlook.com [52.101.127.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78983A451B;
	Fri, 31 Jul 2026 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484165; cv=fail; b=PurCluIZdjSNZXkd7+zxzqb6u+jN9Jc+5hwBRcRdAC/ePyBswF4ia6dWahAy+q8SHyG2RSUABKTGb8PpwYtryE4bxiOdbX1Vz4V4goLKGwhEnWlTWBuT1l/KJ3/zBqcacaVky85jQRHMxt0Ehum/18lAlpI4Zy2lsHmKD+PtceQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484165; c=relaxed/simple;
	bh=cfa5NTAX+yNhhgyHNTOYq3ftRABGCUaZfPs+pTEGock=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IibiXt6kidUfhvtlxPw1uD1Q0JVnlS8qrpxltK+8gOnPVnz1s8hpd4LLkg90nm4uPxxdOuMskMPN/k0Vhs4kbcVAMRWzG+M9HwMTSpGSZqMFIjZ/1wYWL4IBdZB3wEZXR+b0SB+Lci4NovMrMuwvltIv4ub92IGPGjj0fOj7HA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=jDvVhoHw; arc=fail smtp.client-ip=52.101.127.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="jDvVhoHw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O2lCBwVIVr35xrZYbBavekGioMaAsNn29yZFw/vyiiXL/+6+yCT7TVxAz0Cmj85G9o4frw/Z0HAogVC81nJE0HrTK3Q/vy0x4mJVGn5dvN6L8LAqTAO0J82bzfGqzrrO3CY4bkZKPkXsnTPlWvq+zPVzqykFphCQ7CcpZCMn4Hy7+BNDVFIFktCRUsV90nJVg7BNmJ1AYjBBrWrD4lckIwQKVqepsCJ1Bzt0+Os6bwKuk1sdQ9yzxDM8eoL3fRXirWDt/GeIgyUSx7asoc+7eYmHK6iackL6rT+GSxHS+8JW7spDyeU0+lrfL83Rlt/ANVi6m6vParkjoaQRGIiInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzcSVPU60A+L8vRGNzI8dSr/08hU9N2T154Cb/HCl6c=;
 b=v9J1qixa8PywPnah1PVcGhDZlLPPL/63U0Ts4X+WkInppKHd5rKeteNKJfiohIvt5To8azaqrlsLFZe/mzt3gpHCzIKxjsRrykTxHe7ceOlo6h0NDtML1Y5CK2bJB63EWpvWVZ+9HCfmaY/0HBjzC5kYPo28KKSRRXRHnuhmOyAmipcEJqx9BG5GIzN+ls1iYjrpwQEd/+zp/zNKt0k2nJ+IUbMUrR/PX5v60/IAf4rW1zU7O5ocLi5DkHSpnKTDX2MEDYNAKldoLE+DpfhonEyHeN3XB765STmUuWXGXjECRMn9frtXxuN+UuZlbdWKjoBgR5SKbzXFlowAKS5lAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzcSVPU60A+L8vRGNzI8dSr/08hU9N2T154Cb/HCl6c=;
 b=jDvVhoHwfAS40KAPncRBsF91VZoe6QPezgrizBTkFekWJcDVbXxvTUuk/QZZDTgpwOG0/u5Wmc0UO8nRvcRFHgIQKygZTR7XEcHFDbQ9691j9PwP0kPhwO6h6w6TGJ+W57qt3CuqS7z4peRpTbdisWM7XVYHf6KZxHIpSMJ8RUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:08 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:08 +0000
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
Subject: [PATCH v5 10/14] serial: 8250: allow low-level drivers to override break control
Date: Fri, 31 Jul 2026 15:48:16 +0800
Message-ID: <20260731074820.735619-11-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: ee7ab461-34de-452c-e1de-08deeed8339f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uMK/tWHqjvqF7Pr2MqaszPBHYLkCwXptjisRPADs8OFdfUnO2SioIPQlWOBa72dLex+CRWMe0nsKIZsFLTIG4BUd0CGapzFCdfK4HLjUV7HP34Ce7NuAJp9N7SWi6ozQ8/zYe9YFovQOVz/StYcb3DiI5vkJPrvzHz9c1hwpmeP3COpt+Rg+R0do2NGxXgyWxSGV2c6D4KVvs4b1T8n9KIfufcf4t/KovasqOhIIfDu85eCjK9MGGK+aZUW+x8QVhxUiDD/+/Wu1m2orBvtCpGve/K+kACDdzCi3RwRH7gDixNo6BCZJTe23T6DyekyV5CLt5JSisJexUoYNmtsTIiOCMbRyLXof8ynomOnA/H5TsMkORGkh8Zrvjl8RITAlAhCnfwWb9JlNP8c2DbpJduOT7+r4dvpwh5/LWcFhvyJ7v7ZVmHnFerNjXGEM6mF3E6qhZ2dW/eG4a8cFUL/NCfiisM5TSP2039A236uHw0hOUiivyK4FTdynnfwel+DxTD3VKYqHHJicyYUoVUsLHZ6ogYBrGVtaO9YouuBc6Z+dwpZvHQXpWeADHJR4xtxkLTv18ptcMdLp7NGTUJbBnFepR6AY6MU8XxTEXVxYzGat3WpDdn/Nhg4fpX4GeddRsDw0UK68gR5boPphv25ykiDro5KR2acWNDfiKF3h6kL0sl5tM7lxsIZTLmADd68d2i77XHMDlFgcsV+D4SzQOWrXOSFZ0eEPXHTXEOiWPPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LrrFAk6MRdWtS+VaU7QfxBSbZ39F3+EDAsl9aVPRmPAilkTKzWECTZk6v7yb?=
 =?us-ascii?Q?8lqYFTAEtOMHy2Qnc8HoZN3Wj7CSTn90VkNbQ8cbZM9ZUNjsCZ/pzuOpgNi6?=
 =?us-ascii?Q?lJ51AtfKPQNPikCGsVPmFtsE5qmRSWLvoZQWuG8I+yUE1a2x+285bNUhlTlZ?=
 =?us-ascii?Q?VqnadzODriId+M/crARWOKp7GOV8MAgx1T7RSPzsrA4wCVrzCgZ5dUrdhQaU?=
 =?us-ascii?Q?5Dkn/9FRQU4M3Dby4suToTOysXgA6Eemxh+GlsA5JytbfUVnnyIyjj+N/6q3?=
 =?us-ascii?Q?dy47ZvIG+FNQ0a/v7JYobhbeF7R5XQs9PWNI8LLvw5fqcFHSgCpxMbtRqv0i?=
 =?us-ascii?Q?NSiLXczJKLQ8Mt+DakhOIs2qwn6yxmcvahFLMU/K10AYaXh6lvKCei2acyY1?=
 =?us-ascii?Q?jwDopcw0MgKEvLiiSSM8xPcZw1jOUZlwvKQk2GdlEqeITgU3BFpoSJOYkZe+?=
 =?us-ascii?Q?pPrDGhLwY8QUdn/1anHDC7zdAyeEeecqFh05fcn1tfGmh25yHMu1rN1N2RCm?=
 =?us-ascii?Q?bqkOsWnswGUPwyHXibtEQk75hVtjz8Fx3JMrinKrOVOMjpM4bdLLpkVIh0CF?=
 =?us-ascii?Q?ahkuI8nRmjkGOfuuIvT7aBnCqoaG/NdNLzKLn0VMvTeykaXEXTXYNWlfJxJt?=
 =?us-ascii?Q?cDoOkNBPDa+LZTsq2ritpeQaQl7xqfhcVUWHpQy042Gx6UBJT71MgfGfbcy4?=
 =?us-ascii?Q?bjQyBqTX8sHh9te0syKPj+bTxN2VfTCQ56m1DW/KQKHvG6V/q8C1VWUtXsvX?=
 =?us-ascii?Q?pRIBu2qGbDjjUnVKD2urOpYvOAOsbwCXSv+2WKYuhzLzyNSxuVe1Zd81MoQB?=
 =?us-ascii?Q?M6+//IBJv65QjLX3j2olyc1bZbELyrqKRqOiiG0Q+iF5h2a7xD1XiFCVREHH?=
 =?us-ascii?Q?4agBdCmykqt7hS/xPkXNzW8EsWKFrvnjo+B1msjrwUALFtwzJs94qd6b56DX?=
 =?us-ascii?Q?//Da4kit5vtqxjva2V4DPhwzXjJND6LHfcXhR11MZwogfk4Ao2+R/4Abq5Mf?=
 =?us-ascii?Q?vYAP2CXvkcBFqv5njPEs//PbHCTelpacVR2R4bEUhYZE6yApN0fp6fCqvZPD?=
 =?us-ascii?Q?DVDPlQsz2b6rs6YkFkZB/CGcioZxXlCr/h9pSa6Al0R295YbuQD7P66JQTBo?=
 =?us-ascii?Q?mvSQHxqbg8t7/MN7B8TFv88A/D0vDMLtFZothNoWA5EP/OKc69PNAys/GsQ1?=
 =?us-ascii?Q?jLx9QLKDHhBba+wB9TV6qXbKgwCtBD076I5Xj/g97KRdJUByt58IuBZY0vDE?=
 =?us-ascii?Q?9N3EYhPzxtmaZe2qn8Kn0PFGaNqybwyCj2d2LvGhERO7LfY52d8l044y+Rk3?=
 =?us-ascii?Q?zGmZfbj1HQ18Qy4xC6xDQ777gpvc+kmcuBpnkl8RcXyNphQMyS7jZ9e9RZOH?=
 =?us-ascii?Q?gaRhNBcV3HLo165q0chMUaDu4xFa5R1S5DfNlSROfdfuMkJTzzwQpK8SiR2f?=
 =?us-ascii?Q?rNHcgPom6C6SgmjMZXBQR406ZdLUWNu2BXTr06yn6eemKSIoK+RuuHbZ0QV4?=
 =?us-ascii?Q?qzLlcikC0gIPIsMQc0wgJAzW6KFABjMuODpWZmxD/rR7WmXQIc2dtOO1ubjG?=
 =?us-ascii?Q?31JCHZx08h+Bvzlqx+nQAR2Ziq7QnT9zWLBTmsqqeUWEzwuJO2rTC8czDn3N?=
 =?us-ascii?Q?LmK+tv+S6CLZm7VHwtLr5P7JcWq0XBk9M/qvAHhsDLC63n3bltYjIxQDQLqJ?=
 =?us-ascii?Q?He/F+MFCKuzsJtf3vY39nxHdrk5nFNnb1lY9tGvQfzMDDuZLxTq2gSouuVW6?=
 =?us-ascii?Q?zvQYxOwLIB0s/DhLapJhjDfqvt9JOyg=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7ab461-34de-452c-e1de-08deeed8339f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:08.2100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qPmzSwYl6IeorD3xzTU4zkAHJS0b1Y6RcfXtGX3sOHB6i2BMglpsrYk5AYu2tbYKgWMcM5F+wNsf7yxJ5wYaArwkx8sun43aG9sMAfSWYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

Some UARTs require driver-specific handling for break signaling, which
cannot be expressed by the generic 8250 break implementation alone.

Add an optional uart_port break_ctl callback and route
serial8250_break_ctl() through it when provided. Rename the existing
8250 implementation to serial8250_do_break_ctl() and export it so
low-level drivers can reuse the default 8250 behavior when appropriate.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  2 ++
 drivers/tty/serial/8250/8250_port.c | 11 ++++++++++-
 include/linux/serial_8250.h         |  1 +
 include/linux/serial_core.h         |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index bfa421ab3253..0a3355eb4bc3 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -796,6 +796,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.startup = up->port.startup;
 	if (up->port.shutdown)
 		uart->port.shutdown = up->port.shutdown;
+	if (up->port.break_ctl)
+		uart->port.break_ctl = up->port.break_ctl;
 	if (up->port.pm)
 		uart->port.pm = up->port.pm;
 	if (up->port.handle_break)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a17fdb5d68d2..6325784e5e73 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1937,7 +1937,7 @@ static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		serial8250_do_set_mctrl(port, mctrl);
 }
 
-static void serial8250_break_ctl(struct uart_port *port, int break_state)
+void serial8250_do_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 
@@ -1950,6 +1950,15 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 		up->lcr &= ~UART_LCR_SBC;
 	serial_port_out(port, UART_LCR, up->lcr);
 }
+EXPORT_SYMBOL_GPL(serial8250_do_break_ctl);
+
+static void serial8250_break_ctl(struct uart_port *port, int break_state)
+{
+	if (port->break_ctl)
+		port->break_ctl(port, break_state);
+	else
+		serial8250_do_break_ctl(port, break_state);
+}
 
 /* Returns true if @bits were set, false on timeout */
 static bool wait_for_lsr(struct uart_8250_port *up, int bits)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 01efdce0fda0..5ae00dede026 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -192,6 +192,7 @@ void serial8250_do_shutdown(struct uart_port *port);
 void serial8250_do_pm(struct uart_port *port, unsigned int state,
 		      unsigned int oldstate);
 void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
+void serial8250_do_break_ctl(struct uart_port *port, int break_state);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 110ad4e2aef9..f6ba3e7b09f1 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -463,6 +463,7 @@ struct uart_port {
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);
 	void			(*unthrottle)(struct uart_port *port);
+	void			(*break_ctl)(struct uart_port *port, int break_state);
 	int			(*handle_irq)(struct uart_port *);
 	void			(*pm)(struct uart_port *, unsigned int state,
 				      unsigned int old);
-- 
2.45.2

