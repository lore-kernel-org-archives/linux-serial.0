From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/7] serial: delete last unused traces of pausing I/O in 8250
Date: Thu,  1 Mar 2012 21:33:17 -0500
Message-ID: <1330655603-5268-2-git-send-email-paul.gortmaker@windriver.com>
References: <1330655603-5268-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63481 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972Ab2CBCdk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Mar 2012 21:33:40 -0500
In-Reply-To: <1330655603-5268-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

This is the last traces of pausing I/O that we had back some
twenty years ago.  Probably was only required for 8MHz ISA
cards running "on the edge" at 12MHz.  Anyway it hasn't been
in use for years, so lets just bury it for good.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250.c |  308 +++++++++++++++++++--------------------
 1 files changed, 150 insertions(+), 158 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 9b7336f..b803e61 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -494,26 +494,18 @@ serial_out_sync(struct uart_8250_port *up, int offset, int value)
 	(up->port.serial_in(&(up)->port, (offset)))
 #define serial_out(up, offset, value)	\
 	(up->port.serial_out(&(up)->port, (offset), (value)))
-/*
- * We used to support using pause I/O for certain machines.  We
- * haven't supported this for a while, but just in case it's badly
- * needed for certain old 386 machines, I've left these #define's
- * in....
- */
-#define serial_inp(up, offset)		serial_in(up, offset)
-#define serial_outp(up, offset, value)	serial_out(up, offset, value)
 
 /* Uart divisor latch read */
 static inline int _serial_dl_read(struct uart_8250_port *up)
 {
-	return serial_inp(up, UART_DLL) | serial_inp(up, UART_DLM) << 8;
+	return serial_in(up, UART_DLL) | serial_in(up, UART_DLM) << 8;
 }
 
 /* Uart divisor latch write */
 static inline void _serial_dl_write(struct uart_8250_port *up, int value)
 {
-	serial_outp(up, UART_DLL, value & 0xff);
-	serial_outp(up, UART_DLM, value >> 8 & 0xff);
+	serial_out(up, UART_DLL, value & 0xff);
+	serial_out(up, UART_DLM, value >> 8 & 0xff);
 }
 
 #if defined(CONFIG_MIPS_ALCHEMY)
@@ -583,10 +575,10 @@ static unsigned int serial_icr_read(struct uart_8250_port *up, int offset)
 static void serial8250_clear_fifos(struct uart_8250_port *p)
 {
 	if (p->capabilities & UART_CAP_FIFO) {
-		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO);
-		serial_outp(p, UART_FCR, UART_FCR_ENABLE_FIFO |
+		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO |
 			       UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
-		serial_outp(p, UART_FCR, 0);
+		serial_out(p, UART_FCR, 0);
 	}
 }
 
@@ -599,15 +591,15 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 {
 	if (p->capabilities & UART_CAP_SLEEP) {
 		if (p->capabilities & UART_CAP_EFR) {
-			serial_outp(p, UART_LCR, UART_LCR_CONF_MODE_B);
-			serial_outp(p, UART_EFR, UART_EFR_ECB);
-			serial_outp(p, UART_LCR, 0);
+			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
+			serial_out(p, UART_EFR, UART_EFR_ECB);
+			serial_out(p, UART_LCR, 0);
 		}
-		serial_outp(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
+		serial_out(p, UART_IER, sleep ? UART_IERX_SLEEP : 0);
 		if (p->capabilities & UART_CAP_EFR) {
-			serial_outp(p, UART_LCR, UART_LCR_CONF_MODE_B);
-			serial_outp(p, UART_EFR, 0);
-			serial_outp(p, UART_LCR, 0);
+			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
+			serial_out(p, UART_EFR, 0);
+			serial_out(p, UART_LCR, 0);
 		}
 	}
 }
@@ -622,12 +614,12 @@ static int __enable_rsa(struct uart_8250_port *up)
 	unsigned char mode;
 	int result;
 
-	mode = serial_inp(up, UART_RSA_MSR);
+	mode = serial_in(up, UART_RSA_MSR);
 	result = mode & UART_RSA_MSR_FIFO;
 
 	if (!result) {
-		serial_outp(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
-		mode = serial_inp(up, UART_RSA_MSR);
+		serial_out(up, UART_RSA_MSR, mode | UART_RSA_MSR_FIFO);
+		mode = serial_in(up, UART_RSA_MSR);
 		result = mode & UART_RSA_MSR_FIFO;
 	}
 
@@ -646,7 +638,7 @@ static void enable_rsa(struct uart_8250_port *up)
 			spin_unlock_irq(&up->port.lock);
 		}
 		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
-			serial_outp(up, UART_RSA_FRR, 0);
+			serial_out(up, UART_RSA_FRR, 0);
 	}
 }
 
