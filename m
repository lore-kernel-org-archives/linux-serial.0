Return-Path: <SRS0=Q4jN=7I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E2CC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 26 May 2020 14:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C1320723
	for <linux-serial@archiver.kernel.org>; Tue, 26 May 2020 14:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgEZO4f (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 26 May 2020 10:56:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:44776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbgEZO4f (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 26 May 2020 10:56:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 31CFFAD5C;
        Tue, 26 May 2020 14:56:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Raghavendra <rananta@codeaurora.org>
Subject: [PATCH] tty: hvc_console, fix crashes on parallel open/close
Date:   Tue, 26 May 2020 16:56:32 +0200
Message-Id: <20200526145632.13879-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

hvc_open sets tty->driver_data to NULL when open fails at some point.
Typically, the failure happens in hp->ops->notifier_add(). If there is
a racing process which tries to open such mangled tty, which was not
closed yet, the process will crash in hvc_open as tty->driver_data is
NULL.

All this happens because close wants to know whether open failed or not.
But ->open should not NULL this and other tty fields for ->close to be
happy. ->open should call tty_port_set_initialized(true) and close
should check by tty_port_initialized() instead. So do this properly in
this driver.

So this patch removes these from ->open:
* tty_port_tty_set(&hp->port, NULL). This happens on last close.
* tty->driver_data = NULL. Dtto.
* tty_port_put(&hp->port). This happens in shutdown and until now, this
  must have been causing a reference underflow, if I am not missing
  something.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-and-tested-by: Raghavendra <rananta@codeaurora.org>
---
 drivers/tty/hvc/hvc_console.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 436cc51c92c3..cdcc64ea2554 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -371,15 +371,14 @@ static int hvc_open(struct tty_struct *tty, struct file * filp)
 	 * tty fields and return the kref reference.
 	 */
 	if (rc) {
-		tty_port_tty_set(&hp->port, NULL);
-		tty->driver_data = NULL;
-		tty_port_put(&hp->port);
 		printk(KERN_ERR "hvc_open: request_irq failed with rc %d.\n", rc);
-	} else
+	} else {
 		/* We are ready... raise DTR/RTS */
 		if (C_BAUD(tty))
 			if (hp->ops->dtr_rts)
 				hp->ops->dtr_rts(hp, 1);
+		tty_port_set_initialized(&hp->port, true);
+	}
 
 	/* Force wakeup of the polling thread */
 	hvc_kick();
@@ -389,22 +388,12 @@ static int hvc_open(struct tty_struct *tty, struct file * filp)
 
 static void hvc_close(struct tty_struct *tty, struct file * filp)
 {
-	struct hvc_struct *hp;
+	struct hvc_struct *hp = tty->driver_data;
 	unsigned long flags;
 
 	if (tty_hung_up_p(filp))
 		return;
 
-	/*
-	 * No driver_data means that this close was issued after a failed
-	 * hvc_open by the tty layer's release_dev() function and we can just
-	 * exit cleanly because the kref reference wasn't made.
-	 */
-	if (!tty->driver_data)
-		return;
-
-	hp = tty->driver_data;
-
 	spin_lock_irqsave(&hp->port.lock, flags);
 
 	if (--hp->port.count == 0) {
@@ -412,6 +401,9 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 		/* We are done with the tty pointer now. */
 		tty_port_tty_set(&hp->port, NULL);
 
+		if (!tty_port_initialized(&hp->port))
+			return;
+
 		if (C_HUPCL(tty))
 			if (hp->ops->dtr_rts)
 				hp->ops->dtr_rts(hp, 0);
@@ -428,6 +420,7 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 		 * waking periodically to check chars_in_buffer().
 		 */
 		tty_wait_until_sent(tty, HVC_CLOSE_WAIT);
+		tty_port_set_initialized(&hp->port, false);
 	} else {
 		if (hp->port.count < 0)
 			printk(KERN_ERR "hvc_close %X: oops, count is %d\n",
-- 
2.26.2

