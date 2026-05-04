Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012009.outbound.protection.outlook.com [40.107.75.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0D33121E;
	Mon,  4 May 2026 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884656; cv=fail; b=OevrEKS3XFeTGl7ldhxIMTskA+Lz9Wtnb30/eezEJSmEKVhrF70K++JBkviZ0JQ07eZU1eWepoBMjuzWhSQuw5AkR94k5PclnsX9qX6t6hWDWuotSwrO17nZQsyBfauDWeW4xq8Y4NS1Pg52FAVu3nFisXElDLppcCgjhbFjkrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884656; c=relaxed/simple;
	bh=77UL0xplWxMp+bMupdwh0TYGttwWe6fRZwK/PqR1ekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p2c/8OXkbT1P0iZKFIFkFL7fst95B61+juSulnbARtKLI/7biRmAHgKatR+JZGGJY/arF1uscX+savDvmUOD3q5pdn0pXfXGmHNgy478D2PRZqBzINEuSypYSSluCVhDMv380qgd3H7iDx4l5A9bxGR8NAEeg/6zXCzatPaTg+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=e2LgS3HK; arc=fail smtp.client-ip=40.107.75.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="e2LgS3HK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VS6VT/D2T9DSmJBIxgDi71fY/KKtA1cZoxMF88Cb30Mz7Jsw7RolfiLJfiQ7FsnD7GkjW+1pG01dCZw6hzdi80k5uz9nTcyClFFytIh3LKR5ol5sA32dIx+V4YOfchPDWg7NuhaHpnzlKjEQHFfdDawb3yPakvZdjRkeTmC976p+VRlFu3K2NfOqw6uaY2x/Z2+TluzugM7uLsYbTndm2nDMaJW93THYog0ckoHAhZJKVKP8x9VCWEsj5/G0abjWndvcW0GuDESnmJ2nAEcyuhJWX17vhsEOQRznb8xgeS6vrOn+z7rS2nntrMPQA1AayhoRB46Eip5+AqTfcyFV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZJa+2ZHe/bghRJVKi0q6/ZSTodPl/2sDYtzBgiFekI=;
 b=d4b+1QUVzZOLi2LqllL0SLkdia1rXxg1AX1nkiTCR/gBaFiVkGoYYsqI54KITMQRoksfKJ7rcskezk8COEWKVbTC/eRnv1tMZvmQof6p90uOV4IF/jJinOwS/rLzDmpPPMv2OFA4EuPqiPHVBNQZCP7wgZc7CXUhy/pB4BHOejEl2Mub5jGauSa9fdVGY41z5bkTp30BgGziQ85OwIhHy/7RJgxtlZ+yZ9MdNG4Kvehy/26E0WSSn20rNQHYLc/cxjvdqhy/+uNImRipJhz75shCpW6CejQcEVA1+7i4E193o0rQSM9rwH+3gXqfGomHueyX3IzD1cmDwUX1i3XzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZJa+2ZHe/bghRJVKi0q6/ZSTodPl/2sDYtzBgiFekI=;
 b=e2LgS3HKyAQGUDLpNELZpZBSrElA3cpqzrBeGWKaPvYfr9BbkLSQf0l/voA6btvQbJeb2fizjOzVAncDM+uNq5SqP9iyn8B0NafrivR3MyKjDygvEY3OS9/0jHLXdvkdDdiGQaI1fmUl/aiQGwND3FyXjN+S/PtIu6SGVN9ujrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:52 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:52 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 12/15] serial: 8250: allow low-level drivers to override break control
