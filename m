Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4D1C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 21:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01DA161465
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 21:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbhI2VOG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 17:14:06 -0400
Received: from phobos.denx.de ([85.214.62.61]:51580 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346861AbhI2VOD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 17:14:03 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:504a:b573:3d62:4f2f:678d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id BE85D80644;
        Wed, 29 Sep 2021 23:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632949939;
        bh=+Vbj7BdTPdd2VOuxbKMB9TKssRPFfwfJDUODpvvPd3M=;
        h=From:To:Cc:Subject:Date:From;
        b=K5IZR1A5aFzrFJIUpGfPZBfpzwuBAD/7FLZMhRm4ZEUWWxjoQChgko3ydv9E3/Adt
         3dk31m/AnkfWKUdlZLTumWXWhA5cDeyYboBwtDwfuPEiXyO4B96wIo17uwPcZBamfc
         z2VLVeaCov+gbUGnJwWWbwVMnqMf7hFK+wfFIg0XA4gpllnMsIPzLO29rRSSY56DmL
         pRSAjpw4aZ63zDH49UnzUU/vcWw2Xv8FibtbaVtbdUvAfiFy0dhvwaBSGaKA4c1Xe7
         4fLzoyfLENqjVjp82qJBDzAj5h3FNlAu1RoiBI93RlQgJNJBkB/eeDJSYaEw3IcqgO
         y/y6JnHW1ZnXA==
From:   Fabio Estevam <festevam@denx.de>
To:     gregkh@linuxfoundation.org
Cc:     michael@walle.cc, linux-serial@vger.kernel.org, johan@kernel.org,
        marex@denx.de, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] serial: imx: Fix sysrq deadlock
Date:   Wed, 29 Sep 2021 18:11:59 -0300
Message-Id: <20210929211159.6238-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following sysrq command causes the following deadlock:

 # echo t > /proc/sysrq-trigger
 ....
[   20.325246] ======================================================
[   20.325252] WARNING: possible circular locking dependency detected
[   20.325260] 5.15.0-rc2-next-20210924-00004-gd2d6e664f29f-dirty #163
Not tainted
[   20.325273] ------------------------------------------------------
[   20.325279] sh/236 is trying to acquire lock:
[   20.325293] c1618614 (console_owner){-...}-{0:0}, at:
console_unlock+0x180/0x5bc
[   20.325361]
[   20.325361] but task is already holding lock:
[   20.325368] eefccc90 (&pool->lock){-.-.}-{2:2}, at:
show_workqueue_state+0x104/0x3c8
[   20.325432]
[   20.325432] which lock already depends on the new lock.

...

[   20.325657] -> #2 (&pool->lock/1){-.-.}-{2:2}:
[   20.325690]        __queue_work+0x114/0x810
[   20.325710]        queue_work_on+0x54/0x94
[   20.325727]        __imx_uart_rxint.constprop.0+0x1b4/0x2e0
[   20.325760]        imx_uart_int+0x270/0x310

This problem happens because uart_handle_sysrq_char() is called
with the lock held.

Fix this by using the same approach done in commit 5697df7322fe ("serial:
fsl_lpuart: split sysrq handling"), which calls uart_prepare_sysrq_char()
and uart_unlock_and_check_sysrq() instead.

Its commit log says:

"Instead of uart_handle_sysrq_char() use uart_prepare_sysrq_char() and
uart_unlock_and_check_sysrq(). This will call handle_sysrq() without
holding the port lock, which in turn let us drop the spin_trylock hack."

Do the same here to fix the deadlock.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/tty/serial/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..c945f6f64ebe 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -788,6 +788,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 	unsigned int rx, flg, ignored = 0;
 	struct tty_port *port = &sport->port.state->port;
 
+	uart_unlock_and_check_sysrq(&sport->port);
 	while (imx_uart_readl(sport, USR2) & USR2_RDR) {
 		u32 usr2;
 
@@ -803,7 +804,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
 			continue;
 
 		if (unlikely(rx & URXD_ERR)) {
@@ -846,6 +847,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 out:
 	tty_flip_buffer_push(port);
 
+	spin_lock(&sport->port.lock);
 	return IRQ_HANDLED;
 }
 
@@ -1977,9 +1979,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned int ucr1;
 	int locked = 1;
 
-	if (sport->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
+	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&sport->port.lock, flags);
 	else
 		spin_lock_irqsave(&sport->port.lock, flags);
-- 
2.25.1

