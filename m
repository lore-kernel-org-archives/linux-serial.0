Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2091.outbound.protection.outlook.com [40.107.215.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD11192B82;
	Fri,  7 Jun 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760641; cv=fail; b=IvFg48AS/k/0QeVIoZJLOgDf5ID7UJlkmCkATaTtvN6f1wDUXDaHjZZ0Y4KK938d8q/1pvOfwGQal2IimB7QWOpPQj+ol4bgLAJ46oguaIO1ZiZ89T19KbtKQHROolxcdJZfCBJvJYINKgktXPmpJWp9sUQjKW7Dh9UP18h84Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760641; c=relaxed/simple;
	bh=He8PxhPNMnRVM26WTwBYxZsZhtki4GoJfVYZbKLjGl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBl7WAlJjLIFhEc1XD5yHtmI4HnSEtGcNF3wWLn0tF0eZE/vdWoDMyqZXZgKnCuDu0jjjlBKbDFf6z4Zf9dy5j9RqBx2KB/PhaasZydooYBr69lYQ5DlZLZbO8sGpOrCWNfAFP73Z7z7bzhutXJlW87yQJf2Bbhu3Krz7DKz4Fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=fyOlEJcY; arc=fail smtp.client-ip=40.107.215.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="fyOlEJcY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZ1blB3P9seaDyRWwS2zbNQe9S+hTDD0bkw0DS9Tz3M9OWyrERYWEQl+j0mtB0euh8lTE7pSAQ26TZJ+/j0yWm5Pmz/UtIXPEZY5L7HJcIv3KMyS+cEhrz/0+JL+/hOecPoTQOBoqdeKQGSaMVA7aW8cG607r3hhVxwY6XEjUoNlTqOwzPJ+N9lC2/tzAaDq6ftKTmL95dmraXgG+2DkOTy335U7hd8V7J26CO1cXyadplHLElthlg7kKfGksPx/srrz8Uo0vk+dBZn36QJGLZAt+nAnePJHC5ubD/14Rx8s6vShgXYJOYX/BXhJJkirtxIsaNr1m9YxM895g8ReEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgsLtGV5uXUkGOD/sXOjxWftxGWiqyiIiRFMni8DkmM=;
 b=IHbvfa6/bqu2Q0rgn12o0gDpzrf8qoZzmHtIFEmO2Ig7F12dwSNWuh/9unIxk9+37vnAsMkh5ZtVeqbIcoRuDX4kBsavbwyR8fGGK9JtbheUMC7JlWzvS4rxKmjCppjWLdERkPBRIZKg9hCrFdOxiGdSn10sX7YwPrBnF4hxJUUXnYaKYqkPmqYafTQjj5Lp2njteXhwltLeb9OEX6ubf02g1OBVl/5kWGw/9Z3aPMmKy/oyoIWmXSTQ9BQZCLhTzg+4OujomFO32csYTob9Tg6xfRWQ4SVWWlKTY2A285A71Wfhnwxn8pLCxRrp+sLe7FEgMkMk2a3NDKvcciH5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgsLtGV5uXUkGOD/sXOjxWftxGWiqyiIiRFMni8DkmM=;
 b=fyOlEJcYaPeGWl+dU+2X8pyuYYkmTQPeQ4e9NTS1DZH7jLIOIBAUxmUsmP/LHnTUtvzpIlmTYY9dgP5wLrSBO2pdan9RfdmI9RAzUtxjjTWFYMhGEPzIPwawIik8FGjgCygI9t7AtTmi5qM9/fqeocSox0NzQLAH0XXRXiip7yc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB5588.apcprd01.prod.exchangelabs.com
 (2603:1096:101:12f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 11:43:50 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 11:43:50 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH 6/6] tty: serial: 8250: Add support for MUEX50 UART
Date: Fri,  7 Jun 2024 19:43:36 +0800
Message-Id: <20240607114336.4496-7-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::12) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB5588:EE_
X-MS-Office365-Filtering-Correlation-Id: 255eb7ff-e358-42a4-23eb-08dc86e71987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?syh8tNA7n9boNQzNowkntTE/s+whadkpP3FRvjr1w2+NaoI9uMmLG/5yaE+8?=
 =?us-ascii?Q?/uM93Falo1uqLyaUuOQlWyffH82SLqDKsaA3xtWthYuwsVidw6hsqWoPoe9s?=
 =?us-ascii?Q?MSaTYR41x7purV2gH9f8fEG9Kmbbx5aZx/8O/QZ3REN5SCkJ5rOD2WnxLhFq?=
 =?us-ascii?Q?KD29cUhCx7uzrgb3Hw77qj5fN2/VUMa4jTbQqpNxr3FojkbB/V2xGkwYI6Kf?=
 =?us-ascii?Q?aPL/I7St60kCeHPaahC+9h8RWFh8f4reTqFinjh6Eb3Jxs2fUjJtlA7RyEX0?=
 =?us-ascii?Q?5F1YgWzBi/EgUCb1TF8eUn6lOTrHvjdOjYHgRzJUb4Ya0T4smkC0ntpqHSFP?=
 =?us-ascii?Q?GEKWKE8+qlAKTloOEeMA1oTqQLmLvrIUhfh4nnYbCIKZ9bl4UNAgZrV5AJqj?=
 =?us-ascii?Q?jLBK49rzCU36i2zYZ4uncfNIib1vh4dgAVi8mRaSQENFkpf0uSep2WQgdLzm?=
 =?us-ascii?Q?uHp5LR4t56Mo27oVx0MR7l5LyD3b1cBrVDvPtbKJggWmoGwn/v+lOimtnUtK?=
 =?us-ascii?Q?3ttkae0syXExC37lTXJCl7PG+Z4Be/aR+PJZRRc8oWKiE4Nq2YAsFBOJMM6D?=
 =?us-ascii?Q?Gx/odDAfjetSen2sSyf2ftWPHtzQT7wNfKvXh65R84keIX+zMvi+xz66X/Yo?=
 =?us-ascii?Q?mXFafugTaAWuHKjzfQa41yf86ZYFbGD2201tE4COJCcODy6lFvaHdRQokaU4?=
 =?us-ascii?Q?SMXrkzB+6SIjjL9UMUBxcwfYjkRqMvdu8udm7SBB/l2DkA44H/9GoQk9CuhI?=
 =?us-ascii?Q?BS9UYzEA4Oq3sLnVa03bQ8bbT1jbYBsUPXhbG9hmGDSGlzVYxgRnnf12G2Ft?=
 =?us-ascii?Q?6czrhAf/do/dGUGQryn7nCXf4Nro7MVPl9gUDRavqS8TRFyNcmF6Hu88Z52J?=
 =?us-ascii?Q?GQmEcFmvMEMkDvC+MzPR6/Osz1/HjjKp6MpI7Sz50wMffeE0p9BoNse4PkJr?=
 =?us-ascii?Q?2kWcGOzjDEqG9TQqsZl/WPCnL8qG4JtwZENbqxruBzsLvEsV8bHv0LlhhU/r?=
 =?us-ascii?Q?NjjwfGYdA7A3V6THTJjaelLslqElO4i7JU64/zCALMfCfBdSyGDXm9EEuSkP?=
 =?us-ascii?Q?CcbWD4LibR+cRNB0+9UBmI64AHbtuWWnsKjHq65UuZIZvM05tr3fDNef/+ka?=
 =?us-ascii?Q?BLICgEgIoxQOJITR9rRIn+vX/FsLZRn+gM02djeMLlK8m7SgXqfN9cTc6gCr?=
 =?us-ascii?Q?uJ91QlIga09XrSFvGTm3qOKusvRxsSdplKzJCkOeD5sR+ocaFEQ4rtlJoNuZ?=
 =?us-ascii?Q?Eqi4H3qCGzzXtFmvce2ISZGnQrUzUxvYJxdDB5ZU5KQMY21P3Wwp4raBR9Sc?=
 =?us-ascii?Q?80sk5dsNwO9y1q+4ax9hwvB/MQPJtccKQH/odSXRhiluPUAUznaITQJ5H6/z?=
 =?us-ascii?Q?PSrwjDQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g2fyiWuvYNWMJWNI3CjnP7oKSEBRuiKY4EbWVvOeHQJIqB9QQbP5aUv2Qy2c?=
 =?us-ascii?Q?ZoHudHzYPjDkD1+tRTKn8gIBXzIl/xwrAx5oAHPnXdbVReh7XCmbmu5S67aP?=
 =?us-ascii?Q?yLtRDUXlOn6rcfIO/3uBDeSAu8b3FUED3RGkFUDCN1GUJBuYmFM5hfe8zjCF?=
 =?us-ascii?Q?/jX6TumgGDyhHuBsMKrQ9rwZGOTbH8gVjTKohEQ+JuAVmp2slq8jN+jGYfRE?=
 =?us-ascii?Q?mxPAixC8ox1q+UlIQc2JFRZikYjlw2jRItsWDU3rTuF3TxaxRGLVYH7j5z2s?=
 =?us-ascii?Q?0J5Q6oPuAEmZetfwCj0zffMO9n0mUU7mx3UcsOj0T6j4PiEoZYQzdUflCpwp?=
 =?us-ascii?Q?1pGVisGzQHiz8FkCGHpHuYmATmETJlp9qwW1CE7j9/B5u06/KiRxLpp5C1qS?=
 =?us-ascii?Q?xoRZWz5FXuTuPel35KXegsOjkMorkwisFcZPXyE9X2sSDtx0WnbgeCmzJOk2?=
 =?us-ascii?Q?lRs7JR6np3vyp1PiOZKWLLHCnodWOXjgS4YBPRP4+rkCgvrty5e+8OEmYWqa?=
 =?us-ascii?Q?Uu06NRkFTiS3imKEeG+P/wL3zWWf1MBqMiJKcvALZjOS7DXXBfpdmn5K96nZ?=
 =?us-ascii?Q?THAfvfXCvobex/mQin4jDFfz9nS/AatKgEW2KkcEOVNJXUx4lIffv8Av+FLl?=
 =?us-ascii?Q?Zpk8M4y/t4KoFvjx/Vp4quA/2jxHelt9kEyDOrMm99gsX2DwWFSq9Nz4DHTK?=
 =?us-ascii?Q?CDMiPQyg9r7WR1bofnYGU2hxfft7lSlw06uT6OyhA55Z8dQS1PmbLnVEfYRN?=
 =?us-ascii?Q?3yMr97UNEb6AWfBDPZUtCg+PtWnMkrNSYVrZzQs99l7nV9zJiq6dba3K+g2i?=
 =?us-ascii?Q?kRJSZ1LQsrqX3dAH2IHZSWErjtmxbfj/KX4tNxzruPN5ZXLXgoqmcPeP2ojb?=
 =?us-ascii?Q?DgeUzfYVzJPYhJpMH8MjsejDgBqtN4HPpRBSiWmxP/F9xQ1avH3xiIyLAP3Q?=
 =?us-ascii?Q?wJOKV9uazSlNnW162Q5vC2Qm4GfAkKfIfqEMB5d9obGR/BBzkzhPqjGYFfjN?=
 =?us-ascii?Q?ASCx9I4bWvBq5FkQ0lrqHAl+8AiAYNl2R6SdbP2sU3Y8qUjYwI6IGoAthpnG?=
 =?us-ascii?Q?SmfIJEJrMezxil57pFS2h4wAf7/7QqwHuWBSTqCrmcA2G+eEyZ9jY5kxUqlN?=
 =?us-ascii?Q?D4KGDPpuzEoav+EwjnUu2b+u97dMMxkdMuLsvK8o0NorUoG4Zyeig0S7qnDt?=
 =?us-ascii?Q?5e+9XK/SxaaShcpfxEm5HapHr3L93Z6OpRWTVDFjenPmJXwkvybuN13Nu/Ls?=
 =?us-ascii?Q?Du3ZEsjz3dfeYvhO88v5JXJFRx8nkkT8mr/DXmmm/VSKIcChg93JgChe9FqU?=
 =?us-ascii?Q?l98siZbaC5kqePcAW37bhWmS1hmc/zofA5D7MKJW1NcaSP/Dab/SeQMy9XeR?=
 =?us-ascii?Q?uC3z5PQoXmxXU0kD4RP+zAvh6we1H82nnEPlkEGnxvSzmMn/WdElfRJQatNm?=
 =?us-ascii?Q?TRyu8/x4ct9esn1JTnoi+VAUy0s/wJphn/6EZo+Md13g9pyF5f5gpRgFIf8a?=
 =?us-ascii?Q?pYFub+aOgYhQsd6TuxByezBABjEMLKUuNI5SLD9D7DE5eHTxDntFXCO9v2H2?=
 =?us-ascii?Q?+0DydCbuRva4X9eNm9RBMvCXxm5EgHaAYdBgy5Ob7wtRjD61zVCbcNHm2IV4?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255eb7ff-e358-42a4-23eb-08dc86e71987
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 11:43:50.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIy7zDjq+SMVrAz23oO2HamzOosnhm1xYvE9TvKExHji3LCQ7b3yVlmSzW3z32QzVF+n/TG+INW9clpA1TFjyXlPPiNo5sfvmY+kzl2m0EQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB5588

