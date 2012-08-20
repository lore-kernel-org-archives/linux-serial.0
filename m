From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] serial: sunsu.c - don't explicitly tie array size to dynamic entity
Date: Mon, 20 Aug 2012 19:56:27 -0400
Message-ID: <1345506988-15390-3-git-send-email-paul.gortmaker@windriver.com>
References: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:57546 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2HTX7m (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Aug 2012 19:59:42 -0400
In-Reply-To: <1345506988-15390-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>

The addition of 8250-like entities continues to grow, while this
driver has a snapshot of a select few common 8250 UARTs.  So it
has no need to grow with the new additions, since it calls out
its own (largely historic) static list which does not grow.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/sunsu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 675303b..d919095 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -61,7 +61,7 @@ static char *su_typev[] = { "su(???)", "su(mouse)", "su(kbd)", "su(serial)" };
 /*
  * Here we define the default xmit fifo size used for each type of UART.
  */
-static const struct serial_uart_config uart_config[PORT_MAX_8250+1] = {
+static const struct serial_uart_config uart_config[] = {
 	{ "unknown",	1,	0 },
 	{ "8250",	1,	0 },
 	{ "16450",	1,	0 },
-- 
1.7.11.1