@@ -665,12 +657,12 @@ static void disable_rsa(struct uart_8250_port *up)
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
 		spin_lock_irq(&up->port.lock);
 
-		mode = serial_inp(up, UART_RSA_MSR);
+		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
 
 		if (!result) {
-			serial_outp(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
-			mode = serial_inp(up, UART_RSA_MSR);
+			serial_out(up, UART_RSA_MSR, mode & ~UART_RSA_MSR_FIFO);
+			mode = serial_in(up, UART_RSA_MSR);
 			result = !(mode & UART_RSA_MSR_FIFO);
 		}
 
@@ -691,28 +683,28 @@ static int size_fifo(struct uart_8250_port *up)
 	unsigned short old_dl;
 	int count;
 
-	old_lcr = serial_inp(up, UART_LCR);
-	serial_outp(up, UART_LCR, 0);
-	old_fcr = serial_inp(up, UART_FCR);
-	old_mcr = serial_inp(up, UART_MCR);
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO |
+	old_lcr = serial_in(up, UART_LCR);
+	serial_out(up, UART_LCR, 0);
+	old_fcr = serial_in(up, UART_FCR);
+	old_mcr = serial_in(up, UART_MCR);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO |
 		    UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
-	serial_outp(up, UART_MCR, UART_MCR_LOOP);
-	serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_MCR, UART_MCR_LOOP);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	old_dl = serial_dl_read(up);
 	serial_dl_write(up, 0x0001);
-	serial_outp(up, UART_LCR, 0x03);
+	serial_out(up, UART_LCR, 0x03);
 	for (count = 0; count < 256; count++)
-		serial_outp(up, UART_TX, count);
+		serial_out(up, UART_TX, count);
 	mdelay(20);/* FIXME - schedule_timeout */
-	for (count = 0; (serial_inp(up, UART_LSR) & UART_LSR_DR) &&
+	for (count = 0; (serial_in(up, UART_LSR) & UART_LSR_DR) &&
 	     (count < 256); count++)
-		serial_inp(up, UART_RX);
-	serial_outp(up, UART_FCR, old_fcr);
-	serial_outp(up, UART_MCR, old_mcr);
-	serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_A);
+		serial_in(up, UART_RX);
+	serial_out(up, UART_FCR, old_fcr);
+	serial_out(up, UART_MCR, old_mcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	serial_dl_write(up, old_dl);
-	serial_outp(up, UART_LCR, old_lcr);
+	serial_out(up, UART_LCR, old_lcr);
 
 	return count;
 }
@@ -727,20 +719,20 @@ static unsigned int autoconfig_read_divisor_id(struct uart_8250_port *p)
 	unsigned char old_dll, old_dlm, old_lcr;
 	unsigned int id;
 
-	old_lcr = serial_inp(p, UART_LCR);
-	serial_outp(p, UART_LCR, UART_LCR_CONF_MODE_A);
+	old_lcr = serial_in(p, UART_LCR);
+	serial_out(p, UART_LCR, UART_LCR_CONF_MODE_A);
 
-	old_dll = serial_inp(p, UART_DLL);
-	old_dlm = serial_inp(p, UART_DLM);
+	old_dll = serial_in(p, UART_DLL);
+	old_dlm = serial_in(p, UART_DLM);
 
