From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [PATCH 7/7] tty: serial: lantiq: Add CCF support
Date: Tue, 12 Jun 2018 13:40:34 +0800
Message-ID: <20180612054034.4969-8-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180612054034.4969-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@intel.com
Cc: linux-mips@linux-mips.org, qi-ming.wu@intel.com, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Songjun Wu <songjun.wu@linux.intel.com>, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

Previous implementation uses platform-dependent API to get the clock.
Those functions are not available for other SoC which uses the same IP.
The CCF (Common Clock Framework) have an abstraction based APIs
for clock.
Change to use CCF APIs to get clock and rate.
So that different SoCs can use the same driver.
Clocks and clock-names are updated in device tree binding.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>

---

 .../devicetree/bindings/serial/lantiq_asc.txt      |  15 +++
 drivers/tty/serial/Kconfig                         |   2 +-
 drivers/tty/serial/lantiq.c                        | 101 +++++++++++++++++----
 3 files changed, 98 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.txt b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
index 3acbd309ab9d..608f0c87a4af 100644
--- a/Documentation/devicetree/bindings/serial/lantiq_asc.txt
+++ b/Documentation/devicetree/bindings/serial/lantiq_asc.txt
@@ -6,6 +6,10 @@ Required properties:
 - interrupts: the 3 (tx rx err) interrupt numbers. The interrupt specifier
   depends on the interrupt-parent interrupt controller.
 
