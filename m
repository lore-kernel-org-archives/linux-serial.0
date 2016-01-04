From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/5] serial: sh-sci: Use premultiplier to handle half sampling rate
Date: Mon,  4 Jan 2016 14:45:20 +0100
Message-ID: <1451915122-30219-4-git-send-email-geert+renesas@glider.be>
References: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1451915122-30219-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On SCIx variants different from HSCIF, the bit rate is equal to the
sampling clock rate divided by half the sampling rate. Currently this is
handled by dividing the sampling rate by two, which was OK as it was
always even.

Replace halving the sampling rate by premultiplying the base clock
frequency by 2, to accommodate odd sampling rates on SCIFA/SCIFB later.

Replace the shift value in the BRG divider calculation by a
premultiplication of the base clock frequency too, for consistency.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e8d6fa77e11208d4..f3c2a89a9550add9 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1934,9 +1934,11 @@ static int sci_sck_calc(struct sci_port *s, unsigned int bps,
 	unsigned int min_sr, max_sr, sr;
 	int err, min_err = INT_MAX;
 
+	if (s->port.type != PORT_HSCIF)
+		freq *= 2;
 	if (s->sampling_rate) {
 		/* SCI(F) has a fixed sampling rate */
-		min_sr = max_sr = s->sampling_rate / 2;
+		min_sr = max_sr = s->sampling_rate;
 	} else {
 		/* HSCIF has a variable 1/(8..32) sampling rate */
 		min_sr = 8;
@@ -1967,9 +1969,11 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 	unsigned int min_sr, max_sr, sr, dl;
 	int err, min_err = INT_MAX;
 
+	if (s->port.type != PORT_HSCIF)
+		freq *= 2;
 	if (s->sampling_rate) {
 		/* SCIF has a fixed sampling rate */
-		min_sr = max_sr = s->sampling_rate / 2;
+		min_sr = max_sr = s->sampling_rate;
 	} else {
 		/* HSCIF has a variable 1/(8..32) sampling rate */
 		min_sr = 8;
@@ -2002,18 +2006,18 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 			  unsigned int *brr, unsigned int *srr,
 			  unsigned int *cks)
 {
-	unsigned int min_sr, max_sr, shift, sr, br, prediv, scrate, c;
+	unsigned int min_sr, max_sr, sr, br, prediv, scrate, c;
 	unsigned long freq = s->clk_rates[SCI_FCK];
 	int err, min_err = INT_MAX;
 
+	if (s->port.type != PORT_HSCIF)
+		freq *= 2;
 	if (s->sampling_rate) {
 		min_sr = max_sr = s->sampling_rate;
-		shift = 0;
 	} else {
 		/* HSCIF has a variable sample rate */
 		min_sr = 8;
 		max_sr = 32;
-		shift = 1;
 	}
 
 	/*
@@ -2034,7 +2038,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 	for (sr = max_sr; sr >= min_sr; sr--) {
 		for (c = 0; c <= 3; c++) {
 			/* integerized formulas from HSCIF documentation */
-			prediv = sr * (1 << (2 * c + shift));
+			prediv = sr * (1 << (2 * c + 1));
 
 			/*
 			 * We need to calculate:
-- 
1.9.1

