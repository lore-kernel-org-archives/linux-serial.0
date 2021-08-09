Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C18C43214
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 14:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734E76103B
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 14:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhHIOzl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235293AbhHIOzW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 10:55:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AC796101D;
        Mon,  9 Aug 2021 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520896;
        bh=YCFy1J2Y2QsNsPSVYSAN99rjizBKWXJw6JQNinsDlbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TS4nSHJiOxNWQNoIxwClvDENw00c1lcg2XvB9Pv7QTObBnjaAH+2CZ8tNOb9lSCNT
         X9z+pcGnnF/mhQal3Th0n/ZG7aF6Ho1GyedVBXb1Imp63+jeiFPXUcg30N9LvCrIYh
         9E/1wYctTBFC8FmMso6G27anRRcH6uhMh8GXrUeCgVfKFSypVQnZgXqy0i9dWcDN1K
         K9tOscWmJ2VsmN+11JXSm/yl+0wX9pnZjpNXpUBKux4MXLBWfdOWh6RhCNUbHf6jvi
         6Ddjn48Ib0RCtufyT743xEqV2I4PHEuFt6fnOiwdUSvtTpPAq6ZPYMF8f3fqKzRMoj
         DsPVJ13fA55sg==
Received: by pali.im (Postfix)
        id EFC1AC7C; Mon,  9 Aug 2021 16:54:55 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 6/6] serial: mvebu-uart: implement support for baudrates higher than 230400
Date:   Mon,  9 Aug 2021 16:53:29 +0200
Message-Id: <20210809145329.24177-7-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809145329.24177-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210809145329.24177-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This change implements simple usage of fractional divisor. When main
divisor D is too large to represent requested baudrate then use divisor M
from fractional divisor feature. All the M prescalers are set to same and
maximal value 63, so fractional part is not used at all.

Tests showed that UART at 1500000 baudrate via this configuration is stable
and usable. So there is no need to implement complicated calculation of
fractional coefficients yet.

To use this feature with higher baudrates, it is required to use UART clock
provided by UART clock driver. Default boot xtal clock is not capable of
higher baudrates and this change also contains code for determining upper
limit of possible baudrate.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/tty/serial/mvebu-uart.c | 79 ++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index a31235add99f..0fe251b8627b 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -99,6 +99,7 @@
 #define UART_OSAMP		0x14
 #define  OSAMP_DEFAULT_DIVISOR	16
 #define  OSAMP_DIVISORS_MASK	0x3F3F3F3F
+#define  OSAMP_MAX_DIVISOR	63
 
 #define MVEBU_NR_UARTS		2
 
@@ -479,18 +480,59 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 		return -EOPNOTSUPP;
 
 	/*
-	 * The baudrate is derived from the UART clock thanks to two divisors:
-	 *   > D ("baud generator"): can divide the clock from 2 to 2^10 - 1.
-	 *   > M ("fractional divisor"): allows a better accuracy for
-	 *     baudrates higher than 230400.
+	 * The baudrate is derived from the UART clock thanks to divisors:
+	 *   > d1 * d2 ("TBG divisors"): can divide only TBG clock from 1 to 6
+	 *   > D ("baud generator"): can divide the clock from 1 to 1023
+	 *   > M ("fractional divisor"): allows a better accuracy (from 1 to 63)
 	 *
-	 * As the derivation of M is rather complicated, the code sticks to its
-	 * default value (x16) when all the prescalers are zeroed, and only
-	 * makes use of D to configure the desired baudrate.
+	 * Exact formulas for calculating baudrate:
+	 *
+	 * with default x16 scheme:
+	 *   baudrate = xtal / (d * 16)
+	 *   baudrate = tbg / (d1 * d2 * d * 16)
+	 *
+	 * with fractional divisor:
+	 *   baudrate = 10 * xtal / (d * (3 * (m1 + m2) + 2 * (m3 + m4)))
+	 *   baudrate = 10 * tbg / (d1*d2 * d * (3 * (m1 + m2) + 2 * (m3 + m4)))
+	 *
+	 * Oversampling value:
+	 *   osamp = (m1 << 0) | (m2 << 8) | (m3 << 16) | (m4 << 24);
+	 *
+	 * Where m1 controls number of clock cycles per bit for bits 1,2,3;
+	 * m2 for bits 4,5,6; m3 for bits 7,8 and m4 for bits 9,10.
+	 *
+	 * To simplify baudrate setup set all the M prescalers to same value.
+	 * For 9600 baudrate and higher it is enough to use just default (x16)
+	 * divisor or fractional divisor with M = 63, so there is no need to
+	 * use real fractional support (when the M prescalers are not equal).
+	 *
+	 * When all the M prescalers are zeroed then default (x16) divisor is
+	 * used. Default x16 scheme is more stable than M (fractional divisor),
+	 * so use M only when D divisor is not enough to derivate baudrate.
+	 *
+	 * Member port->uartclk is either xtal clock rate or TBG clock rate
+	 * divided by (d1 * d2). So UART clock driver already sets d1 and d2
+	 * divisors and UART driver cannot change them. Moreover they are
+	 * shared with both UARTs.
 	 */