+Optional properties:
+- clocks: Should contain frequency clock and gate clock
+- clock-names: Should be "freq" and "asc"
+
 Example:
 
 asc1: serial@e100c00 {
@@ -14,3 +18,14 @@ asc1: serial@e100c00 {
 	interrupt-parent = <&icu0>;
 	interrupts = <112 113 114>;
 };
+
+asc0: serial@600000 {
+	compatible = "lantiq,asc";
+	reg = <0x600000 0x100000>;
+	interrupt-parent = <&gic>;
+	interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
+	<GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
+	<GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&pll0aclk SSX4_CLK>, <&clkgate1 GATE_URT_CLK>;
+	clock-names = "freq", "asc";
+};
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0f058df0b070..0f8ac5872a54 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1062,7 +1062,7 @@ config SERIAL_OMAP_CONSOLE
 
 config SERIAL_LANTIQ
 	bool "Lantiq serial driver"
-	depends on LANTIQ
+	depends on LANTIQ || INTEL_MIPS || COMPILE_TEST
 	select SERIAL_CORE
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index cc33208c93ac..fd7ba89daaa2 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -24,7 +24,9 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
+#ifndef CONFIG_COMMON_CLK
 #include <lantiq_soc.h>
+#endif
 
 #define PORT_LTQ_ASC		111
 #define MAXPORTS		2
@@ -104,7 +106,7 @@ static struct uart_driver lqasc_reg;
 struct ltq_uart_port {
 	struct uart_port	port;
 	/* clock used to derive divider */
-	struct clk		*fpiclk;
+	struct clk		*freqclk;
 	/* clock gating of the ASC core */
 	struct clk		*clk;
 	unsigned int		tx_irq;
@@ -120,7 +122,6 @@ static inline struct ltq_uart_port *to_ltq_uart_port(struct uart_port *port)
 
 static void lqasc_stop_tx(struct uart_port *port)
 {
-	return;
 }
 
 static void lqasc_start_tx(struct uart_port *port)
@@ -291,8 +292,7 @@ static unsigned int lqasc_tx_empty(struct uart_port *port)
 	return status ? 0 : TIOCSER_TEMT;
 }
 
-static unsigned int
-lqasc_get_mctrl(struct uart_port *port)
+static unsigned int lqasc_get_mctrl(struct uart_port *port)
 {
 	return TIOCM_CTS | TIOCM_CAR | TIOCM_DSR;
 }
@@ -301,21 +301,65 @@ static void lqasc_set_mctrl(struct uart_port *port, u_int mctrl)
 {
 }
 
-static void
-lqasc_break_ctl(struct uart_port *port, int break_state)
+static void lqasc_break_ctl(struct uart_port *port, int break_state)
 {
 }
 
-static int
-lqasc_startup(struct uart_port *port)
+static void lqasc_fdv_and_reload_get(struct ltq_uart_port *ltq_port,
+				     unsigned int baudrate, unsigned int *fdv,
+				     unsigned int *reload)
+{
+	unsigned int asc_clk = clk_get_rate(ltq_port->freqclk);
+	unsigned int baudrate1 = baudrate * 8192;
+	unsigned long long baudrate2 = (unsigned long long)baudrate * 1000;
+	unsigned long long fdv_over_bg_fpi;
+	unsigned long long fdv_over_bg;
+	unsigned long long difference;
+	unsigned long long min_difference;
+	unsigned int bg;
+
+	/* Sanity check first */
+	if (baudrate >= (asc_clk >> 4)) {
+		pr_err("%s current fpi clock %u can't provide baudrate %u!!!\n",
+		       __func__, asc_clk, baudrate);
+		return;
+	}
+
+	min_difference = UINT_MAX;
+	fdv_over_bg_fpi = baudrate1;
+
+	for (bg = 1; bg <= 8192; bg++, fdv_over_bg_fpi += baudrate1) {
+		fdv_over_bg = fdv_over_bg_fpi + asc_clk / 2;
+		do_div(fdv_over_bg, asc_clk);
+		if (fdv_over_bg <= 512) {
+			difference = fdv_over_bg * asc_clk * 1000;
+			do_div(difference, 8192 * bg);
+			if (difference < baudrate2)
+				difference = baudrate2 - difference;
+			else
+				difference -= baudrate2;
+			if (difference < min_difference) {
+				*fdv = (unsigned int)fdv_over_bg & 511;
+				*reload = bg - 1;
+				min_difference = difference;
+			}
+			/* Perfect one found */
+			if (min_difference == 0)
+				break;
+		}
+	}
+}
+
+static int lqasc_startup(struct uart_port *port)
 {
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
 	int retval;
 	unsigned long flags;
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_enable(ltq_port->clk);
-	port->uartclk = clk_get_rate(ltq_port->fpiclk);
+		clk_prepare_enable(ltq_port->clk);
+
+	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
 	asc_w32_mask(ASCCLC_DISS | ASCCLC_RMCMASK, (1 << ASCCLC_RMCOFFSET),
@@ -378,6 +422,7 @@ static void lqasc_shutdown(struct uart_port *port)
 	int i = 100;
 
 	writel(0, port->membase + LTQ_ASC_CON);
+	writel(0, port->membase + LTQ_ASC_IRNEN);
 	free_irq(ltq_port->tx_irq, port);
 	free_irq(ltq_port->rx_irq, port);
 	free_irq(ltq_port->err_irq, port);
@@ -401,7 +446,7 @@ static void lqasc_shutdown(struct uart_port *port)
 	spin_unlock_irqrestore(&ltq_port->lock, flags);
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_disable(ltq_port->clk);
+		clk_disable_unprepare(ltq_port->clk);
 }
 
 static void lqasc_set_termios(struct uart_port *port,
@@ -476,9 +521,13 @@ static void lqasc_set_termios(struct uart_port *port,
 
 	/* Set baud rate - take a divider of 2 into account */
 	baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
+	if (baud)
+		lqasc_fdv_and_reload_get(ltq_port, baud, &fdv, &reload);
+
 	divisor = uart_get_divisor(port, baud);
 	divisor = divisor / 2 - 1;
 
+	/* Disable the baudrate generator */
 	asc_w32_mask(ASCCON_R, 0, port->membase + LTQ_ASC_CON);
 	/* Ensure the setting is effect before enabling */
 	wmb();
@@ -490,6 +539,9 @@ static void lqasc_set_termios(struct uart_port *port,
 	/* now we can write the new baudrate into the register */
 	writel(fdv, port->membase + LTQ_ASC_FDV);
 
+	/* Ensure baud configuration takes effetive before enabling */
+	wmb();
+
 	/* turn the baudrate generator back on */
 	asc_w32_mask(0, ASCCON_R, port->membase + LTQ_ASC_CON);
 
@@ -546,7 +598,7 @@ static int lqasc_request_port(struct uart_port *port)
 	if (port->flags & UPF_IOREMAP) {
 		port->membase = devm_ioremap_nocache(&pdev->dev,
 						     port->mapbase, size);
-		if (port->membase == NULL)
+		if (!port->membase)
 			return -ENOMEM;
 	}
 	return 0;
@@ -652,9 +704,9 @@ static int __init lqasc_console_setup(struct console *co, char *options)
 	port = &ltq_port->port;
 
 	if (!IS_ERR(ltq_port->clk))
-		clk_enable(ltq_port->clk);
+		clk_prepare_enable(ltq_port->clk);
 
-	port->uartclk = clk_get_rate(ltq_port->fpiclk);
+	port->uartclk = clk_get_rate(ltq_port->freqclk);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
@@ -729,8 +781,11 @@ static int __init lqasc_probe(struct platform_device *pdev)
 	}
 
 	/* check if this is the console port */
-	if (mmres->start != CPHYSADDR(LTQ_EARLY_ASC))
-		line = 1;
+	line = of_alias_get_id(node, "serial");
+	if (line < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", line);
+		return line;
+	}
 
 	if (lqasc_port[line]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", line);
@@ -755,14 +810,22 @@ static int __init lqasc_probe(struct platform_device *pdev)
 	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
-	ltq_port->fpiclk = clk_get_fpi();
-	if (IS_ERR(ltq_port->fpiclk)) {
+#ifdef CONFIG_COMMON_CLK
+	ltq_port->freqclk = devm_clk_get(&pdev->dev, "freq");
+#else
+	ltq_port->freqclk = clk_get_fpi();
+#endif
+	if (IS_ERR(ltq_port->freqclk)) {
 		pr_err("failed to get fpi clk\n");
 		return -ENOENT;
 	}
 
 	/* not all asc ports have clock gates, lets ignore the return code */
+#ifdef CONFIG_COMMON_CLK
+	ltq_port->clk = devm_clk_get(&pdev->dev, "asc");
+#else
 	ltq_port->clk = clk_get(&pdev->dev, NULL);
+#endif
 
 	ltq_port->tx_irq = irqres[0].start;
 	ltq_port->rx_irq = irqres[1].start;
@@ -790,7 +853,7 @@ static struct platform_driver lqasc_driver = {
 	},
 };
 
-int __init init_lqasc(void)
+static int __init init_lqasc(void)
 {
 	int ret;
 
-- 
2.11.0
