From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 07/24] SERIAL: omap: allow hardware assisted IXANY mode to be
 disabled
Date: Sat, 06 Oct 2012 13:41:23 +0100
Message-ID: <E1TKTh5-0002mn-37@rmk-PC.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47243 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064Ab2JFMld (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Oct 2012 08:41:33 -0400
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org

Nothing was clearing the UART_MCR_XONANY bit, so once the ixany
mode gets set, there's no possibility to disable it.  Clear this
bit when IXANY mode is cleared.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f2535fe..6314827 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -696,6 +696,8 @@ serial_omap_configure_xonxoff
 	 */
 	if (termios->c_iflag & IXANY)
 		up->mcr |= UART_MCR_XONANY;
+	else
+		up->mcr &= ~UART_MCR_XONANY;
 
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-- 
1.7.4.4