Date: Mon,  4 May 2026 16:48:57 +0800
Message-ID: <20260504084900.22380-13-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: c812adf2-800e-4bb0-a6e2-08dea9ba3f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	znAsNtNkyaDT+oh3xMC388F2SrjZAMFpbTsNowAWM5uUKokHQaBxmCZ3ftC/pDzbQad4Sr0DZGuNa/xk06guUG2x7ElPVx0gducVOMLX0KZnk2eQXaMdYSx1LaMTq2zOBoV/H31xQbyAZp3U7+OCsyJSMxFm88UXnBvYFfBfNK7rhVcE8bm/weNPT3gwX+Hn8v5OQB2Bj5M7Wwh/CcvpU+3XzacTDvHZZgYhX5EJxTAjzant3O6P4PjtWpr1yqN6a4xFxX53Ket5o1SbXBYVwGaVbDZa+q81IlKZErymAG7GV1B5eItSjipbipaeSSDCgYNyUjTa5QYz69nKu8mnPCrUjQyvQNY3O7bemWnZshJd4Sz8PZx6lQzCLu43Azb1fU4u7kDn5I4lojNhWC1dO2W3Z3f0+Miqo4VSb6wnNk/MEA4rtbdZMCs0f75yQ2T8FeEiR/AFy1nuwTO8bIUWdGz5oFPgx6a/ScfkmFpTqQTyHAw6cePQQSFld0ve5TdVtl+HmcG9pey5W9wcRWERcEWvZsoN18Q2Mrx1tH4IKaDOvcitqmMWPu0DdUW0wQs/jx6LBeIEwlGTjq+loWcV8c7EceJnFGmYTGO6G7h2z9gg3lLYR92BPi027FpcaBwykJ+jORHJ4/ivkRJO7VVkUl/5jQl35TWw9ZVoeGjucdjnZrxazyHooh6AZqrHeA8SPhLie8fTC/PCrxKegzlLyXxi4j5PqTs8FKRl+GDst5tvG9RLhEt1EzJ7t4b0/uya
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZPd6T4Oae358cHKFxg56CSwiMgPBFHmE8LZ+ztxbMyvuTITjXVa81U+l4ftx?=
 =?us-ascii?Q?EJAvo01DzJuI0rWFDhzoZfL2Il0PUqdeEwNtX9XaeF+R0mO3g7ZhJsum3pMO?=
 =?us-ascii?Q?niWr0L6JrDnbsk7qE+o2N1ZHIWzUD+yLOqfToJbZHyKBGdjYM5kAOIBMz3I+?=
 =?us-ascii?Q?zo9Qn8bviJoZxFqILmQDSP5sUqAdR/+NhS8bBy5BNc6x00hJScjXTE7r2Y7l?=
 =?us-ascii?Q?SYwUTICJyFRoprMKFsBTIbeISUpncWXHAIEQAaEUAQRIaFTe4IEzNfWArjuv?=
 =?us-ascii?Q?jd3EZ6GnsindG7UuzyT/4smmY74hJ6dBSZ74qtBsPdkILamEAHDQ08u4NDh7?=
 =?us-ascii?Q?yN0mz1auxwXLp9K1H88PYnsz5iACweDqtSZFBrAG3mOj0NUpo6KmaUN9oqiF?=
 =?us-ascii?Q?fRH0oWzib5FqsNP4XK9WrC2DkhzsNSESohIgC4QfzkTXu6thpBsFhtRmOP8Z?=
 =?us-ascii?Q?659NYyiMjYsgVZ6FOqI37CkwNFCLIHrzyX0j6qg7Mx6cqssDSo+TdDnIsXYl?=
 =?us-ascii?Q?WPsDmv3lY4IrlKZA6ip6/sEuaB+jkXomQLtXXBHZtVjRVqGoGqcw4znpE+mA?=
 =?us-ascii?Q?VmQPij6/9DY/ah2qX+qJrNi+YZi0W08u4Ge4lysbNpB+1GF0Wm6KaaWJc+0m?=
 =?us-ascii?Q?UsvbcYJtS6HayO1hBKj8eaqFVKJg0BGVEnI+t3zTvKUAlTh/+PTNZix2Gy0H?=
 =?us-ascii?Q?eqfwntw7i4LFW7XgRfyMJxSDm8kKRBup4F2q+2OoBwcQlOdP1VuaCJ4vtRqu?=
 =?us-ascii?Q?1H4YbaRjcuUONhF07ITechB0Hr9TLzPujcwwoKzQQ8v7wVkHuXC8BFRkLwaa?=
 =?us-ascii?Q?nzYwfFgr72E/g22nJSP+4lVJosn4CTlV6nRkj/muvU/5+mSmIUzPyqYpjcE5?=
 =?us-ascii?Q?SCGqvy+u9X0mP00R1b9iMkiHbC65Uf/xypzTFnqPeO3jvUVH5Bk7BiA8IyGC?=
 =?us-ascii?Q?EgYknEjL0tqM4c9RZrtCJDhwNqvCTuG9/F1fJ5hFDL5r5UROlT6CcKPnwMZa?=
 =?us-ascii?Q?hrZgfhSdcUXRgC2PEL9DSdAGoU6NIxkovA72vxFoizkGwOeu3Q9FssMK9k5S?=
 =?us-ascii?Q?rwLhAm1XPg36SeI3JDidFDOh1gZ+frfbsgTs9jjgsU1hPeXrG5c2fuH7eD5u?=
 =?us-ascii?Q?KaNMUvNxTbpkBVYJZnHPTnOtBUZqHS5YMvcHwDCtHBXqSAuhkqbRe0ZxTEF4?=
 =?us-ascii?Q?j4fhCR6FaJ/P5W2Yk0jHSPssW4U+8TOJ7rUwClXyo2TaagUXo7Qt0YcgnaTM?=
 =?us-ascii?Q?j95bYETeomCCi4R14st2N6bbgm8R0wSPYZi9rXfz3woflJq7IMM3n0r+87ql?=
 =?us-ascii?Q?sYg1kc2x1vUbWE2TLUa85sYps9TcRsaMVpujwVJ9cQBukPZ4jdmY2jM0PfES?=
 =?us-ascii?Q?QotCdhoE5tT+m+D7+rF+YRPbWtaluDeHef4N8nyCn2Nf1IOFpYdT71EKj+KB?=
 =?us-ascii?Q?NQ2CA3QhTPTkpKcR8hnhM+eqFT83Ub/XyVGySMIPFAjqxeL/ILpg5hTy1Ch8?=
 =?us-ascii?Q?zLjSjoXpN2QRoL8EY9K38FYxRFhmf/FiPvqmRRFg4kl2lG6MQSGVuUM05pe9?=
 =?us-ascii?Q?4o9Pk5SiV0DFslODa64mcskpr//Ok5cuAzGtUN+h6wOqVZ6eacbzBkNypl8H?=
 =?us-ascii?Q?6Oye8nH1T6xQCg20aQx8QifvWINuyjte4xjZD0ZXaG7jIJ/aqjDnaS1TDgAa?=
 =?us-ascii?Q?m3FhiZLRO2+2183rpfARHXhNWzM0Zgmx7m6nZr9cmlPJ38igQKLJP5UGRxO7?=
 =?us-ascii?Q?wJIeTSwjFerukWJazU9jI50ImO280Nc=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c812adf2-800e-4bb0-a6e2-08dea9ba3f50
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:52.5490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuPcPw4z9s4dtGAfdQ8TOgeYifbW564x9A9zqIdQjF8U/U8HfLf0vQK4rQRz0XY7HK7MoH5mnljKtnV3Lo7dWt5rt2ixXpMNqCl7QcYLpCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

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
2.43.0

