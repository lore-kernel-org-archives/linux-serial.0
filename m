From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] serial: 8250: remove a few lines of dead code
Date: Mon, 25 Mar 2013 23:01:21 +0100
Message-ID: <1364248881.1390.302.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:55543 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752022Ab3CYWBY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Mar 2013 18:01:24 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

Support for the WindRiver SBC8560 board was removed in v3.6. But there
are still a few lines depending on its obsolete Kconfig macro. Remove
these now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Not tested.

 drivers/tty/serial/8250/8250.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 34eb676..1ebf853 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -117,13 +117,6 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
  * is cleared, the machine locks up with endless interrupts.
  */
 #define ALPHA_KLUDGE_MCR  (UART_MCR_OUT2 | UART_MCR_OUT1)
-#elif defined(CONFIG_SBC8560)
-/*
- * WindRiver did something similarly broken on their SBC8560 board. The
- * UART tristates its IRQ output while OUT2 is clear, but they pulled
- * the interrupt line _up_ instead of down, so if we register the IRQ
- * while the UART is in that state, we die in an IRQ storm. */
-#define ALPHA_KLUDGE_MCR (UART_MCR_OUT2)
 #else
 #define ALPHA_KLUDGE_MCR 0
 #endif
-- 
1.7.11.7

