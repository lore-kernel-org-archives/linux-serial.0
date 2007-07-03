From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] synclink: Remove bogus 'no change' termios optimisation
 from synclink drivers
Date: Tue, 3 Jul 2007 15:28:04 +0100
Message-ID: <20070703152804.5669a6d9@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52209 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754467AbXGCOW3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jul 2007 10:22:29 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, paulkf@microgate.com

Again this check is wrong now, and un-needed

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/synclink.c linux-2.6.22-rc6-mm1/drivers/char/synclink.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/synclink.c	2007-07-02 20:48:49.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/synclink.c	2007-07-02 21:06:50.000000000 +0100
@@ -160,8 +160,6 @@
 
 #define IO_PIN_SHUTDOWN_LIMIT 100
 
-#define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
-
 struct	_input_signal_events {
 	int	ri_up;	
 	int	ri_down;
@@ -3064,12 +3062,6 @@
 		printk("%s(%d):mgsl_set_termios %s\n", __FILE__,__LINE__,
 			tty->driver->name );
 	
-	/* just return if nothing has changed */
-	if ((tty->termios->c_cflag == old_termios->c_cflag)
-	    && (RELEVANT_IFLAG(tty->termios->c_iflag) 
-		== RELEVANT_IFLAG(old_termios->c_iflag)))
-	  return;
-
 	mgsl_change_params(info);
 
 	/* Handle transition to B0 status */
diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/synclink_gt.c linux-2.6.22-rc6-mm1/drivers/char/synclink_gt.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/synclink_gt.c	2007-07-02 20:48:49.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/synclink_gt.c	2007-07-02 21:06:50.000000000 +0100
@@ -144,8 +144,6 @@
 /*
  * tty support and callbacks
  */
-#define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
-
 static struct tty_driver *serial_driver;
 
 static int  open(struct tty_struct *tty, struct file * filp);
@@ -823,12 +821,6 @@
 
 	DBGINFO(("%s set_termios\n", tty->driver->name));
 
-	/* just return if nothing has changed */
-	if ((tty->termios->c_cflag == old_termios->c_cflag)
-	    && (RELEVANT_IFLAG(tty->termios->c_iflag)
-		== RELEVANT_IFLAG(old_termios->c_iflag)))
-		return;
-
 	change_params(info);
 
 	/* Handle transition to B0 status */
diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/synclinkmp.c linux-2.6.22-rc6-mm1/drivers/char/synclinkmp.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/synclinkmp.c	2007-07-02 20:47:23.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/synclinkmp.c	2007-07-02 21:06:50.000000000 +0100
@@ -135,8 +135,6 @@
 
 #define IO_PIN_SHUTDOWN_LIMIT 100
 
-#define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
-
 struct	_input_signal_events {
 	int	ri_up;
 	int	ri_down;
@@ -927,12 +925,6 @@
 		printk("%s(%d):%s set_termios()\n", __FILE__,__LINE__,
 			tty->driver->name );
 
-	/* just return if nothing has changed */
-	if ((tty->termios->c_cflag == old_termios->c_cflag)
-	    && (RELEVANT_IFLAG(tty->termios->c_iflag)
-		== RELEVANT_IFLAG(old_termios->c_iflag)))
-	  return;
-
 	change_params(info);
 
 	/* Handle transition to B0 status */
