From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [PATCH] s3c2412 serial : more accurate baudrate generation
Date: Thu, 03 Jan 2008 16:39:16 +0100
Message-ID: <477D01A4.6070808@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline;
 filename="s3c_uart_2412_UDIVSLOT"
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Linux Arm Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>, linux-serial@vger.kernel.org, Ben Dooks <ben@trinity.fluff.org>
List-Id: linux-serial@vger.kernel.org


use UDIVSLOT register on 2412, to get better accuracy when computing the
baudrate.

The clock generation is divised on 16 slots.
UDIVSLOT : if the bit n is set to 1, then for the slot n the clock generator 
divide clock source by (UBRDIV + 2) instead of (UBRDIV + 1).

So if m is the number of bit set to one, the baudrate is
CLOCK / (m*(UBRDIV + 2) + (16-m)*(UBRDIV + 1))
CLOCK / (16*(UBRDIV + 1) + m)

See 2412 datasheet for more info.

Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
Index: linux-2.6/drivers/serial/s3c2410.c
===================================================================
--- linux-2.6.orig/drivers/serial/s3c2410.c	2008-01-02 16:24:20.000000000 +0100
+++ linux-2.6/drivers/serial/s3c2410.c	2008-01-02 18:43:38.000000000 +0100
@@ -625,6 +625,7 @@
 	struct s3c24xx_uart_clksrc	*clksrc;
 	unsigned int			 calc;
 	unsigned int			 quot;
+	unsigned int			 slot;
 	struct clk			*src;
 };
 
@@ -643,8 +644,21 @@
 	rate /= clksrc->divisor;
 
 	calc->clksrc = clksrc;
-	calc->quot = (rate + (8 * baud)) / (16 * baud);
-	calc->calc = (rate / (calc->quot * 16));
+	if (port->type == PORT_S3C2412) {
+		unsigned long divisor;
+		unsigned long rem;
+		divisor = (rate + baud / 2) / baud;
+		calc->quot = divisor / 16; /* interger part */
+		rem = divisor % 16; /* remaining part */
+		/* slot contains rem bit(s) set to 1 */
+		calc->slot = (0xffff << (16 - rem)) & 0xffff;
+
+		calc->calc = rate / divisor;
+	}
+	else {
+		calc->quot = (rate + (8 * baud)) / (16 * baud);
+		calc->calc = (rate / (calc->quot * 16));
+	}
 
 	calc->quot--;
 	return 1;
@@ -652,7 +666,7 @@
 
 static unsigned int s3c24xx_serial_getclk(struct uart_port *port,
 					  struct s3c24xx_uart_clksrc **clksrc,
-					  struct clk **clk,
+					  struct clk **clk, unsigned int *slot,
 					  unsigned int baud)
 {
 	struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
@@ -733,6 +747,7 @@
 
 	*clksrc = best->clksrc;
 	*clk    = best->src;
+	*slot   = best->slot;
 
 	return best->quot;
 }
@@ -746,7 +761,7 @@
 	struct s3c24xx_uart_clksrc *clksrc = NULL;
 	struct clk *clk = NULL;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, slot = 0;
 	unsigned int ulcon;
 	unsigned int umcon;
 
@@ -765,7 +780,7 @@
 	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
 		quot = port->custom_divisor;
 	else
-		quot = s3c24xx_serial_getclk(port, &clksrc, &clk, baud);
+		quot = s3c24xx_serial_getclk(port, &clksrc, &clk, &slot, baud);
 
 	/* check to see if we need  to change clock source */
 
@@ -826,6 +841,8 @@
 
 	wr_regl(port, S3C2410_ULCON, ulcon);
 	wr_regl(port, S3C2410_UBRDIV, quot);
+	if (port->type == PORT_S3C2412)
+		wr_regl(port, S3C2412_UDIVSLOT, slot);
 	wr_regl(port, S3C2410_UMCON, umcon);
 
 	dbg("uart: ulcon = 0x%08x, ucon = 0x%08x, ufcon = 0x%08x\n",
Index: linux-2.6/include/asm-arm/plat-s3c/regs-serial.h
===================================================================
--- linux-2.6.orig/include/asm-arm/plat-s3c/regs-serial.h	2008-01-02 16:44:26.000000000 +0100
+++ linux-2.6/include/asm-arm/plat-s3c/regs-serial.h	2008-01-02 16:50:57.000000000 +0100
@@ -49,6 +49,7 @@
 #define S3C2410_UFCON	  (0x08)
 #define S3C2410_UMCON	  (0x0C)
 #define S3C2410_UBRDIV	  (0x28)
+#define S3C2412_UDIVSLOT  (0x2C)
 #define S3C2410_UTRSTAT	  (0x10)
 #define S3C2410_UERSTAT	  (0x14)
 #define S3C2410_UFSTAT	  (0x18)
-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
