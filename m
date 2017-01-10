From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] serial: 8250_port: Remove dangerous pr_debug()
Date: Tue, 10 Jan 2017 18:11:29 +0300
Message-ID: <1484061089-20070-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Phillip Raffeck <phillip.raffeck@fau.de>, Anton Wuerfel <anton.wuerfel@fau.de>, "Matwey V. Kornilov" <matwey@sai.msu.ru>, Yegor Yefremov <yegorslists@googlemail.com>, Thor Thayer <tthayer@opensource.altera.com>
List-Id: linux-serial@vger.kernel.org

With CONFIG_DYNAMIC_DEBUG if dyndbg enables debug output in
8250_port.c deadlock happens inevitably on UART IRQ handling.

That's the problematic execution path:
---------------------------->8------------------------
UART IRQ:
  serial8250_interrupt() ->
    serial8250_handle_irq(): lock "port->lock" ->
      pr_debug() ->
        serial8250_console_write(): bump in locked "port->lock".

      OR (if above pr_debug() gets removed):
      serial8250_tx_chars() ->
        pr_debug() ->
          serial8250_console_write(): bump in locked "port->lock".
---------------------------->8------------------------

So let's get rid of those not that much useful debug entries.

Discussed problem could be easily reproduced with QEMU for x86_64.
As well as this fix could be mimicked with muting of dynamic debug for
the problematic lines as simple as:
---------------------------->8------------------------
dyndbg="+p; file 8250_port.c line 1756 -p; file 8250_port.c line 1822 -p"
---------------------------->8------------------------

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Phillip Raffeck <phillip.raffeck@fau.de>
Cc: Anton Wuerfel <anton.wuerfel@fau.de>
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Yegor Yefremov <yegorslists@googlemail.com>
Cc: Thor Thayer <tthayer@opensource.altera.com>
---
 drivers/tty/serial/8250/8250_port.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fe4399b41df6..3cfdd745a97a 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1753,8 +1753,6 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	pr_debug("%s: THRE\n", __func__);
-
 	/*
 	 * With RPM enabled, we have to wait until the FIFO is empty before the
 	 * HW can go idle. So we get here once again with empty FIFO and disable
@@ -1819,8 +1817,6 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	status = serial_port_in(port, UART_LSR);
 
-	pr_debug("%s: status = %x\n", __func__, status);
-
 	if (status & (UART_LSR_DR | UART_LSR_BI)) {
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
-- 
2.7.4
