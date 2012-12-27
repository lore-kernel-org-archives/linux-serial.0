From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 1/3] tty: Fix comments that reference BKL, eventd, old paths
Date: Wed, 26 Dec 2012 20:43:41 -0800
Message-ID: <c141e9cf9329550e53d18c9a8a2c6246@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [69.28.251.93] ([69.28.251.93]:60073 "EHLO b32.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab2L0Ey3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Dec 2012 23:54:29 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-serial@vger.kernel.org

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/tty/serial/serial_core.c |   18 +++++++++---------
 drivers/tty/tty_io.c             |    2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2c7230a..83d127f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1308,9 +1308,10 @@ static void uart_set_termios(struct tty_struct *tty,
 }
 
 /*
- * In 2.4.5, calls to this will be serialized via the BKL in
- *  linux/drivers/char/tty_io.c:tty_release()
- *  linux/drivers/char/tty_io.c:do_tty_handup()
+ * Calls to uart_close() are serialised via the tty_lock in
+ *   drivers/tty/tty_io.c:tty_release()
+ *   drivers/tty/tty_io.c:do_tty_hangup()
+ * This runs from a workqueue and can sleep for a _short_ time only.
  */
 static void uart_close(struct tty_struct *tty, struct file *filp)
 {
@@ -1437,10 +1438,9 @@ static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
 }
 
 /*
- * This is called with the BKL held in
- *  linux/drivers/char/tty_io.c:do_tty_hangup()
- * We're called from the eventd thread, so we can sleep for
- * a _short_ time only.
+ * Calls to uart_hangup() are serialised by the tty_lock in
+ *   drivers/tty/tty_io.c:do_tty_hangup()
+ * This runs from a workqueue and can sleep for a _short_ time only.
  */
 static void uart_hangup(struct tty_struct *tty)
 {
@@ -1521,8 +1521,8 @@ static void uart_dtr_rts(struct tty_port *port, int onoff)
 }
 
 /*
- * calls to uart_open are serialised by the BKL in
- *   fs/char_dev.c:chrdev_open()
+ * Calls to uart_open are serialised by the tty_lock in
+ *   drivers/tty/tty_io.c:tty_open()
  * Note that if this fails, then uart_close() _will_ be called.
  *
  * In time, we want to scrap the "opening nonpresent ports"
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index da9fde8..54a254a 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -536,7 +536,7 @@ EXPORT_SYMBOL_GPL(tty_wakeup);
  *	__tty_hangup		-	actual handler for hangup events
  *	@work: tty device
  *
- *	This can be called by the "eventd" kernel thread.  That is process
+ *	This can be called by a "kworker" kernel thread.  That is process
  *	synchronous but doesn't hold any locks, so we need to make sure we
  *	have the appropriate locks for what we're doing.
  *
-- 
1.7.10.4

