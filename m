Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7701C43214
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11616103E
	for <linux-serial@archiver.kernel.org>; Thu, 26 Aug 2021 19:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243394AbhHZTXL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:23:11 -0400
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:17536
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243391AbhHZTXK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 26 Aug 2021 15:23:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPNBd07lyBy0F3mtS700q8cSDT92gqSfByDWix9lJe2ULto91savPmFjhj+vetSlDatx2YZ8oxxLp0ZCs7ijLJocrdo4DgbO76eYTR6E/Jdo8cyzVRBn4+3PHOwMUQkg09GiBJcQGbQgaSSvFhYKX7uVA4qNEWz7ldoNnDq71P3WzJumItH45aCn208KeAdbyNiDk7jaiEVsem8enZAaxJZcJApFYF5MGxZxxF57WjEkV1xfTu+B3x/ahW3pX7b7e5jh4ohfB6vGn9rzgKKwz4VD+OFjte2cSimH82C/wlA/AO8Y+K4rHb472cFg2npmh/acJADxbYIKykwfRiyaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+++k6yptvMRCw1rPf0eQVBc8YD/HmfwtiBLN60iOdtM=;
 b=eaXgk4opYx4WxgMWDCgINvW8WSAicctOLWBtA2URBFt4h723zdfslU1FbGXplQVOyPlFx36qVX6pCH0Fs8OLdmifotPIM/2a7pUgW0FBxsCqZskt72JcAY6pP8iOLd5LhBqT1Irabwh8RXxwXhN/qAiRgp8Asnx3uhDS8ogZ4yKv7cZedWRs+ORbIvMt4UCZrRU01chDngabNWErmmv+zsG8JUPhHLq58/C6BMHQpKzgr149uVX/a6yfsiQfpN1aAqGgsRHmns0a/HCdxZAJXKgI6jjkKmSr3rm6AykQFA9AyE2F+/mlX2QxrrRPRR0YZ0wM6h+Ik1bJTV+TPXmyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+++k6yptvMRCw1rPf0eQVBc8YD/HmfwtiBLN60iOdtM=;
 b=gZoUpeXQYa8oVVqNLMz7pWQamzuvfNDpWzDgw1I/mhc1OajrTb81+E8sqIAuBAKlDlN19lHVur6SERGBRhjfaQQ33ZQx4uAyNVBJNaxMaP0LMx88NmYyQlTjUtJajClxvCLMyxvMXXACBaLDAyGWjBuIHh6M369a4z97q9q8ATQ=
Authentication-Results: barco.com; dkim=none (message not signed)
 header.d=none;barco.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4859.eurprd03.prod.outlook.com (2603:10a6:10:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 19:22:18 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4436.025; Thu, 26 Aug 2021
 19:22:18 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-serial@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 4/4] tty: serial: uartlite: Prevent changing fixed parameters
