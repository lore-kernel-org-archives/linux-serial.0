From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 4/4] serial: sh-sci: Clear (H)SCIF timeout and overrun during reset
Date: Fri, 24 Jun 2016 16:59:16 +0200
Message-ID: <1466780356-12623-5-git-send-email-geert+renesas@glider.be>
References: <1466780356-12623-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1466780356-12623-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Magnus Damm <damm+renesas@opensource.se>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add the missing timeout bit definition for (H)SCIF.
Clear the timeout and overrun flag bits during UART reset, cfr. the
initialization flowchart in the datasheet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/tty/serial/sh-sci.c | 5 +++++
 drivers/tty/serial/sh-sci.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 0a2be5d293220e08..cf2a7903d2f0270b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2059,6 +2059,11 @@ static void sci_reset(struct uart_port *port)
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

