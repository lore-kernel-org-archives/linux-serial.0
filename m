From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH v2 1/2] serial: mps2-uart: move to dynamic port allocation
Date: Wed, 30 Jan 2019 09:55:14 +0000
Message-ID: <1548842115-14782-2-git-send-email-vladimir.murzin@arm.com>
References: <1548842115-14782-1-git-send-email-vladimir.murzin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1548842115-14782-1-git-send-email-vladimir.murzin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: greg@kroah.com, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
List-Id: linux-serial@vger.kernel.org

Some designs, like MPS3, expose number of virtual serial ports which
already close or exceeds MPS2_MAX_PORTS. Increasing MPS2_MAX_PORTS
would have negative impact (in terms of memory consumption) on tiny
MPS2 platform which, in fact, has only one physically populated UART.

Start with converting existent static port array to idr. As a bonus it
make driver not to fail in case when no alias was specified in device
tree.

Note: there is no need in idr_destroy() because code doesn't unload
since ce87122911f8 ("serial: mps2-uart: make driver explicitly non-modular")

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
Changelog
	v1 -> v2
	   -  added a note about idr_destroy()

 drivers/tty/serial/mps2-uart.c | 47 ++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 9f8f637..6da0633 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -22,6 +22,7 @@
 #include <linux/serial_core.h>
 #include <linux/tty_flip.h>
 #include <linux/types.h>
+#include <linux/idr.h>
 
 #define SERIAL_NAME	"ttyMPS"
 #define DRIVER_NAME	"mps2-uart"
@@ -397,7 +398,7 @@ static const struct uart_ops mps2_uart_pops = {
 	.verify_port = mps2_uart_verify_port,
 };
 
-static struct mps2_uart_port mps2_uart_ports[MPS2_MAX_PORTS];
+static DEFINE_IDR(ports_idr);
 
 #ifdef CONFIG_SERIAL_MPS2_UART_CONSOLE
 static void mps2_uart_console_putchar(struct uart_port *port, int ch)
@@ -410,7 +411,8 @@ static void mps2_uart_console_putchar(struct uart_port *port, int ch)
 
 static void mps2_uart_console_write(struct console *co, const char *s, unsigned int cnt)
 {
-	struct uart_port *port = &mps2_uart_ports[co->index].port;
+	struct mps2_uart_port *mps_port = idr_find(&ports_idr, co->index);
+	struct uart_port *port = &mps_port->port;
 
 	uart_console_write(port, s, cnt, mps2_uart_console_putchar);
 }
@@ -426,7 +428,10 @@ static int mps2_uart_console_setup(struct console *co, char *options)
 	if (co->index < 0 || co->index >= MPS2_MAX_PORTS)
 		return -ENODEV;
 
-	mps_port = &mps2_uart_ports[co->index];
+	mps_port = idr_find(&ports_idr, co->index);
+
+	if (!mps_port)
+		return -ENODEV;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -487,27 +492,32 @@ static struct uart_driver mps2_uart_driver = {
 	.cons = MPS2_SERIAL_CONSOLE,
 };
 
-static struct mps2_uart_port *mps2_of_get_port(struct platform_device *pdev)
+static int mps2_of_get_port(struct platform_device *pdev,
+			    struct mps2_uart_port *mps_port)
 {
 	struct device_node *np = pdev->dev.of_node;
 	int id;
 
 	if (!np)
-		return NULL;
+		return -ENODEV;
 
 	id = of_alias_get_id(np, "serial");
+
+	if (id < 0)
+		id = idr_alloc_cyclic(&ports_idr, (void *)mps_port, 0, MPS2_MAX_PORTS, GFP_KERNEL);
+	else
+		id = idr_alloc(&ports_idr, (void *)mps_port, id, MPS2_MAX_PORTS, GFP_KERNEL);
+
 	if (id < 0)
-		id = 0;
+		return id;
 
-	if (WARN_ON(id >= MPS2_MAX_PORTS))
-		return NULL;
+	mps_port->port.line = id;
 
-	mps2_uart_ports[id].port.line = id;
-	return &mps2_uart_ports[id];
+	return 0;
 }
 
-static int mps2_init_port(struct mps2_uart_port *mps_port,
-			  struct platform_device *pdev)
+static int mps2_init_port(struct platform_device *pdev,
+			  struct mps2_uart_port *mps_port)
 {
 	struct resource *res;
 	int ret;
@@ -550,11 +560,16 @@ static int mps2_serial_probe(struct platform_device *pdev)
 	struct mps2_uart_port *mps_port;
 	int ret;
 
-	mps_port = mps2_of_get_port(pdev);
-	if (!mps_port)
-		return -ENODEV;
+	mps_port = devm_kzalloc(&pdev->dev, sizeof(struct mps2_uart_port), GFP_KERNEL);
+
+        if (!mps_port)
+                return -ENOMEM;
+
+	ret = mps2_of_get_port(pdev, mps_port);
+	if (ret)
+		return ret;
 
-	ret = mps2_init_port(mps_port, pdev);
+	ret = mps2_init_port(pdev, mps_port);
 	if (ret)
 		return ret;
 
-- 
2.7.4
