From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 4/7] serial: sh-sci: increase RX FIFO trigger defaults for (H)SCIF
Date: Fri,  9 Dec 2016 13:36:08 +0100
Message-ID: <1481286971-16667-5-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1481286971-16667-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, geert@linux-m68k.org
Cc: linux-serial@vger.kernel.org, magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/tty/serial/sh-sci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 844288f..ce3cf03 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -141,6 +141,7 @@ struct sci_port {
 	struct timer_list		rx_timer;
 	unsigned int			rx_timeout;
 #endif
+	int				rx_trigger;
 
 	bool autorts;
 };
@@ -2204,6 +2205,7 @@ static void sci_reset(struct uart_port *port)
 {
 	const struct plat_sci_reg *reg;
 	unsigned int status;
+	struct sci_port *s = to_sci_port(port);
 
 	do {
 		status = serial_port_in(port, SCxSR);
@@ -2223,6 +2225,9 @@ static void sci_reset(struct uart_port *port)
 		status &= ~(SCLSR_TO | SCLSR_ORER);
 		serial_port_out(port, SCLSR, status);
 	}
+
+	if (s->rx_trigger > 1)
+		scif_set_rtrg(port, s->rx_trigger);
 }
 
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
@@ -2729,6 +2734,7 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->overrun_reg = SCLSR;
 		sci_port->overrun_mask = SCLSR_ORER;
 		sci_port->sampling_rate_mask = SCI_SR_RANGE(8, 32);
+		sci_port->rx_trigger = 64;
 		break;
 	case PORT_SCIFA:
 		port->fifosize = 64;
@@ -2747,12 +2753,14 @@ static int sci_init_single(struct platform_device *dev,
 			sci_port->overrun_mask = SCLSR_ORER;
 			sci_port->sampling_rate_mask = SCI_SR(32);
 		}
+		sci_port->rx_trigger = 8;
 		break;
 	default:
 		port->fifosize = 1;
 		sci_port->overrun_reg = SCxSR;
 		sci_port->overrun_mask = SCI_ORER;
 		sci_port->sampling_rate_mask = SCI_SR(32);
+		sci_port->rx_trigger = 1;
 		break;
 	}
 
-- 
2.7.4
