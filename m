Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24FFC433B4
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 01:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3005613DE
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 01:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhEJBoG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 9 May 2021 21:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhEJBn5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 9 May 2021 21:43:57 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A3CC06175F;
        Sun,  9 May 2021 18:42:53 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 4F5AC8F;
        Sun,  9 May 2021 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1620610973;
        bh=cJWOo4TfUzj7t7/dXgttcnTX16/CdJrjTEAU3pw82dw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZ3ek6kKU43A648ercUBWqvEVh3HZv9sYrQRYDSF84hJPZlSt7VYfxFAtA3sPPw+W
         t2cD3vtJwA6zK7JKdw3alNeHZjeZSYi7Xhxt2CxDFBY/xMUbWsg5hm6d/cMw4kpDZ/
         TkTMIGzanOIQlfLHRqaO2C/H9DenBJ9r9tzLiaAw=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openbmc@lists.ozlabs.org, Zev Weiss <zev@bewilderbeest.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Johan Hovold <johan@kernel.org>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] serial: 8250_aspeed_vuart: use UPF_IOREMAP to set up register mapping
Date:   Sun,  9 May 2021 20:42:31 -0500
Message-Id: <20210510014231.647-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510014231.647-1-zev@bewilderbeest.net>
References: <20210510014231.647-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Previously this driver's use of devm_ioremap_resource() led to
duplicated calls to __release_region() when unbinding it (one from
serial8250_release_std_resource() and one from devres_release_all()),
the second of which resulted in a warning message:

  # echo 1e787000.serial > /sys/bus/platform/drivers/aspeed-vuart/unbind
  [33091.774200] Trying to free nonexistent resource <000000001e787000-000000001e78703f>

With this change the driver uses the generic serial8250 code's
UPF_IOREMAP to take care of the register mapping automatically instead
of doing its own devm_ioremap_resource(), thus avoiding the duplicate
__release_region() on unbind.

In doing this we eliminate vuart->regs, since it merely duplicates
vuart->port->port.membase, which we now use for our I/O accesses.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Reported-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 249164dc397b..2bf1d8582d9a 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -34,7 +34,6 @@
 
 struct aspeed_vuart {
 	struct device		*dev;
-	void __iomem		*regs;
 	struct clk		*clk;
 	int			line;
 	struct timer_list	unthrottle_timer;
@@ -66,12 +65,12 @@ static const int unthrottle_timeout = HZ/10;
 
 static inline u8 aspeed_vuart_readb(struct aspeed_vuart *vuart, u8 reg)
 {
-	return readb(vuart->regs + reg);
+	return readb(vuart->port->port.membase + reg);
 }
 
 static inline void aspeed_vuart_writeb(struct aspeed_vuart *vuart, u8 val, u8 reg)
 {
-	writeb(val, vuart->regs + reg);
+	writeb(val, vuart->port->port.membase + reg);
 }
 
 static ssize_t lpc_address_show(struct device *dev,
@@ -429,13 +428,9 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	timer_setup(&vuart->unthrottle_timer, aspeed_vuart_unthrottle_exp, 0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	vuart->regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(vuart->regs))
-		return PTR_ERR(vuart->regs);
 
 	memset(&port, 0, sizeof(port));
 	port.port.private_data = vuart;
-	port.port.membase = vuart->regs;
 	port.port.mapbase = res->start;
 	port.port.mapsize = resource_size(res);
 	port.port.startup = aspeed_vuart_startup;
@@ -492,7 +487,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 	port.port.iotype = UPIO_MEM;
 	port.port.type = PORT_16550A;
 	port.port.uartclk = clk;
-	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
+	port.port.flags = UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF | UPF_IOREMAP
 		| UPF_FIXED_PORT | UPF_FIXED_TYPE | UPF_NO_THRE_TEST;
 
 	if (of_property_read_bool(np, "no-loopback-test"))
-- 
2.31.1

