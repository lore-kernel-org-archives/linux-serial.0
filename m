From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/5] serial: sh-sci: Use a bitmask to indicate supported sampling rates
Date: Mon,  4 Jan 2016 14:45:21 +0100
Message-ID: <1451915122-30219-5-git-send-email-geert+renesas@glider.be>
References: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Replace the single sampling rate and special handling for HSCIF's
variable sampling rates by a bitmask and a custom iterator.
This prepares for the advent of SCIFA/SCIFB's sparse variable sampling
rates.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 66 +++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f3c2a89a9550add9..17188fc4b1b32439 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -85,6 +85,18 @@ enum SCI_CLKS {
 	SCI_NUM_CLKS
 };
 
+/* Bit x set means sampling rate x + 1 is supported */
+#define SCI_SR(x)		BIT((x) - 1)
+#define SCI_SR_RANGE(x, y)	GENMASK((y) - 1, (x) - 1)
+
+#define min_sr(_port)		ffs((_port)->sampling_rate_mask)
+#define max_sr(_port)		fls((_port)->sampling_rate_mask)
+
+/* Iterate over all supported sampling rates, from high to low */
+#define for_each_sr(_sr, _port)						\
+	for ((_sr) = max_sr(_port); (_sr) >= min_sr(_port); (_sr)--)	\
+		if ((_port)->sampling_rate_mask & SCI_SR((_sr)))
+
 struct sci_port {
 	struct uart_port	port;
 
@@ -94,7 +106,7 @@ struct sci_port {
 	unsigned int		overrun_mask;
 	unsigned int		error_mask;
 	unsigned int		error_clear;
-	unsigned int		sampling_rate;
+	unsigned int		sampling_rate_mask;
 	resource_size_t		reg_size;
 
 	/* Break timer */
@@ -1931,21 +1943,13 @@ static int sci_sck_calc(struct sci_port *s, unsigned int bps,
 			unsigned int *srr)
 {
 	unsigned long freq = s->clk_rates[SCI_SCK];
-	unsigned int min_sr, max_sr, sr;
 	int err, min_err = INT_MAX;
+	unsigned int sr;
 
 	if (s->port.type != PORT_HSCIF)
 		freq *= 2;
-	if (s->sampling_rate) {
-		/* SCI(F) has a fixed sampling rate */
-		min_sr = max_sr = s->sampling_rate;
-	} else {
-		/* HSCIF has a variable 1/(8..32) sampling rate */
-		min_sr = 8;
-		max_sr = 32;
-	}
 
-	for (sr = max_sr; sr >= min_sr; sr--) {
+	for_each_sr(sr, s) {
 		err = DIV_ROUND_CLOSEST(freq, sr) - bps;
 		if (abs(err) >= abs(min_err))
 			continue;
@@ -1966,21 +1970,13 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 			unsigned long freq, unsigned int *dlr,
 			unsigned int *srr)
 {
-	unsigned int min_sr, max_sr, sr, dl;
 	int err, min_err = INT_MAX;
+	unsigned int sr, dl;
 
 	if (s->port.type != PORT_HSCIF)
 		freq *= 2;
-	if (s->sampling_rate) {
-		/* SCIF has a fixed sampling rate */
-		min_sr = max_sr = s->sampling_rate;
-	} else {
-		/* HSCIF has a variable 1/(8..32) sampling rate */
-		min_sr = 8;
-		max_sr = 32;
-	}
 
-	for (sr = max_sr; sr >= min_sr; sr--) {
+	for_each_sr(sr, s) {
 		dl = DIV_ROUND_CLOSEST(freq, sr * bps);
 		dl = clamp(dl, 1U, 65535U);
 
@@ -2006,19 +2002,12 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 			  unsigned int *brr, unsigned int *srr,
 			  unsigned int *cks)
 {
-	unsigned int min_sr, max_sr, sr, br, prediv, scrate, c;
 	unsigned long freq = s->clk_rates[SCI_FCK];
+	unsigned int sr, br, prediv, scrate, c;
 	int err, min_err = INT_MAX;
 
 	if (s->port.type != PORT_HSCIF)
 		freq *= 2;
-	if (s->sampling_rate) {
-		min_sr = max_sr = s->sampling_rate;
-	} else {
-		/* HSCIF has a variable sample rate */
-		min_sr = 8;
-		max_sr = 32;
-	}
 
 	/*
 	 * Find the combination of sample rate and clock select with the
@@ -2035,7 +2024,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 	 *      (|D - 0.5| / N * (1 + F))|
 	 *  NOTE: Usually, treat D for 0.5, F is 0 by this calculation.
 	 */
-	for (sr = max_sr; sr >= min_sr; sr--) {
+	for_each_sr(sr, s) {
 		for (c = 0; c <= 3; c++) {
 			/* integerized formulas from HSCIF documentation */
 			prediv = sr * (1 << (2 * c + 1));
@@ -2129,8 +2118,7 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 	for (i = 0; i < SCI_NUM_CLKS; i++)
 		max_freq = max(max_freq, s->clk_rates[i]);
 
-	baud = uart_get_baud_rate(port, termios, old, 0,
-				  max_freq / max(s->sampling_rate, 8U));
+	baud = uart_get_baud_rate(port, termios, old, 0, max_freq / min_sr(s));
 	if (!baud)
 		goto done;
 
@@ -2562,37 +2550,37 @@ static int sci_init_single(struct platform_device *dev,
 		port->fifosize = 256;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCIFA_ORER;
-		sci_port->sampling_rate = 16;
+		sci_port->sampling_rate_mask = SCI_SR(16);
 		break;
 	case PORT_HSCIF:
 		port->fifosize = 128;
 		sci_port->overrun_reg = SCLSR;
 		sci_port->overrun_mask = SCLSR_ORER;
-		sci_port->sampling_rate = 0;
+		sci_port->sampling_rate_mask = SCI_SR_RANGE(8, 32);
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCIFA_ORER;
-		sci_port->sampling_rate = 16;
+		sci_port->sampling_rate_mask = SCI_SR(16);
 		break;
 	case PORT_SCIF:
 		port->fifosize = 16;
 		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE) {
 			sci_port->overrun_reg = SCxSR;
 			sci_port->overrun_mask = SCIFA_ORER;
-			sci_port->sampling_rate = 16;
+			sci_port->sampling_rate_mask = SCI_SR(16);
 		} else {
 			sci_port->overrun_reg = SCLSR;
 			sci_port->overrun_mask = SCLSR_ORER;
-			sci_port->sampling_rate = 32;
+			sci_port->sampling_rate_mask = SCI_SR(32);
 		}
 		break;
 	default:
 		port->fifosize = 1;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCI_ORER;
-		sci_port->sampling_rate = 32;
+		sci_port->sampling_rate_mask = SCI_SR(32);
 		break;
 	}
 
@@ -2601,7 +2589,7 @@ static int sci_init_single(struct platform_device *dev,
 	 * data override the sampling rate for now.
 	 */
 	if (p->sampling_rate)
-		sci_port->sampling_rate = p->sampling_rate;
+		sci_port->sampling_rate_mask = SCI_SR(p->sampling_rate);
 
 	if (!early) {
 		ret = sci_init_clocks(sci_port, &dev->dev);
-- 
1.9.1

