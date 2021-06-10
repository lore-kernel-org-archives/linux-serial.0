Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDABC48BE0
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 18:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47431613DF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 18:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhFJSlQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhFJSlP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Jun 2021 14:41:15 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 070ADC061760
        for <linux-serial@vger.kernel.org>; Thu, 10 Jun 2021 11:39:19 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 1E3349200BB; Thu, 10 Jun 2021 20:39:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 17AC692009B;
        Thu, 10 Jun 2021 20:39:14 +0200 (CEST)
Date:   Thu, 10 Jun 2021 20:39:14 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] serial: 8250: Add proper clock handling for OxSemi PCIe
 devices
In-Reply-To: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106100339580.5469@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Oxford Semiconductor PCIe (Tornado) serial port devices are driven by a
fixed 62.5MHz clock input derived from the 100MHz PCI Express clock.

We currently drive the device using its default oversampling rate of 16 
and the clock prescaler disabled, consequently yielding the baud base of 
3906250.  This base is inadequate for some of the high-speed baud rates 
such as 460800bps, for which the closest rate possible can be obtained 
by dividing the baud base by 8, yielding the baud rate of 488281.25bps, 
which is off by 5.9638%.  This is enough for data communication to break 
with the remote end talking actual 460800bps where missed stop bits have 
been observed.

We can do better however, by taking advantage of a reduced oversampling 
rate, which can be set to any integer value from 4 to 16 inclusive by 
programming the TCR register, and by using the clock prescaler, which 
can be set to any value from 1 to 63.875 in increments of 0.125 in the 
CPR/CPR2 register pair[1][2][3][4].  The prescaler has to be explicitly 
enabled though by setting bit 7 in the MCR or otherwise it is bypassed 
as if the value of 1 was used.

By using these parameters rates from 15625000bps down to 1bps can be 
obtained, with either exact or highly-accurate actual bit rates for 
standard and many non-standard rates.

Make use of these features then as follows:

- Set the baud base to 15625000, reflecting the minimum oversampling 
  rate of 4 with the clock prescaler and divisor both set to 1.

- Set the MCR mask and force bits in the UART template so as to have 
  MCR[7] always set and then have 8250 core propagate those settings, if 
  supplied as non-zero, overriding the ALPHA_KLUDGE_MCR default.

- Override the `get_divisor' handler and determine a good combination of
  parameters by using a lookup table with predetermined value pairs of 
  the oversampling rate and the clock prescaler and finding a pair that 
  divides the input clock such that the quotient, when rounded to the 
  nearest integer, deviates the least from the exact result.  Calculate 
  the clock divisor accordingly.

  Scale the resulting oversampling rate (only by powers of two) if 
  possible so as to maximise it, reducing the divisor accordingly, and 
  avoid a divisor overflow for very low baud rates by scaling the 
  oversampling rate and/or the prescaler even if that causes some 
  accuracy loss.

  Also handle the historic spd_cust feature so as to allow one to set 
  all the three parameters manually to arbitrary values, by keeping the 
  low 16 bits for the divisor and then putting TCR in bits 19:16 and 
  CPR/CPR2 in bits 28:20, sanitising the bit pattern supplied such as
  to clamp CPR/CPR2 values between 0.000 and 0.875 inclusive to 1.000.
  This preserves compatibility with any existing setups, that is where 
  requesting a custom divisor that only has any bits set among the low 
  16 the oversampling rate of 16 and the clock prescaler of 1 will be 
  used.

  Finally abuse the `frac' argument to store the determined bit patterns 
  for the TCR, CPR and CPR2 registers.

- Override the `set_divisor' handler so as to set the TCR, CPR and CPR2 
  registers from the `frac' value supplied.  Set the divisor as usually.

With the baud base set to 15625000 and the unsigned 16-bit UART_DIV_MAX 
limitation imposed by `serial8250_get_baud_rate' standard baud rates 
below 300bps become unavailable in the regular way, e.g. the rate of 
200bps requires the baud base to be divided by 78125 and that is beyond 
the unsigned 16-bit range.  The historic spd_cust feature can still be 
used to obtain such rates if so required.

Here are the figures for the standard and some non-standard baud rates 
(including those quoted in Oxford Semiconductor documentation), giving 
the requested rate (r), the actual rate yielded (a) and its deviation 
from the requested rate (d), and the values of the oversampling rate 
(tcr), the clock prescaler (cpr) and the divisor (div) produced by the 
new `get_divisor' handler:

r: 15625000, a: 15625000.00, d:  0.0000%, tcr:  4, cpr:  1.000, div:     1
r: 12500000, a: 12500000.00, d:  0.0000%, tcr:  5, cpr:  1.000, div:     1
r: 10416666, a: 10416666.67, d:  0.0000%, tcr:  6, cpr:  1.000, div:     1
r:  8928571, a:  8928571.43, d:  0.0000%, tcr:  7, cpr:  1.000, div:     1
r:  7812500, a:  7812500.00, d:  0.0000%, tcr:  8, cpr:  1.000, div:     1
r:  4000000, a:  4000000.00, d:  0.0000%, tcr:  5, cpr:  3.125, div:     1
r:  3686400, a:  3676470.59, d: -0.2694%, tcr:  8, cpr:  2.125, div:     1
r:  3500000, a:  3496503.50, d: -0.0999%, tcr: 13, cpr:  1.375, div:     1
r:  3000000, a:  2976190.48, d: -0.7937%, tcr: 14, cpr:  1.500, div:     1
r:  2500000, a:  2500000.00, d:  0.0000%, tcr: 10, cpr:  2.500, div:     1
r:  2000000, a:  2000000.00, d:  0.0000%, tcr: 10, cpr:  3.125, div:     1
r:  1843200, a:  1838235.29, d: -0.2694%, tcr: 16, cpr:  2.125, div:     1
r:  1500000, a:  1492537.31, d: -0.4975%, tcr:  5, cpr:  8.375, div:     1
r:  1152000, a:  1152073.73, d:  0.0064%, tcr: 14, cpr:  3.875, div:     1
r:   921600, a:   919117.65, d: -0.2694%, tcr: 16, cpr:  2.125, div:     2
r:   576000, a:   576036.87, d:  0.0064%, tcr: 14, cpr:  3.875, div:     2
r:   460800, a:   460829.49, d:  0.0064%, tcr:  7, cpr:  3.875, div:     5
r:   230400, a:   230414.75, d:  0.0064%, tcr: 14, cpr:  3.875, div:     5
r:   115200, a:   115207.37, d:  0.0064%, tcr: 14, cpr:  1.250, div:    31
r:    57600, a:    57603.69, d:  0.0064%, tcr:  8, cpr:  3.875, div:    35
r:    38400, a:    38402.46, d:  0.0064%, tcr: 14, cpr:  3.875, div:    30
r:    19200, a:    19201.23, d:  0.0064%, tcr:  8, cpr:  3.875, div:   105
r:     9600, a:     9600.06, d:  0.0006%, tcr:  9, cpr:  1.125, div:   643
r:     4800, a:     4799.98, d: -0.0004%, tcr:  7, cpr:  2.875, div:   647
r:     2400, a:     2400.02, d:  0.0008%, tcr:  9, cpr:  2.250, div:  1286
r:     1200, a:     1200.00, d:  0.0000%, tcr: 14, cpr:  2.875, div:  1294
r:      300, a:      300.00, d:  0.0000%, tcr: 11, cpr:  2.625, div:  7215
r:      200, a:      200.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 15625
r:      150, a:      150.00, d:  0.0000%, tcr: 13, cpr:  2.250, div: 14245
r:      134, a:      134.00, d:  0.0000%, tcr: 11, cpr:  2.625, div: 16153
r:      110, a:      110.00, d:  0.0000%, tcr: 12, cpr:  1.000, div: 47348
r:       75, a:       75.00, d:  0.0000%, tcr:  4, cpr:  5.875, div: 35461
r:       50, a:       50.00, d:  0.0000%, tcr: 16, cpr:  1.250, div: 62500
r:       25, a:       25.00, d:  0.0000%, tcr: 16, cpr:  2.500, div: 62500
r:        4, a:        4.00, d:  0.0000%, tcr: 16, cpr: 20.000, div: 48828
r:        2, a:        2.00, d:  0.0000%, tcr: 16, cpr: 40.000, div: 48828
r:        1, a:        1.00, d:  0.0000%, tcr: 16, cpr: 63.875, div: 61154

