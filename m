From: Juergen Borleis <jbe@pengutronix.de>
Subject: [PATCH v2] serial: mxs-auart: keep the AUART unit in reset state when not in use
Date: Wed, 15 Jul 2015 09:36:17 +0200
Message-ID: <1436945777-4332-1-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Whenever the UART device driver gets closed from userland, the driver
disables the UART unit and then stops its clock to save power.

The bit which disabled the UART unit is described as:

 =C2=A0"UART Enable. If this bit is set to 1, the UART is enabled. Data
  transmission and reception occurs for the UART signals. When the
  UART is disabled in the middle of transmission or reception, it
  completes the current character before stopping."

The important part is the "it completes the current character". Wheneve=
r
a reception is ongoing when the UART gets disabled (including the clock
off) the statemachine freezes and "remembers" this state on the next
open() and re-enabling of the unit's clock.

In this case we end up receiving an additional bogus character
immediately.

The solution in this change is to move the AUART unit into its reset
state on close() and only release it from its reset state on the next
open().

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 drivers/tty/serial/mxs-auart.c | 38 ++++++++++++++++++++++++++++++----=
----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-au=
art.c
index 13cf773..13b3e3c 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -858,6 +858,30 @@ static void mxs_auart_reset(struct uart_port *u)
 	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
 }
=20
+static void mxs_auart_keep_reset(struct uart_port *u)
+{
+	int i;
+	u32 reg;
+
+	reg =3D readl(u->membase + AUART_CTRL0);
+	/* if already in reset state, keep it untouched */
+	if (reg & AUART_CTRL0_SFTRST)
+		return;
+
+	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
+	writel(AUART_CTRL0_SFTRST, u->membase + AUART_CTRL0_SET);
+
+	for (i =3D 0; i < 10000; i++) {
+		reg =3D readl(u->membase + AUART_CTRL0);
+		/* reset is finished when the clock is gated */
+		if (reg & AUART_CTRL0_CLKGATE)
+			return;
+		udelay(3);
+	}
+
+	dev_err(u->dev, "Failed to reset the unit.");
+}
+
 static int mxs_auart_startup(struct uart_port *u)
 {
 	int ret;
@@ -867,7 +891,10 @@ static int mxs_auart_startup(struct uart_port *u)
 	if (ret)
 		return ret;
=20
-	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
+	/* reset the unit if not aleady done */
+	mxs_auart_keep_reset(u);
+	/* bring it out of reset now */
+	mxs_auart_reset(u);
=20
 	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_SET);
=20
@@ -899,13 +926,8 @@ static void mxs_auart_shutdown(struct uart_port *u=
)
 	if (auart_dma_enabled(s))
 		mxs_auart_dma_exit(s);
=20
-	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);
-
-	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
-			u->membase + AUART_INTR_CLR);
-
-	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_SET);
-
+	/* reset the unit and keep it in reset state */
+	mxs_auart_keep_reset(u);
 	clk_disable_unprepare(s->clk);
 }
=20
--=20
2.1.4
