From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] tty: serial_core: Move uart_console() check after console registration
Date: Thu, 29 Sep 2016 17:31:04 +0200
Message-ID: <1475163064-20399-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Rob Herring <robh@kernel.org>
Cc: Takeshi Kihara <takeshi.kihara.df@renesas.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The port->console flag is always false, as uart_console() is called
before the serial console has been registered.

Hence for a serial port used as the console, uart_tty_port_shutdown()
will still be called when userspace closes the port, powering it down.
This will lead to a system lock up when the serial console driver writes
to the serial port's registers.

To fix this, move the setting of port->console after the call to
uart_configure_port(), which registers the serial console.

Fixes: 761ed4a94582ab29 ("tty: serial_core: convert uart_close to use tty_port_close")
Reported-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reported-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
RFC because of the comment "If this port is a console, then the spinlock
is already initialised", and the pre-existing code calling
uart_console() before uart_configure_port().

Can be reproduced on Renesas boards:
  1. With systemd: hangs during boot,
  2. Without systemd: "telinit n" to switch to a runlevel that doesn't
     run a getty on ttySC0, and trigger kernel output.
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6e4f63627479db8d..ce8899c13af3d97f 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2746,8 +2746,6 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 	uport->cons = drv->cons;
 	uport->minor = drv->tty_driver->minor_start + uport->line;
 
-	port->console = uart_console(uport);
-
 	/*
 	 * If this port is a console, then the spinlock is already
 	 * initialised.
@@ -2761,6 +2759,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	uart_configure_port(drv, state, uport);
 
+	port->console = uart_console(uport);
+
 	num_groups = 2;
 	if (uport->attr_group)
 		num_groups++;
-- 
1.9.1
