From: Rob Herring <robh@kernel.org>
Subject: [PATCH] serial: core: fix console problems on uart_close
Date: Mon, 24 Oct 2016 15:56:49 -0500
Message-ID: <20161024205649.32430-1-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Mike Galbraith <umgwanakikbuti@gmail.com>, Mugunthan V N <mugunthanvnm@ti.com>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Commit 761ed4a94582 ('tty: serial_core: convert uart_close to use
tty_port_close') started setting the ttyport console flag for serial
drivers. This is causing crashes, hangs, or garbage output on several
platforms because the serial shutdown is skipped and IRQs are left
enabled.

Partially revert commit 761ed4a94582 and drop reporting UART tty_ports
as a console leaving the console handling to the serial_core as it was
before.

Fixes: 761ed4a94582ab29 ("tty: serial_core: convert uart_close to use tty_port_close")
Reported-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reported-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Reported-by: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Geert's fix seems to be inadequate for some systems as Mike reported[1]. 
This fix works in Mike's case.

Geert, Mugunthan, Can you all test this is enough to fix your issues.

Rob

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1254753.html


 drivers/tty/serial/serial_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6e4f63627479..664c99aeeca5 100644
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
-- 
2.10.1
