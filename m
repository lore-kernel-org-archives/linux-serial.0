From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [Patch] new serial flow control
Date: Tue, 5 Oct 2004 00:55:30 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20041004225530.GG2593__12175.7635068663$1097049024$gmane$org@bouh.is-a-geek.org>
References: <20041004225430.GF2593@bouh.is-a-geek.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yEPQxsgoJgBvi8ip"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from iona.labri.fr ([147.210.8.143]:38058 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S269091AbUJFHqr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Oct 2004 03:46:47 -0400
Received: from localhost (guismo.drimm.u-bordeaux1.fr [147.210.36.243])
	by localhost.labri.fr (Postfix) with ESMTP id DD9FC1017B5
	for <linux-serial@vger.kernel.org>; Wed,  6 Oct 2004 09:46:46 +0200 (CEST)
Received: from iona.labri.fr ([147.210.8.143])
 by localhost (guismo [147.210.36.243]) (amavisd-new, port 10024) with LMTP
 id 06939-06-7 for <linux-serial@vger.kernel.org>;
 Wed,  6 Oct 2004 09:46:44 +0200 (CEST)
Received: from bouh.labri.fr (bouh.labri.fr [147.210.20.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by iona.labri.fr (Postfix) with ESMTP id BC3C91017A9
	for <linux-serial@vger.kernel.org>; Wed,  6 Oct 2004 09:46:44 +0200 (CEST)
Received: from samy by bouh.labri.fr with local (Exim 3.35 #1 (Debian))
	id 1CF6VX-0000nj-00
	for <linux-serial@vger.kernel.org>; Wed, 06 Oct 2004 09:46:43 +0200
Content-Disposition: inline
In-Reply-To: <20041004225430.GF2593@bouh.is-a-geek.org>
List-Id: linux-serial@vger.kernel.org
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, sebastien.hinderer@libertysurf.fr


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is patch for 2.6

--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tvbpatch-2.6"

diff -ur linux-2.6.8.1-orig/drivers/serial/serial_core.c linux-2.6.8.1-tvb/drivers/serial/serial_core.c
--- linux-2.6.8.1-orig/drivers/serial/serial_core.c	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6.8.1-tvb/drivers/serial/serial_core.c	2004-09-30 00:36:27.000000000 +0200
@@ -118,23 +118,6 @@
 	}
 }
 
-static inline void
-uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
-{
-	unsigned long flags;
-	unsigned int old;
-
-	spin_lock_irqsave(&port->lock, flags);
-	old = port->mctrl;
-	port->mctrl = (old & ~clear) | set;
-	if (old != port->mctrl)
-		port->ops->set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
-}
-
-#define uart_set_mctrl(port,set)	uart_update_mctrl(port,set,0)
-#define uart_clear_mctrl(port,clear)	uart_update_mctrl(port,0,clear)
-
 /*
  * Startup the port.  This will be called once per open.  All calls
  * will be serialised by the per-port semaphore.
@@ -187,8 +170,13 @@
 			 * Setup the RTS and DTR signals once the
 			 * port is open and ready to respond.
 			 */
-			if (info->tty->termios->c_cflag & CBAUD)
-				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
+			if (info->tty->termios->c_cflag & CBAUD) {
+				uart_set_mctrl(port, TIOCM_DTR);
+				if (info->tty->termios->c_cflag & CTVB)
+					uart_clear_mctrl(port, TIOCM_RTS);
+				else
+					uart_set_mctrl(port, TIOCM_RTS);
+			}
 		}
 
 		info->flags |= UIF_INITIALIZED;
@@ -434,6 +422,11 @@
 	else
 		state->info->flags &= ~UIF_CTS_FLOW;
 
+	if (termios->c_cflag & CTVB)
+		state->info->flags |= UIF_TVB_FLOW;
+	else
+		state->info->flags &= ~UIF_TVB_FLOW;
+
 	if (termios->c_cflag & CLOCAL)
 		state->info->flags &= ~UIF_CHECK_CD;
 	else
@@ -1180,8 +1173,8 @@
 	/* Handle transition away from B0 status */
 	if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		unsigned int mask = TIOCM_DTR;
-		if (!(cflag & CRTSCTS) ||
-		    !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!(cflag & CTVB) && (!(cflag & CRTSCTS) ||
+		    !test_bit(TTY_THROTTLED, &tty->flags)))
 			mask |= TIOCM_RTS;
 		uart_set_mctrl(state->port, mask);
 	}
@@ -1419,8 +1412,13 @@
 		/*
 		 * And finally enable the RTS and DTR signals.
 		 */
-		if (tty->termios->c_cflag & CBAUD)
-			uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
+		if (tty->termios->c_cflag & CBAUD) {
+			uart_set_mctrl(port, TIOCM_DTR);
+			if (tty->termios->c_cflag & CTVB)
+				uart_clear_mctrl(port,TIOCM_RTS);
+			else
+				uart_set_mctrl(port,TIOCM_RTS);
+		}
 	}
 }
 
