From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] serial: remove termios checks from various old char serial
 drivers
Date: Tue, 3 Jul 2007 15:45:25 +0100
Message-ID: <20070703154525.4f42688f@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59290 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754306AbXGCOjL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Jul 2007 10:39:11 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: akpm@osdl.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/cyclades.c linux-2.6.22-rc6-mm1/drivers/char/cyclades.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/cyclades.c	2007-07-02 20:50:11.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/cyclades.c	2007-07-02 21:05:53.000000000 +0100
@@ -4164,10 +4164,6 @@
 	printk(KERN_DEBUG "cyc:cy_set_termios ttyC%d\n", info->line);
 #endif
 
-	if (tty->termios->c_cflag == old_termios->c_cflag &&
-			(tty->termios->c_iflag & (IXON | IXANY)) ==
-			(old_termios->c_iflag & (IXON | IXANY)))
-		return;
 	set_line_char(info);
 
 	if ((old_termios->c_cflag & CRTSCTS) &&
diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/esp.c linux-2.6.22-rc6-mm1/drivers/char/esp.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/esp.c	2007-07-02 20:47:23.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/esp.c	2007-07-02 21:05:53.000000000 +0100
@@ -1121,8 +1121,6 @@
 	/*
 	 * Set up parity check flag
 	 */
-#define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
-
 	info->read_status_mask = UART_LSR_OE | UART_LSR_THRE | UART_LSR_DR;
 	if (I_INPCK(info->tty))
 		info->read_status_mask |= UART_LSR_FE | UART_LSR_PE;
@@ -1920,11 +1918,6 @@
 	struct esp_struct *info = (struct esp_struct *)tty->driver_data;
 	unsigned long flags;
 
-	if (   (tty->termios->c_cflag == old_termios->c_cflag)
-	    && (   RELEVANT_IFLAG(tty->termios->c_iflag) 
-		== RELEVANT_IFLAG(old_termios->c_iflag)))
-		return;
-
 	change_speed(info);
 
 	spin_lock_irqsave(&info->lock, flags);
diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/istallion.c linux-2.6.22-rc6-mm1/drivers/char/istallion.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/istallion.c	2007-07-02 20:50:11.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/istallion.c	2007-07-02 21:06:25.000000000 +0100
@@ -1753,9 +1753,6 @@
 		return;
 
 	tiosp = tty->termios;
-	if ((tiosp->c_cflag == old->c_cflag) &&
-	    (tiosp->c_iflag == old->c_iflag))
-		return;
 
 	stli_mkasyport(portp, &aport, tiosp);
 	stli_cmdwait(brdp, portp, A_SETPORT, &aport, sizeof(asyport_t), 0);
diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/mxser.c linux-2.6.22-rc6-mm1/drivers/char/mxser.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/mxser.c	2007-07-02 20:48:49.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/mxser.c	2007-07-02 21:06:25.000000000 +0100
@@ -90,8 +90,6 @@
 #define UART_MCR_AFE		0x20
 #define UART_LSR_SPECIAL	0x1E
 
-#define RELEVANT_IFLAG(iflag)	(iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK|\
-					  IXON|IXOFF))
 
 #define IRQ_T(info) ((info->flags & ASYNC_SHARE_IRQ) ? IRQF_SHARED : IRQF_DISABLED)
 
@@ -1729,16 +1727,12 @@
 	struct mxser_struct *info = tty->driver_data;
 	unsigned long flags;
 
-	if ((tty->termios->c_cflag != old_termios->c_cflag) ||
-			(RELEVANT_IFLAG(tty->termios->c_iflag) != RELEVANT_IFLAG(old_termios->c_iflag))) {
+	mxser_change_speed(info, old_termios);
 
-		mxser_change_speed(info, old_termios);
-
-		if ((old_termios->c_cflag & CRTSCTS) &&
-				!(tty->termios->c_cflag & CRTSCTS)) {
-			tty->hw_stopped = 0;
-			mxser_start(tty);
-		}
+	if ((old_termios->c_cflag & CRTSCTS) &&
+			!(tty->termios->c_cflag & CRTSCTS)) {
+		tty->hw_stopped = 0;
+		mxser_start(tty);
 	}
 
 /* Handle sw stopped */
diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/mxser_new.c linux-2.6.22-rc6-mm1/drivers/char/mxser_new.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/mxser_new.c	2007-07-02 20:50:11.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/mxser_new.c	2007-07-02 21:06:25.000000000 +0100
@@ -72,8 +72,6 @@
 #define UART_MCR_AFE		0x20
 #define UART_LSR_SPECIAL	0x1E
 
-#define RELEVANT_IFLAG(iflag)	(iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK|\
-					  IXON|IXOFF))
 
 #define C168_ASIC_ID    1
 #define C104_ASIC_ID    2
@@ -1990,18 +1988,14 @@
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
-	if ((tty->termios->c_cflag != old_termios->c_cflag) ||
-			(RELEVANT_IFLAG(tty->termios->c_iflag) != RELEVANT_IFLAG(old_termios->c_iflag))) {
-
-		spin_lock_irqsave(&info->slock, flags);
-		mxser_change_speed(info, old_termios);
-		spin_unlock_irqrestore(&info->slock, flags);
+	spin_lock_irqsave(&info->slock, flags);
+	mxser_change_speed(info, old_termios);
+	spin_unlock_irqrestore(&info->slock, flags);
 
-		if ((old_termios->c_cflag & CRTSCTS) &&
-				!(tty->termios->c_cflag & CRTSCTS)) {
-			tty->hw_stopped = 0;
-			mxser_start(tty);
-		}
+	if ((old_termios->c_cflag & CRTSCTS) &&
+			!(tty->termios->c_cflag & CRTSCTS)) {
+		tty->hw_stopped = 0;
+		mxser_start(tty);
 	}
 
 	/* Handle sw stopped */
diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.22-rc6-mm1/drivers/char/nozomi.c linux-2.6.22-rc6-mm1/drivers/char/nozomi.c
--- linux.vanilla-2.6.22-rc6-mm1/drivers/char/nozomi.c	2007-07-02 20:50:11.000000000 +0100
+++ linux-2.6.22-rc6-mm1/drivers/char/nozomi.c	2007-07-02 21:06:25.000000000 +0100
@@ -192,8 +192,6 @@
     }\
 } while(0)
 
-#define RELEVANT_IFLAG(iflag) ((iflag) & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
-
 /*    Defines */
 #define NOZOMI_NAME     "nozomi"
 #define NOZOMI_NAME_TTY "nozomi_tty"
@@ -1869,15 +1867,6 @@
 
 	cflag = tty->termios->c_cflag;
 
-	if (old_termios) {
-		if ((cflag == old_termios->c_cflag) &&
-		    (RELEVANT_IFLAG(tty->termios->c_iflag) ==
-		     RELEVANT_IFLAG(old_termios->c_iflag))) {
-			D1(" - nothing to change...");
-			goto exit_termios;
-		}
-	}
-
 	/* get the byte size */
 	switch (cflag & CSIZE) {
 	case CS5:
