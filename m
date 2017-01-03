From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 15/19] serial: sh-sci: Extend sci_port_params with more port parameters
Date: Wed,  4 Jan 2017 01:06:35 +0200
Message-ID: <20170103230639.19660-16-laurent.pinchart+renesas@ideasonboard.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The fifo size, overrun register and mask, sampling rate mask and error
mask all depend on the port type only and don't need to be computed at
runtime. Add them to the sci_port_parameters structure.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 181 ++++++++++++++++++++++++--------------------
 drivers/tty/serial/sh-sci.h |   4 +-
 2 files changed, 102 insertions(+), 83 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 285d0c726ca3..010422ae88ff 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -107,6 +107,12 @@ struct plat_sci_reg {
 
 struct sci_port_params {
 	const struct plat_sci_reg regs[SCIx_NR_REGS];
+	unsigned int fifosize;
+	unsigned int overrun_reg;
+	unsigned int overrun_mask;
+	unsigned int sampling_rate_mask;
+	unsigned int error_mask;
+	unsigned int error_clear;
 };
 
 struct sci_port {
@@ -115,10 +121,6 @@ struct sci_port {
 	/* Platform configuration */
 	const struct sci_port_params *params;
 	const struct plat_sci_port *cfg;
-	unsigned int		overrun_reg;
-	unsigned int		overrun_mask;
-	unsigned int		error_mask;
-	unsigned int		error_clear;
 	unsigned int		sampling_rate_mask;
 	resource_size_t		reg_size;
 	struct mctrl_gpios	*gpios;
@@ -179,6 +181,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCxSR]		= { 0x04,  8 },
 			[SCxRDR]	= { 0x05,  8 },
 		},
+		.fifosize = 1,
+		.overrun_reg = SCxSR,
+		.overrun_mask = SCI_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCI_DEFAULT_ERROR_MASK | SCI_ORER,
+		.error_clear = SCI_ERROR_CLEAR & ~SCI_ORER,
 	},
 
 	/*
@@ -196,6 +204,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCFCR]		= { 0x06,  8 },
 			[SCFDR]		= { 0x07, 16 },
 		},
+		.fifosize = 1,
+		.overrun_reg = SCxSR,
+		.overrun_mask = SCI_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCI_DEFAULT_ERROR_MASK | SCI_ORER,
+		.error_clear = SCI_ERROR_CLEAR & ~SCI_ORER,
 	},
 
 	/*
@@ -214,6 +228,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCPCR]		= { 0x30, 16 },
 			[SCPDR]		= { 0x34, 16 },
 		},
+		.fifosize = 64,
+		.overrun_reg = SCxSR,
+		.overrun_mask = SCIFA_ORER,
+		.sampling_rate_mask = SCI_SR_SCIFAB,
+		.error_mask = SCIF_DEFAULT_ERROR_MASK | SCIFA_ORER,
+		.error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
 	},
 
 	/*
@@ -233,6 +253,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCPCR]		= { 0x30, 16 },
 			[SCPDR]		= { 0x34, 16 },
 		},
+		.fifosize = 256,
+		.overrun_reg = SCxSR,
+		.overrun_mask = SCIFA_ORER,
+		.sampling_rate_mask = SCI_SR_SCIFAB,
+		.error_mask = SCIF_DEFAULT_ERROR_MASK | SCIFA_ORER,
+		.error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
 	},
 
 	/*
@@ -252,6 +278,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCSPTR]	= { 0x20, 16 },
 			[SCLSR]		= { 0x24, 16 },
 		},
+		.fifosize = 16,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
 	/*
@@ -268,6 +300,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCFCR]		= { 0x0c,  8 },
 			[SCFDR]		= { 0x0e, 16 },
 		},
+		.fifosize = 16,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
 	/*
@@ -286,6 +324,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCSPTR]	= { 0x20, 16 },
 			[SCLSR]		= { 0x24, 16 },
 		},
+		.fifosize = 16,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
 	/*
@@ -307,6 +351,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCDL]		= { 0x30, 16 },
 			[SCCKS]		= { 0x34, 16 },
 		},
+		.fifosize = 16,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
 	/*
@@ -328,6 +378,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCDL]		= { 0x30, 16 },
 			[SCCKS]		= { 0x34, 16 },
 		},
+		.fifosize = 128,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR_RANGE(8, 32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
 	/*
@@ -346,6 +402,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCFDR]		= { 0x1c, 16 },
 			[SCLSR]		= { 0x24, 16 },
 		},
+		.fifosize = 16,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
 	/*
@@ -367,6 +429,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCSPTR]	= { 0x24, 16 },
 			[SCLSR]		= { 0x28, 16 },
 		},
+		.fifosize = 16,
+		.overrun_reg = SCLSR,
+		.overrun_mask = SCLSR_ORER,
+		.sampling_rate_mask = SCI_SR(32),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK,
+		.error_clear = SCIF_ERROR_CLEAR,
 	},
 
 	/*
@@ -384,6 +452,12 @@ static const struct sci_port_params sci_port_params[SCIx_NR_REGTYPES] = {
 			[SCFCR]		= { 0x18, 16 },
 			[SCFDR]		= { 0x1c, 16 },
 		},
+		.fifosize = 16,
+		.overrun_reg = SCxSR,
+		.overrun_mask = SCIFA_ORER,
+		.sampling_rate_mask = SCI_SR(16),
+		.error_mask = SCIF_DEFAULT_ERROR_MASK | SCIFA_ORER,
+		.error_clear = SCIF_ERROR_CLEAR & ~SCIFA_ORER,
 	},
 };
 
@@ -546,7 +620,7 @@ static void sci_clear_SCxSR(struct uart_port *port, unsigned int mask)
 	if (port->type == PORT_SCI) {
 		/* Just store the mask */
 		serial_port_out(port, SCxSR, mask);
-	} else if (to_sci_port(port)->overrun_mask == SCIFA_ORER) {
+	} else if (to_sci_port(port)->params->overrun_mask == SCIFA_ORER) {
 		/* SCIFA/SCIFB and SCIF on SH7705/SH7720/SH7721 */
 		/* Only clear the status bits we want to clear */
 		serial_port_out(port, SCxSR,
@@ -641,11 +715,13 @@ static void sci_init_pins(struct uart_port *port, unsigned int cflag)
 
 static int sci_txfill(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
+	unsigned int fifo_mask = (s->params->fifosize << 1) - 1;
 	const struct plat_sci_reg *reg;
 
 	reg = sci_getreg(port, SCTFDR);
 	if (reg->size)
-		return serial_port_in(port, SCTFDR) & ((port->fifosize << 1) - 1);
+		return serial_port_in(port, SCTFDR) & fifo_mask;
 
 	reg = sci_getreg(port, SCFDR);
 	if (reg->size)
@@ -661,15 +737,17 @@ static int sci_txroom(struct uart_port *port)
 
 static int sci_rxfill(struct uart_port *port)
 {
+	struct sci_port *s = to_sci_port(port);
+	unsigned int fifo_mask = (s->params->fifosize << 1) - 1;
 	const struct plat_sci_reg *reg;
 
 	reg = sci_getreg(port, SCRFDR);
 	if (reg->size)
-		return serial_port_in(port, SCRFDR) & ((port->fifosize << 1) - 1);
+		return serial_port_in(port, SCRFDR) & fifo_mask;
 
 	reg = sci_getreg(port, SCFDR);
 	if (reg->size)
-		return serial_port_in(port, SCFDR) & ((port->fifosize << 1) - 1);
+		return serial_port_in(port, SCFDR) & fifo_mask;
 
 	return (serial_port_in(port, SCxSR) & SCxSR_RDxF(port)) != 0;
 }
@@ -880,7 +958,7 @@ static int sci_handle_errors(struct uart_port *port)
 	struct sci_port *s = to_sci_port(port);
 
 	/* Handle overruns */
-	if (status & s->overrun_mask) {
+	if (status & s->params->overrun_mask) {
 		port->icount.overrun++;
 
 		/* overrun error */
@@ -946,14 +1024,14 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 	int copied = 0;
 	u16 status;
 
-	reg = sci_getreg(port, s->overrun_reg);
+	reg = sci_getreg(port, s->params->overrun_reg);
 	if (!reg->size)
 		return 0;
 
-	status = serial_port_in(port, s->overrun_reg);
-	if (status & s->overrun_mask) {
-		status &= ~s->overrun_mask;
-		serial_port_out(port, s->overrun_reg, status);
+	status = serial_port_in(port, s->params->overrun_reg);
+	if (status & s->params->overrun_mask) {
+		status &= ~s->params->overrun_mask;
+		serial_port_out(port, s->params->overrun_reg, status);
 
 		port->icount.overrun++;
 
@@ -1542,12 +1620,10 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 
 	ssr_status = serial_port_in(port, SCxSR);
 	scr_status = serial_port_in(port, SCSCR);
-	if (s->overrun_reg == SCxSR)
+	if (s->params->overrun_reg == SCxSR)
 		orer_status = ssr_status;
-	else {
-		if (sci_getreg(port, s->overrun_reg)->size)
-			orer_status = serial_port_in(port, s->overrun_reg);
-	}
+	else if (sci_getreg(port, s->params->overrun_reg)->size)
+		orer_status = serial_port_in(port, s->params->overrun_reg);
 
 	err_enabled = scr_status & port_rx_irq_mask(port);
 
@@ -1573,7 +1649,7 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 		ret = sci_br_interrupt(irq, ptr);
 
 	/* Overrun Interrupt */
-	if (orer_status & s->overrun_mask) {
+	if (orer_status & s->params->overrun_mask) {
 		sci_handle_fifo_overrun(port);
 		ret = IRQ_HANDLED;
 	}
@@ -2589,51 +2665,13 @@ static int sci_init_single(struct platform_device *dev,
 	if (unlikely(sci_port->params == NULL))
 		return -EINVAL;
 
-	switch (p->type) {
-	case PORT_SCIFB:
-		port->fifosize = 256;
-		sci_port->overrun_reg = SCxSR;
-		sci_port->overrun_mask = SCIFA_ORER;
-		sci_port->sampling_rate_mask = SCI_SR_SCIFAB;
-		break;
-	case PORT_HSCIF:
-		port->fifosize = 128;
-		sci_port->overrun_reg = SCLSR;
-		sci_port->overrun_mask = SCLSR_ORER;
-		sci_port->sampling_rate_mask = SCI_SR_RANGE(8, 32);
-		break;
-	case PORT_SCIFA:
-		port->fifosize = 64;
-		sci_port->overrun_reg = SCxSR;
-		sci_port->overrun_mask = SCIFA_ORER;
-		sci_port->sampling_rate_mask = SCI_SR_SCIFAB;
-		break;
-	case PORT_SCIF:
-		port->fifosize = 16;
-		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE) {
-			sci_port->overrun_reg = SCxSR;
-			sci_port->overrun_mask = SCIFA_ORER;
-			sci_port->sampling_rate_mask = SCI_SR(16);
-		} else {
-			sci_port->overrun_reg = SCLSR;
-			sci_port->overrun_mask = SCLSR_ORER;
-			sci_port->sampling_rate_mask = SCI_SR(32);
-		}
-		break;
-	default:
-		port->fifosize = 1;
-		sci_port->overrun_reg = SCxSR;
-		sci_port->overrun_mask = SCI_ORER;
-		sci_port->sampling_rate_mask = SCI_SR(32);
-		break;
-	}
-
 	/* SCIFA on sh7723 and sh7724 need a custom sampling rate that doesn't
 	 * match the SoC datasheet, this should be investigated. Let platform
 	 * data override the sampling rate for now.
 	 */
-	if (p->sampling_rate)
-		sci_port->sampling_rate_mask = SCI_SR(p->sampling_rate);
+	sci_port->sampling_rate_mask = p->sampling_rate
+				     ? SCI_SR(p->sampling_rate)
+				     : sci_port->params->sampling_rate_mask;
 
 	if (!early) {
 		ret = sci_init_clocks(sci_port, &dev->dev);
@@ -2649,29 +2687,10 @@ static int sci_init_single(struct platform_device *dev,
 	sci_port->break_timer.function = sci_break_timer;
 	init_timer(&sci_port->break_timer);
 
-	/*
-	 * Establish some sensible defaults for the error detection.
-	 */
-	if (p->type == PORT_SCI) {
-		sci_port->error_mask = SCI_DEFAULT_ERROR_MASK;
-		sci_port->error_clear = SCI_ERROR_CLEAR;
-	} else {
-		sci_port->error_mask = SCIF_DEFAULT_ERROR_MASK;
-		sci_port->error_clear = SCIF_ERROR_CLEAR;
-	}
-
-	/*
-	 * Make the error mask inclusive of overrun detection, if
-	 * supported.
-	 */
-	if (sci_port->overrun_reg == SCxSR) {
-		sci_port->error_mask |= sci_port->overrun_mask;
-		sci_port->error_clear &= ~sci_port->overrun_mask;
-	}
-
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
 	port->regshift		= p->regshift;
+	port->fifosize		= sci_port->params->fifosize;
 
 	/*
 	 * The UART port needs an IRQ value, so we peg this to the RX IRQ
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index ffa6d688c335..08073f0db732 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -151,12 +151,12 @@ enum {
 #define SCxSR_PER(port)		(((port)->type == PORT_SCI) ? SCI_PER    : SCIF_PER)
 #define SCxSR_BRK(port)		(((port)->type == PORT_SCI) ? 0x00       : SCIF_BRK)
 
-#define SCxSR_ERRORS(port)	(to_sci_port(port)->error_mask)
+#define SCxSR_ERRORS(port)	(to_sci_port(port)->params->error_mask)
 
 #define SCxSR_RDxF_CLEAR(port) \
 	(((port)->type == PORT_SCI) ? SCI_RDxF_CLEAR : SCIF_RDxF_CLEAR)
 #define SCxSR_ERROR_CLEAR(port) \
-	(to_sci_port(port)->error_clear)
+	(to_sci_port(port)->params->error_clear)
 #define SCxSR_TDxE_CLEAR(port) \
 	(((port)->type == PORT_SCI) ? SCI_TDxE_CLEAR : SCIF_TDxE_CLEAR)
 #define SCxSR_BREAK_CLEAR(port) \
-- 
Regards,

Laurent Pinchart
