Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C766FCCA479
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 00:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiF2A6A (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 20:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiF2A55 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 20:57:57 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A6326FB
        for <linux-serial@vger.kernel.org>; Tue, 28 Jun 2022 17:57:54 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220629005753epoutp03a6046ac710cc7148ef3cccd12400090e~88Xrms2wQ1571315713epoutp03I
        for <linux-serial@vger.kernel.org>; Wed, 29 Jun 2022 00:57:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220629005753epoutp03a6046ac710cc7148ef3cccd12400090e~88Xrms2wQ1571315713epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656464273;
        bh=eOELwGthOhj4Twna3ildIS47IEDsUa9r0d3IFwQZJ6A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QqXoVnISrLLVO1yvlC8gu3tKjCBubBlfbfDCfI8FPvQMW5sqKHqlsgoBNf1JwWcCP
         BhAIhLI0Tulqq/PMveIcr2QMJP4dTC3PwE06fr50/EJMO/7BKNGjA4fNLMsq2gWRNz
         fOYnL6ZQrpghWCdvKGZI3zwI5asnC0StHbyPzdXI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220629005752epcas2p37291981f31d1dfa105a63243b2b7ee25~88XqtAuf_0406604066epcas2p3R;
        Wed, 29 Jun 2022 00:57:52 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.89]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LXjk73b5Jz4x9QF; Wed, 29 Jun
        2022 00:57:51 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.DA.09662.F83ABB26; Wed, 29 Jun 2022 09:57:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17~88XplYyCc1396813968epcas2p42;
        Wed, 29 Jun 2022 00:57:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220629005750epsmtrp1f14bb8b05b530a4eed95963062a9530d~88XpkTe2V2342623426epsmtrp1V;
        Wed, 29 Jun 2022 00:57:50 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-69-62bba38fb47e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A5.F9.08802.E83ABB26; Wed, 29 Jun 2022 09:57:50 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220629005750epsmtip253cacbd8a1c3fc11e613a68383f03128~88XpXTri22587325873epsmtip2w;
        Wed, 29 Jun 2022 00:57:50 +0000 (GMT)
