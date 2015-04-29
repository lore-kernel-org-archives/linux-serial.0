From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 1/2] serial: sirf: use dynamic method allocate uart structure
Date: Wed, 29 Apr 2015 06:45:08 +0000
Message-ID: <1430289909-28396-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: Qipan Li <Qipan.Li@csr.com>, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-serial@vger.kernel.org

From: Qipan Li <Qipan.Li@csr.com>

In different platform of SiRF SoCs, there is no same uart and usp-uart
numbers, it is not convenient to use hard-coded ports array and port
lines.

here we drop the hard-coded ports table , and drop "cell-index". then
move to use alias id to get line.

for example:
	aliases {
		serial0 = &uart0;
		serial1 = &uart1;
		serial2 = &uart2;
		serial3 = &uart3;
		serial4 = &uart4;
		serial5 = &uart5;
		serial6 = &uart6;
		serial9 = &usp2;
	};

at the same, enlarge the max port number according to the chip with the most
UART.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 84 ++++++++++-----------------------------
 drivers/tty/serial/sirfsoc_uart.h |  8 +---
 2 files changed, 23 insertions(+), 69 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 247faed..e033b93 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -59,50 +59,7 @@ static const struct sirfsoc_baudrate_to_regv baudrate_to_regv[] = {
 	{9600, 1114979},
 };
 
-static struct sirfsoc_uart_port sirfsoc_uart_ports[SIRFSOC_UART_NR] = {
-	[0] = {
-		.port = {
-			.iotype		= UPIO_MEM,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 0,
-		},
-	},
-	[1] = {
-		.port = {
-			.iotype		= UPIO_MEM,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 1,
-		},
-	},
-	[2] = {
-		.port = {
-			.iotype		= UPIO_MEM,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 2,
-		},
-	},
-	[3] = {
-		.port = {
-			.iotype		= UPIO_MEM,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 3,
-		},
-	},
-	[4] = {
-		.port = {
-			.iotype		= UPIO_MEM,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 4,
-		},
-	},
-	[5] = {
-		.port = {
-			.iotype		= UPIO_MEM,
-			.flags		= UPF_BOOT_AUTOCONF,
-			.line		= 5,
-		},
-	},
-};
+static struct sirfsoc_uart_port *sirf_ports[SIRFSOC_UART_NR];
 
 static inline struct sirfsoc_uart_port *to_sirfport(struct uart_port *port)
 {
@@ -1187,27 +1144,29 @@ sirfsoc_uart_console_setup(struct console *co, char *options)
 	unsigned int bits = 8;
 	unsigned int parity = 'n';
 	unsigned int flow = 'n';
-	struct uart_port *port = &sirfsoc_uart_ports[co->index].port;
-	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	struct sirfsoc_register *ureg = &sirfport->uart_reg->uart_reg;
+	struct sirfsoc_uart_port *sirfport;
+	struct sirfsoc_register *ureg;
 	if (co->index < 0 || co->index >= SIRFSOC_UART_NR)
 		return -EINVAL;
-
-	if (!port->mapbase)
+	sirfport = sirf_ports[co->index];
+	if (!sirfport)
+		return -ENODEV;
+	ureg = &sirfport->uart_reg->uart_reg;
+	if (!sirfport->port.mapbase)
 		return -ENODEV;
 
 	/* enable usp in mode1 register */
 	if (sirfport->uart_reg->uart_type == SIRF_USP_UART)
-		wr_regl(port, ureg->sirfsoc_mode1, SIRFSOC_USP_EN |
+		wr_regl(&sirfport->port, ureg->sirfsoc_mode1, SIRFSOC_USP_EN |
 				SIRFSOC_USP_ENDIAN_CTRL_LSBF);
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-	port->cons = co;
+	sirfport->port.cons = co;
 
 	/* default console tx/rx transfer using io mode */
 	sirfport->rx_dma_chan = NULL;
 	sirfport->tx_dma_chan = NULL;
-	return uart_set_options(port, co, baud, parity, bits, flow);
+	return uart_set_options(&sirfport->port, co, baud, parity, bits, flow);
 }
 
 static void sirfsoc_uart_console_putchar(struct uart_port *port, int ch)
@@ -1224,8 +1183,10 @@ static void sirfsoc_uart_console_putchar(struct uart_port *port, int ch)
 static void sirfsoc_uart_console_write(struct console *co, const char *s,
 							unsigned int count)
 {
-	struct uart_port *port = &sirfsoc_uart_ports[co->index].port;
-	uart_console_write(port, s, count, sirfsoc_uart_console_putchar);
+	struct sirfsoc_uart_port *sirfport = sirf_ports[co->index];
+
+	uart_console_write(&sirfport->port, s, count,
+			sirfsoc_uart_console_putchar);
 }
 
 static struct console sirfsoc_uart_console = {
@@ -1284,16 +1245,15 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 
 	match = of_match_node(sirfsoc_uart_ids, pdev->dev.of_node);
-	if (of_property_read_u32(pdev->dev.of_node, "cell-index", &pdev->id)) {
-		dev_err(&pdev->dev,
-			"Unable to find cell-index in uart node.\n");
-		ret = -EFAULT;
+	sirfport = devm_kzalloc(&pdev->dev, sizeof(*sirfport), GFP_KERNEL);
+	if (!sirfport) {
+		ret = -ENOMEM;
 		goto err;
 	}
-	if (of_device_is_compatible(pdev->dev.of_node, "sirf,prima2-usp-uart"))
-		pdev->id += ((struct sirfsoc_uart_register *)
-				match->data)->uart_param.register_uart_nr;
-	sirfport = &sirfsoc_uart_ports[pdev->id];
+	sirfport->port.line = of_alias_get_id(pdev->dev.of_node, "serial");
+	sirf_ports[sirfport->port.line] = sirfport;
+	sirfport->port.iotype = UPIO_MEM;
+	sirfport->port.flags = UPF_BOOT_AUTOCONF;
 	port = &sirfport->port;
 	port->dev = &pdev->dev;
 	port->private_data = sirfport;
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 11fd681..cd30ba9 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -9,8 +9,6 @@
 struct sirfsoc_uart_param {
 	const char *uart_name;
 	const char *port_name;
-	u32 uart_nr;
-	u32 register_uart_nr;
 };
 
 struct sirfsoc_register {
@@ -183,8 +181,6 @@ struct sirfsoc_uart_register sirfsoc_usp = {
 	.uart_param = {
 		.uart_name = "ttySiRF",
 		.port_name = "sirfsoc-uart",
-		.uart_nr = 2,
-		.register_uart_nr = 3,
 	},
 };
 
@@ -255,8 +251,6 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 	.uart_param = {
 		.uart_name = "ttySiRF",
 		.port_name = "sirfsoc_uart",
-		.uart_nr = 3,
-		.register_uart_nr = 0,
 	},
 };
 /* uart io ctrl */
@@ -365,7 +359,7 @@ struct sirfsoc_uart_register sirfsoc_uart = {
 #define SIRFSOC_UART_MINOR			0
 #define SIRFUART_PORT_NAME			"sirfsoc-uart"
 #define SIRFUART_MAP_SIZE			0x200
-#define SIRFSOC_UART_NR				6
+#define SIRFSOC_UART_NR				11
 #define SIRFSOC_PORT_TYPE			0xa5
 
 /* Uart Common Use Macro*/
-- 
2.3.5
