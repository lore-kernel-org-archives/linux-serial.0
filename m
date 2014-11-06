From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] serial: pl011: Fix build breakage with !CONFIG_DMA_ENGINE
Date: Thu,  6 Nov 2014 09:06:12 -0500
Message-ID: <1415282772-26256-1-git-send-email-peter@hurleysoftware.com>
References: <201411061551.b7jIlJ0U%fengguang.wu@intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:58645 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbaKFOGf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Nov 2014 09:06:35 -0500
In-Reply-To: <201411061551.b7jIlJ0U%fengguang.wu@intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fengguang Wu <fengguang.wu@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Russell King <linux@arm.linux.org.uk>

Commit 479e9b94fdce7bc4 ("serial: Refactor uart_flush_buffer() from
uart_close") refactored the uart_flush_buffer() in uart_close() into
those drivers that define a flush_buffer() method. However, in the
amba-pl011 driver configured without CONFIG_DMA_ENGINE, flush_buffer()
is a NULL method, so the direct call fails to compile.

Check and call the flush_buffer() method through the ops table instead.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/amba-pl011.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8469b66..83c8f72 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1689,7 +1689,8 @@ static void pl011_shutdown(struct uart_port *port)
 			plat->exit();
 	}
 
-	pl011_dma_flush_buffer(port);
+	if (uap->port.ops->flush_buffer)
+		uap->port.ops->flush_buffer(port);
 }
 
 static void
-- 
2.1.3

