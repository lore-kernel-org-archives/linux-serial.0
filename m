From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 3/4] serial: sccnxp: Using structure for each supported IC instead of switch in probe
Date: Wed, 31 Jul 2013 14:56:31 +0400
Message-ID: <1375268191-13428-3-git-send-email-shc_work@mail.ru>
References: <1375268191-13428-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp33.i.mail.ru ([94.100.177.93]:41403 "EHLO smtp33.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755530Ab3GaK4k (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 31 Jul 2013 06:56:40 -0400
In-Reply-To: <1375268191-13428-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Alexander Shiyan <shc_work@mail.ru>

This patch replaces switch in probe function to constant structure
for each supported IC. This makes code a bit smaller and cleaner and
helps adding DT support to the driver in the future.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/sccnxp.c | 272 ++++++++++++++++++++------------------------
 1 file changed, 124 insertions(+), 148 deletions(-)

diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 81e7047..ef53c7a 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -95,16 +95,17 @@
 #define MCTRL_IBIT(cfg, sig)		((((cfg) >> (sig)) & 0xf) - LINE_IP0)
 #define MCTRL_OBIT(cfg, sig)		((((cfg) >> (sig)) & 0xf) - LINE_OP0)
 
-/* Supported chip types */
-enum {
-	SCCNXP_TYPE_SC2681	= 2681,
-	SCCNXP_TYPE_SC2691	= 2691,
-	SCCNXP_TYPE_SC2692	= 2692,
-	SCCNXP_TYPE_SC2891	= 2891,
-	SCCNXP_TYPE_SC2892	= 2892,
-	SCCNXP_TYPE_SC28202	= 28202,
-	SCCNXP_TYPE_SC68681	= 68681,
-	SCCNXP_TYPE_SC68692	= 68692,
+#define SCCNXP_HAVE_IO		0x00000001
+#define SCCNXP_HAVE_MR0		0x00000002
+
+struct sccnxp_chip {
+	const char		*name;
+	unsigned int		nr;
+	unsigned long		freq_min;
+	unsigned long		freq_std;
+	unsigned long		freq_max;
+	unsigned int		flags;
+	unsigned int		fifosize;
 };
 
 struct sccnxp_port {
@@ -112,16 +113,10 @@ struct sccnxp_port {
 	struct uart_port	port[SCCNXP_MAX_UARTS];
 	bool			opened[SCCNXP_MAX_UARTS];
 
-	const char		*name;
 	int			irq;
-
 	u8			imr;
-	u8			addr_mask;
-	int			freq_std;
 
-	int			flags;
-#define SCCNXP_HAVE_IO		0x00000001
-#define SCCNXP_HAVE_MR0		0x00000002
+	struct sccnxp_chip	*chip;
 
 #ifdef CONFIG_SERIAL_SCCNXP_CONSOLE
 	struct console		console;
@@ -137,29 +132,94 @@ struct sccnxp_port {
 	struct regulator	*regulator;
 };
 
-static inline u8 sccnxp_raw_read(void __iomem *base, u8 reg, u8 shift)
-{
-	return readb(base + (reg << shift));
-}
+static const struct sccnxp_chip sc2681 = {
+	.name		= "SC2681",
+	.nr		= 2,
+	.freq_min	= 1000000,
+	.freq_std	= 3686400,
+	.freq_max	= 4000000,
+	.flags		= SCCNXP_HAVE_IO,
+	.fifosize	= 3,
+};
 
-static inline void sccnxp_raw_write(void __iomem *base, u8 reg, u8 shift, u8 v)
-{
-	writeb(v, base + (reg << shift));
-}
+static const struct sccnxp_chip sc2691 = {
+	.name		= "SC2691",
+	.nr		= 1,
+	.freq_min	= 1000000,
+	.freq_std	= 3686400,
+	.freq_max	= 4000000,
+	.flags		= 0,
+	.fifosize	= 3,
+};
+
+static const struct sccnxp_chip sc2692 = {
+	.name		= "SC2692",
+	.nr		= 2,
+	.freq_min	= 1000000,
+	.freq_std	= 3686400,
+	.freq_max	= 4000000,
+	.flags		= SCCNXP_HAVE_IO,
+	.fifosize	= 3,
+};
+
+static const struct sccnxp_chip sc2891 = {
+	.name		= "SC2891",
+	.nr		= 1,
+	.freq_min	= 100000,
+	.freq_std	= 3686400,
+	.freq_max	= 8000000,
+	.flags		= SCCNXP_HAVE_IO | SCCNXP_HAVE_MR0,
+	.fifosize	= 16,
+};
+
+static const struct sccnxp_chip sc2892 = {
+	.name		= "SC2892",
+	.nr		= 2,
+	.freq_min	= 100000,
+	.freq_std	= 3686400,
+	.freq_max	= 8000000,
+	.flags		= SCCNXP_HAVE_IO | SCCNXP_HAVE_MR0,
+	.fifosize	= 16,
+};
+
+static const struct sccnxp_chip sc28202 = {
+	.name		= "SC28202",
+	.nr		= 2,
+	.freq_min	= 1000000,
+	.freq_std	= 14745600,
+	.freq_max	= 50000000,
+	.flags		= SCCNXP_HAVE_IO | SCCNXP_HAVE_MR0,
+	.fifosize	= 256,
+};
+
+static const struct sccnxp_chip sc68681 = {
+	.name		= "SC68681",
+	.nr		= 2,
+	.freq_min	= 1000000,
+	.freq_std	= 3686400,
+	.freq_max	= 4000000,
+	.flags		= SCCNXP_HAVE_IO,
+	.fifosize	= 3,
+};
+
+static const struct sccnxp_chip sc68692 = {
+	.name		= "SC68692",
+	.nr		= 2,
+	.freq_min	= 1000000,
+	.freq_std	= 3686400,
+	.freq_max	= 4000000,
+	.flags		= SCCNXP_HAVE_IO,
+	.fifosize	= 3,
+};
 
 static inline u8 sccnxp_read(struct uart_port *port, u8 reg)
 {
-	struct sccnxp_port *s = dev_get_drvdata(port->dev);
-
-	return sccnxp_raw_read(port->membase, reg & s->addr_mask,
-			       port->regshift);
+	return readb(port->membase + (reg << port->regshift));
 }
 
 static inline void sccnxp_write(struct uart_port *port, u8 reg, u8 v)
 {
-	struct sccnxp_port *s = dev_get_drvdata(port->dev);
-
-	sccnxp_raw_write(port->membase, reg & s->addr_mask, port->regshift, v);
+	writeb(v, port->membase + (reg << port->regshift));
 }
 
 static inline u8 sccnxp_port_read(struct uart_port *port, u8 reg)
@@ -225,13 +285,14 @@ static int sccnxp_set_baud(struct uart_port *port, int baud)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
 	int div_std, tmp_baud, bestbaud = baud, besterr = -1;
+	struct sccnxp_chip *chip = s->chip;
 	u8 i, acr = 0, csr = 0, mr0 = 0;
 
 	/* Find best baud from table */
 	for (i = 0; baud_std[i].baud && besterr; i++) {
-		if (baud_std[i].mr0 && !(s->flags & SCCNXP_HAVE_MR0))
+		if (baud_std[i].mr0 && !(chip->flags & SCCNXP_HAVE_MR0))
 			continue;
-		div_std = DIV_ROUND_CLOSEST(s->freq_std, baud_std[i].baud);
+		div_std = DIV_ROUND_CLOSEST(chip->freq_std, baud_std[i].baud);
 		tmp_baud = DIV_ROUND_CLOSEST(port->uartclk, div_std);
 		if (!sccnxp_update_best_err(baud, tmp_baud, &besterr)) {
 			acr = baud_std[i].acr;
@@ -241,7 +302,7 @@ static int sccnxp_set_baud(struct uart_port *port, int baud)
 		}
 	}
 
-	if (s->flags & SCCNXP_HAVE_MR0) {
+	if (chip->flags & SCCNXP_HAVE_MR0) {
 		/* Enable FIFO, set half level for TX */
 		mr0 |= MR0_FIFO | MR0_TXLVL;
 		/* Update MR0 */
@@ -364,7 +425,7 @@ static void sccnxp_handle_tx(struct uart_port *port)
 			sccnxp_disable_irq(port, IMR_TXRDY);
 
 			/* Set direction to input */
-			if (s->flags & SCCNXP_HAVE_IO)
+			if (s->chip->flags & SCCNXP_HAVE_IO)
 				sccnxp_set_bit(port, DIR_OP, 0);
 		}
 		return;
@@ -438,7 +499,7 @@ static void sccnxp_start_tx(struct uart_port *port)
 	spin_lock_irqsave(&s->lock, flags);
 
 	/* Set direction to output */
-	if (s->flags & SCCNXP_HAVE_IO)
+	if (s->chip->flags & SCCNXP_HAVE_IO)
 		sccnxp_set_bit(port, DIR_OP, 1);
 
 	sccnxp_enable_irq(port, IMR_TXRDY);
@@ -484,7 +545,7 @@ static void sccnxp_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
 	unsigned long flags;
 
-	if (!(s->flags & SCCNXP_HAVE_IO))
+	if (!(s->chip->flags & SCCNXP_HAVE_IO))
 		return;
 
 	spin_lock_irqsave(&s->lock, flags);
@@ -502,7 +563,7 @@ static unsigned int sccnxp_get_mctrl(struct uart_port *port)
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
 	unsigned int mctrl = TIOCM_DSR | TIOCM_CTS | TIOCM_CAR;
 
-	if (!(s->flags & SCCNXP_HAVE_IO))
+	if (!(s->chip->flags & SCCNXP_HAVE_IO))
 		return mctrl;
 
 	spin_lock_irqsave(&s->lock, flags);
@@ -618,7 +679,7 @@ static void sccnxp_set_termios(struct uart_port *port,
 
 	/* Setup baudrate */
 	baud = uart_get_baud_rate(port, termios, old, 50,
-				  (s->flags & SCCNXP_HAVE_MR0) ?
+				  (s->chip->flags & SCCNXP_HAVE_MR0) ?
 				  230400 : 38400);
 	baud = sccnxp_set_baud(port, baud);
 
@@ -642,7 +703,7 @@ static int sccnxp_startup(struct uart_port *port)
 
 	spin_lock_irqsave(&s->lock, flags);
 
-	if (s->flags & SCCNXP_HAVE_IO) {
+	if (s->chip->flags & SCCNXP_HAVE_IO) {
 		/* Outputs are controlled manually */
 		sccnxp_write(port, SCCNXP_OPCR_REG, 0);
 	}
@@ -682,7 +743,7 @@ static void sccnxp_shutdown(struct uart_port *port)
 	sccnxp_port_write(port, SCCNXP_CR_REG, CR_RX_DISABLE | CR_TX_DISABLE);
 
 	/* Leave direction to input */
-	if (s->flags & SCCNXP_HAVE_IO)
+	if (s->chip->flags & SCCNXP_HAVE_IO)
 		sccnxp_set_bit(port, DIR_OP, 0);
 
 	spin_unlock_irqrestore(&s->lock, flags);
@@ -692,7 +753,7 @@ static const char *sccnxp_type(struct uart_port *port)
 {
 	struct sccnxp_port *s = dev_get_drvdata(port->dev);
 
-	return (port->type == PORT_SC26XX) ? s->name : NULL;
+	return (port->type == PORT_SC26XX) ? s->chip->name : NULL;
 }
 
 static void sccnxp_release_port(struct uart_port *port)
@@ -779,12 +840,24 @@ static int sccnxp_console_setup(struct console *co, char *options)
 }
 #endif
 
+static const struct platform_device_id sccnxp_id_table[] = {
+	{ .name = "sc2681",	.driver_data = (kernel_ulong_t)&sc2681, },
+	{ .name = "sc2691",	.driver_data = (kernel_ulong_t)&sc2691, },
+	{ .name = "sc2692",	.driver_data = (kernel_ulong_t)&sc2692, },
+	{ .name = "sc2891",	.driver_data = (kernel_ulong_t)&sc2891, },
+	{ .name = "sc2892",	.driver_data = (kernel_ulong_t)&sc2892, },
+	{ .name = "sc28202",	.driver_data = (kernel_ulong_t)&sc28202, },
+	{ .name = "sc68681",	.driver_data = (kernel_ulong_t)&sc68681, },
+	{ .name = "sc68692",	.driver_data = (kernel_ulong_t)&sc68692, },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sccnxp_id_table);
+
 static int sccnxp_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	int chiptype = pdev->id_entry->driver_data;
 	struct sccnxp_pdata *pdata = dev_get_platdata(&pdev->dev);
-	int i, ret, fifosize, freq_min, freq_max, uartclk;
+	int i, ret, uartclk;
 	struct sccnxp_port *s;
 	void __iomem *membase;
 	struct clk *clk;
@@ -802,92 +875,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 
 	spin_lock_init(&s->lock);
 
-	/* Individual chip settings */
-	switch (chiptype) {
-	case SCCNXP_TYPE_SC2681:
-		s->name		= "SC2681";
-		s->uart.nr	= 2;
-		s->freq_std	= 3686400;
-		s->addr_mask	= 0x0f;
-		s->flags	= SCCNXP_HAVE_IO;
-		fifosize	= 3;
-		freq_min	= 1000000;
-		freq_max	= 4000000;
-		break;
-	case SCCNXP_TYPE_SC2691:
-		s->name		= "SC2691";
-		s->uart.nr	= 1;
-		s->freq_std	= 3686400;
-		s->addr_mask	= 0x07;
-		s->flags	= 0;
-		fifosize	= 3;
-		freq_min	= 1000000;
-		freq_max	= 4000000;
-		break;
-	case SCCNXP_TYPE_SC2692:
-		s->name		= "SC2692";
-		s->uart.nr	= 2;
-		s->freq_std	= 3686400;
-		s->addr_mask	= 0x0f;
-		s->flags	= SCCNXP_HAVE_IO;
-		fifosize	= 3;
-		freq_min	= 1000000;
-		freq_max	= 4000000;
-		break;
-	case SCCNXP_TYPE_SC2891:
-		s->name		= "SC2891";
-		s->uart.nr	= 1;
-		s->freq_std	= 3686400;
-		s->addr_mask	= 0x0f;
-		s->flags	= SCCNXP_HAVE_IO | SCCNXP_HAVE_MR0;
-		fifosize	= 16;
-		freq_min	= 100000;
-		freq_max	= 8000000;
-		break;
-	case SCCNXP_TYPE_SC2892:
-		s->name		= "SC2892";
-		s->uart.nr	= 2;
-		s->freq_std	= 3686400;
-		s->addr_mask	= 0x0f;
-		s->flags	= SCCNXP_HAVE_IO | SCCNXP_HAVE_MR0;
-		fifosize	= 16;
-		freq_min	= 100000;
-		freq_max	= 8000000;
-		break;
-	case SCCNXP_TYPE_SC28202:
-		s->name		= "SC28202";
-		s->uart.nr	= 2;
-		s->freq_std	= 14745600;
-		s->addr_mask	= 0x7f;
-		s->flags	= SCCNXP_HAVE_IO | SCCNXP_HAVE_MR0;
-		fifosize	= 256;
-		freq_min	= 1000000;
-		freq_max	= 50000000;
-		break;
-	case SCCNXP_TYPE_SC68681:
-		s->name		= "SC68681";
-		s->uart.nr	= 2;
-		s->freq_std	= 3686400;
-		s->addr_mask	= 0x0f;
-		s->flags	= SCCNXP_HAVE_IO;
-		fifosize	= 3;
-		freq_min	= 1000000;
-		freq_max	= 4000000;
-		break;
-	case SCCNXP_TYPE_SC68692:
-		s->name		= "SC68692";
-		s->uart.nr	= 2;
-		s->freq_std	= 3686400;
-		s->addr_mask	= 0x0f;
-		s->flags	= SCCNXP_HAVE_IO;
-		fifosize	= 3;
-		freq_min	= 1000000;
-		freq_max	= 4000000;
-		break;
-	default:
-		dev_err(&pdev->dev, "Unsupported chip type %i\n", chiptype);
-		return -ENOTSUPP;
-	}
+	s->chip = (struct sccnxp_chip *)pdev->id_entry->driver_data;
 
 	s->regulator = devm_regulator_get(&pdev->dev, "vcc");
 	if (!IS_ERR(s->regulator)) {
@@ -907,12 +895,12 @@ static int sccnxp_probe(struct platform_device *pdev)
 			goto err_out;
 		}
 		dev_notice(&pdev->dev, "Using default clock frequency\n");
-		uartclk = s->freq_std;
+		uartclk = s->chip->freq_std;
 	} else
 		uartclk = clk_get_rate(clk);
 
 	/* Check input frequency */
-	if ((uartclk < freq_min) || (uartclk > freq_max)) {
+	if ((uartclk < s->chip->freq_min) || (uartclk > s->chip->freq_max)) {
 		dev_err(&pdev->dev, "Frequency out of bounds\n");
 		ret = -EINVAL;
 		goto err_out;
@@ -940,6 +928,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 	s->uart.dev_name	= "ttySC";
 	s->uart.major		= SCCNXP_MAJOR;
 	s->uart.minor		= SCCNXP_MINOR;
+	s->uart.nr		= s->chip->nr;
 #ifdef CONFIG_SERIAL_SCCNXP_CONSOLE
 	s->uart.cons		= &s->console;
 	s->uart.cons->device	= uart_console_device;
@@ -961,7 +950,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 		s->port[i].dev		= &pdev->dev;
 		s->port[i].irq		= s->irq;
 		s->port[i].type		= PORT_SC26XX;
-		s->port[i].fifosize	= fifosize;
+		s->port[i].fifosize	= s->chip->fifosize;
 		s->port[i].flags	= UPF_SKIP_TEST | UPF_FIXED_TYPE;
 		s->port[i].iotype	= UPIO_MEM;
 		s->port[i].mapbase	= res->start;
@@ -971,7 +960,7 @@ static int sccnxp_probe(struct platform_device *pdev)
 		s->port[i].ops		= &sccnxp_ops;
 		uart_add_one_port(&s->uart, &s->port[i]);
 		/* Set direction to input */
-		if (s->flags & SCCNXP_HAVE_IO)
+		if (s->chip->flags & SCCNXP_HAVE_IO)
 			sccnxp_set_bit(&s->port[i], DIR_OP, 0);
 	}
 
@@ -1025,19 +1014,6 @@ static int sccnxp_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id sccnxp_id_table[] = {
-	{ "sc2681",	SCCNXP_TYPE_SC2681 },
-	{ "sc2691",	SCCNXP_TYPE_SC2691 },
-	{ "sc2692",	SCCNXP_TYPE_SC2692 },
-	{ "sc2891",	SCCNXP_TYPE_SC2891 },
-	{ "sc2892",	SCCNXP_TYPE_SC2892 },
-	{ "sc28202",	SCCNXP_TYPE_SC28202 },
-	{ "sc68681",	SCCNXP_TYPE_SC68681 },
-	{ "sc68692",	SCCNXP_TYPE_SC68692 },
-	{ },
-};
-MODULE_DEVICE_TABLE(platform, sccnxp_id_table);
-
 static struct platform_driver sccnxp_uart_driver = {
 	.driver = {
 		.name	= SCCNXP_NAME,
-- 
1.8.1.5

