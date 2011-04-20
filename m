From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/7] TTY: serial_core, remove invalid test
Date: Wed, 20 Apr 2011 10:43:16 +0200
Message-ID: <1303288998-31718-5-git-send-email-jslaby@suse.cz>
References: <1303288998-31718-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303288998-31718-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: jirislaby@gmail.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

tty->index (named here as line) is set up in initialize_tty_struct.
The value is checked in get_tty_driver for the found driver as:
	if (device < base || device >= base + p->num)
		continue;
	*index = device - base;

So index/line can never be more than driver->num. Hence remove this
test from uart_open.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/serial_core.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index d4bd465..848fd13 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1543,15 +1543,6 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
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