From:   Chanho Park <chanho61.park@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Hector Martin <marcan@marcan.st>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v2] tty: serial: samsung_tty: support more than 4 uart ports
Date:   Wed, 29 Jun 2022 09:55:38 +0900
Message-Id: <20220629005538.60132-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmuW7/4t1JBr0LpC0ezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Ox9/VWdotNj6+xWsw4v4/J4sziXnaL09cWsFuc3+bvwO1xfV2Ax6ZV
        nWwed67tYfPYP3cNu8fmJfUei5ftZPPo27KK0ePzJrkAjqhsm4zUxJTUIoXUvOT8lMy8dFsl
        7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygI5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ
        +cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2Rkvt3xmLehWrnj28RJrA+MsmS5G
        Tg4JAROJn7+3MoPYQgI7GCUu3teAsD8xSuzdxNXFyAVkf2aU+PPnMlARB1jDlScyEPFdjBLv
        Z65hhHA+MkosntkBNolNQFdiy/NXjCC2iEC2xJz2TawgRcwCD5kk7qw6CDZJWMBHYv+WXJAa
        FgFViYmfH4HV8wrYSSzesogd4jp5iQ3ze5kh4oISJ2c+YQGxmYHizVtnM4PMlBD4yy6x/NNR
        ZogGF4m+KyugbGGJV8e3QA2SknjZ3wZlF0ssnfWJCaK5gVHi8rZfbBAJY4lZz9oZQY5jFtCU
        WL9LH+JjZYkjt6D28kl0HP7LDhHmlehoE4JoVJc4sH06C4QtK9E95zMrhO0h8fDiS3ZIgMZK
        XHh2i30Co/wsJN/MQvLNLIS9CxiZVzGKpRYU56anFhsVmMCjNDk/dxMjOJVqeexgnP32g94h
        RiYOxkOMEhzMSiK8C8/sTBLiTUmsrEotyo8vKs1JLT7EaAoM34nMUqLJ+cBknlcSb2hiaWBi
        ZmZobmRqYK4kzuuVsiFRSCA9sSQ1OzW1ILUIpo+Jg1Oqgcnnn3K6nuHLIDPZK1HN528sX5fF
        HFAXe1ppukcZz/OfyxSTYw93lQQEb1rxbHnqPuvFcY9eCJyp7/+7Tq/y9gwjZc3OBwc7Fs57
        td1k35aeHxlL/KrN1B+xz8o8eUl18cEt2x8kNf4M27np9Vw7i8y92tJHWz+4vrnCI/vEIU1j
        IUflk9VfRcu5fcqnOU6pyeBmS98cMPm9sejMpYw3K6yqxQ7VOCqIaC1elCNVMclzWu+FBvHE
        +YxHCycrXQn0YAt9YWh0WUw0f5XltCU6d1SSz5xPWnwpKUj3bkf366CKmv59S7epzDxwdFGy
        ScehfeZf/8yd+7P6z/p3YvmBDmUzD116LPnCffNU8y1tCj+UWIozEg21mIuKEwHdFGOKLgQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsWy7bCSvG7f4t1JBp8uGFs8mLeNzeLyfm2L
        5sXr2Sx2NBxhtXg3V8Zi7+ut7BabHl9jtZhxfh+TxZnFvewWp68tYLc4v83fgdvj+roAj02r
        Otk87lzbw+axf+4ado/NS+o9Fi/byebRt2UVo8fnTXIBHFFcNimpOZllqUX6dglcGS+3fGYt
        6FauePbxEmsD4yyZLkYODgkBE4krT4BMLg4hgR2MEk279rN3MXICxWUlnr3bAWULS9xvOcIK
        UfSeUeL+52PMIAk2AV2JLc9fMYLYIgLZEmu/7GUDKWIWeM4ksW/qVBaQDcICPhL7t+SC1LAI
        qEpM/PwIrJ5XwE5i8ZZFUAvkJTbM72WGiAtKnJz5hAXEZgaKN2+dzTyBkW8WktQsJKkFjEyr
        GCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCA1xLawfjnlUf9A4xMnEwHmKU4GBWEuFd
        eGZnkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2CyTBycUg1MBdnT
        NphvvxPlPyeX+at0tO6rGwERVWKGkj81g1ccOrn/7EPT6uN/VzD+kGs6GLAoqGWpQIvNPYb2
        0+v+5L79//HOt5IZk6KZt5cG1GgUznOY+z7rxtq9KkVK8YvTFSdL6n4WnubYzT6VQzW25ZbM
        q6kXDC61mexKna7rbNojeVbGZumti6XrHtTJbHbW/Nm65Jj2VknDqsWXRG9l7DCV4q/a+/XX
        et6uyZoMqt1P//Q86nA9a6gs1b9x5f8dl8WeTeji6TLYmOlrM1Nie6n+nwrpUp39yzlv+0wO
        5s0qmzw5emnJihvHMtxzlNxmHPt184H4nzdHVySE3gm2TXyjdOhvzbtt3jl3tG+qsiQpKrEU
        ZyQaajEXFScCAKF8yKPfAgAA
X-CMS-MailID: 20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17
References: <CGME20220629005750epcas2p418cd79922d1b3f13eda761ee3fcd3e17@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Regarding Exynos Auto v9 SoC, it supports uarts up to 12. However, the
maximum number of the ports has been derived from
CONFIG_SERIAL_SAMSUNG_UARTS and tightly coupled with the config for
previous Samsung SoCs such as s3c24xx and s3c64xx. To overcome this
limitation, this changes the usage of the definition to UART_NR which is
widely used from other serial drivers. This also defines the value to 12
only for ARM64 SoCs to not affect the change to previous arm32 SoCs.

