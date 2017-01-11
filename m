From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 16/18] serial: sh-sci: Remove manual break debouncing
Date: Wed, 11 Jan 2017 16:43:38 +0200
Message-ID: <20170111144340.29074-17-laurent.pinchart+renesas@ideasonboard.com>
References: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170111144340.29074-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The sh-sci driver implements manual break debouncing for a few SH
platforms by reading the value of the RX pin port register. This feature
is optional and the driver considers all negative or zero values of the
platform data port_reg field as invalid. As the four platforms that set
the field to a register address all use an address higher than
0x7fffffff, the driver will always consider the value as invalid and
never perform debouncing. The feature is unused, remove it.

Debouncing could be implemented properly in the future using the pinctrl
and GPIO APIs if desired.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 124 +++-----------------------------------------
 include/linux/serial_sci.h  |   5 --
 2 files changed, 7 insertions(+), 122 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fcedb96fe324..d2de169326d8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -125,10 +125,6 @@ struct sci_port {
 	resource_size_t		reg_size;
 	struct mctrl_gpios	*gpios;
 
-	/* Break timer */
-	struct timer_list	break_timer;
-	int			break_flag;
-
 	/* Clocks */
 	struct clk		*clks[SCI_NUM_CLKS];
 	unsigned long		clk_rates[SCI_NUM_CLKS];
@@ -517,14 +513,6 @@ static void sci_port_disable(struct sci_port *sci_port)
 	if (!sci_port->port.dev)
 		return;
 
-	/* Cancel the break timer to ensure that the timer handler will not try
-	 * to access the hardware with clocks and power disabled. Reset the
-	 * break flag to make the break debouncing state machine ready for the
-	 * next break.
-	 */
-	del_timer_sync(&sci_port->break_timer);
-	sci_port->break_flag = 0;
-
 	for (i = SCI_NUM_CLKS; i-- > 0; )
 		clk_disable_unprepare(sci_port->clks[i]);
 
@@ -751,20 +739,6 @@ static int sci_rxfill(struct uart_port *port)
 	return (serial_port_in(port, SCxSR) & SCxSR_RDxF(port)) != 0;
 }
 
-/*
- * SCI helper for checking the state of the muxed port/RXD pins.
- */
-static inline int sci_rxd_in(struct uart_port *port)
-{
-	struct sci_port *s = to_sci_port(port);
-
-	if (s->cfg->port_reg <= 0)
-		return 1;
-
-	/* Cast for ARM damage */
-	return !!__raw_readb((void __iomem *)(uintptr_t)s->cfg->port_reg);
-}
-
 /* ********************************************************************** *
  *                   the interrupt related routines                       *
  * ********************************************************************** */