-	serial_outp(p, UART_DLL, 0);
-	serial_outp(p, UART_DLM, 0);
+	serial_out(p, UART_DLL, 0);
+	serial_out(p, UART_DLM, 0);
 
-	id = serial_inp(p, UART_DLL) | serial_inp(p, UART_DLM) << 8;
+	id = serial_in(p, UART_DLL) | serial_in(p, UART_DLM) << 8;
 
-	serial_outp(p, UART_DLL, old_dll);
-	serial_outp(p, UART_DLM, old_dlm);
-	serial_outp(p, UART_LCR, old_lcr);
+	serial_out(p, UART_DLL, old_dll);
+	serial_out(p, UART_DLM, old_dlm);
+	serial_out(p, UART_LCR, old_lcr);
 
 	return id;
 }
@@ -850,11 +842,11 @@ static void autoconfig_8250(struct uart_8250_port *up)
 	up->port.type = PORT_8250;
 
 	scratch = serial_in(up, UART_SCR);
-	serial_outp(up, UART_SCR, 0xa5);
+	serial_out(up, UART_SCR, 0xa5);
 	status1 = serial_in(up, UART_SCR);
-	serial_outp(up, UART_SCR, 0x5a);
+	serial_out(up, UART_SCR, 0x5a);
 	status2 = serial_in(up, UART_SCR);
-	serial_outp(up, UART_SCR, scratch);
+	serial_out(up, UART_SCR, scratch);
 
 	if (status1 == 0xa5 && status2 == 0x5a)
 		up->port.type = PORT_16450;
@@ -885,7 +877,7 @@ static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
 	} else {
 		status &= ~0xB0; /* Disable LOCK, mask out PRESL[01] */
 		status |= 0x10;  /* 1.625 divisor for baud_base --> 921600 */
-		serial_outp(up, 0x04, status);
+		serial_out(up, 0x04, status);
 	}
 	return 1;
 }
@@ -908,9 +900,9 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * Check for presence of the EFR when DLAB is set.
 	 * Only ST16C650V1 UARTs pass this test.
 	 */
-	serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 	if (serial_in(up, UART_EFR) == 0) {
-		serial_outp(up, UART_EFR, 0xA8);
+		serial_out(up, UART_EFR, 0xA8);
 		if (serial_in(up, UART_EFR) != 0) {
 			DEBUG_AUTOCONF("EFRv1 ");
 			up->port.type = PORT_16650;
@@ -918,7 +910,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 		} else {
 			DEBUG_AUTOCONF("Motorola 8xxx DUART ");
 		}
-		serial_outp(up, UART_EFR, 0);
+		serial_out(up, UART_EFR, 0);
 		return;
 	}
 
@@ -926,7 +918,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * Maybe it requires 0xbf to be written to the LCR.
 	 * (other ST16C650V2 UARTs, TI16C752A, etc)
 	 */
