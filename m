From: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
Subject: [PATCH] tty: serial: constify uartlite_reg_ops structs
Date: Tue, 15 Dec 2015 01:42:05 +0200
Message-ID: <20151214234205.GA5972@waves>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Constifies uartlite_reg_ops structures in tty's
serial port driver since they are not modified
after their initialization.

Detected and found using Coccinelle.

Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
---
 drivers/tty/serial/uartlite.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b1c6bd3..733cf58 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -72,7 +72,7 @@ static void uartlite_outbe32(u32 val, void __iomem *addr)
 	iowrite32be(val, addr);
 }
 
-static struct uartlite_reg_ops uartlite_be = {
+static const struct uartlite_reg_ops uartlite_be = {
 	.in = uartlite_inbe32,
 	.out = uartlite_outbe32,
 };
@@ -87,21 +87,21 @@ static void uartlite_outle32(u32 val, void __iomem *addr)
 	iowrite32(val, addr);
 }
 
-static struct uartlite_reg_ops uartlite_le = {
+static const struct uartlite_reg_ops uartlite_le = {
 	.in = uartlite_inle32,
 	.out = uartlite_outle32,
 };
 
 static inline u32 uart_in32(u32 offset, struct uart_port *port)
 {
-	struct uartlite_reg_ops *reg_ops = port->private_data;
+	const struct uartlite_reg_ops *reg_ops = port->private_data;
 
 	return reg_ops->in(port->membase + offset);
 }
 
 static inline void uart_out32(u32 val, u32 offset, struct uart_port *port)
 {
-	struct uartlite_reg_ops *reg_ops = port->private_data;
+	const struct uartlite_reg_ops *reg_ops = port->private_data;
 
 	reg_ops->out(val, port->membase + offset);
 }
-- 
2.4.3


-- 
Kind Regards,
Aya Saif El-yazal Mahfouz
