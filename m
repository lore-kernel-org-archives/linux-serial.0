From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 11/26] serial: 8250: Document serial8250_modem_status() locking
Date: Tue,  2 Sep 2014 17:39:20 -0400
Message-ID: <1409693975-1028-12-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Existing callers of serial8250_modem_status() [1] hold the uart port
lock; document.

[1] In-tree callers of serial8250_modem_status()

drivers/tty/serial/8250/8250_fsl.c
  fsl8250_handle_irq()

drivers/tty/serial/8250/8250_core.c
  serial8250_handle_irq()
  serial8250_console_write()
  serial8250_get_mctrl() *

* Call graphs for callers of serial8250_get_mctrl() from the function
  which acquires the uart port lock

drivers/tty/serial/serial_core.c
  uart_port_startup()
  uart_tiocmget()
  uart_set_termios()
  uart_carrier_raised()
    ops->get_mctrl() ---> serial8250_get_mctrl()

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/8250/8250_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 109da60..d2615e3b 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1467,6 +1467,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_tx_chars);
 
+/* Caller holds uart port lock */
 unsigned int serial8250_modem_status(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
-- 
2.1.0
