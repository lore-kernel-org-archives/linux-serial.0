From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 15/79] tty: serial: allow ports to override the irq handler
Date: Wed, 26 Oct 2011 14:12:20 +0200
Message-ID: <1319631204-23262-15-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60938 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932852Ab1JZMNe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:34 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jamie Iles <jamie@jamieiles.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Jamie Iles <jamie@jamieiles.com>

Some serial ports may have unusal requirements for interrupt handling
(e.g. the Synopsys DesignWare 8250-alike port and it's busy detect
interrupt).  Add a .handle_irq callback that can be used for platforms
to override the interrupt behaviour in a similar fashion to the
.serial_out and .serial_in callbacks.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/serial_core.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 76e1103..c31ae43 100644
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
1.7.7

