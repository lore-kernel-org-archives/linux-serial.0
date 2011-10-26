From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 34/79] TTY: use tty_wait_until_sent_from_close in other drivers
Date: Wed, 26 Oct 2011 14:12:39 +0200
Message-ID: <1319631204-23262-34-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60996 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932872Ab1JZMNn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:43 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 67AA78F71C
	for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2011 14:13:42 +0200 (CEST)
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Let's use the newly added helper to avoid stalls in drivers which are
not yet ported to tty_port helpers.

Those which are broken (call tty_wait_until_sent with irqs disabled)
are left untouched. They are in a deeper trouble than we are trying to
solve here. This includes amiserial, 68328serial, 68360serial and
crisv10.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/isdn/i4l/isdn_tty.c      |    2 +-
 drivers/tty/hvc/hvc_console.c    |    2 +-
 drivers/tty/hvc/hvcs.c           |    2 +-
 drivers/tty/serial/serial_core.c |    3 ++-
 net/irda/ircomm/ircomm_tty.c     |    2 +-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index d850427..e5546cb 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1693,7 +1693,7 @@ isdn_tty_close(struct tty_struct *tty, struct file *filp)
 	 * line status register.
 	 */
 	if (info->flags & ISDN_ASYNC_INITIALIZED) {
-		tty_wait_until_sent(tty, 3000);	/* 30 seconds timeout */
+		tty_wait_until_sent_from_close(tty, 3000);	/* 30 seconds timeout */
 		/*
 		 * Before we drop DTR, make sure the UART transmitter
 		 * has completely drained; this is especially
diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index e1aaf4f..b6b2d18 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -388,7 +388,7 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 		 * there is no buffered data otherwise sleeps on a wait queue
 		 * waking periodically to check chars_in_buffer().
 		 */
-		tty_wait_until_sent(tty, HVC_CLOSE_WAIT);
+		tty_wait_until_sent_from_close(tty, HVC_CLOSE_WAIT);
 	} else {
 		if (hp->count < 0)
 			printk(KERN_ERR "hvc_close %X: oops, count is %d\n",
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 4c8b665..e523773 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1237,7 +1237,7 @@ static void hvcs_close(struct tty_struct *tty, struct file *filp)
 		irq = hvcsd->vdev->irq;
 		spin_unlock_irqrestore(&hvcsd->lock, flags);
 
-		tty_wait_until_sent(tty, HVCS_CLOSE_WAIT);
+		tty_wait_until_sent_from_close(tty, HVCS_CLOSE_WAIT);
 
 		/*
 		 * This line is important because it tells hvcs_open that this
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0464360..1d3780c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1292,7 +1292,8 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	if (port->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, msecs_to_jiffies(port->closing_wait));
+		tty_wait_until_sent_from_close(tty,
+				msecs_to_jiffies(port->closing_wait));
 
 	/*
 	 * At this point, we stop accepting input.  To do this, we
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index b3cc8b3..253695d 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -551,7 +551,7 @@ static void ircomm_tty_close(struct tty_struct *tty, struct file *filp)
 	 */
 	tty->closing = 1;
 	if (self->closing_wait != ASYNC_CLOSING_WAIT_NONE)
-		tty_wait_until_sent(tty, self->closing_wait);
+		tty_wait_until_sent_from_close(tty, self->closing_wait);
 
 	ircomm_tty_shutdown(self);
 
-- 
1.7.7

