From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 1/5] tty: serial: allow ports to override the irq handler
Date: Mon, 15 Aug 2011 10:17:51 +0100
Message-ID: <1313399875-11006-2-git-send-email-jamie@jamieiles.com>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44113 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab1HOJSD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Aug 2011 05:18:03 -0400
Received: by wyg24 with SMTP id 24so3358626wyg.19
        for <linux-serial@vger.kernel.org>; Mon, 15 Aug 2011 02:18:02 -0700 (PDT)
In-Reply-To: <1313399875-11006-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: arnd@arndb.de, Jamie Iles <jamie@jamieiles.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

Some serial ports may have unusal requirements for interrupt handling
(e.g. the Synopsys DesignWare 8250-alike port and it's busy detect
interrupt).  Add a .handle_irq callback that can be used for platforms
to override the interrupt behaviour in a similar fashion to the
.serial_out and .serial_in callbacks.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 include/linux/serial_core.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a5c3114..b6fa317 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -300,6 +300,7 @@ struct uart_port {
 	void			(*set_termios)(struct uart_port *,
 				               struct ktermios *new,
 				               struct ktermios *old);
+	int			(*handle_irq)(struct uart_port *);
 	void			(*pm)(struct uart_port *, unsigned int state,
 				      unsigned int old);
 	unsigned int		irq;			/* irq number */
-- 
1.7.4.1

