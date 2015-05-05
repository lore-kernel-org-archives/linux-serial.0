From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] serial: 8250: Do nothing if nr_uarts=0
Date: Tue, 05 May 2015 08:26:27 +0200
Message-ID: <55486293.2080400@siemens.com>
References: <554797D4.5080704@siemens.com> <5547A614.9020109@hurleysoftware.com> <5547B04C.8080706@siemens.com> <5547C001.8040400@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5547C001.8040400@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When nr_uarts was set to 0 (via config or 8250_core.nr_uarts), we crash
early on x86 because serial8250_isa_init_ports dereferences base_ops
which remains NULL. In fact, there is nothing to do for all the callers
of serial8250_isa_init_ports if there are no uarts.

Based on suggestions by Peter Hurley.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

This supersedes "serial: 8250: Prevent kernel crash with nr_uarts=0"

 drivers/tty/serial/8250/8250_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 4506e40..dfcb14f 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -3548,6 +3548,9 @@ static struct console univ8250_console = {
 
 static int __init univ8250_console_init(void)
 {
+	if (nr_uarts == 0)
+		return -ENODEV;
+
 	serial8250_isa_init_ports();
 	register_console(&univ8250_console);
 	return 0;
@@ -3578,7 +3581,7 @@ int __init early_serial_setup(struct uart_port *port)
 {
 	struct uart_port *p;
 
-	if (port->line >= ARRAY_SIZE(serial8250_ports))
+	if (port->line >= ARRAY_SIZE(serial8250_ports) || nr_uarts == 0)
 		return -ENODEV;
 
 	serial8250_isa_init_ports();
@@ -3945,6 +3948,9 @@ static int __init serial8250_init(void)
 {
 	int ret;
 
+	if (nr_uarts == 0)
+		return -ENODEV;
+
 	serial8250_isa_init_ports();
 
 	printk(KERN_INFO "Serial: 8250/16550 driver, "
-- 
2.1.4
