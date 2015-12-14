From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 23/27] serial: sh-sci: Add support for optional BRG on (H)SCIF
Date: Mon, 14 Dec 2015 19:57:32 +0100
Message-ID: <1450119456-964-24-git-send-email-geert+renesas@glider.be>
References: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1450119456-964-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Add support for using the Baud Rate Generator for External Clock (BRG), as
found on some SCIF and HSCIF variants, to provide the sampling clock.
This can improve baud rate range and accuracy.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3:
  - Add Acked-by,
  - Terminate loop over sampling rates on perfect match,
  - Rename "int_clk" to "brg_int", "SCI_INT_CLK" to "SCI_BRG_INT",
  - Add comment that the BRG divides the internal/external clock,
  - Reword patch description, using sampling clock source.
---
 drivers/tty/serial/sh-sci.c | 85 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 229162481fd67b9d..4ff5d0cf812688ff 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -80,6 +80,8 @@ enum {
 enum SCI_CLKS {
 	SCI_FCK,		/* Functional Clock */
 	SCI_SCK,		/* Optional External Clock */
+	SCI_BRG_INT,		/* Optional BRG Internal Clock Source */
+	SCI_SCIF_CLK,		/* Optional BRG External Clock Source */
 	SCI_NUM_CLKS
 };
 
@@ -1958,6 +1960,43 @@ static int sci_sck_calc(struct sci_port *s, unsigned int bps,
 	return min_err;
 }
 
+static int sci_brg_calc(struct sci_port *s, unsigned int bps,
+			unsigned long freq, unsigned int *dlr,
+			unsigned int *srr)
+{
+	unsigned int min_sr, max_sr, sr, dl;
+	int err, min_err = INT_MAX;
+
+	if (s->sampling_rate) {
+		/* SCIF has a fixed sampling rate */
+		min_sr = max_sr = s->sampling_rate / 2;
+	} else {
+		/* HSCIF has a variable 1/(8..32) sampling rate */
+		min_sr = 8;
+		max_sr = 32;
+	}
+
+	for (sr = max_sr; sr >= min_sr; sr--) {
+		dl = DIV_ROUND_CLOSEST(freq, sr * bps);
+		dl = clamp(dl, 1U, 65535U);
+
+		err = DIV_ROUND_CLOSEST(freq, sr * dl) - bps;
+		if (abs(err) >= abs(min_err))
+			continue;
+
+		min_err = err;
+		*dlr = dl;
+		*srr = sr - 1;
+
+		if (!err)
+			break;
+	}
+
+	dev_dbg(s->port.dev, "BRG: %u%+d bps using DL %u SR %u\n", bps,
+		min_err, *dlr, *srr + 1);
+	return min_err;
+}
+
 /* calculate sample rate, BRR, and clock select */
 static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 			  unsigned int *brr, unsigned int *srr,
@@ -2053,8 +2092,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 			    struct ktermios *old)
 {
 	unsigned int baud, smr_val = 0, scr_val = 0, i;
-	unsigned int brr = 255, cks = 0, srr = 15, sccks = 0;
-	unsigned int brr1 = 255, cks1 = 0, srr1 = 15;
+	unsigned int brr = 255, cks = 0, srr = 15, dl = 0, sccks = 0;
+	unsigned int brr1 = 255, cks1 = 0, srr1 = 15, dl1 = 0;
 	struct sci_port *s = to_sci_port(port);
 	const struct plat_sci_reg *reg;
 	int min_err = INT_MAX, err;
@@ -2111,6 +2150,38 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		}
 	}
 
+	/* Optional BRG Frequency Divided External Clock */
+	if (s->clk_rates[SCI_SCIF_CLK] && sci_getreg(port, SCDL)->size) {
+		err = sci_brg_calc(s, baud, s->clk_rates[SCI_SCIF_CLK], &dl1,
+				   &srr1);
+		if (abs(err) < abs(min_err)) {
+			best_clk = SCI_SCIF_CLK;
+			scr_val = SCSCR_CKE1;
+			sccks = 0;
+			min_err = err;
+			dl = dl1;
+			srr = srr1;
+			if (!err)
+				goto done;
+		}
+	}
+
+	/* Optional BRG Frequency Divided Internal Clock */
+	if (s->clk_rates[SCI_BRG_INT] && sci_getreg(port, SCDL)->size) {
+		err = sci_brg_calc(s, baud, s->clk_rates[SCI_BRG_INT], &dl1,
+				   &srr1);
+		if (abs(err) < abs(min_err)) {
+			best_clk = SCI_BRG_INT;
+			scr_val = SCSCR_CKE1;
+			sccks = SCCKS_XIN;
+			min_err = err;
+			dl = dl1;
+			srr = srr1;
+			if (!min_err)
+				goto done;
+		}
+	}
+
 	/* Divided Functional Clock using standard Bit Rate Register */
 	err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
 	if (abs(err) < abs(min_err)) {
@@ -2133,8 +2204,10 @@ done:
 	 * Program the optional External Baud Rate Generator (BRG) first.
 	 * It controls the mux to select (H)SCK or frequency divided clock.
 	 */
-	if (best_clk >= 0 && sci_getreg(port, SCCKS)->size)
+	if (best_clk >= 0 && sci_getreg(port, SCCKS)->size) {
+		serial_port_out(port, SCDL, dl);
 		serial_port_out(port, SCCKS, sccks);
+	}
 
 	sci_reset(port);
 
@@ -2143,8 +2216,8 @@ done:
 	if (best_clk >= 0) {
 		smr_val |= cks;
 		dev_dbg(port->dev,
-			 "SCR 0x%x SMR 0x%x BRR %u CKS 0x%x SRR %u\n",
-			 scr_val, smr_val, brr, sccks, srr);
+			 "SCR 0x%x SMR 0x%x BRR %u CKS 0x%x DL %u SRR %u\n",
+			 scr_val, smr_val, brr, sccks, dl, srr);
 		serial_port_out(port, SCSCR, scr_val);
 		serial_port_out(port, SCSMR, smr_val);
 		serial_port_out(port, SCBRR, brr);
@@ -2382,6 +2455,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	const char *clk_names[] = {
 		[SCI_FCK] = "fck",
 		[SCI_SCK] = "sck",
+		[SCI_BRG_INT] = "brg_int",
+		[SCI_SCIF_CLK] = "scif_clk",
 	};
 	struct clk *clk;
 	unsigned int i;
-- 
1.9.1

