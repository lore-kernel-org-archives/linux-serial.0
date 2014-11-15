From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH] serial: pxa: prepare/unprepare clocks
Date: Sat, 15 Nov 2014 22:52:48 +0300
Message-ID: <1416081168-28423-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36303 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbaKOTxA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 15 Nov 2014 14:53:00 -0500
Received: by mail-wi0-f169.google.com with SMTP id n3so2224169wiv.0
        for <linux-serial@vger.kernel.org>; Sat, 15 Nov 2014 11:52:58 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

Change clk_enable/disable() calls to clk_prepare_enable() and
clk_disable_unrepapre().

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/tty/serial/pxa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 21b7d8b8..2f4c329 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -647,7 +647,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;
 
-	clk_enable(up->clk);
+	clk_prepare_enable(up->clk);
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
@@ -674,7 +674,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
-	clk_disable(up->clk);
+	clk_disable_unprepare(up->clk);
 
 }
 
-- 
2.1.1

