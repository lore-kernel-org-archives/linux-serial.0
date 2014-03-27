From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2] serial_core: Fix pm imbalance on unbind
Date: Thu, 27 Mar 2014 11:40:39 +0100
Message-ID: <1395916839-11502-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

When a serial port is closed, uart_close() takes care of shutting down the
hardware, and powering it down.

When a serial port is unbound while in use, uart_close() bypasses all of
this, as this is supposed to be done through uart_hangup() (invoked via
tty_vhangup() in uart_remove_one_port()).

However, uart_hangup() does not set the hardware's power state, leaving it
powered up.  This may also lead to unbounded nesting counts in clock and
power management, depending on their internal implementation.

Make sure to power down the port in uart_hangup(), except when the port is
used as a serial console.

For serial consoles, this operation must be postponed until after the port
becomes completely unused. This case is not fixed yet, as it depends on a
(future) fix for the tty->count vs. port->count imbalance on failed
uart_open().

After this, the module clock used by the sh-sci driver is disabled on
unbind while the serial port is in use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop serial console case, as this needs other fixes first

 drivers/tty/serial/serial_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 2cf5649a6dc0..0cec51ce8902 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1452,6 +1452,8 @@ static void uart_hangup(struct tty_struct *tty)
 		clear_bit(ASYNCB_NORMAL_ACTIVE, &port->flags);
 		spin_unlock_irqrestore(&port->lock, flags);
 		tty_port_tty_set(port, NULL);
+		if (!uart_console(state->uart_port))
+			uart_change_pm(state, UART_PM_STATE_OFF);
 		wake_up_interruptible(&port->open_wait);
 		wake_up_interruptible(&port->delta_msr_wait);
 	}
-- 
1.7.9.5

