From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] serial: 8250_uniphier: fix dl_read and dl_write functions
Date: Mon, 19 Oct 2015 13:37:55 +0900
Message-ID: <1445229475-23201-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The register offset must be shifted by regshift, otherwise the
baudrate is not set.  I missed the issue probably because the
divisor register was already set by the boot loader.

Fixes: 1a8d2903cb6a ("serial: 8250_uniphier: add UniPhier serial driver")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Hi Greg,

Please apply this simple fix for Linux 4.3.

Thanks,
Masahiro


 drivers/tty/serial/8250/8250_uniphier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index d11621e..245edbb 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -115,12 +115,16 @@ static void uniphier_serial_out(struct uart_port *p, int offset, int value)
  */
 static int uniphier_serial_dl_read(struct uart_8250_port *up)
 {
-	return readl(up->port.membase + UNIPHIER_UART_DLR);
+	int offset = UNIPHIER_UART_DLR << up->port.regshift;
+
+	return readl(up->port.membase + offset);
 }
 
 static void uniphier_serial_dl_write(struct uart_8250_port *up, int value)
 {
-	writel(value, up->port.membase + UNIPHIER_UART_DLR);
+	int offset = UNIPHIER_UART_DLR << up->port.regshift;
+
+	writel(value, up->port.membase + offset);
 }
 
 static int uniphier_of_serial_setup(struct device *dev, struct uart_port *port,
-- 
1.9.1
