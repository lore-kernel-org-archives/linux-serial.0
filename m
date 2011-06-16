From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH 1/5] tty: serial: allow ports to override the irq handler
Date: Thu, 16 Jun 2011 10:19:57 +0100
Message-ID: <1308216001-5299-2-git-send-email-jamie@jamieiles.com>
References: <1308216001-5299-1-git-send-email-jamie@jamieiles.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:54149 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133Ab1FPJUJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 05:20:09 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so1330937wwa.1
        for <linux-serial@vger.kernel.org>; Thu, 16 Jun 2011 02:20:08 -0700 (PDT)
In-Reply-To: <1308216001-5299-1-git-send-email-jamie@jamieiles.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

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
index 758c5b0..5dd7653 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -296,6 +296,7 @@ struct uart_port {
 	void			(*set_termios)(struct uart_port *,
 				               struct ktermios *new,
 				               struct ktermios *old);
+	int			(*handle_irq)(struct uart_port *);
 	void			(*pm)(struct uart_port *, unsigned int state,
 				      unsigned int old);
 	unsigned int		irq;			/* irq number */
-- 
1.7.4.1

