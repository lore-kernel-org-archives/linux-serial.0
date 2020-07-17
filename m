Return-Path: <SRS0=hg1Z=A4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DBFC433E4
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 08:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10D92071A
	for <linux-serial@archiver.kernel.org>; Fri, 17 Jul 2020 08:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="i9oGE/r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgGQI0n (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:26:43 -0400
Received: from mail-eopbgr30056.outbound.protection.outlook.com ([40.107.3.56]:13932
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgGQI0m (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Jul 2020 04:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxXMidnFHiAlJX4DDbtmH45rIQbHrvxnU0414Y9Yzip07V3G+PEMY66tHswCElQxT4ZtbYM2DFC+6xlMaICRA8PS9SjzIhvzDjEquRyfZ32nkCEzmGs0u/Gs5r/71ePuQMjPl+Qn4OEevN3ONJxEt00AHCqkdYECGQwfZWRtqpufP+KZKmqkoMi9Innjq5qqmlffC/NIN/WU52CGE4uBwsTfw+ej2U2j5lJD01f7X5pbFLXdlJbf4D/NxqzrkA9b11giVpCs6mbLq7VSrppH4FuYaAZHazJOyXTGQLeFMkKwKCywniPj1L9AcbwtQl1fr5OQQrlUL7F6BnVdcVc8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEGmNSHE1GLEW3PWLTmEcRU6ZnUWEpyaiUPzdMUwGzo=;
 b=UEj9GL1RaEMnWcgtfuahQgBMuU4LsiCahPd0Ycizla+n3kOde3KdUrplBkg2NoCkV1HObhmHU0+qqnQWGon8vzfODEjOPZ9nsGg8bslGqgu0RwCo6zxHkp+SlTZpGipCznBFEd2jrmkKJdSXaITI5YLBEeBNm0HUNL2StoA6RUc6ZTUdNIVLp49vIjFJpFQVeMIUM0TDfQ4KZah74XlskPFcVxFEho0JtUpS/IDXdTt/nWwkgDlYBEP8WKV9gisxL0P3Xn+FFEHbTTt4+M5lkOt/AC1BOj9ns8aWfAUFyyOwBi36UsB8iKEcKcJdatt3S1gW+ZoOIbK1RI8iz9srlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEGmNSHE1GLEW3PWLTmEcRU6ZnUWEpyaiUPzdMUwGzo=;
 b=i9oGE/r1ffQc5JCOwkBe8IJzSjxa4BIgozvKx9lCUDn1lJ9Xbvw9wYsj8jBzgoBFu3ImAVfBGGZvZAN2mHTNG/vOceVogzA+adDLssv29R6CfNxVjMT38EntEER4W5sOZ0tujul9AXEf3EbA0Xz3jJkzLyeneWHN9bBErySwKW4=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR04MB6101.eurprd04.prod.outlook.com
 (2603:10a6:20b:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 08:26:38 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3174.028; Fri, 17 Jul 2020
 08:26:38 +0000
From:   Fugang Duan <fugang.duan@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, lukas@wunner.de,
        s.hauer@pengutronix.de, kernel@pengutronix.de, fugang.duan@nxp.com,
        jslaby@suse.com
Subject: [PATCH tty/serial v2 1/1] tty: serial: imx: enable imx serial console port as module
Date:   Fri, 17 Jul 2020 16:18:27 +0800
Message-Id: <20200717081827.3417-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13)
 To AM6PR0402MB3607.eurprd04.prod.outlook.com (2603:10a6:209:12::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611-OptiPlex-7040.ap.freescale.net (119.31.174.67) by SG2PR04CA0151.apcprd04.prod.outlook.com (2603:1096:4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Fri, 17 Jul 2020 08:26:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9fab16d8-c8d4-491d-eebe-08d82a2b1fff
X-MS-TrafficTypeDiagnostic: AM6PR04MB6101:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6101105D7F3047DA15795A18FF7C0@AM6PR04MB6101.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sksdEWixEz2EEkFb7Id77pWymyhshqBedMJ8gd7PT2pL3WqnrVARAOpoU7k0piztWMH7NmGvURFS4aCz9C0TicWw7E58hRPAaVPxk1RjPLDNFecHYebbplxkxCJC4TYeCGu2uXS1mYMAPB7HHFNglxtpJqy91BKE8L7Ahj7ybnoOTpRYosnWwXfRc7yA+cZ7dCwXSPMPWQBD2OhJ3TWzkjR+MG+C7IlLDOtN5uIHXf5nv4J3ylrnP/FcH0ECFOLLUJOODAkd+6U/STtyOdZEEN3fCqpmhR8JGY51CONKIGTy5uts09wcsuypt1nPay1N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(8936002)(6506007)(2906002)(1076003)(478600001)(316002)(8676002)(6486002)(186003)(16526019)(26005)(5660300002)(6916009)(52116002)(6512007)(956004)(44832011)(4326008)(6666004)(86362001)(2616005)(83380400001)(66556008)(66946007)(66476007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +vuoKcK7+WBZF/2ZMMGxfo/3BIPuKkB2FOKreNQA/C0mHI/j/kTuPY+DlUeXLNisgWnPrFK8M0Uhbzo8w/lCU5AiOWxbAR7097lTGuFe2OJooEYP5KONjArSmHTJ9KsTNq/mR1IWkibOubw34y22x2og0QbRnWqB9Bt3B3cuytzQB1XiQYePHHcaYh3bMtZYyrn/kN4MAKb+YkuhBMJynKjeiwJQQp42fIsbSC6RTsxTXVMnVxbaWdFFBxWxtzZOb1Znz6i+/XrFfcfjm9YkI5OQ6KVCzHrUX/qLpmqE6k9NprBVE5r1yAYiZpU2DF5TkMTIhKHUQBcbcqQoV4aSYcv9CRZGY80TVXGOlfbObQElpOJZAHepb6rFNM5v2faMDkrbPEYOFC2k9Ju28yoHrn0R05HvSbI/Wn4TAVnGrrUhf6eyzYzUAwnOmGvui24lBgDsCaFCAgPOGKq4p3sZYKkP5B8k/Omejo9oRq7aUoc=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fab16d8-c8d4-491d-eebe-08d82a2b1fff
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 08:26:38.5829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxCLjBqiahDDYOtQxjXBQDLgXqfhTy+73AyHSywdJyqVe9q7get3dQ1dTpnjECx8jRBhros0mFbJq2WLh43BSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

GKI kernel requires drivers built as modules including
console driver, so add the support that imx serial console
driver can be built as module.

The changes of the patch:
- imx console driver can be built as module.
- move out earlycon code to separated driver like imx_earlycon.c,
  and imx earlycon driver only support build-in.

v2:
 - fix kbuild error

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/Kconfig        | 18 +++++++----
 drivers/tty/serial/Makefile       |  1 +
 drivers/tty/serial/imx.c          | 37 ++---------------------
 drivers/tty/serial/imx_earlycon.c | 50 +++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 780908d43557..dabd06ca9b66 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -502,20 +502,28 @@ config SERIAL_IMX
 	  can enable its onboard serial port by enabling this option.
 
 config SERIAL_IMX_CONSOLE
-	bool "Console on IMX serial port"
-	depends on SERIAL_IMX=y
+	tristate "Console on IMX serial port"
+	depends on SERIAL_IMX
 	select SERIAL_CORE_CONSOLE
-	select SERIAL_EARLYCON if OF
 	help
 	  If you have enabled the serial port on the Freescale IMX
-	  CPU you can make it the console by answering Y to this option.
+	  CPU you can make it the console by answering Y/M to this option.
 
-	  Even if you say Y here, the currently visible virtual console
+	  Even if you say Y/M here, the currently visible virtual console
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
 	  "console=ttymxc0". (Try "man bootparam" or see the documentation of
 	  your bootloader about how to pass options to the kernel at boot time.)
 
+config SERIAL_IMX_EARLYCON
+	bool "Earlycon on IMX serial port"
+	depends on OF
+	select SERIAL_EARLYCON
+	default y
+	help
+	  If you have enabled the earlycon on the Freescale IMX
+	  CPU you can make it the earlycon by answering Y to this option.
+
 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
 	depends on HAS_IOMEM
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d056ee6cca33..caf167f0c10a 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_SERIAL_ZS) += zs.o
 obj-$(CONFIG_SERIAL_SH_SCI) += sh-sci.o
 obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
 obj-$(CONFIG_SERIAL_IMX) += imx.o
+obj-$(CONFIG_SERIAL_IMX_EARLYCON) += imx_earlycon.o
 obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
 obj-$(CONFIG_SERIAL_ICOM) += icom.o
 obj-$(CONFIG_SERIAL_MESON) += meson_uart.o
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1265e8d86d8a..6814485cf255 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -361,7 +361,7 @@ static inline int imx_uart_is_imx6q(struct imx_port *sport)
 /*
  * Save and restore functions for UCR1, UCR2 and UCR3 registers
  */
-#if defined(CONFIG_SERIAL_IMX_CONSOLE)
+#if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_ucrs_save(struct imx_port *sport,
 			       struct imx_port_ucrs *ucr)
 {
@@ -1915,7 +1915,7 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
-#ifdef CONFIG_SERIAL_IMX_CONSOLE
+#if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, int ch)
 {
 	struct imx_port *sport = (struct imx_port *)port;
@@ -2112,39 +2112,6 @@ static struct console imx_uart_console = {
 
 #define IMX_CONSOLE	&imx_uart_console
 
-#ifdef CONFIG_OF
-static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
-{
-	struct imx_port *sport = (struct imx_port *)port;
-
-	while (imx_uart_readl(sport, IMX21_UTS) & UTS_TXFULL)
-		cpu_relax();
-
-	imx_uart_writel(sport, ch, URTX0);
-}
-
-static void imx_uart_console_early_write(struct console *con, const char *s,
-					 unsigned count)
-{
-	struct earlycon_device *dev = con->data;
-
-	uart_console_write(&dev->port, s, count, imx_uart_console_early_putchar);
-}
-
-static int __init
-imx_console_early_setup(struct earlycon_device *dev, const char *opt)
-{
-	if (!dev->port.membase)
-		return -ENODEV;
-
-	dev->con->write = imx_uart_console_early_write;
-
-	return 0;
-}
-OF_EARLYCON_DECLARE(ec_imx6q, "fsl,imx6q-uart", imx_console_early_setup);
-OF_EARLYCON_DECLARE(ec_imx21, "fsl,imx21-uart", imx_console_early_setup);
-#endif
-
 #else
 #define IMX_CONSOLE	NULL
 #endif
diff --git a/drivers/tty/serial/imx_earlycon.c b/drivers/tty/serial/imx_earlycon.c
new file mode 100644
index 000000000000..795606e1a22f
--- /dev/null
+++ b/drivers/tty/serial/imx_earlycon.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ */
+
+#include <linux/module.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <linux/serial.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/io.h>
+
+#define URTX0 0x40 /* Transmitter Register */
+#define UTS_TXFULL (1<<4) /* TxFIFO full */
+#define IMX21_UTS 0xb4 /* UART Test Register on all other i.mx*/
+
+static void imx_uart_console_early_putchar(struct uart_port *port, int ch)
+{
+	while (readl_relaxed(port->membase + IMX21_UTS) & UTS_TXFULL)
+		cpu_relax();
+
+	writel_relaxed(ch, port->membase + URTX0);
+}
+
+static void imx_uart_console_early_write(struct console *con, const char *s,
+					 unsigned count)
+{
+	struct earlycon_device *dev = con->data;
+
+	uart_console_write(&dev->port, s, count, imx_uart_console_early_putchar);
+}
+
+static int __init
+imx_console_early_setup(struct earlycon_device *dev, const char *opt)
+{
+	if (!dev->port.membase)
+		return -ENODEV;
+
+	dev->con->write = imx_uart_console_early_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(ec_imx6q, "fsl,imx6q-uart", imx_console_early_setup);
+OF_EARLYCON_DECLARE(ec_imx21, "fsl,imx21-uart", imx_console_early_setup);
+
+MODULE_AUTHOR("NXP");
+MODULE_DESCRIPTION("IMX earlycon driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