The MUEX50 UART does not directly match to PORT_16550A or other generic
UART configurations.

This patch adds an UART configuration to capture the hardware
capabilities of MUEX50 UART and apply to Moxa PCI serial boards.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c  | 3 +++
 drivers/tty/serial/8250/8250_port.c | 8 ++++++++
 include/uapi/linux/serial_core.h    | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index e2fcddec9ab5..3ccbb406f505 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2159,6 +2159,9 @@ pci_moxa_setup(struct serial_private *priv,
 	unsigned int bar = FL_GET_BASE(board->flags);
 	int offset;
 
+	port->port.flags |= UPF_FIXED_TYPE;
+	port->port.type = PORT_MUEX50;
+
 	if (pci_moxa_is_pcie(dev->device) || pci_moxa_is_mini_pcie(dev->device)) {
 		if (pci_moxa_supported_rs(dev) & MOXA_SUPP_RS485) {
 			port->port.rs485_config = pci_moxa_rs485_config;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 893bc493f662..c3de350e9a30 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -319,6 +319,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_MUEX50] = {
+		.name		= "Moxa PCIe UART",
+		.fifo_size	= 128,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10,
+		.rxtrig_bytes	= {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 9c007a106330..5afeb6d99e7e 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -231,6 +231,9 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS	123
 
+/* Moxa PCIe UART */
+#define PORT_MUEX50	124
+
 /* Generic type identifier for ports which type is not important to userspace. */
 #define PORT_GENERIC	(-1)
 
-- 
2.34.1

