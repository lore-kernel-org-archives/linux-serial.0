From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] serial: core: Use cons->index for preferred console registration
Date: Mon,  2 Sep 2019 16:27:59 +0200
Message-ID: <4a877f1c7189a7c45b59a6ebfc3de607e8758949.1567434470.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

The reason for this patch is xilinx_uartps driver which create one dynamic
instance per IP with unique major and minor combinations. drv->nr is in
this case all the time setup to 1. That means that uport->line is all the
time setup to 0 and drv->tty_driver->name_base is doing shift in name to
for example ttyPS3.

register_console() is looping over console_cmdline array and looking for
proper name/index combination which is in our case ttyPS/3.
That's why every instance of driver needs to be registered with proper
combination of name/number (ttyPS/3). Using uport->line is doing
registration with ttyPS/0 which is wrong that's why proper console index
should be used which is in cons->index field.

Also it is visible that recording console should be done based on
information about console not about the port but in most cases numbers are
the same and xilinx_uartps is only one exception now.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4223cb496764..5ec447a4c5c3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2825,7 +2825,8 @@ int uart_add_one_port(struct uart_driver *drv, struct uart_port *uport)
 		lockdep_set_class(&uport->lock, &port_lock_key);
 	}
 	if (uport->cons && uport->dev)
-		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
+		of_console_check(uport->dev->of_node, uport->cons->name,
+				 uport->cons->index);
 
 	uart_configure_port(drv, state, uport);
 
-- 
2.17.1
