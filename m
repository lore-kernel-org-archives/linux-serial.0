From: Sergei Organov <osv@topconrd.ru>
Subject: [PATCH] Fix TIOCSBRK/TIOCCBRK handling by mxser.c.
Date: 18 Sep 2003 17:42:47 +0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <87brtigqlk.fsf@osv.topconrd.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from topconrd.ru ([62.105.138.7]:19716 "EHLO TopconRD.RU")
	by vger.kernel.org with ESMTP id S261321AbTIRNms (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Sep 2003 09:42:48 -0400
Received: from osv.topconrd.ru (osv@osv.javad.ru [62.105.138.43])
	by TopconRD.RU (8.12.3/8.12.3/Debian-6.4) with ESMTP id h8IDgl67010006
	for <linux-serial@vger.kernel.org>; Thu, 18 Sep 2003 17:42:47 +0400
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

The patch below fixes TIOCSBRK/TIOCCBRK handling in 'mxser.c' by means of
defining break_ctl routine for tty_driver.

--- linux-2.4.19/drivers/char/mxser.c.old	Sat Aug  3 04:39:43 2002
+++ linux-2.4.19/drivers/char/mxser.c	Thu Sep 18 17:33:21 2003
@@ -29,11 +29,14 @@
  *
  *      for             : LINUX 2.0.X, 2.2.X, 2.4.X
  *      date            : 2001/05/01
- *      version         : 1.2 
+ *      version         : 1.2
  *      
  *    Fixes for C104H/PCI by Tim Hockin <thockin@sun.com>
  *    Added support for: C102, CI-132, CI-134, CP-132, CP-114, CT-114 cards
  *                        by Damian Wrobel <dwrobel@ertel.com.pl>
+ *    09/03: Use tty_driver.break_ctl for break control. This fixes handling
+ *           of TIOCSBRK/TIOCCBRK by the driver.
+ *                        by Sergei Organov <osv@topconrd.ru>
  *
  */
 
@@ -65,7 +68,7 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
-#define		MXSER_VERSION			"1.2.1"
+#define		MXSER_VERSION			"1.2.2"
 
 #define		MXSERMAJOR	 	174
 #define		MXSERCUMAJOR		175
@@ -368,7 +371,7 @@
 static int mxser_get_serial_info(struct mxser_struct *, struct serial_struct *);
 static int mxser_set_serial_info(struct mxser_struct *, struct serial_struct *);
 static int mxser_get_lsr_info(struct mxser_struct *, unsigned int *);
-static void mxser_send_break(struct mxser_struct *, int);
+static void mxser_break_ctl(struct tty_struct *, int);
 static int mxser_get_modem_info(struct mxser_struct *, unsigned int *);
 static int mxser_set_modem_info(struct mxser_struct *, unsigned int, unsigned int *);
 
@@ -556,6 +559,7 @@
 	mxvar_sdriver.stop = mxser_stop;
 	mxvar_sdriver.start = mxser_start;
 	mxvar_sdriver.hangup = mxser_hangup;
+        mxvar_sdriver.break_ctl = mxser_break_ctl;
 
 	/*
 	 * The callout device is just like normal device except for
@@ -653,7 +657,7 @@
 		n = (sizeof(mxser_pcibrds) / sizeof(mxser_pcibrds[0])) - 1;
 		index = 0;
 		for (b = 0; b < n; b++) {
-			while (pdev = pci_find_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev)) 
+			while ((pdev = pci_find_device(mxser_pcibrds[b].vendor, mxser_pcibrds[b].device, pdev))) 
 			{
 				if (pci_enable_device(pdev))
 					continue;
@@ -1061,7 +1065,6 @@
 {
 	unsigned long flags;
 	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
-	int retval;
 	struct async_icount cprev, cnow;	/* kernel counter temps */
 	struct serial_icounter_struct *p_cuser;		/* user space */
 	unsigned long templ;
@@ -1074,21 +1077,6 @@
 			return (-EIO);
 	}
 	switch (cmd) {
-	case TCSBRK:		/* SVID version: non-zero arg --> no break */
-		retval = tty_check_change(tty);
-		if (retval)
-			return (retval);
-		tty_wait_until_sent(tty, 0);
-		if (!arg)
-			mxser_send_break(info, HZ / 4);		/* 1/4 second */
-		return (0);
-	case TCSBRKP:		/* support for POSIX tcsendbreak() */
-		retval = tty_check_change(tty);
-		if (retval)
-			return (retval);
-		tty_wait_until_sent(tty, 0);
-		mxser_send_break(info, arg ? arg * (HZ / 10) : HZ / 4);
-		return (0);
 	case TIOCGSOFTCAR:
 		return put_user(C_CLOCAL(tty) ? 1 : 0, (unsigned long *) arg);
 	case TIOCSSOFTCAR:
@@ -2253,19 +2241,18 @@
 }
 
 /*
- * This routine sends a break character out the serial port.
+ * This routine turns the break condition on or off
  */
-static void mxser_send_break(struct mxser_struct *info, int duration)
+static void mxser_break_ctl(struct tty_struct *tty, int break_state)
 {
+	struct mxser_struct *info = (struct mxser_struct *) tty->driver_data;
 	unsigned long flags;
-	if (!info->base)
-		return;
-	set_current_state(TASK_INTERRUPTIBLE);
-	save_flags(flags);
-	cli();
-	outb(inb(info->base + UART_LCR) | UART_LCR_SBC, info->base + UART_LCR);
-	schedule_timeout(duration);
-	outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC, info->base + UART_LCR);
+	
+	save_flags(flags); cli();
+	if (break_state == -1)
+          outb(inb(info->base + UART_LCR) | UART_LCR_SBC, info->base + UART_LCR);
+	else
+          outb(inb(info->base + UART_LCR) & ~UART_LCR_SBC, info->base + UART_LCR);
 	restore_flags(flags);
 }
 

