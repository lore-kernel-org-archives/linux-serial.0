Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C797C43334
	for <linux-serial@archiver.kernel.org>; Mon, 27 Jun 2022 07:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiF0HRe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiF0HRc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Jun 2022 03:17:32 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B225FF8
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 00:17:29 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220627071727epoutp0368c87fdbb7fe5aebc64f9c1baa2e9024~8aQhspKeL1396513965epoutp03n
        for <linux-serial@vger.kernel.org>; Mon, 27 Jun 2022 07:17:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220627071727epoutp0368c87fdbb7fe5aebc64f9c1baa2e9024~8aQhspKeL1396513965epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656314247;
        bh=W8ud58vs9N+KQWmGqCM+knBPUNsTeqmTbXj2sk6sjYU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UEUoWfdxlQuql/I3nhHa8Cih1Jhvz8+WMaVyuZgdlwKc5qwbrH3s0IIpNEuB6SRzm
         xaNB/Ey0nppADVsgdOODg6gv69RoFnpV9y/1DXVICVhRgvO/yfQ38DF1WqVjfTpUgU
         K+3TkfQiIPbSpqar0FFZnQWC3sNalReUcIM7JImA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220627071727epcas2p383dd43a82323e6a41f4ccee7214e1378~8aQhDWZXb2598825988epcas2p36;
        Mon, 27 Jun 2022 07:17:27 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LWfF24GDJz4x9QC; Mon, 27 Jun
        2022 07:17:26 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.55.09650.68959B26; Mon, 27 Jun 2022 16:17:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220627071726epcas2p476cfa45f74a73bfd0fcfe03eacc2df60~8aQgFJ-PV1370213702epcas2p4W;
        Mon, 27 Jun 2022 07:17:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220627071726epsmtrp1ed5b1b9a03b892e06c074cd464cc979a~8aQgEEg7x0631406314epsmtrp1V;
        Mon, 27 Jun 2022 07:17:26 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-80-62b959862b2a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.AC.08905.58959B26; Mon, 27 Jun 2022 16:17:26 +0900 (KST)
Received: from localhost.localdomain (unknown [10.229.9.51]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220627071725epsmtip2beca9b0d1b7a8fbc847369cc446906ec~8aQf2Yodh1911819118epsmtip2H;
        Mon, 27 Jun 2022 07:17:25 +0000 (GMT)
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
Subject: [PATCH] tty: serial: samsung_tty: support more than 4 uart ports
Date:   Mon, 27 Jun 2022 16:15:12 +0900
Message-Id: <20220627071512.18180-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmhW5b5M4kg5VbFCwezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Ox9/VWdotNj6+xWsw4v4/J4sziXnaL09cWsFuc3+bvwO1xfV2Ax6ZV
        nWwed67tYfPYP3cNu8fmJfUei5ftZPPo27KK0ePzJrkAjqhsm4zUxJTUIoXUvOT8lMy8dFsl
        7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygI5UUyhJzSoFCAYnFxUr6djZF+aUlqQoZ
        +cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ2RkH3x5mK1irUPFudQdLA+NZqS5G
        Tg4JAROJlrWvWEFsIYEdjBJ7j9h1MXIB2Z8YJea07GWGcL4xSvy4sJ0NpmPtiotMEIm9jBKn
        e1vYIJyPjBL7lv4Bq2IT0JXY8vwVI4gtIpAtMad9EytIEbPAQyaJO6sOMoMkhAU8JRZf3QjW
        wCKgKvF04wUWEJtXwE6i89giZoh18hIb5vcyQ8QFJU7OfAJWwwwUb946G+w+CYFGDok77w6z
        QDS4SBz7/Y0VwhaWeHV8CzuELSXxsr8Nyi6WWDrrExNEcwOjxOVtv6CeM5aY9awd6GwOoA2a
        Eut36YOYEgLKEkduQe3lk+g4/JcdIswr0dEmBNGoLnFg+3SoC2Qluud8ZoUo8ZBY9tUTEryx
        Eidv72OcwCg/C8kzs5A8Mwth7QJG5lWMYqkFxbnpqcVGBUbwSE3Oz93ECE6nWm47GKe8/aB3
        iJGJg/EQowQHs5II7+vrW5OEeFMSK6tSi/Lji0pzUosPMZoCg3cis5Rocj4woeeVxBuaWBqY
        mJkZmhuZGpgrifN6pWxIFBJITyxJzU5NLUgtgulj4uCUamAyeuOidtaFWTI3XqD0QeCDyElS
        RiLSO6zyjm07/+/U7tjWGY++z+BqEe9p2rBwhvynV7WL7phe7V8TvOTh98U7NY+HXRDir9z/
        Nm++fabND7d6ldg5bgbrkyrND65RTePqnq5kE5gyP3ruatkL9roPZyrvVF4bpvglX0LS5Pec
        QybX/z9Teh3hfPJYgaVIgVaSz/b512LaF1j+2WK6pqlUZ/X3txauh1k1C2K21U5kmSa5MV2g
        YUHX3Ka96QzdHAvNoxvrz20PE235fr+oMOWTtk7n9jfzWDIXi9ruD76YKnBtwR4x+6nyq8WC
        GKWnls2/pLmn5Mmciu6qWStydlRv9Zm+bcL5zUz8uQvDYjYosRRnJBpqMRcVJwIA+ZgVljAE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvG5b5M4kg+PnGC0ezNvGZnF5v7ZF
        8+L1bBY7Go6wWrybK2Ox9/VWdotNj6+xWsw4v4/J4sziXnaL09cWsFuc3+bvwO1xfV2Ax6ZV
        nWwed67tYfPYP3cNu8fmJfUei5ftZPPo27KK0ePzJrkAjigum5TUnMyy1CJ9uwSujINvD7MV
        rFWoeLe6g6WB8axUFyMnh4SAicTaFReZuhi5OIQEdjNK3LnTxwSRkJV49m4HO4QtLHG/5Qgr
        RNF7RokrB2ezgiTYBHQltjx/xQhiiwhkS6z9spcNpIhZ4DmTxL6pU1lAEsICnhKLr25kA7FZ
        BFQlnm68ABbnFbCT6Dy2iBlig7zEhvm9zBBxQYmTM5+A1TADxZu3zmaewMg3C0lqFpLUAkam
        VYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwUGupbmDcfuqD3qHGJk4GA8xSnAwK4nw
        vr6+NUmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGJp30
        r4/MiiqurDiptjHFt66sOOP2gmqXxxERP78fXa6Zu/FL9HbVSjZua4vtp7pMDhTP4/+zcun/
        /WUnXm8u1hTb9E3s6Vvla5Pm7HocVa0rGSA/YanwlO/M2Xc8ZBxXpkfWrbFR+Nf4fZ3AhY2p
        Ny81h2sZ7Lh2e0nEiz/WC+3cD79XC/S3WNnz29I4SapSaUWtwWvX74Z7fWRLBfYq8b3o+nEj
        ozs2uG2vdImaXf3HbQv8Tu6StDnK1/B8Z/dLjprVnx8v1jm3qNis8NjOf9M6dwZ/mvX3Yp0a
        458tkqW//c2/nfby+VHGuWy31WfPdBb3Dcwi4ddW5jTHiB053Rbx+c5fhqiQx+xTKi4Gr1Ji
        Kc5INNRiLipOBABLBg4S4QIAAA==
X-CMS-MailID: 20220627071726epcas2p476cfa45f74a73bfd0fcfe03eacc2df60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220627071726epcas2p476cfa45f74a73bfd0fcfe03eacc2df60
References: <CGME20220627071726epcas2p476cfa45f74a73bfd0fcfe03eacc2df60@epcas2p4.samsung.com>
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
structure as default value. Regarding the ports which are greater than 4
will be initialized as default value and the fifo size will be retrieved
from the DT property.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/tty/serial/samsung_tty.c | 34 ++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index d7d035cd95c0..679789bf856d 100644
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
@@ -1815,7 +1821,7 @@ static const struct uart_ops apple_s5l_serial_ops = {
 static struct uart_driver s3c24xx_uart_drv = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "s3c2410_serial",
-	.nr		= CONFIG_SERIAL_SAMSUNG_UARTS,
+	.nr		= UART_NR,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.dev_name	= S3C24XX_SERIAL_NAME,
 	.major		= S3C24XX_SERIAL_MAJOR,
@@ -1825,7 +1831,7 @@ static struct uart_driver s3c24xx_uart_drv = {
 #define __PORT_LOCK_UNLOCKED(i) \
 	__SPIN_LOCK_UNLOCKED(s3c24xx_serial_ports[i].port.lock)
 static struct s3c24xx_uart_port
-s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
+s3c24xx_serial_ports[UART_NR] = {
 	[0] = {
 		.port = {
 			.lock		= __PORT_LOCK_UNLOCKED(0),
@@ -1848,7 +1854,7 @@ s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
 			.line		= 1,
 		}
 	},
-#if CONFIG_SERIAL_SAMSUNG_UARTS > 2
+#if UART_NR > 2
 	[2] = {
 		.port = {
 			.lock		= __PORT_LOCK_UNLOCKED(2),
@@ -1861,7 +1867,7 @@ s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
 		}
 	},
 #endif
-#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
+#if UART_NR > 3
 	[3] = {
 		.port = {
 			.lock		= __PORT_LOCK_UNLOCKED(3),
@@ -1877,6 +1883,19 @@ s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS] = {
 };
 #undef __PORT_LOCK_UNLOCKED
 
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
+
 /* s3c24xx_serial_resetport
  *
  * reset the fifos and other the settings.
@@ -2191,6 +2210,9 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	}
 	ourport = &s3c24xx_serial_ports[index];
 
+	if (ourport->port.line != index)
+		s3c24xx_serial_init_port_default(index);
+
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
 	if (!ourport->drv_data) {
 		dev_err(&pdev->dev, "could not find driver data\n");
@@ -2589,7 +2611,7 @@ s3c24xx_serial_console_setup(struct console *co, char *options)
 
 	/* is this a valid port */
 
-	if (co->index == -1 || co->index >= CONFIG_SERIAL_SAMSUNG_UARTS)
+	if (co->index == -1 || co->index >= UART_NR)
 		co->index = 0;
 
 	port = &s3c24xx_serial_ports[co->index].port;
-- 
2.36.1

