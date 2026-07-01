Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013048.outbound.protection.outlook.com [40.107.44.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AE1369D55;
	Wed,  1 Jul 2026 03:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877480; cv=fail; b=QVUGCi4QDFpOSDkWQMTfrGrcoJPrYMAk2CkH2ongPN0ju81v/i4/vJLlYvCnHsC95UmNsS5SdJKIJGpbTSVhZtrTr56SJdHRMiMNaz3i/KVv0RbrtV3X8l0WmQ/WP+zOY6FoFBAT2sFDFDmOzgKxM7J9sQ+izKXEfHSb6A9ArWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877480; c=relaxed/simple;
	bh=KJ1w4RJHpOFCuuIqHkwrCik5OeOgFnySosKbOOcLHXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GrPDm35FDr4Tvp0I8rn/UldLkDFSgDShclL2DpMmiFEzf+BiqQVFSvDMecJAdNG//Rd43Dw9Tm8nqQM2v2srYbyU8xLTWzvTjtQNAFoJWIZzciYo1WrkLijPX/CmtHBlrTkNYeZuL+XgnTOot91QN9pAfxRwT9KbRf1pxsNL2Y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=XwEZVmAX; arc=fail smtp.client-ip=40.107.44.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="XwEZVmAX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enlnLyj5tOvrLQgcpkWQ2Ru1oRq8IW8opT048YDkuNIJ7EpHvfUrMcD2PseL5oiPF5r/M+hENLz7Ux4sbHeWZHuafXSDOYKMfchalkH/Yhx08L7S0FluTxMGAbqfXEcI3h9ly8Rxs8kNYbJ1BJYgDj57SM+Vpd1sB+UAmaIzBivwqGbwZ8Okh1zzra4hJo1QXp1J8V9LlAs8zQjo0JAK28S6Y4JL+fQHsReY8XEY6DEu+he3Q0cC++rzKxk/EtRtmrMyb5SjB1RzKCHaInZI2Zav/WCBg7M5C9VW++VteV73624d4yXL6TaWiRs5Iz+Tyji6PdhoGocp1R4iyJzUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpivmmdZZ8woQxvmupKEOzxm8TMXeVuiYn/iPJ6vfPA=;
 b=Mi7UW+NjbyoQnDcBTmZu49+BY3aDi5I/JUKr3x6MOgNDlwUcuuqmHUVWg55rUn3ZPowFeabNosgXSg5HHnFZQfVxkhsOuiIDSRjbiwaQJQ4TMs0afZEeYG87sseZmlCC3GjJDLkgDxjnUi7bgwvVbT5kwqwxRQ4fJWa/qPwFIikSeShSUhCvuESNrd6ykaua6+ppBcs4/TlbXhtz25oeslTtMbm+QV8UJoBhd+xTyo/bPrMwvMf5sTmSOGjS2zhpkSDtRi3nrcPN+DY9OPc19vyc3h9qr5XltfVgUkYIgOqRpXyGl/0vq7tH4qVhD+hmYGu4nA9OLAGmtPgVO8LAqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpivmmdZZ8woQxvmupKEOzxm8TMXeVuiYn/iPJ6vfPA=;
 b=XwEZVmAXlV7SSd86a8vwe3v3ngIK7bzN8ZJGG5opbBRmaExGhrWj7p5PogCN4HD2D/WmCw2PsOiueCY2XV+qEfSG1hiiv9SFd7mMZyafdY8vWIQIkG+1w3W5I4TgaWr7UfxgWf5XG81quu1k/+RBMxD7iBg3z94+lELtWGiPB+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB5417.apcprd01.prod.exchangelabs.com
 (2603:1096:101:c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:44:36 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:44:36 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 12/15] serial: 8250: allow low-level drivers to override break control
Date: Wed,  1 Jul 2026 11:41:25 +0800
Message-ID: <20260701034128.218569-13-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB5417:EE_
X-MS-Office365-Filtering-Correlation-Id: 68201735-e400-4780-124d-08ded723120e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|52116014|376014|1800799024|38350700014|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	exKqPUpS0L+iWBDOPkGJC22feHqv9yhHY2HfqjjVXJ7EA7X4mKyFHPV1MjZA3qHAm6LFPzWD9E9vbBd2m7JOTeLpQ0BrqT+a8KIagP9uH1aVtsTpw82gCU2mWRTTqOKxnXvZ6+lY8Ghszh0UAlxOpxsrzzSs4E7JleyLuEuutBTxfOl7/bqQ8W/vz6072mwx94emFVipuGAvpx43l+5rihyWCdsW1mTLyDkEvRqDayA2IsqIF2KDIQo5o3yPXxYySn0F0YnuBARx6BrP9vUySMyWDWkkVDLH302f8j1b1YgD8hA8O50bjnVUo4HVvtPxGnt7tPnjWyFY8qRYfsyQp5jo0M0PSsYaQIcOB1MhI0fEcp9rm56NFOMGV3JEKl/ABO61QVrZ1kzqPXht8619CMb3eYK6f8Amfa3BnKqwFq8pLyzXqY5Gph9MB+YQBeIfo3BtGh0VZX92FW6iAt9X3ApWoGW5+tJtJCHuQLTL0BhJfn04+6w/8+r233lQhNx+5U4lLFQ2mXUA5BNfxtdQxMM4GOdTm4IH1b2FDopovIZp5zi0N0BKklqlHLmq7eE/NSxXBNbuAotWcNY8RlEdmkL4hjBIonV0T9NRjtyKnS9VgOsnWpd7KZxhJTpudg/NxXxcL/Li80da96kDfyDYWpl0wUt4q2krMnz3omSkaoslCCzhCV7AcYaGSD55IK93JtfD/3+NwiFtpiUwfm6GzUlRJvtnEOUF30SZ/er1lBQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(52116014)(376014)(1800799024)(38350700014)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CGvrv6Gt7zTTraIkg2DswslhsNcehdBVvtd/tekeCcleoBsAEHPSvQPH/A51?=
 =?us-ascii?Q?lt6qJBM0Cb57nnWYlgHM8s4/Q8MkbdzEUFrdPK8KVjFWBHQeZ4G+Z525xB0X?=
 =?us-ascii?Q?5bQUbLGAMYtseFh78y9qobITQgaiEkOlnI1tEidHOF5t6yIvNv3f6ixdOxgQ?=
 =?us-ascii?Q?OS7qX6y8SiX11AT+SSEbU2THwe7Vg8x6Ujl2MuDnD86u/Jn4VdSO3Nv0qPzL?=
 =?us-ascii?Q?5bM2++80g/eodtjTkbrtNcBNCTNry/Qd7iZFvpii58bdw2Si+ID5PxTYY3Ou?=
 =?us-ascii?Q?bqnGelMGfIuUHADEMEuKLSE25/MZ9pxPwAZBl8mk+jGOzPdVBEQjgDSHFzAb?=
 =?us-ascii?Q?cQorLXkO/asFbXeqJlsOFKLDJjeA1X6yYPf2At+qAV5eWDHTB3UJa57zIcov?=
 =?us-ascii?Q?vnolf6C39orFJWQsQtxqaYye7d/XxvQZ3EjKCv8zIbuJB9l1tseWeRzEa2Ro?=
 =?us-ascii?Q?8Zq62nrivDTcT0e6hD7UGf2d7krE5WaDjMafaj9Xnn6W1GYIhGVoHxg7vy8l?=
 =?us-ascii?Q?3S+HEqSPTPQRYt+UaQIe8S9i52VIJ6IM7NDfFoBhyWvSQC1HylbYUQJ2H6fj?=
 =?us-ascii?Q?oWbZ9qNir6X6FGoSSb50L9t9Ua2bb1rLKceWsjEhj9dIhGiZKoi35cf6pvib?=
 =?us-ascii?Q?8ZAJbVEGzI30hUCK4qd62Umvlq5lE/sjYjaCwGCW8uqBkruzYftMPC3Xb9UY?=
 =?us-ascii?Q?BkQI8G0UQlV/BUuEpx4ZsgYrfekzxWV36wTrb+BZr1Lhly6+5jdbruc+hxUQ?=
 =?us-ascii?Q?dz/KDSCSPCYaCQjL6rA5G4wM5kGOaMT4KfZ4eHMK4wisILQf07tLnjOOJ00t?=
 =?us-ascii?Q?3FMuCr2Gk1uaWH8bCX/pkUDvlSyh0XzenTRDCeqS20X6EfBxtbk7WdLkA4T5?=
 =?us-ascii?Q?le4x3epxbcDIPMVRFq1bUjpNIBqDiJMReeXj2DWuiKvTPM+rgHDhq4tZv6f/?=
 =?us-ascii?Q?zrM2OxUJ6PlMTXdOucRqz+j6U+w4YDJcKv4O57b96/6HuKPBEXct7WN+AfpM?=
 =?us-ascii?Q?ZzPgqqLWeek0nP7OD0mC5k2+wefHCQWNr6eDZr0b2Q6zbIcTlnJAkvZKnOjf?=
 =?us-ascii?Q?SajX6fXg1jVb9Yd6NpXBUtMcpE9vsN+qlqlcXvk2INhqECY5Zk3bYD+mh0ny?=
 =?us-ascii?Q?M+SascGo052Ap8agtUK8fUM85eydLvsAC28899AYnchms7Agmr8DAMIh6IaD?=
 =?us-ascii?Q?ZGrVpx5IgvfMqzZUrc9HWL0PRXE74u90cJCeBjqp7g6cGSkh91p5Ny1F9LM+?=
 =?us-ascii?Q?oG6P0To4pC07rS4vl6zUBd3B2zMyrCbiY+b63zBp4fZ2Rl7hhv92vgdbtrTt?=
 =?us-ascii?Q?uMIqZwh/sp0Xw/HZV1WdNGlJXIRMzqUeOiwxUQPMmgWIlOvqCVOexAagztC7?=
 =?us-ascii?Q?THBn0MilfcGOSwzYFK0bv1Buhi31Nhoyvb6EwmOwaCuWino5zQxiHoj9pUC1?=
 =?us-ascii?Q?C/RY3dKtDbqmJGlXlgGf+YkINvyH5u3GG2w2YkysXv2Ui1DbUqCfnimqb5tc?=
 =?us-ascii?Q?/HP3RpKAYBzs2EpRZyvo+XhXEt97a+PMSMv3QmUKqrJRIW/0fP9LAkJqzJgL?=
 =?us-ascii?Q?zGWcXftFWz/6l0JzxMQc8Mf/NEGNducavozvyBJCFoc/VxcICPLr8vc8NSz4?=
 =?us-ascii?Q?SNiuhdruTvOg4cAgKqQmuw+Fwf+3C0XTm7KsTC1sWHlZ18xFAJ137w+ks8SE?=
 =?us-ascii?Q?a0/TmQBP3VF/Dabnym1Zpf2sL/oJvpBwaCypeQWP1EMDt03FBzAXoWko8zO2?=
 =?us-ascii?Q?ub2407eIT5CTl4I4zefyJBvty4uIzaI=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68201735-e400-4780-124d-08ded723120e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:44:36.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzjXmziGtGgJU2K4E5tu1ylD7s0ngRlm9Uur+1DHR1B1NCZUTf5roZUU0q5kJ/LUU8gEE4aCIG+nWfaSylXo9HH0upMzrTd5tob4bFADvEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB5417

Some UARTs require driver-specific handling for break signaling, which
cannot be expressed by the generic 8250 break implementation alone.

Add an optional uart_port break_ctl callback and route
serial8250_break_ctl() through it when provided. Rename the existing
8250 implementation to serial8250_do_break_ctl() and export it under the
SERIAL_8250_PCI namespace so low-level drivers can reuse the default
8250 behavior when appropriate.

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
index a17fdb5d68d2..72ecc0112b8a 100644
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
+EXPORT_SYMBOL_NS_GPL(serial8250_do_break_ctl, "SERIAL_8250_PCI");
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
index 666430b47899..d9e5e3d02003 100644
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

