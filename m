From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 30/48] TTY: serial_core, remove invalid test
Date: Mon, 23 May 2011 12:10:36 -0700
Message-ID: <1306177854-18172-30-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42077 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932634Ab1EWTLb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:31 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jiri Slaby <jslaby@suse.cz>

tty->index (named here as line) is set up in initialize_tty_struct.
The value is checked in get_tty_driver for the found driver as:
	if (device < base || device >= base + p->num)
		continue;
	*index = device - base;

So index/line can never be more than driver->num. Hence remove this
test from uart_open.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 55965d5..69d0000 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1530,15 +1530,6 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	pr_debug("uart_open(%d) called\n", line);
 
 	/*
-	 * tty->driver->num won't change, so we won't fail here with
-	 * tty->driver_data set to something non-NULL (and therefore
-	 * we won't get caught by uart_close()).
-	 */
-	retval = -ENODEV;
-	if (line >= tty->driver->num)
-		goto fail;
-
-	/*
 	 * We take the semaphore inside uart_get to guarantee that we won't
 	 * be re-entered while allocating the state structure, or while we
 	 * request any IRQs that the driver may need.  This also has the nice
-- 
1.7.4.2