References:

[1] "OXPCIe200 PCI Express Multi-Port Bridge", Oxford Semiconductor,
    Inc., DS-0045, 10 Nov 2008, Section "950 Mode", pp. 64-65

[2] "OXPCIe952 PCI Express Bridge to Dual Serial & Parallel Port",
    Oxford Semiconductor, Inc., DS-0046, Mar 06 08, Section "950 Mode", 
    p. 20

[3] "OXPCIe954 PCI Express Bridge to Quad Serial Port", Oxford
    Semiconductor, Inc., DS-0047, Feb 08, Section "950 Mode", p. 20

[4] "OXPCIe958 PCI Express Bridge to Octal Serial Port", Oxford
    Semiconductor, Inc., DS-0048, Feb 08, Section "950 Mode", p. 20

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/tty/serial/8250/8250.h      |   23 ++
 drivers/tty/serial/8250/8250_core.c |    6 
 drivers/tty/serial/8250/8250_pci.c  |  330 ++++++++++++++++++++++++++++--------
 drivers/tty/serial/8250/8250_port.c |   21 --
 4 files changed, 292 insertions(+), 88 deletions(-)

linux-serial-8250-oxsemi-pcie-prescaler.diff
Index: linux-malta-cbus-uart/drivers/tty/serial/8250/8250.h
===================================================================
--- linux-malta-cbus-uart.orig/drivers/tty/serial/8250/8250.h
+++ linux-malta-cbus-uart/drivers/tty/serial/8250/8250.h
@@ -120,6 +120,29 @@ static inline void serial_out(struct uar
 	up->port.serial_out(&up->port, offset, value);
 }
 
+/*
+ * For the 16C950
+ */
+static inline void serial_icr_write(struct uart_8250_port *up,
+				    int offset, int value)
+{
+	serial_out(up, UART_SCR, offset);
+	serial_out(up, UART_ICR, value);
+}
+
+static inline unsigned int serial_icr_read(struct uart_8250_port *up,
+					   int offset)
+{
+	unsigned int value;
+
+	serial_icr_write(up, UART_ACR, up->acr | UART_ACR_ICRRD);
+	serial_out(up, UART_SCR, offset);
+	value = serial_in(up, UART_ICR);
+	serial_icr_write(up, UART_ACR, up->acr);
+
+	return value;
+}
+
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
 
 static inline int serial_dl_read(struct uart_8250_port *up)