Instead of enumerating all the ports as predefined arrays, this
introduces s3c24xx_serial_init_port_default that is initializing the
structure as the default value.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
Changes from v1:
- Remove initial value assignment of s3c24xx_serial_ports by assigning
  them dynamically as suggested by Greg and Krzysztof.

 drivers/tty/serial/samsung_tty.c | 82 ++++++++++----------------------
 1 file changed, 25 insertions(+), 57 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 03ef4ff506fd..8971fbb49fa3 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -48,6 +48,12 @@
 #define S3C24XX_SERIAL_MAJOR	204
 #define S3C24XX_SERIAL_MINOR	64
 
+#ifdef CONFIG_ARM64
+#define UART_NR			12
+#else
+#define UART_NR			CONFIG_SERIAL_SAMSUNG_UARTS
+#endif
+
 #define S3C24XX_TX_PIO			1
 #define S3C24XX_TX_DMA			2
 #define S3C24XX_RX_PIO			1
@@ -87,7 +93,7 @@ struct s3c24xx_uart_info {
 struct s3c24xx_serial_drv_data {
 	const struct s3c24xx_uart_info	info;
 	const struct s3c2410_uartcfg	def_cfg;
-	const unsigned int		fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
+	const unsigned int		fifosize[UART_NR];
 };
 
 struct s3c24xx_uart_dma {
@@ -1810,67 +1816,27 @@ static const struct uart_ops apple_s5l_serial_ops = {
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "s3c2410_serial",
-	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
+	.nr		= UART_NR,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.dev_name	= S3C24XX_SERIAL_NAME,
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };
 
-#define __PORT_LOCK_UNLOCKED(i) \
-	__SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[i].port.lock)
-static struct s3c24xx_uart_port
-s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
-	[0] = {
-		.port = {
-			.lock		= __PORT_LOCK_UNLOCKED(0),
-			.iotype		= UPIO_MEM,
-			.uartclk	= 0,
-			.fifosize	= 16,
-			.ops		= &s3c24xx_serial_ops,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 0,
-		}
-	},
-	[1] = {
-		.port = {
-			.lock		= __PORT_LOCK_UNLOCKED(1),
-			.iotype		= UPIO_MEM,
-			.uartclk	= 0,
-			.fifosize	= 16,
-			.ops		= &s3c24xx_serial_ops,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 1,
-		}
-	},
-#if CONFIG_SERIAL_SAMSUNG_UARTS > 2
-	[2] = {
-		.port = {
-			.lock		= __PORT_LOCK_UNLOCKED(2),
-			.iotype		= UPIO_MEM,
-			.uartclk	= 0,
-			.fifosize	= 16,
-			.ops		= &s3c24xx_serial_ops,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 2,
-		}
-	},
-#endif
-#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
-	[3] = {
-		.port = {
-			.lock		= __PORT_LOCK_UNLOCKED(3),
-			.iotype		= UPIO_MEM,
-			.uartclk	= 0,
-			.fifosize	= 16,
-			.ops		= &s3c24xx_serial_ops,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 3,
-		}
-	}
-#endif
-};
-#undef __PORT_LOCK_UNLOCKED
+static struct s3c24xx_uart_port s3c24xx_serial_ports[UART_NR];
+
+static void s3c24xx_serial_init_port_default(int index) {
+	struct uart_port *port = &s3c24xx_serial_ports[index].port;
+
+	spin_lock_init(&port->lock);
+
+	port->iotype = UPIO_MEM;
+	port->uartclk = 0;
+	port->fifosize = 16;
+	port->ops = &s3c24xx_serial_ops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->line = index;
+}
 
 /* s3c24xx_serial_resetport
  *
@@ -2186,6 +2152,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	}
 	ourport = &s3c24xx_serial_ports[index];
 
+	s3c24xx_serial_init_port_default(index);
+
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
 	if (!ourport->drv_data) {
 		dev_err(&pdev->dev, "could not find driver data\n");
@@ -2584,7 +2552,7 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 
 	/* is this a valid port */
 
-	if (co->index == -1 || co->index >= CONFIG_SERIAL_SAMSUNG_UARTS)
+	if (co->index == -1 || co->index >= UART_NR)
 		co->index = 0;
 
 	port = &s3c24xx_serial_ports[co->index].port;
-- 
2.36.1