@@ -832,7 +806,6 @@ static void sci_transmit_chars(struct uart_port *port)
 
 static void sci_receive_chars(struct uart_port *port)
 {
-	struct sci_port *sci_port = to_sci_port(port);
 	struct tty_port *tport = &port->state->port;
 	int i, count, copied = 0;
 	unsigned short status;
@@ -852,8 +825,7 @@ static void sci_receive_chars(struct uart_port *port)
 
 		if (port->type == PORT_SCI) {
 			char c = serial_port_in(port, SCxRDR);
-			if (uart_handle_sysrq_char(port, c) ||
-			    sci_port->break_flag)
+			if (uart_handle_sysrq_char(port, c))
 				count = 0;
 			else
 				tty_insert_flip_char(tport, c, TTY_NORMAL);
@@ -862,25 +834,6 @@ static void sci_receive_chars(struct uart_port *port)
 				char c = serial_port_in(port, SCxRDR);
 
 				status = serial_port_in(port, SCxSR);
-#if defined(CONFIG_CPU_SH3)
-				/* Skip "chars" during break */
-				if (sci_port->break_flag) {
-					if ((c == 0) &&
-					    (status & SCxSR_FER(port))) {
-						count--; i--;
-						continue;
-					}
-
-					/* Nonzero => end-of-break */
-					dev_dbg(port->dev, "debounce<%02x>\n", c);
-					sci_port->break_flag = 0;
-
-					if (STEPFN(c)) {
-						count--; i--;
-						continue;
-					}
-				}
-#endif /* CONFIG_CPU_SH3 */
 				if (uart_handle_sysrq_char(port, c)) {
 					count--; i--;
 					continue;
@@ -918,37 +871,6 @@ static void sci_receive_chars(struct uart_port *port)
 	}
 }
 
-#define SCI_BREAK_JIFFIES (HZ/20)
-
-/*
- * The sci generates interrupts during the break,
- * 1 per millisecond or so during the break period, for 9600 baud.
- * So dont bother disabling interrupts.
- * But dont want more than 1 break event.
- * Use a kernel timer to periodically poll the rx line until
- * the break is finished.
- */
-static inline void sci_schedule_break_timer(struct sci_port *port)
-{
-	mod_timer(&port->break_timer, jiffies + SCI_BREAK_JIFFIES);
-}
-
-/* Ensure that two consecutive samples find the break over. */
-static void sci_break_timer(unsigned long data)
-{
-	struct sci_port *port = (struct sci_port *)data;
-
-	if (sci_rxd_in(&port->port) == 0) {
-		port->break_flag = 1;
-		sci_schedule_break_timer(port);
-	} else if (port->break_flag == 1) {
-		/* break is over. */
-		port->break_flag = 2;
-		sci_schedule_break_timer(port);
-	} else
-		port->break_flag = 0;
-}
-
 static int sci_handle_errors(struct uart_port *port)
 {
 	int copied = 0;
@@ -968,35 +890,13 @@ static int sci_handle_errors(struct uart_port *port)
 	}
 
 	if (status & SCxSR_FER(port)) {
-		if (sci_rxd_in(port) == 0) {
-			/* Notify of BREAK */
-			struct sci_port *sci_port = to_sci_port(port);
-
-			if (!sci_port->break_flag) {
-				port->icount.brk++;
-
-				sci_port->break_flag = 1;
-				sci_schedule_break_timer(sci_port);
-
-				/* Do sysrq handling. */
-				if (uart_handle_break(port))
-					return 0;
-
-				dev_dbg(port->dev, "BREAK detected\n");
-
-				if (tty_insert_flip_char(tport, 0, TTY_BREAK))
-					copied++;
-			}
-
-		} else {
-			/* frame error */
-			port->icount.frame++;
+		/* frame error */
+		port->icount.frame++;
 
-			if (tty_insert_flip_char(tport, 0, TTY_FRAME))
-				copied++;
+		if (tty_insert_flip_char(tport, 0, TTY_FRAME))
+			copied++;
 
-			dev_notice(port->dev, "frame error\n");
-		}
+		dev_notice(port->dev, "frame error\n");
 	}
 
 	if (status & SCxSR_PER(port)) {
@@ -1049,17 +949,11 @@ static int sci_handle_breaks(struct uart_port *port)
 	int copied = 0;
 	unsigned short status = serial_port_in(port, SCxSR);
 	struct tty_port *tport = &port->state->port;
-	struct sci_port *s = to_sci_port(port);
 
 	if (uart_handle_break(port))
 		return 0;
 
-	if (!s->break_flag && status & SCxSR_BRK(port)) {
-#if defined(CONFIG_CPU_SH3)
-		/* Debounce break */
-		s->break_flag = 1;
-#endif
-
+	if (status & SCxSR_BRK(port)) {
 		port->icount.brk++;
 
 		/* Notify of BREAK */
@@ -2675,10 +2569,6 @@ static int sci_init_single(struct platform_device *dev,
 		pm_runtime_enable(&dev->dev);
 	}
 
-	sci_port->break_timer.data = (unsigned long)sci_port;
-	sci_port->break_timer.function = sci_break_timer;
-	init_timer(&sci_port->break_timer);
-
 	port->type		= p->type;
 	port->flags		= UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
 	port->regshift		= p->regshift;
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 1a894c47bfc0..b4419931bf4c 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -9,8 +9,6 @@
  * Generic header for SuperH (H)SCI(F) (used by sh/sh64 and related parts)
  */
 
-#define SCIx_NOT_SUPPORTED	(-1)
-
 /* Serial Control Register (@ = not supported by all parts) */
 #define SCSCR_TIE	BIT(7)	/* Transmit Interrupt Enable */
 #define SCSCR_RIE	BIT(6)	/* Receive Interrupt Enable */
@@ -41,8 +39,6 @@ enum {
 	SCIx_NR_REGTYPES,
 };
 
-struct device;
-
 struct plat_sci_port_ops {
 	void (*init_pins)(struct uart_port *, unsigned int cflag);
 };
@@ -66,7 +62,6 @@ struct plat_sci_port {
 	/*
 	 * Platform overrides if necessary, defaults otherwise.
 	 */
-	int		port_reg;
 	unsigned char	regshift;
 	unsigned char	regtype;
 
-- 
Regards,

Laurent Pinchart

