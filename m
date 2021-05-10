Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698EAC43460
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 01:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE20613DB
	for <linux-serial@archiver.kernel.org>; Mon, 10 May 2021 01:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhEJBoC (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 9 May 2021 21:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhEJBny (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 9 May 2021 21:43:54 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF5AC06138F;
        Sun,  9 May 2021 18:42:50 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2600:6c44:7f:ba20::7c6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 183ED8F;
        Sun,  9 May 2021 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1620610970;
        bh=vlGnGVyK4iFE6i7gI1NT1WgH61NFI88Q9/7ZXsupdiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BcJBeeuBZhCyfsh+6VtodsMsGjgttD050iuoW+DjcsfZwUq9YJoupO5dkk4gCEBhT
         /u+oLwGTOUEvBh/StNpzXuSr4TFtsf8SqImRyj7l3Pm/xfLbKHVQ3GF0zL/ivJtGmv
         UGaGxYsqHAaf9H6OB5gRsfDvsy9GuBwJy8lf4DzM=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     openbmc@lists.ozlabs.org, Zev Weiss <zev@bewilderbeest.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] serial: 8250_aspeed_vuart: initialize vuart->port in aspeed_vuart_probe()
Date:   Sun,  9 May 2021 20:42:30 -0500
Message-Id: <20210510014231.647-3-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510014231.647-1-zev@bewilderbeest.net>
References: <20210510014231.647-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Previously this had only been initialized if we hit the throttling path
in aspeed_vuart_handle_irq(); moving it to the probe function is a
slight consistency improvement and avoids redundant reinitialization in
the interrupt handler.  It also serves as preparation for converting the
driver's I/O accesses to use port->port.membase instead of its own
vuart->regs.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 9e8b2e8e32b6..249164dc397b 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -349,11 +349,9 @@ static int aspeed_vuart_handle_irq(struct uart_port *port)
 			struct aspeed_vuart *vuart = port->private_data;
 			__aspeed_vuart_set_throttle(up, true);
 
-			if (!timer_pending(&vuart->unthrottle_timer)) {
-				vuart->port = up;
+			if (!timer_pending(&vuart->unthrottle_timer))
 				mod_timer(&vuart->unthrottle_timer,
 					  jiffies + unthrottle_timeout);
-			}
 
 		} else {
 			count = min(space, 256);
@@ -511,6 +509,7 @@ static int aspeed_vuart_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 
 	vuart->line = rc;
+	vuart->port = serial8250_get_port(vuart->line);
 
 	rc = of_parse_phandle_with_fixed_args(
 		np, "aspeed,sirq-polarity-sense", 2, 0,
-- 
2.31.1