Index: linux-malta-cbus-uart/drivers/tty/serial/8250/8250_core.c
===================================================================
--- linux-malta-cbus-uart.orig/drivers/tty/serial/8250/8250_core.c
+++ linux-malta-cbus-uart/drivers/tty/serial/8250/8250_core.c
@@ -1027,6 +1027,12 @@ int serial8250_register_8250_port(struct
 		uart->rs485_stop_tx	= up->rs485_stop_tx;
 		uart->dma		= up->dma;
 
+		/* Override ALPHA_KLUDGE_MCR default.  */
+		if (up->mcr_mask | up->mcr_force) {
+			uart->mcr_mask = up->mcr_mask;
+			uart->mcr_force = up->mcr_force;
+		}
+
 		/* Take tx_loadsz from fifosize if it wasn't set separately */
 		if (uart->port.fifosize && !uart->tx_loadsz)
 			uart->tx_loadsz = uart->port.fifosize;
Index: linux-malta-cbus-uart/drivers/tty/serial/8250/8250_pci.c
===================================================================
--- linux-malta-cbus-uart.orig/drivers/tty/serial/8250/8250_pci.c
+++ linux-malta-cbus-uart/drivers/tty/serial/8250/8250_pci.c
@@ -1066,6 +1066,202 @@ static int pci_oxsemi_tornado_init(struc
 	return number_uarts;
 }
 
+/* Tornado-specific constants for the TCR and CPR registers; see below.  */
+#define OXSEMI_TORNADO_TCR_MASK	0xf
+#define OXSEMI_TORNADO_CPR_MASK	0x1ff
+#define OXSEMI_TORNADO_CPR_MIN	8
+
+/*
+ * Determine the oversampling rate, the clock prescaler, and the clock
+ * divisor for the requested baud rate.  The clock rate is 62.5 MHz,
+ * which is four times the baud base, and the prescaler increments in
+ * steps of 1/8.  Therefore to make calculations on integers we need
+ * to use a scaled clock rate, which is the baud base multiplied by 32
+ * (or our assumed UART clock rate multiplied by 2).
+ *
+ * The allowed oversampling rates are from 4 up to 16 inclusive (values
+ * from 0 to 3 inclusive map to 16).  Likewise the clock prescaler allows
+ * values between 1.000 and 63.875 inclusive (operation for values from
+ * 0.000 to 0.875 has not been specified).  The clock divisor is the usual
+ * unsigned 16-bit integer.
+ *
+ * For the most accurate baud rate we use a table of predetermined
+ * oversampling rates and clock prescalers that records all possible
+ * products of the two parameters in the range from 4 up to 255 inclusive,
+ * and additionally 335 for the 1500000bps rate, with the prescaler scaled
+ * by 8.  The table is sorted by the decreasing value of the oversampling
+ * rate and ties are resolved by sorting by the decreasing value of the
+ * product.  This way preference is given to higher oversampling rates.
+ *
+ * We iterate over the table and choose the product of an oversampling
+ * rate and a clock prescaler that gives the lowest integer division
+ * result deviation, or if an exact integer divider is found we stop
+ * looking for right away.  We do some fixup if the resulting clock
+ * divisor required would be out of its unsigned 16-bit integer range.
+ *
+ * Finally we abuse the supposed fractional part returned to encode the
+ * 4-bit value of the oversampling rate and the 9-bit value of the clock
+ * prescaler which will end up in the TCR and CPR/CPR2 registers.
+ */
+static unsigned int pci_oxsemi_tornado_get_divisor(struct uart_port *port,
+						   unsigned int baud,
+						   unsigned int *frac)
+{
+	static u8 p[][2] = {
+		{ 16, 14, }, { 16, 13, }, { 16, 12, }, { 16, 11, },
+		{ 16, 10, }, { 16,  9, }, { 16,  8, }, { 15, 17, },
+		{ 15, 16, }, { 15, 15, }, { 15, 14, }, { 15, 13, },
+		{ 15, 12, }, { 15, 11, }, { 15, 10, }, { 15,  9, },
+		{ 15,  8, }, { 14, 18, }, { 14, 17, }, { 14, 14, },
+		{ 14, 13, }, { 14, 12, }, { 14, 11, }, { 14, 10, },
+		{ 14,  9, }, { 14,  8, }, { 13, 19, }, { 13, 18, },
+		{ 13, 17, }, { 13, 13, }, { 13, 12, }, { 13, 11, },
+		{ 13, 10, }, { 13,  9, }, { 13,  8, }, { 12, 19, },
+		{ 12, 18, }, { 12, 17, }, { 12, 11, }, { 12,  9, },
+		{ 12,  8, }, { 11, 23, }, { 11, 22, }, { 11, 21, },
+		{ 11, 20, }, { 11, 19, }, { 11, 18, }, { 11, 17, },
+		{ 11, 11, }, { 11, 10, }, { 11,  9, }, { 11,  8, },
+		{ 10, 25, }, { 10, 23, }, { 10, 20, }, { 10, 19, },
+		{ 10, 17, }, { 10, 10, }, { 10,  9, }, { 10,  8, },
+		{  9, 27, }, {  9, 23, }, {  9, 21, }, {  9, 19, },
+		{  9, 18, }, {  9, 17, }, {  9,  9, }, {  9,  8, },
+		{  8, 31, }, {  8, 29, }, {  8, 23, }, {  8, 19, },
+		{  8, 17, }, {  8,  8, }, {  7, 35, }, {  7, 31, },
+		{  7, 29, }, {  7, 25, }, {  7, 23, }, {  7, 21, },
+		{  7, 19, }, {  7, 17, }, {  7, 15, }, {  7, 14, },
+		{  7, 13, }, {  7, 12, }, {  7, 11, }, {  7, 10, },
+		{  7,  9, }, {  7,  8, }, {  6, 41, }, {  6, 37, },
+		{  6, 31, }, {  6, 29, }, {  6, 23, }, {  6, 19, },
+		{  6, 17, }, {  6, 13, }, {  6, 11, }, {  6, 10, },
+		{  6,  9, }, {  6,  8, }, {  5, 67, }, {  5, 47, },
+		{  5, 43, }, {  5, 41, }, {  5, 37, }, {  5, 31, },
+		{  5, 29, }, {  5, 25, }, {  5, 23, }, {  5, 19, },
+		{  5, 17, }, {  5, 15, }, {  5, 13, }, {  5, 11, },
+		{  5, 10, }, {  5,  9, }, {  5,  8, }, {  4, 61, },
+		{  4, 59, }, {  4, 53, }, {  4, 47, }, {  4, 43, },
+		{  4, 41, }, {  4, 37, }, {  4, 31, }, {  4, 29, },
+		{  4, 23, }, {  4, 19, }, {  4, 17, }, {  4, 13, },
+		{  4,  9, }, {  4,  8, },
+	};
+	/* Scale the quotient for comparison to get the fractional part.  */
+	const unsigned int quot_scale = 65536;
+	unsigned int sclk = port->uartclk * 2;
+	unsigned int sdiv = (sclk + (baud / 2)) / baud;
+	unsigned int best_squot;
+	unsigned int squot;
+	unsigned int quot;
+	u16 cpr;
+	u8 tcr;
+	int i;
+
+	/* Old custom speed handling.  */
+	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST) {
+		unsigned int cust_div = port->custom_divisor;
+
+		quot = cust_div & UART_DIV_MAX;
+		tcr = (cust_div >> 16) & OXSEMI_TORNADO_TCR_MASK;
+		cpr = (cust_div >> 20) & OXSEMI_TORNADO_CPR_MASK;
+		if (cpr < OXSEMI_TORNADO_CPR_MIN)
+			cpr = OXSEMI_TORNADO_CPR_MIN;
+	} else {
+		best_squot = quot_scale;
+		for (i = 0; i < ARRAY_SIZE(p); i++) {
+			unsigned int spre;
+			unsigned int srem;
+			u8 cp;
+			u8 tc;
+
+			tc = p[i][0];
+			cp = p[i][1];
+			spre = tc * cp;
+
+			srem = sdiv % spre;
+			if (srem > spre / 2)
+				srem = spre - srem;
+			squot = (srem * quot_scale + spre / 2) / spre;
+
+			if (srem == 0) {
+				tcr = tc;
+				cpr = cp;
+				quot = sdiv / spre;
+				break;
+			} else if (squot < best_squot) {
+				best_squot = squot;
+				tcr = tc;
+				cpr = cp;
+				quot = (sdiv + spre / 2) / spre;
+			}
+		}
+		while (tcr <= (OXSEMI_TORNADO_TCR_MASK + 1) >> 1 &&
+		       quot % 2 == 0) {
+			quot >>= 1;
+			tcr <<= 1;
+		}
+		while (quot > UART_DIV_MAX) {
+			if (tcr <= (OXSEMI_TORNADO_TCR_MASK + 1) >> 1) {
+				quot >>= 1;
+				tcr <<= 1;
+			} else if (cpr <= OXSEMI_TORNADO_CPR_MASK >> 1) {
+				quot >>= 1;
+				cpr <<= 1;
+			} else {
+				quot = quot * cpr / OXSEMI_TORNADO_CPR_MASK;
+				cpr = OXSEMI_TORNADO_CPR_MASK;
+			}
+		}
+	}
+
+	*frac = (cpr << 8) | (tcr & OXSEMI_TORNADO_TCR_MASK);
+	return quot;
+}
+
+/*
+ * Set the oversampling rate in the transmitter clock cycle register (TCR),
+ * the clock prescaler in the clock prescaler register (CPR and CPR2), and
+ * the clock divisor in the divisor latch (DLL and DLM).  Note that for
+ * backwards compatibility any write to CPR clears CPR2 and therefore CPR
+ * has to be written first, followed by CPR2, which occupies the location
+ * of CKS used with earlier UART designs.
+ */
+static void pci_oxsemi_tornado_set_divisor(struct uart_port *port,
+					   unsigned int baud,
+					   unsigned int quot,
+					   unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u8 cpr2 = quot_frac >> 16;
+	u8 cpr = quot_frac >> 8;
+	u8 tcr = quot_frac;
+
+	serial_icr_write(up, UART_TCR, tcr);
+	serial_icr_write(up, UART_CPR, cpr);
+	serial_icr_write(up, UART_CKS, cpr2);
+	serial8250_do_set_divisor(port, baud, quot, 0);
+}
+
+/*
+ * For Tornado devices we force MCR[7] set for the Divide-by-M N/8 baud rate
+ * generator prescaler (CPR and CPR2).  Otherwise no prescaler would be used.
+ */
+static int pci_oxsemi_tornado_setup(struct serial_private *priv,
+				    const struct pciserial_board *board,
+				    struct uart_8250_port *up, int idx)
+{
+	struct pci_dev *dev = priv->dev;
+
+	/* OxSemi Tornado devices are all 0xCxxx */
+	if (dev->vendor == PCI_VENDOR_ID_OXSEMI &&
+	    (dev->device & 0xF000) == 0xC000) {
+		up->port.get_divisor = pci_oxsemi_tornado_get_divisor;
+		up->port.set_divisor = pci_oxsemi_tornado_set_divisor;
+
+		up->mcr_mask = ~UART_MCR_CLKSEL;
+		up->mcr_force = UART_MCR_CLKSEL;
+	}
+
+	return pci_default_setup(priv, board, up, idx);
+}
+
 static int pci_asix_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
 		  struct uart_8250_port *port, int idx)
