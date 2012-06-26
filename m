From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/3] serial/8250: delete WR SBC850 UART quirk handling
Date: Tue, 26 Jun 2012 15:54:29 -0400
Message-ID: <1340740469-31445-4-git-send-email-paul.gortmaker@windriver.com>
References: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64962 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab2FZTzE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Jun 2012 15:55:04 -0400
In-Reply-To: <1340740469-31445-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

We've are dropping the support for the EOL SBC8560, so we can
also delete this variant of the Alpha quirk support.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/8250/8250.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index f9719d1..ffd1e6e 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -119,13 +119,6 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
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
1.7.9.1

