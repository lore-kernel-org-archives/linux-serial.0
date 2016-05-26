From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] serial: sh-sci: Clear (H)SCIF timeout and overrun during reset
Date: Thu, 26 May 2016 20:18:38 +0200
Message-ID: <1464286718-10745-5-git-send-email-geert+renesas@glider.be>
References: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464286718-10745-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add the missing timeout bit definition for (H)SCIF.
Clear the timeout and overrun flag bits during UART reset, cfr. the
initialization flowchart in the datasheet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 5 +++++
 drivers/tty/serial/sh-sci.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 549d799cb18fafe7..fe9ad1b56420876a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2056,6 +2056,11 @@ static void sci_reset(struct uart_port *port)
 	sci_clear_SCxSR(port,
 			SCxSR_RDxF_CLEAR(port) & SCxSR_ERROR_CLEAR(port) &
 			SCxSR_BREAK_CLEAR(port));
+	if (sci_getreg(port, SCLSR)->size) {
+		status = serial_port_in(port, SCLSR);
+		status &= ~(SCLSR_TO | SCLSR_ORER);
+		serial_port_out(port, SCLSR, status);
+	}
 }
 
 static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 7a4fa185b93ef307..c590418d2a40d78b 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -105,6 +105,7 @@ enum {
 #define SCFCR_LOOP	BIT(0)	/* Loopback Test */
 
 /* SCLSR (Line Status Register) on (H)SCIF */
+#define SCLSR_TO	BIT(2)	/* Timeout */
 #define SCLSR_ORER	BIT(0)	/* Overrun Error */
 
 /* SCSPTR (Serial Port Register), optional */
-- 
1.9.1