Date:   Thu, 26 Aug 2021 15:21:54 -0400
Message-Id: <20210826192154.3202269-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826192154.3202269-1-sean.anderson@seco.com>
References: <20210826192154.3202269-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:208:257::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plantagenet.inhand.com (50.195.82.171) by BL1PR13CA0046.namprd13.prod.outlook.com (2603:10b6:208:257::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.8 via Frontend Transport; Thu, 26 Aug 2021 19:22:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ddc284c-042f-4b1c-4871-08d968c6d1c1
X-MS-TrafficTypeDiagnostic: DB7PR03MB4859:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR03MB4859A8DF7759BD603DDFE01696C79@DB7PR03MB4859.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRHoR1hSHEaaKmX1na6l3VqvPCqbSnH1BHfqiFL3VaLeMMB35uRhUisjfUWLD8hwXbWLHc/DiI+knMQRdJ16yfAjIEoxyNXMKoVnAsOn/ou8es4+f++pFwX2frd2kDqEAKs5gUlVSyD9pmfn+y6UoSzVRv+sB7kyXI8h2ST0x2xk+17PRnWnRA5fWwKqxBcwGt4zV7DanoYcuZFXr61YAidsqAxnflkYh5OQx9rlSA5R4CqDC3PiwlGNS17h2T1thbva2Nh4plB6P3AV9OW+Mx0P63t0IeEi2M9uLRSv0jMEtldqrEYNHDijJWN4uzZBvg4oJK+rY8M5qUdggrFDr7JzSliYBtssJH/4R4kr1ivSLgzw4ejrYr8lXIMrZS/c+lCQDGLNU5BVIIFxSaVaQq/UoJiJG9jlHL6bjrfUYPm9hmAv46SDpHe4DvWFYcEkokvG9xYOyo31OXCF5ZB5Oszt0Xk7LZGC2Mao3LCQaWq85cTl8WffxnjK3YJxDOv/XT2UE8MEM7cc/DWz/IMHh/YuYljQZYt9O7Ah1LMOXutv7bZFXMgL4rdpRNy5wwpYKAAeBqFliiF1PWMU97wrmrPWldAfzu9lfZdlCPRXS0kyKitRrc41tlFvoeQaYF/YSFycjzbZXAwbtGWADrNnIWIyF21RRQdeL7djSbeR6ENaKANd9cxgKG36S4gMgbVl0VGs5+CP/wkIgrPKWt2RAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39840400004)(396003)(136003)(86362001)(54906003)(110136005)(478600001)(6512007)(316002)(83380400001)(5660300002)(6506007)(1076003)(186003)(8936002)(8676002)(26005)(66556008)(2616005)(4326008)(6666004)(66476007)(52116002)(107886003)(44832011)(66946007)(38350700002)(38100700002)(2906002)(956004)(36756003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9rba6ZBJqaN3xEeH1CbmOrGiz7vqkt5Jf37gO6wRkoEnYaHDoojcMyUBi/Vk?=
 =?us-ascii?Q?Si1atC6NayH0z5xoipQ6vYH+ym9m/cpCscmvFOVRwE1Rvj3+guuER2gYWipK?=
 =?us-ascii?Q?H7+SfhVWZYGAz/37G53ekwZj5ztxN07h3hPwb8wtq/FwS+AjFQkSTnY+nDI+?=
 =?us-ascii?Q?8q58ZhNhq6SidiEILmnhyLUhc/zWpZ3/rKP9qO/QuTNWR762J8UNDlh0O2mF?=
 =?us-ascii?Q?3OPAJrGoK0mq36UHbOlK/EUZ6+XDU+TuiGQx/eqqxuXPYgxd35S9qCQCPM8Q?=
 =?us-ascii?Q?hEBkUmN34RijfxkfHOuCl2cjn5aKdSAiovI1QO/I95zkbQi6LJFo0P2gAbux?=
 =?us-ascii?Q?g32mY1Vov9ELarHERVf8YXM0XhOtysjU/afVEgoyufrBm/BI47J/kWwXYEex?=
 =?us-ascii?Q?X0w9ywvqXGnAWNpXzdwSDrS86d/mA7ahF9ufif3yL0TljfaahmcVNRwcgDhV?=
 =?us-ascii?Q?OH01LHpT84PhNpxuDkGA1boL4VoAGFbvzHO3Y2nhpdraAaaRYrT2LJlkoLYp?=
 =?us-ascii?Q?pIGLU44ZYeQ1TQgLnXxxz067vnOzwto6gFbw/WC9OaJ9/OMZS1ZmJ9C/u53Q?=
 =?us-ascii?Q?XakwzBAju2TrCoJJsu29NemH0SV3za+mCwVIW/MTcZWvSEi5urA0VXNN9XwW?=
 =?us-ascii?Q?jyB9Ns7FNNKymkZ+rpYEKfPjPU8VqIiwoxDnSiVBXqUgwSbk5tynMu8kUsKG?=
 =?us-ascii?Q?Yeh25ZM3GYf0uVWIZpVrzhZuiSODfOsCROZDDOA0ZMbsajah2MX4fIduFagw?=
 =?us-ascii?Q?/gNueos9ujlqaZbYVaV7P6vn4NnV503if890hZHi/QZ7xEb7DWpeWuArt4yx?=
 =?us-ascii?Q?PDKglA5ZIVzwQUKNPqqSjsBQmZvDaKkc/4LvdpDjY1LA7oFOBkYeRtQVSbF0?=
 =?us-ascii?Q?5xX8kRg+0+s93s5VSE9ArIWHyriM7tQs+xakoCT3+GDDPeLNIg0E1NusewRO?=
 =?us-ascii?Q?BWTWYRGRB1p7mvgWDZZOPxkzDIu2R2xXjllry/DyEKeQ5YXBrWtX4T1pL4TJ?=
 =?us-ascii?Q?61t5wgNOjeszSLRqbHxAupGXKJvtiEMGz1Hurq0Yop4ATvQoq6AWI+ZzpREF?=
 =?us-ascii?Q?IvZzfS6einHSJONug49nif10NakI4C6tv7D/6mKCDgUa475R0up7OE54fsH3?=
 =?us-ascii?Q?5WwZ9HuZWjr8aIXm69GKojqmafNiEf4yRUYS738hXnjRwTgWD7S8zvH9Lkwz?=
 =?us-ascii?Q?dOmejuM09eBNxX8y/a1uM24tFa9hPq7ZWFMmXJWNLTZpg+6BiNEO0220t2rB?=
 =?us-ascii?Q?jlWlYa84V0RablocrB7Yjnea4zY4iHsy1RbxeVoyE7gI/GcBUTKwz2pyncCs?=
 =?us-ascii?Q?9Mm61mTpOBmk5Py7pQSvrUgP?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc284c-042f-4b1c-4871-08d968c6d1c1
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 19:22:18.3293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3/Bb0Vk/iFYcb9i9aCkJpBP6a1KddC2jSWEFPIZsum+I3rb7jnnC2yap3c8N5WG3zPjNtM/bpffK/cQipr26w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4859
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This device does not support changing baud, parity, data bits, stop
bits, or detecting breaks. Disable "changing" these settings to prevent
their termios from diverging from the actual state of the uart.

In order to determine the correct parameters to enforce, we read the
various new devicetree parameters to discover how the uart was
configured when it was synthesized. The defaults match
ulite_console_setup. xlnx,use-parity, xlnx,odd-parity, and
xlnx,data-bits are optional since there were in-tree users (and
presumably out-of-tree users) who did not set them.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v3:
- Remove warnings about unsupported termios
- Set defaults for xlnx,data-bits and xlnx,use-parity

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

 drivers/tty/serial/uartlite.c | 91 ++++++++++++++++++++++++++++++-----
 1 file changed, 80 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index f42ccc40ffa6..0bea3866bfb8 100644
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
@@ -303,7 +315,12 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
 			      struct ktermios *old)
 {
 	unsigned long flags;
-	unsigned int baud;
+	struct uartlite_data *pdata = port->private_data;
+
+	/* Set termios to what the hardware supports */
+	termios->c_cflag &= ~(BRKINT | CSTOPB | PARENB | PARODD | CSIZE);
+	termios->c_cflag |= pdata->cflags & (PARENB | PARODD | CSIZE);
+	tty_termios_encode_baud_rate(termios, pdata->baud, pdata->baud);
 
 	spin_lock_irqsave(&port->lock, flags);
 
@@ -326,8 +343,7 @@ static void ulite_set_termios(struct uart_port *port, struct ktermios *termios,
 			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
 
 	/* update timeout */
-	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
-	uart_update_timeout(port, termios->c_cflag, baud);
+	uart_update_timeout(port, termios->c_cflag, pdata->baud);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 }
@@ -532,8 +548,6 @@ static int ulite_console_setup(struct console *co, char *options)
 	return uart_set_options(port, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver ulite_uart_driver;
-
 static struct console ulite_console = {
 	.name	= ULITE_NAME,
 	.write	= ulite_console_write,
@@ -756,18 +770,73 @@ static int ulite_probe(struct platform_device *pdev)
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
+		u32 val = 0;
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
+		val = 8;
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