@@ -2518,7 +2714,7 @@ static struct pci_serial_quirk pci_seria
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_oxsemi_tornado_init,
-		.setup		= pci_default_setup,
+		.setup		= pci_oxsemi_tornado_setup,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_MAINPINE,
@@ -2526,7 +2722,7 @@ static struct pci_serial_quirk pci_seria
 		.subvendor	= PCI_ANY_ID,
 		.subdevice	= PCI_ANY_ID,
 		.init		= pci_oxsemi_tornado_init,
-		.setup		= pci_default_setup,
+		.setup		= pci_oxsemi_tornado_setup,
 	},
 	{
 		.vendor		= PCI_VENDOR_ID_DIGI,
@@ -2534,7 +2730,7 @@ static struct pci_serial_quirk pci_seria
 		.subvendor		= PCI_SUBVENDOR_ID_IBM,
 		.subdevice		= PCI_ANY_ID,
 		.init			= pci_oxsemi_tornado_init,
-		.setup		= pci_default_setup,
+		.setup		= pci_oxsemi_tornado_setup,
 	},
 	{
 		.vendor         = PCI_VENDOR_ID_INTEL,
@@ -2851,7 +3047,7 @@ enum pci_board_num_t {
 	pbn_b0_2_1843200,
 	pbn_b0_4_1843200,
 
-	pbn_b0_1_3906250,
+	pbn_b0_1_15625000,
 
 	pbn_b0_bt_1_115200,
 	pbn_b0_bt_2_115200,
@@ -2931,10 +3127,10 @@ enum pci_board_num_t {
 	pbn_plx_romulus,
 	pbn_endrun_2_4000000,
 	pbn_oxsemi,
-	pbn_oxsemi_1_3906250,
-	pbn_oxsemi_2_3906250,
-	pbn_oxsemi_4_3906250,
-	pbn_oxsemi_8_3906250,
+	pbn_oxsemi_1_15625000,
+	pbn_oxsemi_2_15625000,
+	pbn_oxsemi_4_15625000,
+	pbn_oxsemi_8_15625000,
 	pbn_intel_i960,
 	pbn_sgi_ioc3,
 	pbn_computone_4,
@@ -3081,10 +3277,10 @@ static struct pciserial_board pci_boards
 		.uart_offset	= 8,
 	},
 
-	[pbn_b0_1_3906250] = {
+	[pbn_b0_1_15625000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
-		.base_baud	= 3906250,
+		.base_baud	= 15625000,
 		.uart_offset	= 8,
 	},
 
@@ -3479,31 +3675,31 @@ static struct pciserial_board pci_boards
 		.base_baud	= 115200,
 		.uart_offset	= 8,
 	},
-	[pbn_oxsemi_1_3906250] = {
+	[pbn_oxsemi_1_15625000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
-		.base_baud	= 3906250,
+		.base_baud	= 15625000,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_oxsemi_2_3906250] = {
+	[pbn_oxsemi_2_15625000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 2,
-		.base_baud	= 3906250,
+		.base_baud	= 15625000,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_oxsemi_4_3906250] = {
+	[pbn_oxsemi_4_15625000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 4,
-		.base_baud	= 3906250,
+		.base_baud	= 15625000,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_oxsemi_8_3906250] = {
+	[pbn_oxsemi_8_15625000] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 8,
-		.base_baud	= 3906250,
+		.base_baud	= 15625000,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
@@ -4510,158 +4706,158 @@ static const struct pci_device_id serial
 	 */
 	{	PCI_VENDOR_ID_OXSEMI, 0xc101,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_3906250 },
+		pbn_b0_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc105,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_3906250 },
+		pbn_b0_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc11b,    /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc11f,    /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc120,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_3906250 },
+		pbn_b0_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc124,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_3906250 },
+		pbn_b0_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc138,    /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc13d,    /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc140,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_3906250 },
+		pbn_b0_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc141,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_3906250 },
+		pbn_b0_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc144,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_3906250 },
+		pbn_b0_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc145,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_3906250 },
+		pbn_b0_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc158,    /* OXPCIe952 2 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_3906250 },
+		pbn_oxsemi_2_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc15d,    /* OXPCIe952 2 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_3906250 },
+		pbn_oxsemi_2_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc208,    /* OXPCIe954 4 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_4_3906250 },
+		pbn_oxsemi_4_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc20d,    /* OXPCIe954 4 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_4_3906250 },
+		pbn_oxsemi_4_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc308,    /* OXPCIe958 8 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_8_3906250 },
+		pbn_oxsemi_8_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc30d,    /* OXPCIe958 8 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_8_3906250 },
+		pbn_oxsemi_8_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc40b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc40f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc41b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc41f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc42b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc42f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc43b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc43f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc44b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc44f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc45b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc45f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc46b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc46f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc47b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc47f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc48b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc48f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc49b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc49f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4ab,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4af,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4bb,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4bf,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4cb,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4cf,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	/*
 	 * Mainpine Inc. IQ Express "Rev3" utilizing OxSemi Tornado
 	 */
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 1 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4001, 0, 0,
-		pbn_oxsemi_1_3906250 },
+		pbn_oxsemi_1_15625000 },
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 2 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4002, 0, 0,
-		pbn_oxsemi_2_3906250 },
+		pbn_oxsemi_2_15625000 },
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 4 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4004, 0, 0,
-		pbn_oxsemi_4_3906250 },
+		pbn_oxsemi_4_15625000 },
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 8 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4008, 0, 0,
-		pbn_oxsemi_8_3906250 },
+		pbn_oxsemi_8_15625000 },
 
 	/*
 	 * Digi/IBM PCIe 2-port Async EIA-232 Adapter utilizing OxSemi Tornado
 	 */
 	{	PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
 		PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_3906250 },
