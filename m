From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH v1] tty: serial: 8250: Cleanup p->em485 in serial8250_unregister_port
Date: Mon, 15 Feb 2016 21:42:12 +0300
Message-ID: <1455561732-1738-1-git-send-email-matwey@sai.msu.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, andy.shevchenko@gmail.com, gnomes@lxorguk.ukuu.org.uk
Cc: "Matwey V. Kornilov" <matwey@sai.msu.ru>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Formally, currently there is no memory leak, but if
serial8250_ports[line] is reused with other 8250 driver, then em485
will be already activated and it will cause issues.

Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
Hi Peter,

There is an issue with my previous patch. Under specific circumstances,
the emulation can be enabled for drivers which don't want (and support) it.
Unfortunately, I can't test this patch because kgdb over 8250_omap console
is the single one option for me on BBB. This patch testing involves
8250_omap module unloading and then inspecting serial8250_ports.
You say that you are preparing some unit-tests. Could you include a test
for this specific issue? And then probably this patch has to be applied.

 drivers/tty/serial/8250/8250_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index c9720a9..a242881 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1068,6 +1068,15 @@ void serial8250_unregister_port(int line)
 	struct uart_8250_port *uart = &serial8250_ports[line];
 
 	mutex_lock(&serial_mutex);
+
+	if (uart->em485) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&uart->port.lock, flags);
+		serial8250_em485_destroy(uart);
+		spin_unlock_irqrestore(&uart->port.lock, flags);
+	}
+
 	uart_remove_one_port(&serial8250_reg, &uart->port);
 	if (serial8250_isa_devs) {
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
-- 
2.7.0
