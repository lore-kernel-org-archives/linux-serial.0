Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A53FECAAD1
	for <linux-serial@archiver.kernel.org>; Wed, 31 Aug 2022 16:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiHaQKM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbiHaQKA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Aug 2022 12:10:00 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37047764E
        for <linux-serial@vger.kernel.org>; Wed, 31 Aug 2022 09:09:52 -0700 (PDT)
X-QQ-mid: bizesmtp64t1661962181tv52g9lm
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 00:09:35 +0800 (CST)
X-QQ-SSF: 01000000000000B0C000000A0000000
X-QQ-FEAT: o+V1LJLjbvwOwVohsWYhpDR45yOuiAkdVTqBlN5NEX9a2umtgnkFjIjfMupXE
        HkPKrtvJdMEJE9PIT8hqWA1hsaEHCHm+siCFBmGjpN6u86euDKmKbWtQSapeIerk+2qLsHF
        zoR/08591IgboPaRiMSUYmlhCd8UhnpX3W0PwzXg017MAuu84xRkjaDcmOeBxXN2o1vJ4N2
        Xbw1SzhV2EoLBe/laL9rWM0NlnS4vRg/xaqXMUs4Xszs6rnlBtE3imOhgEIt8JJ2IEjpaoW
        MnN3st7U6Ibbv4mmXof1yaUmSeIOb8wDLNQbyhl6FsOaN43AvXhvm3g+UMlct1cdoXkx+wB
        wu+0M+e3p90b3G/HYYcXu0TN1mGzEob/9+u3bRf
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc:     jirislaby@kernel.org, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] serial: Fix double word
Date:   Wed, 31 Aug 2022 12:09:34 -0400
Message-Id: <20220831160934.7986-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fix double word "start start" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/tty/serial/8250/8250_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 39b35a61958c..26c8a66629d0 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1133,7 +1133,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * internal UARTs.
 	 * We're going to explicitly set the UUE bit to 0 before
 	 * trying to write and read a 1 just to make sure it's not
-	 * already a 1 and maybe locked there before we even start start.
+	 * already a 1 and maybe locked there before we even start.
 	 */
 	iersave = serial_in(up, UART_IER);
 	serial_out(up, UART_IER, iersave & ~UART_IER_UUE);
-- 
2.35.1

