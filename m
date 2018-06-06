From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH 4/4] serial: core: Mask mctrl with TIOCM_RTS too if rs485 on and RTS_AFTER_SEND set.
Date: Wed,  6 Jun 2018 11:49:39 +0200
Message-ID: <20180606094942.71190-3-giulio.benetti@micronovasrl.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
 <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: matwey.kornilov@gmail.com, Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Sean Young <sean@mess.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

If rs485 is enabled and RTS_AFTER_SEND is set on startup need to keep
TIOCM_RTS asserted to keep rs485 transceiver in RX when idle.

Check if rs485 is on and RTS_AFTER_SEND is set and mask port->mctrl with
TIOCM_RTS too and not only TIOCM_DTR.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/tty/serial/serial_core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0466f9f08a91..06d9441f6d20 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2288,6 +2288,16 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 
 	if (port->type != PORT_UNKNOWN) {
 		unsigned long flags;
+		int rs485_on = port->rs485_config &&
+			(port->rs485.flags & SER_RS485_ENABLED);
+		int RTS_after_send = !!(port->rs485.flags &
+				SER_RS485_RTS_AFTER_SEND);
+		int mctrl;
+
+		if (rs485_on && RTS_after_send)
+			mctrl = port->mctrl & (TIOCM_DTR | TIOCM_RTS);
+		else
+			mctrl = port->mctrl & TIOCM_DTR;
 
 		uart_report_port(drv, port);
 
@@ -2300,7 +2310,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		 * We probably don't need a spinlock around this, but
 		 */
 		spin_lock_irqsave(&port->lock, flags);
-		port->ops->set_mctrl(port, port->mctrl & TIOCM_DTR);
+		port->ops->set_mctrl(port, mctrl);
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		/*
-- 
2.17.1
