Return-Path: <SRS0=PQGG=7S=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E1EC433DF
	for <linux-serial@archiver.kernel.org>; Fri,  5 Jun 2020 08:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A66207D3
	for <linux-serial@archiver.kernel.org>; Fri,  5 Jun 2020 08:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AXM67ltm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFEIu3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:50:29 -0400
Received: from mail-vi1eur05on2074.outbound.protection.outlook.com ([40.107.21.74]:6122
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbgFEIu2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Jun 2020 04:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWTPV86TnRKdCOm9Fvl3G4Xycwbe9wy9yFLWchD7oSBXKDwNEMW61ndiPH0qGrOtofqWKZwUTPc+c6LGqBNS1UWkxKoeUPJomNlCFITDjFWHInYdG68FvNPF+/YGvK+KR0ktuYgSK7nGyzmUKP2R94TS0AOjhG9VwkvEYxMLRL+gvV3+cm5eDEjUhVMv5BZx7JzyLfvW9TzrXz4qDbOopZTp7ViFjDMl/rnQc5jrmBlHtX1qsFzgwaP+GECkxTr6F0MvLKTHucLOj8u/wL/vQ1ymYWV2nf6DlrX5cOLVF4IVjpXk14p5hghZXZ90gz/lFXB33F/FNsLRcUhP12UBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8fp5ZdvrtIYEJvb2csQ42Bfhe1aPsJ9WJA0d1bgUXU=;
 b=DYg2EypUykrOCZWyV31vItQyaSgCjynkpNEByhYAd4xs3qOyE0nJkEZ1pvhE4Smh/Yyp8+FKsxhpQq44Ljq7kwFs2e9ARS0NHnMGj5L2sTKb1HNXYv7hQePcRl3/LoQBZcbJ5vkwZYXkMzwH9JacTD5cevDflhuMbw9TKJ39/iwyZAeEvn3j/Nof9mPXyeoeyQjgQjX47YFYxSVHtW8K14+49/z3Zi3SSLAqyE9I2gu7i4Z82epIMVniOYzXWh+OcAg+qM/mA3VHn8AcQDDyXQlxvb5ufPEXL154kD+yGiCIlAK9JTxhJHqXtqsyH7aE6WGDLbXonoETArxrWXOuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8fp5ZdvrtIYEJvb2csQ42Bfhe1aPsJ9WJA0d1bgUXU=;
 b=AXM67ltmsrCRYterWrl/L5haHtyeH5LbkxVPbciZMiYMWXBLzoRl2UZrtbE62Rk/y7FFCmlTvGbFpWAPKbwZSaGv9oaYZv9If54zdvvLycAF4CnwU2SCSFoPQHw/goEdIn/GWTI8g0I/YdYo+mradIPqJ2hZxYIlMYXc0ZkBLMk=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM6PR0402MB3445.eurprd04.prod.outlook.com
 (2603:10a6:209:7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 08:50:24 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::35f8:f020:9b47:9aa1%7]) with mapi id 15.20.3045.029; Fri, 5 Jun 2020
 08:50:24 +0000
From:   Fugang Duan <fugang.duan@nxp.com>
To:     gregkh@linuxfoundation.org, u.kleine-koenig@pengutronix.de
Cc:     linux-serial@vger.kernel.org, lukas@wunner.de, fugang.duan@nxp.com,
        jslaby@suse.com, s.hauer@pengutronix.de, kernel@pengutronix.de
Subject: [PATCH tty/serial 1/1] tty: serial: imx: enable imx serial console port as module
Date:   Fri,  5 Jun 2020 16:43:21 +0800
Message-Id: <20200605084321.26255-1-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:3:1::13) To AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611-OptiPlex-7040.ap.freescale.net (119.31.174.66) by SG2PR0401CA0003.apcprd04.prod.outlook.com (2603:1096:3:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 08:50:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5dd04a05-2fa3-414a-fd16-08d8092d7cb0
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3445:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB34456BB30140D5B3E8F2E959FF860@AM6PR0402MB3445.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIBfFZcWoHI8l5jLXLrbP37aud5XElL2Q8HVjP5d0hLdE1Yk/Xt+2FvWem6CSOlAnQN3aom5asPP0o2ilwWt2EYq5ohnmPHp8+DXZKMHQ2zVujJ0sQCxSGGuPZZgosWadbOjX/HpVZgUixqKEEIIepYAA+uJO2A0Wfdtz7EaBs3960WaHplSEAa9CHToIBr0BZ5k7ApZSO4rEwSH78b9gAPYezCiFdojaq6Z6C9Y2xl8x4HRhqg7Q5IFoMs/h+0EVEsJj9g1Lu0OUs3n7lJ48H96s/oOoOLoruTyYOE/60Hd/BYC/QHhTpdO8qUly8aC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(6486002)(36756003)(16526019)(478600001)(66556008)(2906002)(186003)(66946007)(6512007)(44832011)(66476007)(83380400001)(4326008)(86362001)(956004)(6506007)(2616005)(8936002)(26005)(1076003)(316002)(5660300002)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dGtMP2wQKgnBGAHiVWIUbf6W0+dOdYkG5gNz9GLKJyLESit7wIplU+KyTMcXO+6o4g3H5jCvg4zeP6lfd21Bzg5ipTK44rDLpDrqjdlsmN4rCRG83riwhckiHmmmm0ZxuJM96xZQtSkxU0XAqZSHS2iNl4rGq0DtHFYs3FHwdniYUll2jhQDtYtzl0KzYpYjbQhYtb+gxQIRjO5VSLki+mmdhSiLNmp13OT2HveDAYPgTNnbVrIWi9Od+F1DolrxefE4vKhoQ7dz/JcX9hI17aVxe6ZiwHtlci48QfBeJckhY1Ku29joPbQVpDtZObnTa1dsNJZXaYsCg251kQGEkmAxkXCKhEdruDUTLgIU6B68357y+i/J3mx0Zjz8CjVGcVPuGl0FdB4Jh/Hf+f2mfsxnwBcsPwj4siuwrKte1VdtoadCFY6B4gRIKdgE8rcRtSaak0ejwsiX8QdXlEbulZddYOlZaslwuyYbZYVLRHE=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd04a05-2fa3-414a-fd16-08d8092d7cb0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 08:50:24.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5cfQBbnsyzumwodb7M3kLmQQhz3NVJsp2J0qis2nwej8V+9qRvkSkcmAipKo38SnPtYp+k+5g+e4fGP/uGLLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3445
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

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/Kconfig        | 17 +++++++----
 drivers/tty/serial/Makefile       |  1 +
 drivers/tty/serial/imx.c          | 37 ++---------------------
 drivers/tty/serial/imx_earlycon.c | 50 +++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index adf9e80e7dc9..890cbf214561 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -502,20 +502,27 @@ config SERIAL_IMX
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
+	depends OF
+	select SERIAL_EARLYCON if OF
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
index f4d68109bc8b..c8402ee2a78e 100644
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
@@ -1913,7 +1913,7 @@ static const struct uart_ops imx_uart_pops = {
 
 static struct imx_port *imx_uart_ports[UART_NR];
 
-#ifdef CONFIG_SERIAL_IMX_CONSOLE
+#if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
 static void imx_uart_console_putchar(struct uart_port *port, int ch)
 {
 	struct imx_port *sport = (struct imx_port *)port;
@@ -2110,39 +2110,6 @@ static struct console imx_uart_console = {
 
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

