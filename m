From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 03/24] SERIAL: omap: remove setting of EFR SCD bit
Date: Sat, 06 Oct 2012 13:40:01 +0100
Message-ID: <E1TKTfl-0002mW-BO@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The SCD (special character detect) bit enables comparisons with XOFF2,
which we do not program.  As the XOFF2 character remains unprogrammed,
there's little point enabling this feature along with its associated
interrupt.  Remove this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 4a00733..5333f19 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -700,13 +700,8 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_TI752_TCR, OMAP_UART_TCR_TRIG);
-	/* Enable special char function UARTi.EFR_REG[5] and
-	 * load the new software flow control mode IXON or IXOFF
-	 * and restore the UARTi.EFR_REG[4] ENHANCED_EN value.
-	 */
-	serial_out(up, UART_EFR, up->efr | UART_EFR_SCD);
+	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-
 	serial_out(up, UART_MCR, up->mcr & ~UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, up->lcr);
 }
@@ -838,6 +833,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	up->efr = serial_in(up, UART_EFR);
+	up->efr &= ~UART_EFR_SCD;
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
-- 
1.7.4.4

