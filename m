Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A255C433EF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 10:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4DF619E7
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 10:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353496AbhJAKUX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:20:23 -0400
Received: from phobos.denx.de ([85.214.62.61]:56324 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhJAKUX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 06:20:23 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:504a:3108:17dd:9790:6ab4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8BCCC80F1A;
        Fri,  1 Oct 2021 12:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1633083518;
        bh=nJuqml5xEbyn0aUHyDcc9snJ3aGTzalai0IYFMYeQhU=;
        h=From:To:Cc:Subject:Date:From;
        b=Wo3cJp6E52QBuYESt7QQJ6y9IqU4wf+/7B5sSvGcprOFAvQeh0HCq9mcFEtzj2hUa
         /kuHCOaM0LaLzU11ohpFjuaRDT2HZ9PzSJOVFTI4VZi3NpHVQWLGysahtDcyqy7DYm
         rGPMSo0vPYoL7d4epXPZKeLZM4QFdf4IPWYZCLx83DAch9mehheaOrg0mbGGQZ4G2V
         ji+uD5TZ5f0bPnM4s9psI8qpJjduVeFM+Zm5hUOOE+q71t7zd/HS8fJffi28swgBan
         rMsvAOiRTOiKXr3zmmFzPz6Dsxn6/DfCmaElhCeIner88Z3tgYfo44Yuv6uj0rfNb6
         N6qwREcbjn+lg==
From:   Fabio Estevam <festevam@denx.de>
To:     gregkh@linuxfoundation.org
Cc:     michael@walle.cc, linux-serial@vger.kernel.org, johan@kernel.org,
        marex@denx.de, u.kleine-koenig@pengutronix.de,
        Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3]  serial: imx: Suppress false positive sysrq lockdep warning 
Date:   Fri,  1 Oct 2021 07:18:15 -0300
Message-Id: <20211001101815.729648-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The following sysrq command causes the following lockdep warning:

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

Do the same here to suppress the false positive lockdep warning.

As __imx_uart_rxint() drops the lock now, remove the spin_unlock()
inside imx_uart_rxint(), which is only used on i.MX1.

Tested on a i.MX7D board via 'echo t > /proc/sysrq-trigger' in the
command line and also by passing the "<break> + t" keys in
the serial console.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Keep the cast when calling uart_prepare_sysrq_char() - Johan
- Improve commit log and subject - Johan

 drivers/tty/serial/imx.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b121cd869e9..a0135718c588 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -803,7 +803,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(&sport->port, (unsigned char)rx))
+		if (uart_prepare_sysrq_char(&sport->port, (unsigned char)rx))
 			continue;
 
 		if (unlikely(rx & URXD_ERR)) {
@@ -844,6 +844,7 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 	}
 
 out:
+	uart_unlock_and_check_sysrq(&sport->port);
 	tty_flip_buffer_push(port);
 
 	return IRQ_HANDLED;
@@ -852,15 +853,10 @@ static irqreturn_t __imx_uart_rxint(int irq, void *dev_id)
 static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
-	irqreturn_t ret;
 
 	spin_lock(&sport->port.lock);
 
-	ret = __imx_uart_rxint(irq, dev_id);
-
-	spin_unlock(&sport->port.lock);
-
-	return ret;
+	return __imx_uart_rxint(irq, dev_id);
 }
 
 static void imx_uart_clear_rx_errors(struct imx_port *sport);
@@ -959,6 +955,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 		imx_uart_writel(sport, USR1_AGTIM, USR1);
 
 		__imx_uart_rxint(irq, dev_id);
+		spin_lock(&sport->port.lock);
 		ret = IRQ_HANDLED;
 	}
 
@@ -1977,9 +1974,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
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

