Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CCC4338F
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693F560F46
	for <linux-serial@archiver.kernel.org>; Tue, 27 Jul 2021 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhG0WSZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Jul 2021 18:18:25 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:30900
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232683AbhG0WSW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Jul 2021 18:18:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH1au657TwWSMboD9tBcDD/1CgzHCT0VoCDWYdGcD5pm/6kpx9fCzW5E+uoLjOH+/1g9Sx2CEH5gIxIqj0H9hWviq0zWvaraGThuf0IZBLToUSdkuA1NQbK7W+i2LS1KKXDf4TAklsw3a7ER7yVESQdXtM1xWOUYw64kKa2chBHAomqb1hUxCbCjqQtochTThW1v+C1MTpCItlwZ3lqg+YtUJP8FvWw5E35MwvW2WDSS83F9oh5jeNuZhnOBYUknYkFuel+sPQ/DJ8Rl/B3sGkOMG70DnWWb75D6AGgaWqYQFwq3HMnMkPLHGYQRVhQZz6SDcnqrmXZt1bjn1rR+Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu3EQ2vpanRQcMzTLGG29v5Yej11tMfDYoX/l+fXN0s=;
 b=G9vM2mi+KWOhJqPE3qtkl8i0A4Be5blseh0Ogkme8FH/JEQR4h7vIcaN/4UoAMW7ztaj+i2uuRsu72cFZemk4sSB0yOcYXEQifaGeN1DI7auvsS6Vq6fUIa1PZgypFcyZ3rwieVN+Uo6+U57bboeal56jfGlQyKA8566PjSxbC+rdDIhTYVyfr2Ug4rFEIaKaONCT5gQg/bhaWa2V2e6tQSPIn0Ng3nub7mAArXZgu4ghW9rUzdg7xnlq8mFAcwcNqg7eqlSgzotRhtMbg3Oe64mvPj4E/rK2gOhS/Lm2oyp7MbcHOqlinxx8ohRvZpoTNo8MmfPp1RzwAXzPnmiaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yu3EQ2vpanRQcMzTLGG29v5Yej11tMfDYoX/l+fXN0s=;
 b=LZgRgkN1HKsD2kwK3ROf7wwKCMMlVkFvdl/OlQJPi3BwM1Hk37x8xu7iFkpgvEPd22ztG7UDB0206tAxJg+y8R3Y2mg9rpvgHLRKlZxzmR9kHem3kGlDbz0wQp8+AhIxx958WnGxAaaUcWSaZZobPgAPW7473Ix7Hs/tcW5momc=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5141.eurprd03.prod.outlook.com (2603:10a6:10:f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Tue, 27 Jul
 2021 22:18:15 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4352.032; Tue, 27 Jul 2021
 22:18:15 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 4/4] tty: serial: uartlite: Prevent changing fixed parameters
