From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 1/9] serial: samsung: Keep a copy of the location of platform
 data in driver's private data
Date: Tue, 27 Sep 2011 00:37:10 +0530
Message-ID: <1317064038-32428-2-git-send-email-thomas.abraham@linaro.org>
References: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-serial@vger.kernel.org

Add a pointer to the location of the platform data in the driver's private
data. When instantiated using device tree, pdev->dev->platform_data does not
necessarily point to a valid instance of platform data. The platform data
pointer in the driver's private data could be set to pdev->dev->platform_data
or platform data instance created from device tree.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/tty/serial/s5pv210.c |   12 ++++++++++--
 drivers/tty/serial/samsung.c |   16 ++++++++++++----
 drivers/tty/serial/samsung.h |    4 +++-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
index 8b0b888..03b249e 100644
--- a/drivers/tty/serial/s5pv210.c
+++ b/drivers/tty/serial/s5pv210.c
@@ -28,9 +28,13 @@
 static int s5pv210_serial_setsource(struct uart_port *port,
 					struct s3c24xx_uart_clksrc *clk)
 {
-	struct s3c2410_uartcfg *cfg = port->dev->platform_data;
+	struct s3c24xx_uart_port *ourport;
+	struct s3c2410_uartcfg *cfg;
 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
 
+	ourport = container_of(port, struct s3c24xx_uart_port, port);
+	cfg = ourport->cfg;
+
 	if (cfg->flags & NO_NEED_CHECK_CLKSRC)
 		return 0;
 
@@ -51,9 +55,13 @@ static int s5pv210_serial_setsource(struct uart_port *port,
 static int s5pv210_serial_getsource(struct uart_port *port,
 					struct s3c24xx_uart_clksrc *clk)
 {
-	struct s3c2410_uartcfg *cfg = port->dev->platform_data;
+	struct s3c24xx_uart_port *ourport;
+	struct s3c2410_uartcfg *cfg;
 	u32 ucon = rd_regl(port, S3C2410_UCON);
 
+	ourport = container_of(port, struct s3c24xx_uart_port, port);
+	cfg = ourport->cfg;
+
 	clk->divisor = 1;
 
 	if (cfg->flags & NO_NEED_CHECK_CLKSRC)
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index b31f1c3..51cfb9f 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -190,10 +190,13 @@ static inline struct s3c24xx_uart_info *s3c24xx_port_to_info(struct uart_port *p
 
 static inline struct s3c2410_uartcfg *s3c24xx_port_to_cfg(struct uart_port *port)
 {
+	struct s3c24xx_uart_port *ourport;
+
 	if (port->dev == NULL)
 		return NULL;
 
-	return (struct s3c2410_uartcfg *)port->dev->platform_data;
+	ourport = container_of(port, struct s3c24xx_uart_port, port);
+	return ourport->cfg;
 }
 
 static int s3c24xx_serial_rx_fifocnt(struct s3c24xx_uart_port *ourport,
@@ -1125,7 +1128,7 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 				    struct platform_device *platdev)
 {
 	struct uart_port *port = &ourport->port;
-	struct s3c2410_uartcfg *cfg;
+	struct s3c2410_uartcfg *cfg = platdev->dev.platform_data;
 	struct resource *res;
 	int ret;
 
@@ -1134,11 +1137,16 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 	if (platdev == NULL)
 		return -ENODEV;
 
-	cfg = s3c24xx_dev_to_cfg(&platdev->dev);
-
 	if (port->mapbase != 0)
 		return 0;
 
+	/*
+	 * If platform data is supplied, keep a copy of the location of
+	 * platform data in the driver's private data.
+	 */
+	if (cfg)
+		ourport->cfg = cfg;
+
 	if (cfg->hwport > CONFIG_SERIAL_SAMSUNG_UARTS) {
 		printk(KERN_ERR "%s: port %d bigger than %d\n", __func__,
 		       cfg->hwport, CONFIG_SERIAL_SAMSUNG_UARTS);
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 8e87b78..6c9cb9d 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -48,6 +48,9 @@ struct s3c24xx_uart_port {
 	struct clk			*baudclk;
 	struct uart_port		port;
 
+	/* reference to platform data */
+	struct s3c2410_uartcfg		*cfg;
+
 #ifdef CONFIG_CPU_FREQ
 	struct notifier_block		freq_transition;
 #endif
@@ -56,7 +59,6 @@ struct s3c24xx_uart_port {
 /* conversion functions */
 
 #define s3c24xx_dev_to_port(__dev) (struct uart_port *)dev_get_drvdata(__dev)
-#define s3c24xx_dev_to_cfg(__dev) (struct s3c2410_uartcfg *)((__dev)->platform_data)
 
 /* register access controls */
 
-- 
1.6.6.rc2