+
 	m_divisor = OSAMP_DEFAULT_DIVISOR;
 	d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
 
+	if (d_divisor > BRDV_BAUD_MAX) {
+		/*
+		 * Experiments showed that small M divisors are unstable.
+		 * So use maximal possible M = 63 and calculate D divisor.
+		 */
+		m_divisor = OSAMP_MAX_DIVISOR;
+		d_divisor = DIV_ROUND_CLOSEST(port->uartclk, baud * m_divisor);
+	}
+
+	if (d_divisor < 1)
+		d_divisor = 1;
+	else if (d_divisor > BRDV_BAUD_MAX)
+		d_divisor = BRDV_BAUD_MAX;
+
 	spin_lock_irqsave(&mvebu_uart_lock, flags);
 	brdv = readl(port->membase + UART_BRDV);
 	brdv &= ~BRDV_BAUD_MASK;
@@ -500,6 +542,9 @@ static int mvebu_uart_baud_rate_set(struct uart_port *port, unsigned int baud)
 
 	osamp = readl(port->membase + UART_OSAMP);
 	osamp &= ~OSAMP_DIVISORS_MASK;
+	if (m_divisor != OSAMP_DEFAULT_DIVISOR)
+		osamp |= (m_divisor << 0) | (m_divisor << 8) |
+			(m_divisor << 16) | (m_divisor << 24);
 	writel(osamp, port->membase + UART_OSAMP);
 
 	return 0;
@@ -529,14 +574,14 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		port->ignore_status_mask |= STAT_RX_RDY(port) | STAT_BRK_ERR;
 
 	/*
-	 * Maximal divisor is 1023 * 16 when using default (x16) scheme.
-	 * Maximum achievable frequency with simple baudrate divisor is 230400.
-	 * Since the error per bit frame would be of more than 15%, achieving
-	 * higher frequencies would require to implement the fractional divisor
-	 * feature.
+	 * Maximal divisor is 1023 and maximal fractional divisor is 63. And
+	 * experiments showed that baudrates above 1/80 of base clock are not
+	 * stable and usable. So disallow baudrate above 1/80 of the base clock.
+	 * When port->uartclk is not available then mvebu_uart_baud_rate_set()
+	 * fails so values min_baud and max_baud in this case does not matter.
 	 */
-	min_baud = DIV_ROUND_UP(port->uartclk, 1023 * 16);
-	max_baud = 230400;
+	min_baud = DIV_ROUND_UP(port->uartclk, BRDV_BAUD_MAX*OSAMP_MAX_DIVISOR);
+	max_baud = port->uartclk / 80;
 
 	baud = uart_get_baud_rate(port, termios, old, min_baud, max_baud);
 	if (mvebu_uart_baud_rate_set(port, baud)) {
@@ -1397,14 +1442,14 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
 			 * Calculate the smallest TBG d1 and d2 divisors that
 			 * still can provide 9600 baudrate.
 			 */
-			d1 = DIV_ROUND_UP(rate, 9600 * OSAMP_DEFAULT_DIVISOR *
+			d1 = DIV_ROUND_UP(rate, 9600 * OSAMP_MAX_DIVISOR *
 						BRDV_BAUD_MAX);
 			if (d1 < 1)
 				d1 = 1;
 			else if (d1 > CLK_TBG_DIV1_MAX)
 				d1 = CLK_TBG_DIV1_MAX;
 
-			d2 = DIV_ROUND_UP(rate, 9600 * OSAMP_DEFAULT_DIVISOR *
+			d2 = DIV_ROUND_UP(rate, 9600 * OSAMP_MAX_DIVISOR *
 						BRDV_BAUD_MAX * d1);
 			if (d2 < 1)
 				d2 = 1;
@@ -1419,7 +1464,7 @@ static int mvebu_uart_clock_probe(struct platform_device *pdev)
 		}
 
 		/* Skip clock source which cannot provide 9600 baudrate */
-		if (rate > 9600 * OSAMP_DEFAULT_DIVISOR * BRDV_BAUD_MAX * d1 * d2)
+		if (rate > 9600 * OSAMP_MAX_DIVISOR * BRDV_BAUD_MAX * d1 * d2)
 			continue;
 
 		/*
-- 
2.20.1

