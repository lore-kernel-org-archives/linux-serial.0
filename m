From: Stuart Menefy <stuart.menefy@mathembedded.com>
Subject: [PATCH] tty: serial: samsung: Enable baud clock during initialisation
Date: Tue, 12 Feb 2019 21:40:22 +0000
Message-ID: <20190212214022.9446-1-stuart.menefy@mathembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The Exynos 5260, like the 5433, appears to require baud clock as
well as pclk to be running before accessing any of the registers,
otherwise an external abort is raised.

The serial driver already enables baud clock when required, but only
if it knows which clock is baud clock. On older SoCs baud clock may be
selected from a number of possible clocks so to support this the driver
only selects which clock to use for baud clock when a port is opened,
at which point the desired baud rate is known and the best clock can be
selected.

The result is that there are a number of circumstances in which
registers are accessed without first explicitly enabling baud clock:
 - while the driver is being initialised
 - the initial parts of opening a port for the first time
 - when resuming if the port hasn't been already opened

The 5433 overcomes this currently by marking the baud clock as
CLK_IGNORE_UNUSED, so the clock is always enabled, however
for the 5260 I've been trying to avoid this.

This change adds code to pick the first available clock to use
as baud clock and enables it while initialising the driver.

This code wouldn't be sufficient on a SoC which supports
multiple possible baud clock sources _and_ requires the
correct baud clock to be enabled before accessing any of the
serial port registers (in particular the register which selects
which clock to use as the baud clock).  As far as I know
such hardware doesn't exist.

Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
---
 drivers/tty/serial/samsung.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 9fc3559f80d9..83fd51607741 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1694,6 +1694,42 @@ s3c24xx_serial_cpufreq_deregister(struct s3c24xx_uart_port *port)
 }
 #endif
 
+static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
+{
+	struct device *dev = ourport->port.dev;
+	struct s3c24xx_uart_info *info = ourport->info;
+	char clk_name[MAX_CLK_NAME_LENGTH];
+	unsigned int clk_sel;
+	struct clk *clk;
+	int clk_num;
+	int ret;
+
+	clk_sel = ourport->cfg->clk_sel ? : info->def_clk_sel;
+	for (clk_num = 0; clk_num < info->num_clks; clk_num++) {
+		if (!(clk_sel & (1 << clk_num)))
+			continue;
+
+		sprintf(clk_name, "clk_uart_baud%d", clk_num);
+		clk = clk_get(dev, clk_name);
+		if (IS_ERR(clk))
+			continue;
+
+		ret = clk_prepare_enable(clk);
+		if (ret) {
+			clk_put(clk);
+			continue;
+		}
+
+		ourport->baudclk = clk;
+		ourport->baudclk_rate = clk_get_rate(clk);
+		s3c24xx_serial_setsource(&ourport->port, clk_num);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 /* s3c24xx_serial_init_port
  *
  * initialise a single serial port from the platform device given
@@ -1788,6 +1824,10 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 		goto err;
 	}
 
+	ret = s3c24xx_serial_enable_baudclk(ourport);
+	if (ret)
+		pr_warn("uart: failed to enable baudclk\n");
+
 	/* Keep all interrupts masked and cleared */
 	if (s3c24xx_serial_has_interrupt_mask(port)) {
 		wr_regl(port, S3C64XX_UINTM, 0xf);
@@ -1901,6 +1941,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	 * and keeps the clock enabled in this case.
 	 */
 	clk_disable_unprepare(ourport->clk);
+	if (!IS_ERR(ourport->baudclk))
+		clk_disable_unprepare(ourport->baudclk);
 
 	ret = s3c24xx_serial_cpufreq_register(ourport);
 	if (ret < 0)
-- 
2.13.6
