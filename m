From: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] trivial fixes for omap-serial
Date: Thu, 11 Dec 2014 22:44:26 +0100
Message-ID: <20141211214118.GA2285@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Trivial patch monkey <trivial@kernel.org>
List-Id: linux-serial@vger.kernel.org


Trivial fixes for omap-serial.
    
Signed-off-by: Pavel Machek <pavel@ucw.cz>

index 18c30ca..f43ed2c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -63,7 +63,7 @@
 #define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
 #define UART_ERRATA_i291_DMA_FORCEIDLE	BIT(1)
 
-#define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
+#define DEFAULT_CLK_SPEED 48000000 /* 48Mhz */
 
 /* SCR register bitmasks */
 #define OMAP_UART_SCR_RX_TRIG_GRANU1_MASK		(1 << 7)
@@ -93,7 +93,7 @@
 /* WER = 0x7F
  * Enable module level wakeup in WER reg
  */
-#define OMAP_UART_WER_MOD_WKUP	0X7F
+#define OMAP_UART_WER_MOD_WKUP	0x7F
 
 /* Enable XON/XOFF flow control on output */
 #define OMAP_UART_SW_TX		0x08
@@ -114,7 +114,7 @@ struct uart_omap_dma {
 	dma_addr_t		tx_buf_dma_phys;
 	unsigned int		uart_base;
 	/*
-	 * Buffer for rx dma.It is not required for tx because the buffer
+	 * Buffer for rx dma. It is not required for tx because the buffer
 	 * comes from port structure.
 	 */
 	unsigned char		*rx_buf;
@@ -151,7 +151,7 @@ struct uart_omap_port {
 	int			use_dma;
 	/*
 	 * Some bits in registers are cleared on a read, so they must
-	 * be saved whenever the register is read but the bits will not
+	 * be saved whenever the register is read, but the bits will not
 	 * be immediately processed.
 	 */
 	unsigned int		lsr_break_flag;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
