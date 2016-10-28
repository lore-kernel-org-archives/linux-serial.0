From: Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] tty: serial_core: Fix serial console crash on port shutdown
Date: Fri, 28 Oct 2016 07:07:47 -0500
Message-ID: <20161028120748.27763-2-robh@kernel.org>
References: <20161028120748.27763-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161028120748.27763-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Mike Galbraith <mgalbraith@suse.de>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-serial@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The port->console flag is always false, as uart_console() is called
before the serial console has been registered.

Hence for a serial port used as the console, uart_tty_port_shutdown()
will still be called when userspace closes the port, powering it down.
This may lead to a system lock up when the serial console driver writes
to the serial port's registers.

To fix this, move the setting of port->console after the call to
uart_configure_port(), which registers the serial console.

Fixes: 761ed4a94582ab29 ("tty: serial_core: convert uart_close to use tty_port_close")
Reported-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Tested-by: Mugunthan V N <mugunthanvnm@ti.com>
Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
[robh: rebased on tty-linus]
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/tty/serial/serial_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 664c99aeeca5..ce8899c13af3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2759,6 +2759,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 
 	uart_configure_port(drv, state, uport);
 
+	port->console = uart_console(uport);
+
 	num_groups = 2;
 	if (uport->attr_group)
 		num_groups++;
-- 
2.10.1
