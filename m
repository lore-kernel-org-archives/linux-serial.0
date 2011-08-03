From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] SERIAL: Lantiq: Set timeout in uart_port
Date: Wed, 3 Aug 2011 15:37:24 +0100
Message-ID: <20110803143724.GB8673@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34109 "EHLO linux-mips.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753872Ab1HCOhj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Aug 2011 10:37:39 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
Cc: John Crispin <blogic@openwrt.org>, Thomas Langer <thomas.langer@lantiq.com>, linux-mips@linux-mips.org

From: John Crispin <blogic@openwrt.org>

Without this patch apps using readline hang.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: linux-serial@vger.kernel.org
---
No replies when John Crispin first posted this patch.  He's on vacation
so I'm reposting hoping for an ack.  I'd prefer to merge this through
the MIPS tree along with other lantiq fixes -- thanks.

 drivers/tty/serial/lantiq.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 58cf279..bc95f52 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -478,8 +478,10 @@ lqasc_set_termios(struct uart_port *port,
 	spin_unlock_irqrestore(&ltq_asc_lock, flags);
 
 	/* Don't rewrite B0 */
-        if (tty_termios_baud_rate(new))
+	if (tty_termios_baud_rate(new))
 		tty_termios_encode_baud_rate(new, baud, baud);
+
+	uart_update_timeout(port, cflag, baud);
 }
 
 static const char*
-- 
1.7.2.3

