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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B45C433E1
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138C02073E
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 07:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WcLLYMkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgGXHQZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:16:25 -0400
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:3681
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgGXHQZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 03:16:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtBvkxs5ziD8a6Fkr5zoGHojkdyS8dhOJlPN2thyVNv3apQLgiqsLaI7WzayTfC/VholeG8P97Hb0zAj+fa2ypVlXqDrtOTV/swUAIrkGxpgA7iK1FbiCo+5lFg0Zf8diVjPgioL1b3kSMn7f5r35mY6+AlVi1M4dpzMN/K+CE3fuui7gpXF7g0/wNV90Cq3SNdxbGzLDTVER/A8fo2fwukbj2Ik19p5Kl5KCKU0K/Un6pn6ErqI50D3oiigTJeLDe0xFtIQ5O3eAmDJBhh3p8VQtEKqAbzBySq+Ctk0xhBF7K67dAcf6lP/Awat0tLc7S/TdIpc4LXP4y93A30gdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjB6kOBMaieV1ms/MWcFwsjpZXBbQLHy7uKIYTWWU/w=;
 b=KFFY5QFlWJTvPStbtrGVRtKN4Nae4QEXHYKVJVwYYK3+gchbL1GX+VYFJzbF5WlvZ31ecMOyhMhtOVDe9cAZeKoMk2+ZjVx9ByDEvyqKkACB4ZQ/G9ksJ+5wZ7Nwj6ZrkoMv/Y1sSEKaIBBYUct8dFCNDiv9674zMq6XsjKjqVVudDUAugOjhv7Z3XoixI0gd+AC4dSi9ZhU3mgyl8Gn24Vqy3rDnH76p8k/BHlPUnAI6sSi4B9qleadAyL/PgC7fZ6KMoQLixN1YKrnjT4EKMWT4RVcRCvTXe/1a89YD+CDwBsofjnbpKdmiBB4zgFGcEJToh+2yjtrGtnNQQToGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjB6kOBMaieV1ms/MWcFwsjpZXBbQLHy7uKIYTWWU/w=;
 b=WcLLYMkwC9qkacpvPtcRjYVzEhXgrAn6N6I1FyN1XGsRDNcas5/r5qP/7jv2djQt2GykLVPD32+qaMMAD/E5D+5lyqmIet1v9r7hk1QwZjX0DNI7LTpYP8nvYszGwwsxkD7zgW36d2GMxH3dWtcAZ2KAYup/92f3n4r2zretRto=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18) by AM5PR0402MB2930.eurprd04.prod.outlook.com
 (2603:10a6:203:9a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Fri, 24 Jul
 2020 07:16:19 +0000
Received: from AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f]) by AM6PR0402MB3607.eurprd04.prod.outlook.com
 ([fe80::75d9:c8cb:c564:d17f%5]) with mapi id 15.20.3216.026; Fri, 24 Jul 2020
 07:16:19 +0000
From:   Fugang Duan <fugang.duan@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, lukas@wunner.de,
        s.hauer@pengutronix.de, kernel@pengutronix.de, fugang.duan@nxp.com,
        jslaby@suse.com
Subject: [PATCH tty/serial v3 2/2] tty: serial: imx: add imx earlycon driver
Date:   Fri, 24 Jul 2020 15:08:15 +0800
Message-Id: <20200724070815.11445-3-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724070815.11445-1-fugang.duan@nxp.com>
References: <20200724070815.11445-1-fugang.duan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To AM6PR0402MB3607.eurprd04.prod.outlook.com
 (2603:10a6:209:12::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from b38611-OptiPlex-7040.ap.freescale.net (119.31.174.67) by SG2PR03CA0108.apcprd03.prod.outlook.com (2603:1096:4:7c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Fri, 24 Jul 2020 07:16:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b16b42dd-5344-4356-2aff-08d82fa17682
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2930:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0402MB29305F68624D5A8910726D3FFF770@AM5PR0402MB2930.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUobZ+jn0tRU9edqwafXgsJ1YcAJe3ocbdN73BmRSPO0Expo8GyDixwQTXjA4EoeaEpp5TgNCQJAg5TALgPJId7Ts4m48HfAuIYp5Fi/+p0QUwdJ4l/xi4jqDcIj2+Jpk5SHZi+91eioSJ+6tdIdBrSS8E9dIOOn0hPO8afhBCaY6cQW4IUDiEh9a2Rk8SuusGyCYcRsAWdnw3vrHKdCPkh2ZDbP+hACvFBdpR402IYLfNVTiWnTf6xZqDhp4eA16LY2zl7y8vpNKwvrjNqXxogPpW/A22U8nbhAa355EhW9D5bBkwHZ7z+MrnrepBtrW9TV7AFzPIMu7YPVJd7jWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0402MB3607.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(5660300002)(6916009)(4326008)(86362001)(6512007)(36756003)(6486002)(8676002)(8936002)(52116002)(44832011)(66946007)(2906002)(6506007)(956004)(186003)(83380400001)(66556008)(1076003)(316002)(478600001)(16526019)(26005)(66476007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +5MIJdzLw7OTtzQm37QbqFmDXXxUoWoZWVBXIGjwS3wyUbrTimk71amcw99bR8x7C6XRC9RxGGEnNBvHyeXj9rKXn8lwbhyoXawD3WGkeySaPkg9DKuaYbHCniBgXZFwc+buhr2x9I8gvuEOe5jnMI/TxtrJmrBM7oEdze7x/zNAx82PMfJEsV/gAFGmcQHEzBZwruRH7X7s+TRJPx0i/OolRcJPTR9+2k+BtZdFslwVS0xaMj7xuh2SSST2P3zkVc+4IxAejDurGhssdEy2OkWzeiq4WPa8LEP/oeSiQsQ2CQ4w0E9lTpiEePGtuQox/eb80Db9iXJhAfXgBY4A6Rg2rdSJteg58hbsUvupJwwSEfSI5hrD24fbk3ODLm9QeVcuA9TYK9oOS6K64tAjx1Od7jPZbqcTDMTlnSGP3MaEb5hxRCDiywJ7U3n5Y+H9M+Ggxqry0ztqbPNzjLGnkeb3yv30CwkUbqbi7J0y0ZK1eciKtGOO7hGSs2UWIFMy
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16b42dd-5344-4356-2aff-08d82fa17682
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0402MB3607.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 07:16:19.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9K8v8Me67L/HjZNQ3pdvygnFuH5EEWQlmSWE2cwaQiNH2KSS3YJYnPqG4yEffn984XU+wtl8aXdOOigHn8vqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2930
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Split imx earlycon driver from imx serial driver "imx.c" as
separated driver. imx serial driver can be built as module,
but earlycon driver only support build in.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/tty/serial/Kconfig        |  8 +++++
 drivers/tty/serial/imx_earlycon.c | 50 +++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 7fa2c78d1989..8a0352eb337c 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -515,6 +515,14 @@ config SERIAL_IMX_CONSOLE
 	  "console=ttymxc0". (Try "man bootparam" or see the documentation of
 	  your bootloader about how to pass options to the kernel at boot time.)
 
+config SERIAL_IMX_EARLYCON
+	bool "Earlycon on IMX serial port"
+	depends on OF
+	select SERIAL_EARLYCON
+	help
+	  If you have enabled the earlycon on the Freescale IMX
+	  CPU you can make it the earlycon by answering Y to this option.
+
 config SERIAL_UARTLITE
 	tristate "Xilinx uartlite serial port support"
 	depends on HAS_IOMEM
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

