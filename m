From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] mxser: remove unused parameters
Date: Fri,  8 Sep 2017 15:36:51 +0200
Message-ID: <20170908133651.30157-2-jslaby@suse.cz>
References: <20170908133651.30157-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908133651.30157-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Remove
* pdev from mxser_initbrd
* old_termios from mxser_change_speed
as they are unused and update the callers.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6b5f0c796a31..a6c6aa003893 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -642,8 +642,7 @@ static int mxser_set_baud(struct tty_struct *tty, long newspd)
  * This routine is called to set the UART divisor registers to match
  * the specified baud rate for a serial port.
  */
-static int mxser_change_speed(struct tty_struct *tty,
-					struct ktermios *old_termios)
+static int mxser_change_speed(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned cflag, cval, fcr;
@@ -945,7 +944,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	/*
 	 * and set the speed of the serial port
 	 */
-	mxser_change_speed(tty, NULL);
+	mxser_change_speed(tty);
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	return 0;
@@ -1288,7 +1287,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 	if (tty_port_initialized(port)) {
 		if (flags != (port->flags & ASYNC_SPD_MASK)) {
 			spin_lock_irqsave(&info->slock, sl_flags);
-			mxser_change_speed(tty, NULL);
+			mxser_change_speed(tty);
 			spin_unlock_irqrestore(&info->slock, sl_flags);
 		}
 	} else {
@@ -1946,7 +1945,7 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	mxser_change_speed(tty, old_termios);
+	mxser_change_speed(tty);
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
@@ -2375,8 +2374,7 @@ static void mxser_release_ISA_res(struct mxser_board *brd)
 	mxser_release_vector(brd);
 }
 
-static int mxser_initbrd(struct mxser_board *brd,
-		struct pci_dev *pdev)
+static int mxser_initbrd(struct mxser_board *brd)
 {
 	struct mxser_port *info;
 	unsigned int i;
@@ -2640,7 +2638,7 @@ static int mxser_probe(struct pci_dev *pdev,
 	}
 
 	/* mxser_initbrd will hook ISR. */
-	retval = mxser_initbrd(brd, pdev);
+	retval = mxser_initbrd(brd);
 	if (retval)
 		goto err_rel3;
 
@@ -2746,7 +2744,7 @@ static int __init mxser_module_init(void)
 				brd->info->name, ioaddr[b]);
 
 		/* mxser_initbrd will hook ISR. */
-		if (mxser_initbrd(brd, NULL) < 0) {
+		if (mxser_initbrd(brd) < 0) {
 			mxser_release_ISA_res(brd);
 			brd->info = NULL;
 			continue;
-- 
2.14.1
