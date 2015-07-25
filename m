From: Niklas Cassel <nks@flawful.org>
Subject: [PATCH] serial: etraxfs-uart: use mctrl_gpio helpers for handling modem signals
Date: Sat, 25 Jul 2015 02:02:46 +0200
Message-ID: <1437782566-11528-1-git-send-email-nks@flawful.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Niklas Cassel <nks@flawful.org>
List-Id: linux-serial@vger.kernel.org

In order to use the mctrl_gpio helpers, we change the DT bindings:
ri-gpios renamed to rng-gpios. cd-gpios renamed to dcd-gpios.
However, no in-tree dts/dtsi specifies these, so no worries.

Signed-off-by: Niklas Cassel <nks@flawful.org>
---
 .../bindings/serial/axis,etraxfs-uart.txt          |  6 +++-
 drivers/tty/serial/Kconfig                         |  1 +
 drivers/tty/serial/etraxfs-uart.c                  | 40 ++++++----------------
 3 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt b/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
index ebcbb62..51b3c9e 100644
--- a/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
+++ b/Documentation/devicetree/bindings/serial/axis,etraxfs-uart.txt
@@ -6,7 +6,7 @@ Required properties:
 - interrupts: device interrupt
 
 Optional properties:
-- {dtr,dsr,ri,cd}-gpios: specify a GPIO for DTR/DSR/RI/CD
+- {dtr,dsr,rng,dcd}-gpios: specify a GPIO for DTR/DSR/RI/DCD
   line respectively.
 
 Example:
@@ -16,4 +16,8 @@ serial@b00260000 {
 	reg = <0xb0026000 0x1000>;
 	interrupts = <68>;
 	status = "disabled";
+	dtr-gpios = <&sysgpio 0 GPIO_ACTIVE_LOW>;
+	dsr-gpios = <&sysgpio 1 GPIO_ACTIVE_LOW>;
+	rng-gpios = <&sysgpio 2 GPIO_ACTIVE_LOW>;
+	dcd-gpios = <&sysgpio 3 GPIO_ACTIVE_LOW>;
 };
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 15b4079..8a4b62e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1067,6 +1067,7 @@ config SERIAL_ETRAXFS
 	bool "ETRAX FS serial port support"
 	depends on ETRAX_ARCH_V32 && OF
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 
 config SERIAL_ETRAXFS_CONSOLE
 	bool "ETRAX FS serial console support"
diff --git a/drivers/tty/serial/etraxfs-uart.c b/drivers/tty/serial/etraxfs-uart.c
index a647605..382d434 100644
--- a/drivers/tty/serial/etraxfs-uart.c
+++ b/drivers/tty/serial/etraxfs-uart.c
@@ -10,6 +10,8 @@
 #include <linux/of_address.h>
 #include <hwregs/ser_defs.h>
 
+#include "serial_mctrl_gpio.h"
+
 #define DRV_NAME "etraxfs-uart"
 #define UART_NR CONFIG_ETRAX_SERIAL_PORTS
 
@@ -28,10 +30,7 @@ struct uart_cris_port {
 
 	void __iomem *regi_ser;
 
-	struct gpio_desc *dtr_pin;
-	struct gpio_desc *dsr_pin;
-	struct gpio_desc *ri_pin;
-	struct gpio_desc *cd_pin;
+	struct mctrl_gpios *gpios;
 
 	int write_ongoing;
 };
@@ -396,21 +395,9 @@ static unsigned int etraxfs_uart_get_mctrl(struct uart_port *port)
 	ret = 0;
 	if (crisv32_serial_get_rts(up))
 		ret |= TIOCM_RTS;
-	/* DTR is active low */
-	if (up->dtr_pin && !gpiod_get_raw_value(up->dtr_pin))
-		ret |= TIOCM_DTR;
-	/* CD is active low */
-	if (up->cd_pin && !gpiod_get_raw_value(up->cd_pin))
-		ret |= TIOCM_CD;
-	/* RI is active low */
-	if (up->ri_pin && !gpiod_get_raw_value(up->ri_pin))
-		ret |= TIOCM_RI;
-	/* DSR is active low */
-	if (up->dsr_pin && !gpiod_get_raw_value(up->dsr_pin))
-		ret |= TIOCM_DSR;
 	if (crisv32_serial_get_cts(up))
 		ret |= TIOCM_CTS;
-	return ret;
+	return mctrl_gpio_get(up->gpios, &ret);
 }
 
 static void etraxfs_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
@@ -418,15 +405,7 @@ static void etraxfs_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct uart_cris_port *up = (struct uart_cris_port *)port;
 
 	crisv32_serial_set_rts(up, mctrl & TIOCM_RTS ? 1 : 0, 0);
-	/* DTR is active low */
-	if (up->dtr_pin)
-		gpiod_set_raw_value(up->dtr_pin, mctrl & TIOCM_DTR ? 0 : 1);
-	/* RI is active low */
-	if (up->ri_pin)
-		gpiod_set_raw_value(up->ri_pin, mctrl & TIOCM_RNG ? 0 : 1);
-	/* CD is active low */
-	if (up->cd_pin)
-		gpiod_set_raw_value(up->cd_pin, mctrl & TIOCM_CD ? 0 : 1);
+	mctrl_gpio_set(up->gpios, mctrl);
 }
 
 static void etraxfs_uart_break_ctl(struct uart_port *port, int break_state)
@@ -920,11 +899,12 @@ static int etraxfs_uart_probe(struct platform_device *pdev)
 
 	up->irq = irq_of_parse_and_map(np, 0);
 	up->regi_ser = of_iomap(np, 0);
-	up->dtr_pin = devm_gpiod_get_optional(&pdev->dev, "dtr");
-	up->dsr_pin = devm_gpiod_get_optional(&pdev->dev, "dsr");
-	up->ri_pin = devm_gpiod_get_optional(&pdev->dev, "ri");
-	up->cd_pin = devm_gpiod_get_optional(&pdev->dev, "cd");
 	up->port.dev = &pdev->dev;
+
+	up->gpios = mctrl_gpio_init(&pdev->dev, 0);
+	if (IS_ERR(up->gpios))
+		return PTR_ERR(up->gpios);
+
 	cris_serial_port_init(&up->port, dev_id);
 
 	etraxfs_uart_ports[dev_id] = up;
-- 
2.4.6