-	serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	if (serial_in(up, UART_EFR) == 0 && !broken_efr(up)) {
 		DEBUG_AUTOCONF("EFRv2 ");
 		autoconfig_has_efr(up);
@@ -940,23 +932,23 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * switch back to bank 2, read it from EXCR1 again and check
 	 * it's changed. If so, set baud_base in EXCR2 to 921600. -- dwmw2
 	 */
-	serial_outp(up, UART_LCR, 0);
+	serial_out(up, UART_LCR, 0);
 	status1 = serial_in(up, UART_MCR);
-	serial_outp(up, UART_LCR, 0xE0);
+	serial_out(up, UART_LCR, 0xE0);
 	status2 = serial_in(up, 0x02); /* EXCR1 */
 
 	if (!((status2 ^ status1) & UART_MCR_LOOP)) {
-		serial_outp(up, UART_LCR, 0);
-		serial_outp(up, UART_MCR, status1 ^ UART_MCR_LOOP);
-		serial_outp(up, UART_LCR, 0xE0);
+		serial_out(up, UART_LCR, 0);
+		serial_out(up, UART_MCR, status1 ^ UART_MCR_LOOP);
+		serial_out(up, UART_LCR, 0xE0);
 		status2 = serial_in(up, 0x02); /* EXCR1 */
-		serial_outp(up, UART_LCR, 0);
-		serial_outp(up, UART_MCR, status1);
+		serial_out(up, UART_LCR, 0);
+		serial_out(up, UART_MCR, status1);
 
 		if ((status2 ^ status1) & UART_MCR_LOOP) {
 			unsigned short quot;
 
-			serial_outp(up, UART_LCR, 0xE0);
+			serial_out(up, UART_LCR, 0xE0);
 
 			quot = serial_dl_read(up);
 			quot <<= 3;
@@ -964,7 +956,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 			if (ns16550a_goto_highspeed(up))
 				serial_dl_write(up, quot);
 
-			serial_outp(up, UART_LCR, 0);
+			serial_out(up, UART_LCR, 0);
 
 			up->port.uartclk = 921600*16;
 			up->port.type = PORT_NS16550A;
@@ -979,15 +971,15 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * Try setting it with and without DLAB set.  Cheap clones
 	 * set bit 5 without DLAB set.
 	 */
-	serial_outp(up, UART_LCR, 0);
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
+	serial_out(up, UART_LCR, 0);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
 	status1 = serial_in(up, UART_IIR) >> 5;
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
-	serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_A);
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO | UART_FCR7_64BYTE);
 	status2 = serial_in(up, UART_IIR) >> 5;
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
-	serial_outp(up, UART_LCR, 0);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+	serial_out(up, UART_LCR, 0);
 
 	DEBUG_AUTOCONF("iir1=%d iir2=%d ", status1, status2);
 
@@ -1006,13 +998,13 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * already a 1 and maybe locked there before we even start start.
 	 */
 	iersave = serial_in(up, UART_IER);
-	serial_outp(up, UART_IER, iersave & ~UART_IER_UUE);
+	serial_out(up, UART_IER, iersave & ~UART_IER_UUE);
 	if (!(serial_in(up, UART_IER) & UART_IER_UUE)) {
 		/*
 		 * OK it's in a known zero state, try writing and reading
 		 * without disturbing the current state of the other bits.
 		 */
-		serial_outp(up, UART_IER, iersave | UART_IER_UUE);
+		serial_out(up, UART_IER, iersave | UART_IER_UUE);
 		if (serial_in(up, UART_IER) & UART_IER_UUE) {
 			/*
 			 * It's an Xscale.
@@ -1030,7 +1022,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 		 */
 		DEBUG_AUTOCONF("Couldn't force IER_UUE to 0 ");
 	}
-	serial_outp(up, UART_IER, iersave);
+	serial_out(up, UART_IER, iersave);
 
 	/*
 	 * Exar uarts have EFR in a weird location
@@ -1092,8 +1084,8 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 		 * Note: this is safe as long as MCR bit 4 is clear
 		 * and the device is in "PC" mode.
 		 */
-		scratch = serial_inp(up, UART_IER);
-		serial_outp(up, UART_IER, 0);
+		scratch = serial_in(up, UART_IER);
+		serial_out(up, UART_IER, 0);
 #ifdef __i386__
 		outb(0xff, 0x080);
 #endif
@@ -1101,13 +1093,13 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 		 * Mask out IER[7:4] bits for test as some UARTs (e.g. TL
 		 * 16C754B) allow only to modify them if an EFR bit is set.
 		 */
-		scratch2 = serial_inp(up, UART_IER) & 0x0f;
-		serial_outp(up, UART_IER, 0x0F);
+		scratch2 = serial_in(up, UART_IER) & 0x0f;
+		serial_out(up, UART_IER, 0x0F);
 #ifdef __i386__
 		outb(0, 0x080);
 #endif
-		scratch3 = serial_inp(up, UART_IER) & 0x0f;
-		serial_outp(up, UART_IER, scratch);
+		scratch3 = serial_in(up, UART_IER) & 0x0f;
+		serial_out(up, UART_IER, scratch);
 		if (scratch2 != 0 || scratch3 != 0x0F) {
 			/*
 			 * We failed; there's nothing here
@@ -1131,9 +1123,9 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	 * that conflicts with COM 1-4 --- we hope!
 	 */
 	if (!(up->port.flags & UPF_SKIP_TEST)) {
-		serial_outp(up, UART_MCR, UART_MCR_LOOP | 0x0A);
-		status1 = serial_inp(up, UART_MSR) & 0xF0;
-		serial_outp(up, UART_MCR, save_mcr);
+		serial_out(up, UART_MCR, UART_MCR_LOOP | 0x0A);
+		status1 = serial_in(up, UART_MSR) & 0xF0;
+		serial_out(up, UART_MCR, save_mcr);
 		if (status1 != 0x90) {
 			DEBUG_AUTOCONF("LOOP test failed (%02x) ",
 				       status1);
@@ -1150,11 +1142,11 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	 * We also initialise the EFR (if any) to zero for later.  The
 	 * EFR occupies the same register location as the FCR and IIR.
 	 */
-	serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_outp(up, UART_EFR, 0);
-	serial_outp(up, UART_LCR, 0);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+	serial_out(up, UART_EFR, 0);
+	serial_out(up, UART_LCR, 0);
 
-	serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+	serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 	scratch = serial_in(up, UART_IIR) >> 6;
 
 	DEBUG_AUTOCONF("iir=%d ", scratch);
@@ -1191,7 +1183,7 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	}
 #endif
 
-	serial_outp(up, UART_LCR, save_lcr);
+	serial_out(up, UART_LCR, save_lcr);
 
 	if (up->capabilities != uart_config[up->port.type].flags) {
 		printk(KERN_WARNING
@@ -1212,15 +1204,15 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	 */
 #ifdef CONFIG_SERIAL_8250_RSA
 	if (up->port.type == PORT_RSA)
-		serial_outp(up, UART_RSA_FRR, 0);
+		serial_out(up, UART_RSA_FRR, 0);
 #endif
-	serial_outp(up, UART_MCR, save_mcr);
+	serial_out(up, UART_MCR, save_mcr);
 	serial8250_clear_fifos(up);
 	serial_in(up, UART_RX);
 	if (up->capabilities & UART_CAP_UUE)
-		serial_outp(up, UART_IER, UART_IER_UUE);
+		serial_out(up, UART_IER, UART_IER_UUE);
 	else
-		serial_outp(up, UART_IER, 0);
+		serial_out(up, UART_IER, 0);
 
  out:
 	spin_unlock_irqrestore(&up->port.lock, flags);
@@ -1244,31 +1236,31 @@ static void autoconfig_irq(struct uart_8250_port *up)
 
 	/* forget possible initially masked and pending IRQ */
 	probe_irq_off(probe_irq_on());
-	save_mcr = serial_inp(up, UART_MCR);
-	save_ier = serial_inp(up, UART_IER);
-	serial_outp(up, UART_MCR, UART_MCR_OUT1 | UART_MCR_OUT2);
+	save_mcr = serial_in(up, UART_MCR);
+	save_ier = serial_in(up, UART_IER);
+	serial_out(up, UART_MCR, UART_MCR_OUT1 | UART_MCR_OUT2);
 
 	irqs = probe_irq_on();
-	serial_outp(up, UART_MCR, 0);
+	serial_out(up, UART_MCR, 0);
 	udelay(10);
 	if (up->port.flags & UPF_FOURPORT) {
-		serial_outp(up, UART_MCR,
+		serial_out(up, UART_MCR,
 			    UART_MCR_DTR | UART_MCR_RTS);
 	} else {
-		serial_outp(up, UART_MCR,
+		serial_out(up, UART_MCR,
 			    UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
 	}
-	serial_outp(up, UART_IER, 0x0f);	/* enable all intrs */
-	(void)serial_inp(up, UART_LSR);
-	(void)serial_inp(up, UART_RX);
-	(void)serial_inp(up, UART_IIR);
-	(void)serial_inp(up, UART_MSR);
-	serial_outp(up, UART_TX, 0xFF);
+	serial_out(up, UART_IER, 0x0f);	/* enable all intrs */
+	(void)serial_in(up, UART_LSR);
+	(void)serial_in(up, UART_RX);
+	(void)serial_in(up, UART_IIR);
+	(void)serial_in(up, UART_MSR);
+	serial_out(up, UART_TX, 0xFF);
 	udelay(20);
 	irq = probe_irq_off(irqs);
 
-	serial_outp(up, UART_MCR, save_mcr);
-	serial_outp(up, UART_IER, save_ier);
+	serial_out(up, UART_MCR, save_mcr);
+	serial_out(up, UART_IER, save_ier);
 
 	if (up->port.flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
@@ -1388,7 +1380,7 @@ serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
 
 	do {
 		if (likely(lsr & UART_LSR_DR))
-			ch = serial_inp(up, UART_RX);
+			ch = serial_in(up, UART_RX);
 		else
 			/*
 			 * Intel 82571 has a Serial Over Lan device that will
@@ -1453,7 +1445,7 @@ serial8250_rx_chars(struct uart_8250_port *up, unsigned char lsr)
 		uart_insert_char(&up->port, lsr, UART_LSR_OE, ch, flag);
 
 ignore_char:
-		lsr = serial_inp(up, UART_LSR);
+		lsr = serial_in(up, UART_LSR);
 	} while ((lsr & (UART_LSR_DR | UART_LSR_BI)) && (max_count-- > 0));
 	spin_unlock(&up->port.lock);
 	tty_flip_buffer_push(tty);
@@ -1468,7 +1460,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	int count;
 
 	if (up->port.x_char) {
-		serial_outp(up, UART_TX, up->port.x_char);
+		serial_out(up, UART_TX, up->port.x_char);
 		up->port.icount.tx++;
 		up->port.x_char = 0;
 		return;
@@ -1540,7 +1532,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	spin_lock_irqsave(&up->port.lock, flags);
 
-	status = serial_inp(up, UART_LSR);
+	status = serial_in(up, UART_LSR);
 
 	DEBUG_INTR("status = %x...", status);
 
@@ -1902,12 +1894,12 @@ static int serial8250_get_poll_char(struct uart_port *port)
 {
 	struct uart_8250_port *up =
 		container_of(port, struct uart_8250_port, port);
-	unsigned char lsr = serial_inp(up, UART_LSR);
+	unsigned char lsr = serial_in(up, UART_LSR);
 
 	if (!(lsr & UART_LSR_DR))
 		return NO_POLL_CHAR;
 
-	return serial_inp(up, UART_RX);
+	return serial_in(up, UART_RX);
 }
 
 
@@ -1967,14 +1959,14 @@ static int serial8250_startup(struct uart_port *port)
 	if (up->port.type == PORT_16C950) {
 		/* Wake up and initialize UART */
 		up->acr = 0;
-		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_outp(up, UART_EFR, UART_EFR_ECB);
-		serial_outp(up, UART_IER, 0);
-		serial_outp(up, UART_LCR, 0);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_EFR, UART_EFR_ECB);
+		serial_out(up, UART_IER, 0);
+		serial_out(up, UART_LCR, 0);
 		serial_icr_write(up, UART_CSR, 0); /* Reset the UART */
-		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
-		serial_outp(up, UART_EFR, UART_EFR_ECB);
-		serial_outp(up, UART_LCR, 0);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_EFR, UART_EFR_ECB);
+		serial_out(up, UART_LCR, 0);
 	}
 
 #ifdef CONFIG_SERIAL_8250_RSA
@@ -1994,10 +1986,10 @@ static int serial8250_startup(struct uart_port *port)
 	/*
 	 * Clear the interrupt registers.
 	 */
-	(void) serial_inp(up, UART_LSR);
-	(void) serial_inp(up, UART_RX);
-	(void) serial_inp(up, UART_IIR);
-	(void) serial_inp(up, UART_MSR);
+	(void) serial_in(up, UART_LSR);
+	(void) serial_in(up, UART_RX);
+	(void) serial_in(up, UART_IIR);
+	(void) serial_in(up, UART_MSR);
 
 	/*
 	 * At this point, there's no way the LSR could still be 0xff;
@@ -2005,7 +1997,7 @@ static int serial8250_startup(struct uart_port *port)
 	 * here.
 	 */
 	if (!(up->port.flags & UPF_BUGGY_UART) &&
-	    (serial_inp(up, UART_LSR) == 0xff)) {
+	    (serial_in(up, UART_LSR) == 0xff)) {
 		printk_ratelimited(KERN_INFO "ttyS%d: LSR safety check engaged!\n",
 				   serial_index(&up->port));
 		return -ENODEV;
@@ -2017,15 +2009,15 @@ static int serial8250_startup(struct uart_port *port)
 	if (up->port.type == PORT_16850) {
 		unsigned char fctr;
 
-		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
-		fctr = serial_inp(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
-		serial_outp(up, UART_FCTR, fctr | UART_FCTR_TRGD | UART_FCTR_RX);
-		serial_outp(up, UART_TRG, UART_TRG_96);
-		serial_outp(up, UART_FCTR, fctr | UART_FCTR_TRGD | UART_FCTR_TX);
-		serial_outp(up, UART_TRG, UART_TRG_96);
+		fctr = serial_in(up, UART_FCTR) & ~(UART_FCTR_RX|UART_FCTR_TX);
+		serial_out(up, UART_FCTR, fctr | UART_FCTR_TRGD | UART_FCTR_RX);
+		serial_out(up, UART_TRG, UART_TRG_96);
+		serial_out(up, UART_FCTR, fctr | UART_FCTR_TRGD | UART_FCTR_TX);
+		serial_out(up, UART_TRG, UART_TRG_96);
 
-		serial_outp(up, UART_LCR, 0);
+		serial_out(up, UART_LCR, 0);
 	}
 
 	if (is_real_interrupt(up->port.irq)) {
@@ -2095,7 +2087,7 @@ static int serial8250_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_outp(up, UART_LCR, UART_LCR_WLEN8);
+	serial_out(up, UART_LCR, UART_LCR_WLEN8);
 
 	spin_lock_irqsave(&up->port.lock, flags);
 	if (up->port.flags & UPF_FOURPORT) {
@@ -2128,10 +2120,10 @@ static int serial8250_startup(struct uart_port *port)
 	 * Do a quick test to see if we receive an
 	 * interrupt when we enable the TX irq.
 	 */
-	serial_outp(up, UART_IER, UART_IER_THRI);
+	serial_out(up, UART_IER, UART_IER_THRI);
 	lsr = serial_in(up, UART_LSR);
 	iir = serial_in(up, UART_IIR);
-	serial_outp(up, UART_IER, 0);
+	serial_out(up, UART_IER, 0);
 
 	if (lsr & UART_LSR_TEMT && iir & UART_IIR_NO_INT) {
 		if (!(up->bugs & UART_BUG_TXEN)) {
@@ -2151,10 +2143,10 @@ dont_test_tx_en:
 	 * saved flags to avoid getting false values from polling
 	 * routines or the previous session.
 	 */
-	serial_inp(up, UART_LSR);
-	serial_inp(up, UART_RX);
-	serial_inp(up, UART_IIR);
-	serial_inp(up, UART_MSR);
+	serial_in(up, UART_LSR);
+	serial_in(up, UART_RX);
+	serial_in(up, UART_IIR);
+	serial_in(up, UART_MSR);
 	up->lsr_saved_flags = 0;
 	up->msr_saved_flags = 0;
 
@@ -2164,7 +2156,7 @@ dont_test_tx_en:
 	 * anyway, so we don't enable them here.
 	 */
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
-	serial_outp(up, UART_IER, up->ier);
+	serial_out(up, UART_IER, up->ier);
 
 	if (up->port.flags & UPF_FOURPORT) {
 		unsigned int icp;
@@ -2189,7 +2181,7 @@ static void serial8250_shutdown(struct uart_port *port)
 	 * Disable interrupts from this port
 	 */
 	up->ier = 0;
-	serial_outp(up, UART_IER, 0);
+	serial_out(up, UART_IER, 0);
 
 	spin_lock_irqsave(&up->port.lock, flags);
 	if (up->port.flags & UPF_FOURPORT) {
@@ -2205,7 +2197,7 @@ static void serial8250_shutdown(struct uart_port *port)
 	/*
 	 * Disable break condition and FIFOs
 	 */
-	serial_out(up, UART_LCR, serial_inp(up, UART_LCR) & ~UART_LCR_SBC);
+	serial_out(up, UART_LCR, serial_in(up, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
 #ifdef CONFIG_SERIAL_8250_RSA
@@ -2382,11 +2374,11 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		if (termios->c_cflag & CRTSCTS)
 			efr |= UART_EFR_CTS;
 
-		serial_outp(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 		if (up->port.flags & UPF_EXAR_EFR)
-			serial_outp(up, UART_XR_EFR, efr);
+			serial_out(up, UART_XR_EFR, efr);
 		else
-			serial_outp(up, UART_EFR, efr);
+			serial_out(up, UART_EFR, efr);
 	}
 
 #ifdef CONFIG_ARCH_OMAP
@@ -2402,9 +2394,9 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	if (up->capabilities & UART_NATSEMI) {
 		/* Switch to bank 2 not bank 1, to avoid resetting EXCR2 */
-		serial_outp(up, UART_LCR, 0xe0);
+		serial_out(up, UART_LCR, 0xe0);
 	} else {
-		serial_outp(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
+		serial_out(up, UART_LCR, cval | UART_LCR_DLAB);/* set DLAB */
 	}
 
 	serial_dl_write(up, quot);
@@ -2414,16 +2406,16 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * is written without DLAB set, this mode will be disabled.
 	 */
 	if (up->port.type == PORT_16750)
-		serial_outp(up, UART_FCR, fcr);
+		serial_out(up, UART_FCR, fcr);
 
-	serial_outp(up, UART_LCR, cval);		/* reset DLAB */
+	serial_out(up, UART_LCR, cval);			/* reset DLAB */
 	up->lcr = cval;					/* Save LCR */
 	if (up->port.type != PORT_16750) {
 		if (fcr & UART_FCR_ENABLE_FIFO) {
 			/* emulated UARTs (Lucent Venus 167x) need two steps */
-			serial_outp(up, UART_FCR, UART_FCR_ENABLE_FIFO);
+			serial_out(up, UART_FCR, UART_FCR_ENABLE_FIFO);
 		}
-		serial_outp(up, UART_FCR, fcr);		/* set fcr */
+		serial_out(up, UART_FCR, fcr);		/* set fcr */
 	}
 	serial8250_set_mctrl(&up->port, up->port.mctrl);
 	spin_unlock_irqrestore(&up->port.lock, flags);
@@ -3005,11 +2997,11 @@ void serial8250_resume_port(int line)
 
 	if (up->capabilities & UART_NATSEMI) {
 		/* Ensure it's still in high speed mode */
-		serial_outp(up, UART_LCR, 0xE0);
+		serial_out(up, UART_LCR, 0xE0);
 
 		ns16550a_goto_highspeed(up);
 
-		serial_outp(up, UART_LCR, 0);
+		serial_out(up, UART_LCR, 0);
 		up->port.uartclk = 921600*16;
 	}
 	uart_resume_port(&serial8250_reg, &up->port);
-- 
1.7.9.1