+		pbn_oxsemi_2_15625000 },
 
 	/*
 	 * SBS Technologies, Inc. P-Octal and PMC-OCTPRO cards,
Index: linux-malta-cbus-uart/drivers/tty/serial/8250/8250_port.c
===================================================================
--- linux-malta-cbus-uart.orig/drivers/tty/serial/8250/8250_port.c
+++ linux-malta-cbus-uart/drivers/tty/serial/8250/8250_port.c
@@ -528,27 +528,6 @@ serial_port_out_sync(struct uart_port *p
 }
 
 /*
- * For the 16C950
- */
-static void serial_icr_write(struct uart_8250_port *up, int offset, int value)
-{
-	serial_out(up, UART_SCR, offset);
-	serial_out(up, UART_ICR, value);
-}
-
-static unsigned int serial_icr_read(struct uart_8250_port *up, int offset)
-{
-	unsigned int value;
-
-	serial_icr_write(up, UART_ACR, up->acr | UART_ACR_ICRRD);
-	serial_out(up, UART_SCR, offset);
-	value = serial_in(up, UART_ICR);
-	serial_icr_write(up, UART_ACR, up->acr);
-
-	return value;
-}
-
-/*
  * FIFO support.
  */
 static void serial8250_clear_fifos(struct uart_8250_port *p)
