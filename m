From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/9] ARM: meson: serial: release region on port release
Date: Wed, 18 Nov 2015 14:41:11 +0000
Message-ID: <1447857679-30158-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: edward.cragg@codethink.co.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-meson@googlegroups.com, linux-kernel@codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, carlo@caione.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

The meson_uart_release_port() unmaps the register area but does not release
it. The meson_uart_request_port() calls devm_request_mem_region so the
release should call devm_release_mem_region() for that area so that anyt
subsequent use of these calls will work.

This fixes an issue where the addition of reset code before registering
the uart stops the console from working.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 0fc83c9..b9f0829 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -367,9 +367,26 @@ static int meson_uart_verify_port(struct uart_port *port,
 	return ret;
 }
 
+static int meson_uart_res_size(struct uart_port *port)
+{
+	struct platform_device *pdev = to_platform_device(port->dev);
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(port->dev, "cannot obtain I/O memory region");
+		return -ENODEV;
+	}
+
+	return resource_size(res);
+}
+
 static void meson_uart_release_port(struct uart_port *port)
 {
+	int size = meson_uart_res_size(port);
+
 	if (port->flags & UPF_IOREMAP) {
+		devm_release_mem_region(port->dev, port->mapbase, size);
 		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
@@ -377,16 +394,10 @@ static void meson_uart_release_port(struct uart_port *port)
 
 static int meson_uart_request_port(struct uart_port *port)
 {
-	struct platform_device *pdev = to_platform_device(port->dev);
-	struct resource *res;
-	int size;
+	int size = meson_uart_res_size(port);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "cannot obtain I/O memory region");
-		return -ENODEV;
-	}
-	size = resource_size(res);
+	if (size < 0)
+		return size;
 
 	if (!devm_request_mem_region(port->dev, port->mapbase, size,
 				     dev_name(port->dev))) {
-- 
2.6.2