Date:   Tue, 27 Jul 2021 18:17:40 -0400
Message-Id: <20210727221740.1997731-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727221740.1997731-1-sean.anderson@seco.com>
References: <20210727221740.1997731-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by MN2PR06CA0008.namprd06.prod.outlook.com (2603:10b6:208:23d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Tue, 27 Jul 2021 22:18:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caf373a6-aba2-44ea-b28a-08d9514c6ddf
X-MS-TrafficTypeDiagnostic: DBBPR03MB5141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR03MB51419A1FED0596F05152FE4A96E99@DBBPR03MB5141.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExuawR9HdzDAtfa7DrzwzKrPVkpF25vk25DUinMW/cvHt0EPUuC8e47lgsymV2ofM/kcWjj+xT2jla8Ij7XvSYyxNtczBq9WsTDP6pjtf/lFxUQ+CepK5I/99A3MJfpRU5hkYAKNNFMQRI+3Mj/o/1lOdKr0L8H3YMvWp/+p5NAPGiVGckkt0Q7YWv32IFwtt1Haa+84BY0wpban4xEz7Aw3iUxSypjYm6O7EzoefkRXEeg6kSzyPw/0AJSQpNs0KIADOlco6WAAMjp3i+p654yKpaJh+g+g2f/sMf6exI0CUMlbyC76iB0YHWK0qbE1N7GNfkIe0v2mkb8x1BViFxnWvgdQEsGAvB3n2O7yYz3+VIMz2noQuXo2Tnmtmatbel5dnz1dd3S/h0nHLLPPtoJAiSlk4mQZMD8pT64OT2vKy/1hvM9Yja9ruejcvRifu+JYAvbjHupog/p6+9qIu1bAVxyCkbcSOSf+cf956zl5X7TTtuopbOi4+7yT84TMfBrAVbox9YAs6Sz/12R+EBOAGfnikL7KuhpJWP7Rs5p0iX+s2+4z86/kRCazPFCxkFF1/ndSYurIdn6PXXrMezeURdQ6cstDrOZnGZxJSLO8AF7NPr0jPXKCUr+ivL9FUMhYdxWF4eKDjZMvCWyNIfnNa6K4340dBX9KBhZzo6hMtEsLmjkDjBY+z/o4Cfl8nFw+EFPyLgVXxhhiIxLTww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(39830400003)(346002)(366004)(8936002)(38100700002)(38350700002)(66946007)(1076003)(6666004)(316002)(44832011)(86362001)(26005)(6486002)(4326008)(956004)(186003)(6506007)(5660300002)(54906003)(110136005)(2616005)(83380400001)(66556008)(66476007)(36756003)(2906002)(478600001)(52116002)(6512007)(8676002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4xT9ZfLNRoqOvdB6Tzaa9Z1ghZixK4zUt1v1wI9IlvjK1wGmupsSr0PFG6RB?=
 =?us-ascii?Q?WF6oAMyrKgfjxzBNGoXg3ZJLwggf/U+gQXVeyL08yXOgVGaxUM/kNTtAVuzA?=
 =?us-ascii?Q?OAkACrB2Xsdk4mWYun9C8hlhU6QsOpitIww1y70UGpmRct+s0uyjU4Vw6YAV?=
 =?us-ascii?Q?KZ1aMcZv2i4/6zOWrBYdL/bgQYnRw6G2bG+Zm84kABsdv5rOOQdCtijnMADn?=
 =?us-ascii?Q?+TWpQ2OdDjjs5Gfz+8RVazACY8sAN+jOUhVFbeOt0Jh7Uf1Zj7Ys2xU4Thx9?=
 =?us-ascii?Q?eDqfxAClhQnfTNZvu94UizG3+mMjNmht3942zESyLa8LCtzo9xwaZFAZHiaW?=
 =?us-ascii?Q?oQjic4B1EZGe+0ZZx029O2IhV4KS4sK/cBzHgq1+3AIeVfkJ3hoMZYXs15y4?=
 =?us-ascii?Q?fO/BuDiTE8vhzji6mpNpl6Z2FTO5VXb/rL32smxmayl+QxTgUXuAKA+oCeCT?=
 =?us-ascii?Q?tBGlbXWQ5KZdqLFLAv8zljPMzdlrOBMiJncV0ytS7jbwHPdy3kRRbkE8pQLP?=
 =?us-ascii?Q?yhgJSbw6Rx8xbT2MeACClTjGuD5BGZ3evzQBjAesTpfr79Xc9/u5RPgTedhS?=
 =?us-ascii?Q?A6bz9+M0RDxahHeoryOq+fjU27gM3pt5PA/EZjbpg2gkufw6faxgpQqLa3RX?=
 =?us-ascii?Q?qk+32plVaxpScPpvijbikzlNaPcyKYSD3r4fBY8nemG5DzDgIWd1WF5kMvdG?=
 =?us-ascii?Q?rxHznd2F8JDD0Wzd/8Shbs/4a5yqtUS+KllMTY0veZKs4Jmqgzqun8S9asjm?=
 =?us-ascii?Q?7P1yXSakGzNIJAzI3r4D3LFIemVwPWI+KhOxtI1MRiDQwvtYOTH7Oxiyna7v?=
 =?us-ascii?Q?yz92Bkn+7LkxAPrkCY7SFd0bBqE7Ff/s65gY8YY/hn1l5Kfxtr7Hs8tboJHW?=
 =?us-ascii?Q?9iLREMUzFsLEmNvsLhE7C3q3FteG4EM6dw1+bNypTwFoQXbd+CbheVS/cdTU?=
 =?us-ascii?Q?zBS9oxBEFLwx5Q7DzBUgqug6fXXo1cywJsTvyVtnMWoYwxFc4RGL8nVAB3EZ?=
 =?us-ascii?Q?tk616ueVhtbr9SiGISST1VryqOhf39LXB3Tdl5azekkL/AkdIlW/UG/so1nF?=
 =?us-ascii?Q?9aNgh89N40bi3PnZ/IiU49971a20x+C9IEI32bepYXT1XV0bMgB9+5a6pX8P?=
 =?us-ascii?Q?gv7LEnC8YfNP4EJDm7pf43VG+S9lGcou2kIy/opq2wjB86L7YbmeUG+EW13r?=
 =?us-ascii?Q?2yhdBSlQNCzWs6SLQZKKhNi0lcC2vGKV6DI9SGIDbJzkLQSyDT7uhIfdHfWH?=
 =?us-ascii?Q?awEBcSM2YeouQKDKAXgJGGVM7p75Y3Kv/69uo8tDHx4eG4CVG9ZTWrvwMDA1?=
 =?us-ascii?Q?tJnNRg2DjmY2W7RoiXJ5dY77?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf373a6-aba2-44ea-b28a-08d9514c6ddf
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2021 22:18:15.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wrRSGPT8e30QTei3kcrGEaqJDx+CCtu0tJigpjsJsWLzV5u0yo7+7Xy3iLpgBZUmWSxLObSZ3/kGWXFWJyZwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5141
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This device does not support changing baud, parity, data bits, stop
bits, or detecting breaks. Disable "changing" these settings to prevent
their termios from diverging from the actual state of the uart. To inform
users of these limitations, warn if the new termios change these
parameters. We only do this once to avoid spamming the log. These
warnings are inspired by those in the sifive driver.

In order to determine the correct parameters to enforce, we read the
various new devicetree parameters to discover how the uart was
configured when it was synthesized. The defaults match
ulite_console_setup. xlnx,use-parity, xlnx,odd-parity, and
xlnx,data-bits are optional since there were in-tree users (and
presumably out-of-tree users) who did not set them.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v2:
- Compare the baud computed with uart_get_baud_rate to pdata->baud,
  instead of just checking c_cflag. This will catch anything that messes
  with ispeed and ospeed.
- Don't bother trying to set the initial termios. Instead, just skip
  warning if old is NULL.
- Because we no longer use uart_set_options, just convert the devicetree
  properties directly to clflags.
- Merge with [PATCH 4/5] ("tty: serial: uartlite: Initialize termios
  with fixed synthesis parameters") to make it clearer what the
  properties we read are being used for.

 drivers/tty/serial/uartlite.c | 120 ++++++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc40ffa6..87804abd436f 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -8,6 +8,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/console.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
@@ -60,9 +61,18 @@
 static struct uart_port *console_port;
 #endif
 
+/**
+ * struct uartlite_data: Driver private data
+ * reg_ops: Functions to read/write registers
+ * clk: Our parent clock, if present
+ * baud: The baud rate configured when this device was synthesized
+ * cflags: The cflags for parity and data bits
+ */
 struct uartlite_data {
 	const struct uartlite_reg_ops *reg_ops;
 	struct clk *clk;
+	unsigned int baud;
+	tcflag_t cflags;
 };
 
 struct uartlite_reg_ops {
@@ -116,6 +126,8 @@ static inline void uart_out32(u32 val, u32 offset, struct uart_port *port)
 
 static struct uart_port ulite_ports[ULITE_NR_UARTS];
 
+static struct uart_driver ulite_uart_driver;
+
 /* ---------------------------------------------------------------------
  * Core UART driver operations
  */
@@ -303,7 +315,42 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
 			      struct ktermios *old)
 {
 	unsigned long flags;
-	unsigned int baud;
+	struct uartlite_data *pdata = port->private_data;
+	tcflag_t old_cflag;
+
+	/*
+	 * If old is NULL then we're being set up for the first time
+	 * (before any user has touched the termios), so don't warn
+	 * about unsupported features.
+	 */
+	if (old && termios->c_iflag & BRKINT)
+		dev_err_once(port->dev, "BREAK detection not supported\n");
+	termios->c_iflag &= ~BRKINT;
+
+	if (old && termios->c_cflag & CSTOPB && old)
+		dev_err_once(port->dev, "only one stop bit supported\n");
+	termios->c_cflag &= ~CSTOPB;
+
+	old_cflag = termios->c_cflag;
+	termios->c_cflag &= ~(PARENB | PARODD);
+	termios->c_cflag |= pdata->cflags & (PARENB | PARODD);
+	if (old && termios->c_cflag != old_cflag)
+		dev_err_once(port->dev, "only '%c' parity supported\n",
+			     pdata->cflags & PARODD ? 'o' :
+			     pdata->cflags & PARENB ? 'e' : 'n');
+
+	old_cflag = termios->c_cflag;
+	termios->c_cflag &= ~CSIZE;
+	termios->c_cflag |= pdata->cflags & CSIZE;
+	if (old && termios->c_cflag != old_cflag)
+		dev_err_once(port->dev, "only %d data bits supported\n",
+			     FIELD_GET(CSIZE, pdata->cflags) + 5);
+
+	if (old &&
+	    pdata->baud != uart_get_baud_rate(port, termios, old, 0, 460800))
+		dev_err_once(port->dev, "only %d baud supported\n",
+			     pdata->baud);
+	tty_termios_encode_baud_rate(termios, pdata->baud, pdata->baud);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -326,8 +373,7 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
 			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
 
 	/* update timeout */
-	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
-	uart_update_timeout(port, termios->c_cflag, baud);
+	uart_update_timeout(port, termios->c_cflag, pdata->baud);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -532,8 +578,6 @@ static int ulite_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver ulite_uart_driver;
-
 static struct console ulite_console = {
 	.name	= ULITE_NAME,
 	.write	= ulite_console_write,
@@ -756,18 +800,72 @@ static int ulite_probe(struct platform_device *pdev)
 	struct uartlite_data *pdata;
 	int irq, ret;
 	int id = pdev->id;
-#ifdef CONFIG_OF
-	const __be32 *prop;
 
-	prop = of_get_property(pdev->dev.of_node, "port-number", NULL);
-	if (prop)
-		id = be32_to_cpup(prop);
-#endif
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct uartlite_data),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
+	if (IS_ENABLED(CONFIG_OF)) {
+		const char *prop;
+		struct device_node *np = pdev->dev.of_node;
+		u32 val;
+
+		prop = "port-number";
+		ret = of_property_read_u32(np, prop, &id);
+		if (ret && ret != -EINVAL)
+of_err:
+			return dev_err_probe(&pdev->dev, ret,
+					     "could not read %s\n", prop);
+
+		prop = "current-speed";
+		ret = of_property_read_u32(np, prop, &pdata->baud);
+		if (ret)
+			goto of_err;
+
+		prop = "xlnx,use-parity";
+		ret = of_property_read_u32(np, prop, &val);
+		if (ret && ret != -EINVAL)
+			goto of_err;
+
+		if (val) {
+			prop = "xlnx,odd-parity";
+			ret = of_property_read_u32(np, prop, &val);
+			if (ret)
+				goto of_err;
+
+			if (val)
+				pdata->cflags |= PARODD;
+			pdata->cflags |= PARENB;
+		}
+
+		prop = "xlnx,data-bits";
+		ret = of_property_read_u32(np, prop, &val);
+		if (ret && ret != -EINVAL)
+			goto of_err;
+
+		switch (val) {
+		case 5:
+			pdata->cflags |= CS5;
+			break;
+		case 6:
+			pdata->cflags |= CS6;
+			break;
+		case 7:
+			pdata->cflags |= CS7;
+			break;
+		case 8:
+			pdata->cflags |= CS8;
+			break;
+		default:
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "bad data bits %d\n", val);
+		}
+	} else {
+		pdata->baud = 9600;
+		pdata->cflags = CS8;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
-- 
2.25.1

