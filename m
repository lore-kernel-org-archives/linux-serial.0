From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/76] 68328serial: remove unsed m68k_serial->tqueue_hangup
Date: Wed, 16 Mar 2011 14:11:39 -0700
Message-ID: <1300309966-5745-9-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32839 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754195Ab1CPVNA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:13:00 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Greg Ungerer <gerg@uclinux.org>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tejun Heo <tj@kernel.org>

m68k_serial->tqueue_hangup is unused.  Remove it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/68328serial.c |   23 -----------------------
 drivers/tty/serial/68328serial.h |    1 -
 2 files changed, 0 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68328serial.c
index be0ebce..a9d9985 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -393,28 +393,6 @@ static void do_softint(struct work_struct *work)
 #endif   
 }
 
-/*
- * This routine is called from the scheduler tqueue when the interrupt
- * routine has signalled that a hangup has occurred.  The path of
- * hangup processing is:
- *
- * 	serial interrupt routine -> (scheduler tqueue) ->
- * 	do_serial_hangup() -> tty->hangup() -> rs_hangup()
- * 
- */
-static void do_serial_hangup(struct work_struct *work)
-{
-	struct m68k_serial	*info = container_of(work, struct m68k_serial, tqueue_hangup);
-	struct tty_struct	*tty;
-	
-	tty = info->port.tty;
-	if (!tty)
-		return;
-
-	tty_hangup(tty);
-}
-
-
 static int startup(struct m68k_serial * info)
 {
 	m68328_uart *uart = &uart_addr[info->line];
@@ -1348,7 +1326,6 @@ rs68328_init(void)
 	    info->count = 0;
 	    info->blocked_open = 0;
 	    INIT_WORK(&info->tqueue, do_softint);
-	    INIT_WORK(&info->tqueue_hangup, do_serial_hangup);
 	    init_waitqueue_head(&info->open_wait);
 	    init_waitqueue_head(&info->close_wait);
 	    info->line = i;
diff --git a/drivers/tty/serial/68328serial.h b/drivers/tty/serial/68328serial.h
index 664ceb0..8c9c3c0 100644
--- a/drivers/tty/serial/68328serial.h
+++ b/drivers/tty/serial/68328serial.h
@@ -159,7 +159,6 @@ struct m68k_serial {
 	int			xmit_tail;
 	int			xmit_cnt;
 	struct work_struct	tqueue;
-	struct work_struct	tqueue_hangup;
 	wait_queue_head_t	open_wait;
 	wait_queue_head_t	close_wait;
 };
-- 
1.7.4.1

