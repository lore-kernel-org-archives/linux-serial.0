Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D0BC32793
	for <linux-serial@archiver.kernel.org>; Wed, 24 Aug 2022 08:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiHXIGa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Aug 2022 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiHXIG3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Aug 2022 04:06:29 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E765676
        for <linux-serial@vger.kernel.org>; Wed, 24 Aug 2022 01:06:28 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id QlP5oD4V0XaejQlP5oyl50; Wed, 24 Aug 2022 10:06:26 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 24 Aug 2022 10:06:26 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] tty: serial: meson: Use devm_clk_get_enabled() helper
Date:   Wed, 24 Aug 2022 10:06:21 +0200
Message-Id: <3f18638cb3cf08ed8817addca1402ed5e3bd3602.1661328361.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The devm_clk_get_enabled() helper:
   - calls devm_clk_get()
   - calls clk_prepare_enable() and registers what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code, the error handling paths and avoid the need of
a dedicated function used with devm_add_action_or_reset().

That said, meson_uart_probe_clock() is now more or less the same as
devm_clk_get_enabled(), so use this function directly instead.

This also fixes an (unlikely) unchecked devm_add_action_or_reset() error.

Based on my test with allyesconfig, this reduces the .o size from:
   text	   data	    bss	    dec	    hex	filename
   16350	   5016	    128	  21494	   53f6	drivers/tty/serial/meson_uart.o
down to:
   15415	   4784	    128	  20327	   4f67	drivers/tty/serial/meson_uart.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
devm_clk_get_enabled() is new and is part of 6.0-rc1

If the message "couldn't enable clk\n" is of any use, it could be added
in meson_uart_probe_clocks() with a dev_err_probe() call. It wouldn't be
exactly the same meaning, but at least something would be logged.
---
 drivers/tty/serial/meson_uart.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 6c8db19fd572..26de08bf181e 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -667,29 +667,6 @@ static struct uart_driver meson_uart_driver = {
 	.cons		= MESON_SERIAL_CONSOLE,
 };
 
-static inline struct clk *meson_uart_probe_clock(struct device *dev,
-						 const char *id)
-{
-	struct clk *clk = NULL;
-	int ret;
-
-	clk = devm_clk_get(dev, id);
-	if (IS_ERR(clk))
-		return clk;
-
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(dev, "couldn't enable clk\n");
-		return ERR_PTR(ret);
-	}
-
-	devm_add_action_or_reset(dev,
-			(void(*)(void *))clk_disable_unprepare,
-			clk);
-
-	return clk;
-}
-
 static int meson_uart_probe_clocks(struct platform_device *pdev,
 				   struct uart_port *port)
 {
@@ -697,15 +674,15 @@ static int meson_uart_probe_clocks(struct platform_device *pdev,
 	struct clk *clk_pclk = NULL;
 	struct clk *clk_baud = NULL;
 
-	clk_pclk = meson_uart_probe_clock(&pdev->dev, "pclk");
+	clk_pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
 	if (IS_ERR(clk_pclk))
 		return PTR_ERR(clk_pclk);
 
-	clk_xtal = meson_uart_probe_clock(&pdev->dev, "xtal");
+	clk_xtal = devm_clk_get_enabled(&pdev->dev, "xtal");
 	if (IS_ERR(clk_xtal))
 		return PTR_ERR(clk_xtal);
 
-	clk_baud = meson_uart_probe_clock(&pdev->dev, "baud");
+	clk_baud = devm_clk_get_enabled(&pdev->dev, "baud");
 	if (IS_ERR(clk_baud))
 		return PTR_ERR(clk_baud);
 
-- 
2.34.1

