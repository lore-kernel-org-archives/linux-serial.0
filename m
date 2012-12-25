From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] seria: sirf: only use lookup table to set baudrate when ioclk=150MHz
Date: Tue, 25 Dec 2012 18:26:02 +0800
Message-ID: <1356431162-8372-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:41930 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab2LYK0x (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 25 Dec 2012 05:26:53 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>

From: Barry Song <Baohua.Song@csr.com>

The fast lookup table to set baudrate is only right when ioclk
is 150MHz. for most platforms, ioclk is 150MHz, but some boards
might set ioclk to other frequency.

so re-calc the clk_div_reg when ioclk is not 150MHz.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 142217c..fe28b1f 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -375,7 +375,12 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	int		threshold_div;
 	int		temp;
 
-	ioclk_rate = 150000000;
+	struct clk *clk = clk_get_sys("io", NULL);
+	BUG_ON(IS_ERR(clk));
+
+	ioclk_rate = clk_get_rate(clk);
+	clk_put(clk);
+
 	switch (termios->c_cflag & CSIZE) {
 	default:
 	case CS8:
@@ -431,10 +436,13 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 			sirfsoc_uart_disable_ms(port);
 	}
 
-	/* common rate: fast calculation */
-	for (ic = 0; ic < SIRF_BAUD_RATE_SUPPORT_NR; ic++)
-		if (baud_rate == baudrate_to_regv[ic].baud_rate)
-			clk_div_reg = baudrate_to_regv[ic].reg_val;
+	if (ioclk_rate == 150000000) {
+		/* common rate: fast calculation */
+		for (ic = 0; ic < SIRF_BAUD_RATE_SUPPORT_NR; ic++)
+			if (baud_rate == baudrate_to_regv[ic].baud_rate)
+				clk_div_reg = baudrate_to_regv[ic].reg_val;
+	}
+
 	setted_baud = baud_rate;
 	/* arbitary rate setting */
 	if (unlikely(clk_div_reg == 0))
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