diff -ur linux-2.6.8.1-orig/include/asm-alpha/termbits.h linux-2.6.8.1-tvb/include/asm-alpha/termbits.h
--- linux-2.6.8.1-orig/include/asm-alpha/termbits.h	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-alpha/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -148,6 +148,7 @@
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
diff -ur linux-2.6.8.1-orig/include/asm-arm/termbits.h linux-2.6.8.1-tvb/include/asm-arm/termbits.h
--- linux-2.6.8.1-orig/include/asm-arm/termbits.h	2004-08-14 12:56:24.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-arm/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -132,6 +132,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-arm26/termbits.h linux-2.6.8.1-tvb/include/asm-arm26/termbits.h
--- linux-2.6.8.1-orig/include/asm-arm26/termbits.h	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-arm26/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -132,6 +132,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-cris/termbits.h linux-2.6.8.1-tvb/include/asm-cris/termbits.h
--- linux-2.6.8.1-orig/include/asm-cris/termbits.h	2004-08-14 12:54:50.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-cris/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -108,9 +108,10 @@
  *    10 987 654 321 098 765 432 109 876 543 210
  *        |           || ||   CIBAUD, IBSHIFT=16
  *                    ibaud
+ *       |CTVB
  *     |CMSPAR
  *    | CRTSCTS
- *       x x xxx xxx x     x xx Free bits
+ *         x xxx xxx x     x xx Free bits
  */
 
 #define CBAUD	0010017
@@ -159,6 +160,7 @@
  * shifted left IBSHIFT bits.
  */
 #define IBSHIFT   16
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000 /* mark or space (stick) parity - PARODD=space*/
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-h8300/termbits.h linux-2.6.8.1-tvb/include/asm-h8300/termbits.h
--- linux-2.6.8.1-orig/include/asm-h8300/termbits.h	2004-08-14 12:56:24.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-h8300/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -135,6 +135,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-i386/termbits.h linux-2.6.8.1-tvb/include/asm-i386/termbits.h
--- linux-2.6.8.1-orig/include/asm-i386/termbits.h	2004-08-14 12:56:25.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-i386/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -134,6 +134,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-ia64/termbits.h linux-2.6.8.1-tvb/include/asm-ia64/termbits.h
--- linux-2.6.8.1-orig/include/asm-ia64/termbits.h	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-ia64/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -143,6 +143,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-m68k/termbits.h linux-2.6.8.1-tvb/include/asm-m68k/termbits.h
--- linux-2.6.8.1-orig/include/asm-m68k/termbits.h	2004-08-14 12:56:23.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-m68k/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -135,6 +135,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-mips/termbits.h linux-2.6.8.1-tvb/include/asm-mips/termbits.h
--- linux-2.6.8.1-orig/include/asm-mips/termbits.h	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-mips/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -164,6 +164,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000	/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-parisc/termbits.h linux-2.6.8.1-tvb/include/asm-parisc/termbits.h
--- linux-2.6.8.1-orig/include/asm-parisc/termbits.h	2004-08-14 12:55:33.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-parisc/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -135,6 +135,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD    002003600000  /* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR    010000000000          /* mark or space (stick) parity */
 #define CRTSCTS   020000000000          /* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-ppc/termbits.h linux-2.6.8.1-tvb/include/asm-ppc/termbits.h
--- linux-2.6.8.1-orig/include/asm-ppc/termbits.h	2004-08-14 12:55:34.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-ppc/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -147,6 +147,7 @@
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
diff -ur linux-2.6.8.1-orig/include/asm-ppc64/termbits.h linux-2.6.8.1-tvb/include/asm-ppc64/termbits.h
--- linux-2.6.8.1-orig/include/asm-ppc64/termbits.h	2004-08-14 12:55:35.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-ppc64/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -155,6 +155,7 @@
 #define HUPCL	00040000
 
 #define CLOCAL	00100000
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CRTSCTS	  020000000000		/* flow control */
 
 /* c_lflag bits */
diff -ur linux-2.6.8.1-orig/include/asm-s390/termbits.h linux-2.6.8.1-tvb/include/asm-s390/termbits.h
--- linux-2.6.8.1-orig/include/asm-s390/termbits.h	2004-08-14 12:56:01.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-s390/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -142,6 +142,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-sh/termbits.h linux-2.6.8.1-tvb/include/asm-sh/termbits.h
--- linux-2.6.8.1-orig/include/asm-sh/termbits.h	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-sh/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -134,6 +134,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-sparc/termbits.h linux-2.6.8.1-tvb/include/asm-sparc/termbits.h
--- linux-2.6.8.1-orig/include/asm-sparc/termbits.h	2004-08-14 12:55:59.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-sparc/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -174,6 +174,7 @@
 #define B3500000  0x00001012
 #define B4000000  0x00001013  */
 #define CIBAUD	  0x100f0000  /* input baud rate (not used) */
+#define CTVB	  0x20000000  /* VisioBraille Terminal flow control */
 #define CMSPAR	  0x40000000  /* mark or space (stick) parity */
 #define CRTSCTS	  0x80000000  /* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-sparc64/termbits.h linux-2.6.8.1-tvb/include/asm-sparc64/termbits.h
