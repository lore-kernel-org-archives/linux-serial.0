From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 27/48] Char: nozomi, remove port.count checks
Date: Mon, 23 May 2011 12:10:33 -0700
Message-ID: <1306177854-18172-27-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47324 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593Ab1EWTLV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:21 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

Before 33dd474a, these were some kind of protection against race with
HUP. They were protected with port->tty_sem at the same time.

By that commit, the counting was switched to tty_port's one, but the
locking remained the old one. So the count was not protected by
any lock anymore.

The driver should not test whether it raced with HUP or not anyways.
With the new refcounted tty model, it just should proceed as nothing
happened because all needed info is still there. In respect to this,
let's drop the useless and unprotected tests (tty_port->count is
protected by tty_port->lock).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Tested-by: Gerald Pfeifer <gerald@pfeifer.com>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/nozomi.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index acaecc1..c34d622 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1690,11 +1690,6 @@ static int ntty_write(struct tty_struct *tty, const unsigned char *buffer,
 
 	mutex_lock(&port->tty_sem);
 
-	if (unlikely(!port->port.count)) {
-		DBG1(" ");
-		goto exit;
-	}
-
 	rval = kfifo_in(&port->fifo_ul, (unsigned char *)buffer, count);
 
 	/* notify card */
@@ -1740,8 +1735,7 @@ static int ntty_write_room(struct tty_struct *tty)
 
 	if (dc) {
 		mutex_lock(&port->tty_sem);
-		if (port->port.count)
-			room = kfifo_avail(&port->fifo_ul);
+		room = kfifo_avail(&port->fifo_ul);
 		mutex_unlock(&port->tty_sem);
 	}
 	return room;
@@ -1889,11 +1883,6 @@ static s32 ntty_chars_in_buffer(struct tty_struct *tty)
 		goto exit_in_buffer;
 	}
 
-	if (unlikely(!port->port.count)) {
-		dev_err(&dc->pdev->dev, "No tty open?\n");
-		goto exit_in_buffer;
-	}
-
 	rval = kfifo_len(&port->fifo_ul);
 
 exit_in_buffer:
-- 
1.7.4.2

