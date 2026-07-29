Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F893A7597;
	Wed, 29 Jul 2026 06:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305206; cv=fail; b=Ku0BT+b+3OUnceuEo20aiBE+VblO2z/KXABMDSlCP+BpMIldRyn4zSf387RTPtY4aPfKegFXoMksOnP5Fa4v2+m1IpnkS/xzMfcQVuOkuCv9q50OvYb/MijWLoPbp4V0stOCGqJ1PPI5jghXqPMUc09ajUx5WkxRH4VxC5SA1gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305206; c=relaxed/simple;
	bh=cfa5NTAX+yNhhgyHNTOYq3ftRABGCUaZfPs+pTEGock=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrbBDCqcW+tSz3XgDVczWtlD0YY7QDKeAOqhQmmv89EJBbh5T3a3xIQiWG0bzYVDrqZtrXKxjxs/VIPTq582OshjiId1KN4kpZdgkbEItY9nZxpPhBoLN0QAOEyX2Q2yad1fFPwzi+90uYIGOOCDiNmUZi3fum6PJUKVpSvQP7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=DjL5EGJG; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="DjL5EGJG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBch8wTxLQDXWzakEGwR+oNvI/gdP+UWwNZABG0VihSoA/Hr4xpA/fGYgrRi6hPkx5BlVS60wILEtqIxuQjkUfMnFJnl3XCJcdaw/PElgLWycYybvVcZroVwSpgViTfsDPM5WJkvwCK08vrRoS5eKqY4t+gZwcba4phM+ivm1rUK6EGVhbGHTzt+cQqqi/yAtxD8TpWkmaYPxNNCrYVzh+TQ8xVU2XJxpfdbTB0pChJ+z3Ai/GvkFkoBjA/MGChgaSwuIWOds1pzrhdD1CA1+mFw+FkxHGQ0t2tDwN+cpJCbTI9RHj0XVjauv0FgsQy9fxlLP7nroCantCClEbycxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzcSVPU60A+L8vRGNzI8dSr/08hU9N2T154Cb/HCl6c=;
 b=RThs31OgXsIQGPl4V0nrSxD9Kj8B9is9MPRhqfOnmEwrhsDs87aWcmjwYB/VRLCWKK3GoJoGTq21QT1nRkBYKX+uwI79Fo5hEwhn9ujbRFJEgUnVC5tXBon5bAWP0GwrsYsCxdxahDm5s2jaV93qBz8c9ypSSGYWnKVo/cwdV3ZU+U/hMbNUvPCg4gkBre3xy4uJTOsyx8PVCi/zXcexzZFRmkBSKeXTfg2X8fZEt97Xy2juodx+3/A3e1LpRDSYmUC5BuScecKrLHhSzWErXj156mDSRRTHv/CM7ZG1yCt6A29ZrwZ/QMbDS5PfUh+GK3We0gAVRKyydiV4OlxG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzcSVPU60A+L8vRGNzI8dSr/08hU9N2T154Cb/HCl6c=;
 b=DjL5EGJGl2+jl+pyq8UpKucD9Pw0Rf8J5pyVNzoXibdrIpWf5Z9DuIlcaIPTtNKN9uYOyWVeYw/DljIE6Vv+mFpdZQw0wKhHoNq/+yJk3jwJUzj2K/plkqO2CcMbYMKnUBDxxU33HFBxAwkQnl6GxknnDWN8SErDi32UABg05bg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:31 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:31 +0000
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
Subject: [PATCH v4 10/14] serial: 8250: allow low-level drivers to override break control
Date: Wed, 29 Jul 2026 14:05:58 +0800
Message-ID: <20260729060602.492430-11-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55f5392f-5bb5-435b-f04f-08deed378944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	AjTOJdPGdeFDxLt1/81TqJ7xAPQO8J3nPYNiq6vifkrh/zG1eCwJRzPCCql/7UrYI30bZg8QsnWDQAeqhkCtL0Q2HfIJLBavW2kKfvobxPBX8PXFvfXiRRvrfLC6O31nIq8uDJHWjFOMhDcvzrVidCE/338bcygo0QtQMsU9xMG5iMWmiclQYl1TGUZd1Ncfp6Xn417IMssEv45xylZBMxWn1tmPT6z8fyuvMm5EL2eS4yW54PlZxA5MtmWEC++4XgjuWVep1AboEwPXHr4dN6ScARt6zwN/kvABuqVnicyS9HT5AJJxTWotZmgzTC6WXwSlF5xJFFNVnXMOma7Vl0lJFxa8YgTbCj/WYBJVal6LUKlY2o0pAvIcZDs8VzaHdXz4Ir6SCkBDQlTBcWOOtg0Cf72gmW8JwiXcNO1Yn1mrV+Rpz+x2DJLvQqYlUntwbS82T4Qt03NuNuTAu1xgkAnry8o5u09QN/rTK7xxhTdtqPeZ7FCBw8VuiBCKj13Us+eRhUuZT+fLM2C8j03P8hQ0EESIZ8TbPWJ745PV28z5Z/5ej9ckE6HxbVkMhc9SWwyPPeYlsc+xGM0MG4dK9vOmfI/KnTd7F2XmWO2Dn8O0KENre4fI4BFUX270Ts/lt/OuUNIVGR8Szq6IPilkbcoEbUhf0N+Y0nEzvy6KJXxh3FsEcpeet3/59Qj3XnOxJFrl97+P1X8QvgdWiUI02BussTh/6iJr1i3w8UbI7+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T1ei0PSnep6sH8Jm5cypcEU+ZwGfeSHVo/4HhEf+OiAUJXVX3M0DDP/Q1y0w?=
 =?us-ascii?Q?yGNFiWZHz63oPvPnrrFzJsZXBEeJyU8q27ATHJfjyxUF6y52MpS3I6Ua48zW?=
 =?us-ascii?Q?7kKak1uKB3gbsK7Ndhj1griVkFZJ4GZlBUmyRdkDttSpezLalC4U1utAdpse?=
 =?us-ascii?Q?A0OTFugkIPEJUXbQ+/y0X3KMxb80H/s4V0ixXlNmfasBNeLhzR1SoCJNF55r?=
 =?us-ascii?Q?8rwRGEsi9hOHz19GYBS1RYWzg5JDMcnoovW4HIGeXOdr0kLohHBlazYtCnpd?=
 =?us-ascii?Q?VpZOhadMpku3gdgd85iTziL1ouNJ604xww6BBxD84lf49loc78iArkF46wYe?=
 =?us-ascii?Q?Yh/r9tNq3I1U+9rFq2O9OhlwtSYWK8R727QmxDN5CTo0Fqjnz7eugsneobvl?=
 =?us-ascii?Q?TMLOgBsklIzLomr99Lhum0ABSHq9SXTAK4df19ISqKWh1BHwIoZLeag3W4TX?=
 =?us-ascii?Q?lGP4Ts1Vp3D0nMr2ryHk/0XWXI0RrbApd0Vji7te/MvQHfw5qxH8BvUztcj8?=
 =?us-ascii?Q?bAtCVsmGfkKKQc8qa5vmCOT1XCnRwR1L+tmSAi57Liw9ExnApNgJEFjpASZI?=
 =?us-ascii?Q?0u1l6UxSE/7+GGVJpEfqQWBciCV06hvuXtkBFUYOoTO2jOAswj8VtYPWkD4u?=
 =?us-ascii?Q?w8g9CaD6WDWzmVAcpIwZ9Av41DwU9hdkzQrxJ9DwvIeawG8PFRowdt1kIhso?=
 =?us-ascii?Q?Wt7NUNWCh9ophkELtd5JhF3NG7va83RcyJ3dOulRjuvvgo3X43GM2h9dSpA3?=
 =?us-ascii?Q?qs5b5eMdX76JY8/RsssClOsQBchLD9Vergho4mCrHYksDhrLOrP/fuQtPpqf?=
 =?us-ascii?Q?kCwesbROmIm3e3Av9pEO+C+MFO0vO3tNgfL+vuYLD84b/7T3/+w8BZQCjwYT?=
 =?us-ascii?Q?yb0BhUFnJe58l1FFjS3f/T5aF1D5i81m60zEPZbs6sM9W0VYD2vHmzMbYvX1?=
 =?us-ascii?Q?lOM7hJSexoZojgOhVLds2cIWJ5fKPOJMOsNxc7zv18UXmQyZEYHqdTgk4kac?=
 =?us-ascii?Q?laWwKdi046ZN1LzqAXxuF9S90S5iqiEzvw6KNG4ImsQJiAm97KiSu3mBYmQm?=
 =?us-ascii?Q?leg4Fzj6dwsJWYCwlwC6quZWQbehLKbmZdCSY23P5pc9BDuxCyE7TkaPWCPa?=
 =?us-ascii?Q?XTLf21gBLcM9t7Argr7JiINf0U9x32Ie/fmJkCL4Z37sxDhkCHsuaxDLO2KR?=
 =?us-ascii?Q?QszoS3IVTi8UdZjmBqItDvqmYHhai9QAgJNvvSdfRoJgdGt59WOzNhMfNYCZ?=
 =?us-ascii?Q?zKHu8E0gCyUYCSCjjicQzpbR28kEjzwGu3lkjMPyn4N73oi6KVajwtUF8qAW?=
 =?us-ascii?Q?GIFFBliycLrCpuE2Q+Nn+e/+l5OIhFNAJHbfgbjg5sfxanTWHZmtgazG1ila?=
 =?us-ascii?Q?Ua4mMSLXDBOXG74qA1NnjdOU3vArs5R3JQ3rkH4BCPHtlOqpXgFFgCZb1tZN?=
 =?us-ascii?Q?dJmzvylotqQtSOCB7Gi0lfXJZItl6U5db8iTo3vwwQK9wIogdlFCumIg2gBh?=
 =?us-ascii?Q?JlWcN/O/bF0RT5lgB6CotiDNR8W6RCISNdnPvrhZBu3G8glN4GBDg9/vzKlU?=
 =?us-ascii?Q?wqSrS0jSLcYvv/W5WHu2b7WzPKWcP/8aynuUxoTrZL+B9bztixtNeI61OOMZ?=
 =?us-ascii?Q?NSjo0S3rnh/3Dw6MgprOyUPlP1zT6NQg2XZeKXvngYMc3WBAzT2M3IDkh4bN?=
 =?us-ascii?Q?T3QF/XxJcBmv3/F9DTt/REdWz5vO3Y4LvnB1CXz+IMEkiqoBpx6zRJ+g+jYu?=
 =?us-ascii?Q?bYFnUaPl+HyK8pLmJQ0GtMkmHblv7pU=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f5392f-5bb5-435b-f04f-08deed378944
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:31.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbkl+x8byaGsyuWAEeQ1pPJxMs/OTn8fphQlBl14eZC6m4akVULC610O8QJ5rczopS00hs9/bAzt7TQFDtIkkmW6qFOTqV8V9d1RTpPFUVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

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