--- linux-2.6.8.1-orig/include/asm-sparc64/termbits.h	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-sparc64/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -175,6 +175,7 @@
 #define B3500000  0x00001012
 #define B4000000  0x00001013  */
 #define CIBAUD	  0x100f0000  /* input baud rate (not used) */
+#define CTVB	  0x20000000  /* VisioBraille Terminal flow control */
 #define CMSPAR    0x40000000  /* mark or space (stick) parity */
 #define CRTSCTS	  0x80000000  /* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-v850/termbits.h linux-2.6.8.1-tvb/include/asm-v850/termbits.h
--- linux-2.6.8.1-orig/include/asm-v850/termbits.h	2004-08-14 12:54:47.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-v850/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -135,6 +135,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/asm-x86_64/termbits.h linux-2.6.8.1-tvb/include/asm-x86_64/termbits.h
--- linux-2.6.8.1-orig/include/asm-x86_64/termbits.h	2004-08-14 12:54:48.000000000 +0200
+++ linux-2.6.8.1-tvb/include/asm-x86_64/termbits.h	2004-09-30 00:36:27.000000000 +0200
@@ -134,6 +134,7 @@
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 
diff -ur linux-2.6.8.1-orig/include/linux/serial_core.h linux-2.6.8.1-tvb/include/linux/serial_core.h
--- linux-2.6.8.1-orig/include/linux/serial_core.h	2004-08-14 12:54:50.000000000 +0200
+++ linux-2.6.8.1-tvb/include/linux/serial_core.h	2004-09-30 00:41:25.000000000 +0200
@@ -264,6 +264,7 @@
  */
 #define UIF_CHECK_CD		(1 << 25)
 #define UIF_CTS_FLOW		(1 << 26)
+#define UIF_TVB_FLOW		(1 << 21)
 #define UIF_NORMAL_ACTIVE	(1 << 29)
 #define UIF_INITIALIZED		(1 << 31)
 
@@ -375,6 +376,23 @@
 #define uart_handle_sysrq_char(port,ch,regs)	(0)
 #endif
 
+static inline void
+uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
+{
+	unsigned long flags;
+	unsigned int old;
+
+	spin_lock_irqsave(&port->lock, flags);
+	old = port->mctrl;
+	port->mctrl = (old & ~clear) | set;
+	if (old != port->mctrl)
+		port->ops->set_mctrl(port, port->mctrl);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+#define uart_set_mctrl(port,set)	uart_update_mctrl(port,set,0)
+#define uart_clear_mctrl(port,clear)	uart_update_mctrl(port,0,clear)
+
 /*
  * We do the SysRQ and SAK checking like this...
  */
@@ -446,6 +464,11 @@
 				port->ops->stop_tx(port, 0);
 			}
 		}
+	} else if (info->flags & UIF_TVB_FLOW) {
+		if (status)
+			uart_set_mctrl(port, TIOCM_RTS);
+		else
+			uart_clear_mctrl(port, TIOCM_RTS);
 	}
 }
 
@@ -454,6 +477,7 @@
  */
 #define UART_ENABLE_MS(port,cflag)	((port)->flags & UPF_HARDPPS_CD || \
 					 (cflag) & CRTSCTS || \
+					 (cflag) & CTVB || \
 					 !((cflag) & CLOCAL))
 
 #endif
diff -ur linux-2.6.8.1-orig/include/linux/serial.h linux-2.6.8.1-tvb/include/linux/serial.h
--- linux-2.6.8.1-orig/include/linux/serial.h	2004-08-14 12:54:51.000000000 +0200
+++ linux-2.6.8.1-tvb/include/linux/serial.h	2004-09-30 00:36:27.000000000 +0200
@@ -141,7 +141,8 @@
 #define ASYNC_CONS_FLOW		0x00800000 /* flow control for console  */
 
 #define ASYNC_BOOT_ONLYMCA	0x00400000 /* Probe only if MCA bus */
-#define ASYNC_INTERNAL_FLAGS	0xFFC00000 /* Internal flags */
+#define ASYNC_TVB_FLOW		0x00200000 /* Do VisioBraille flow control */
+#define ASYNC_INTERNAL_FLAGS	0xFFE00000 /* Internal flags */
 
 /*
  * Multiport serial configuration structure --- external structure
diff -ur linux-2.6.8.1-orig/include/linux/tty.h linux-2.6.8.1-tvb/include/linux/tty.h
--- linux-2.6.8.1-orig/include/linux/tty.h	2004-08-14 12:55:32.000000000 +0200
+++ linux-2.6.8.1-tvb/include/linux/tty.h	2004-09-30 00:36:27.000000000 +0200
@@ -210,6 +210,7 @@
 #define C_CLOCAL(tty)	_C_FLAG((tty),CLOCAL)
 #define C_CIBAUD(tty)	_C_FLAG((tty),CIBAUD)
 #define C_CRTSCTS(tty)	_C_FLAG((tty),CRTSCTS)
+#define C_TVB(tty)	_C_FLAG((tty),CTVB)
 
 #define L_ISIG(tty)	_L_FLAG((tty),ISIG)
 #define L_ICANON(tty)	_L_FLAG((tty),ICANON)

--yEPQxsgoJgBvi8ip--
