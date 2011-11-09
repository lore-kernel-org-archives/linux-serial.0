From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/10] TTY: serial, do not touch tty->alt_speed
Date: Wed,  9 Nov 2011 21:33:48 +0100
Message-ID: <1320870831-23778-6-git-send-email-jslaby@suse.cz>
References: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320870831-23778-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

It is not used at all, so no need to play any games with that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/serial_core.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 036e0cc..4b1dcd3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -141,8 +141,7 @@ static int uart_startup(struct tty_struct *tty, struct uart_state *state, int in
 
 	/*
 	 * Set the TTY IO error marker - we will only clear this
-	 * once we have successfully opened the port.  Also set
-	 * up the tty->alt_speed kludge
+	 * once we have successfully opened the port.
 	 */
 	set_bit(TTY_IO_ERROR, &tty->flags);
 
@@ -1499,7 +1498,6 @@ static int uart_open(struct tty_struct *tty, struct file *filp)
 	tty->driver_data = state;
 	state->uart_port->state = state;
 	tty->low_latency = (state->uart_port->flags & UPF_LOW_LATENCY) ? 1 : 0;
-	tty->alt_speed = 0;
 	tty_port_tty_set(port, tty);
 
 	/*
-- 
1.7.7
