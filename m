From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH v2 1/2] tty: serial: 8250_core: Remove trailing whitespaces
Date: Tue,  3 Feb 2015 11:01:47 +0100
Message-ID: <d237c6e90cbd2f106a4125816b02d0541fa4cefe.1422957699.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-serial@vger.kernel.org

No functional changes.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Do not sign patch

 drivers/tty/serial/8250/8250_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 11c66856ba2f..65e52c9109e2 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -884,7 +884,7 @@ static int broken_efr(struct uart_8250_port *up)
 	/*
 	 * Exar ST16C2550 "A2" devices incorrectly detect as
 	 * having an EFR, and report an ID of 0x0201.  See
-	 * http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-11/4812.html 
+	 * http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-11/4812.html
 	 */
 	if (autoconfig_read_divisor_id(up) == 0x0201 && size_fifo(up) == 16)
 		return 1;
@@ -1239,7 +1239,7 @@ static void autoconfig(struct uart_8250_port *up, unsigned int probeflags)
 	serial_out(up, UART_LCR, save_lcr);
 
 	port->fifosize = uart_config[up->port.type].fifo_size;
-	old_capabilities = up->capabilities; 
+	old_capabilities = up->capabilities;
 	up->capabilities = uart_config[port->type].flags;
 	up->tx_loadsz = uart_config[port->type].tx_loadsz;
 
-- 
1.8.2.3
