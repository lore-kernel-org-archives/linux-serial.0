From: Eddie Huang <eddie.huang@mediatek.com>
Subject: [PATCH v2 1/4] tty: serial: Add 8250 earlycon to support noinit option
Date: Mon, 12 Jan 2015 21:08:21 +0800
Message-ID: <1421068104-30463-2-git-send-email-eddie.huang@mediatek.com>
References: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421068104-30463-1-git-send-email-eddie.huang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: devicetree@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>, srv_heupstream@mediatek.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, yh.chen@mediatek.com, Howard Chen <ibanezchen@gmail.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-serial@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Jiri Slaby <jslaby@suse.cz>, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Add earlycon support not only baudrate option, but also add noinit option.
If use noinit option, 8250 earlycon will not init serial hardware and use
loader setting.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/tty/serial/8250/8250_early.c |  7 ++++---
 drivers/tty/serial/earlycon.c        | 17 ++++++++++++-----
 include/linux/serial_8250.h          |  2 ++
 include/linux/serial_core.h          |  1 +
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 4858b8a..a13d757 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -138,19 +138,20 @@ static void __init init_port(struct earlycon_device *device)
 	serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
 }
 
-static int __init early_serial8250_setup(struct earlycon_device *device,
+int __init early_serial8250_setup(struct earlycon_device *device,
 					 const char *options)
 {
 	if (!(device->port.membase || device->port.iobase))
 		return 0;
 
-	if (!device->baud) {
+	if (!device->baud && !device->noinit) {
 		device->baud = probe_baud(&device->port);
 		snprintf(device->options, sizeof(device->options), "%u",
 			 device->baud);
 	}
 
-	init_port(device);
+	if (!device->noinit)
+		init_port(device);
 
 	early_device = device;
 	device->con->write = early_serial8250_write;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 64fe25a..4891251 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -58,7 +58,7 @@ static int __init parse_options(struct earlycon_device *device,
 				char *options)
 {
 	struct uart_port *port = &device->port;
-	int mmio, mmio32, length;
+	int noinit, mmio, mmio32, length;
 	unsigned long addr;
 
 	if (!options)
@@ -92,10 +92,17 @@ static int __init parse_options(struct earlycon_device *device,
 	options = strchr(options, ',');
 	if (options) {
 		options++;
-		device->baud = simple_strtoul(options, NULL, 0);
-		length = min(strcspn(options, " ") + 1,
-			     (size_t)(sizeof(device->options)));
-		strlcpy(device->options, options, length);
+		noinit = !strncmp(options, "noinit", 6);
+		if (noinit) {
+			device->noinit = noinit;
+			strlcpy(device->options, options, 6);
+			device->options[6] = '\0';
+		} else {
+			device->baud = simple_strtoul(options, NULL, 0);
+			length = min(strcspn(options, " ") + 1,
+					(size_t)(sizeof(device->options)));
+			strlcpy(device->options, options, length);
+		}
 	}
 
 	if (port->iotype == UPIO_MEM || port->iotype == UPIO_MEM32)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index e02acf0..0e26eec 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -119,6 +119,8 @@ extern int serial8250_find_port(struct uart_port *p);
 extern int serial8250_find_port_for_earlycon(void);
 extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
 extern void serial8250_early_out(struct uart_port *port, int offset, int value);
+extern int early_serial8250_setup(struct earlycon_device *device,
+					 const char *options);
 extern int setup_early_serial8250_console(char *cmdline);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 057038c..72c6698 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -326,6 +326,7 @@ struct earlycon_device {
 	struct uart_port port;
 	char options[16];		/* e.g., 115200n8 */
 	unsigned int baud;
+	int noinit;
 };
 int setup_earlycon(char *buf, const char *match,
 		   int (*setup)(struct earlycon_device *, const char *));
-- 
1.8.1.1.dirty
