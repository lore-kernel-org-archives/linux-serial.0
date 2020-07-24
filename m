Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E834C433DF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC7A02073E
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVQIvDBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgGXHQX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:16:23 -0400
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:3681
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgGXHQX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 03:16:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwbb1Z3GnbSdn3jtUhhb7M8oEq8D0Fclur0DU7ZYW39nah7HV8sWU9mUcKX9ZNARYYxn0mpwEDFHTXjLlum3vmYLdkAQ1zBWUd+X1+EmZcsdEzeIwbM/QI/bdLUCllEn3AGTPCK3sdr7rKt93H1dpBg79CBV+ztFfvXlf86Dm+G2eD3+xRywGeZsBYMIojxH4nJvjt8KlcYrt5t3w1AddPI//VsgFrScnUM/oVoIXsCjd+qneGvzMY7F940Rn0Z3Az99Gmy/Umkp4NBmAd+o6aK5/O5NohfmikzpUMHLF0yWfUx1I041GauSm2E1BRwg69UR74X9Jj4wLuXZYzVVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWzrAQv4DW7mAGLkJpuXNK0vP3MovF4mWJWirqf6Q8U=;
 b=VH2ktwhAQ1AoapZ6sm71Qw3PUXXSF5O0A2jlwvJFF4x4bUkewqfKMmiBs1PyEfTE5H7Ba6XmOnzZWFiMCPRM4xDQ7NdpG+T4tGm0DmbZ/1HY3NEd7HT/zXWO3frEOVaRKWJRNpOqkIwAmINx05V+WXyuZT/ggzRgCqyuijD5+BL0vEfnAT69LeZFTiIsXSOGVlGhTdSqZwX/DNf3wVPNpVebQhTIbJlv4P1m7zJz+ZlBoSz5LgwGX3o5X0Lmetr41pcogRfo9wztnQrbyDAk0IDvvTFfHUpsQ6ccPUVS/Vyao9yMa53YOPLh/G/tvPlxqF+J2eJUW3Og3uAt3g/zoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWzrAQv4DW7mAGLkJpuXNK0vP3MovF4mWJWirqf6Q8U=;
 b=PVQIvDBJPOKYSz3dpsHsV3tzz9XyGg7hp42fKq5l69CIxjl/m8PxXp3NmF07Wx1M+xZRda26txTllsfaoTvyJ+i0v21sAQ7k7LXfg1JM1p4v/MDDo+6OJmp4i6sduJub40nmkIP6QFr2rLOizMVXQy+VaP2f2N4FNRH7RCNbYbo=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM5PR0402MB2930.eurprd04.prod.outlook.com
 (2603:10a6:203:9a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 07:16:16 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3216.026; Fri, 24 Jul 2020
 07:16:16 +0000
From:   Fugang Duan <fugang.duan@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, lukas@wunner.de,
        s.hauer@pengutronix.de, kernel@pengutronix.de, fugang.duan@nxp.com,
        jslaby@suse.com
Subject: [PATCH tty/serial v3 1/2] tty: serial: imx: enable imx serial console port as module
Date:   Fri, 24 Jul 2020 15:08:14 +0800
Message-Id: <20200724070815.11445-2-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724070815.11445-1-fugang.duan@nxp.com>
References: <20200724070815.11445-1-fugang.duan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611-OptiPlex-7040.ap.freescale.net (119.31.174.67) by SG2PR03CA0108.apcprd03.prod.outlook.com (2603:1096:4:7c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Fri, 24 Jul 2020 07:16:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd6c82ce-c51a-4cdb-5953-08d82fa17425
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2930:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2930D3B31940B11943E48A41FF770@AM5PR0402MB2930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFWDxo1neATbij/jrujCpqkYKA8HSqkj1O19l2X2cynx7LRkXcd/nGRgX6OtxyHcZIQlKcceI0Zaf+rxqGibaxCr9n8hXrlO3Fwc87fkSxfwxbdWjgNpIIbOdruW5jNF6rVu/A/bK2EwxCU+XAfHp+meYWCaMyKj7m0Uc+RAHpeGHVR7IJ6fhI5FwLVm1H9hxRV7pNXErWiypSd27UmgnhUSuIS0gF7ki8o5ZcFn7VZ04kez2vPiOzBQwEx99lgX9FvJLSercaZnmWmvUzCSm3e4bZxKnCS+HM55XhPVlIpVYi5YpXTsV29taB9YQ7n6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(5660300002)(6916009)(4326008)(86362001)(6512007)(36756003)(6486002)(8676002)(8936002)(52116002)(44832011)(66946007)(2906002)(6506007)(956004)(186003)(83380400001)(66556008)(1076003)(316002)(478600001)(16526019)(26005)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wZWehQH20/dISlC89oBPJBOTmrOpVa9bwJPElhj6Xd6NVMvEA7o5FBRO+ZGNGm7uEKgb2jAjEH7jz21OKcAbqrUOpJN7Dl51MhX7jyZVfkkWnJL+Nss93zBZxGmEw5so5iUyGXdFlb6TVzHn0lssdV4pzOJkWAXx/ZtdmyIBRsk3Nq5tCqUaKkAT6cIN26/HHRP3XWNjKOD8XJa5lyreQryHCmDeDYm8K3uulKXIuUU+H7nqhM6phESdZG8XWvNrP8KVaex/mwomb/0zBWgCTeW1ISzsXdUb5l1UW0RIEyRxxW9Qsr2OH2/DBKpy2pnB0zJl7shcntaSFpTot6nwwg57WAMzfSmq0wD16A3aBjh2m80f7D3II278cFwUtA+XI3t3C0YW3UeZIkO6siTZ2KcPwAhzjHmG+6ZoOQlDld2TGs668dVbhURV8KVPDbkEsSfzqpP3FXFWFDxX1ez+rIUenDeBXNIkC2wQM50hlPCYQE+TuZ2p3XmGCfEfh/JC
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6c82ce-c51a-4cdb-5953-08d82fa17425
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:16:16.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNRW8idc3GOdLFc5DYNTy6uyNK/4L+49AHHWtJBUivaQEEpE3dvvAINQQufCiU/WG63SvfIZ0ZGVkIp5h9VyHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2930
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add support for building i.MX serial driver as module.

The changes of the patch:
- imx console driver can be built as module.
- move out earlycon code to separated driver like imx_earlycon.c,
  and imx earlycon driver only support build-in.

---
ChangeLog:
v2->v3:
* split imx serial and earlycon driver into two patches.
* remove "GKI" string as it isn't relevant here.
v1->v2:
* fix kbuild error.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/Kconfig |  9 ++++-----
 drivers/tty/serial/imx.c   | 37 ++-----------------------------------
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 780908d43557..7fa2c78d1989 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -502,15 +502,14 @@ config SERIAL_IMX
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
-- 
2.17.1

