From: "Jayachandran C." <jchandra@digeo.com>
Subject: [PATCH] serial: remove unneeded code from serial_core.c
Date: Tue, 18 Oct 2005 18:16:08 -0700
Message-ID: <20051019011608.GE5338@random.pao.digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from packet.digeo.com ([12.110.80.53]:30407 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id S932394AbVJSBQo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Oct 2005 21:16:44 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk, Andrew Morton <akpm@osdl.org>

This patch fixes an issue reported by Coverity in serial/serial_core.c

Error reported: Variable "&((info)->tty)->flags" tracked as NULL was passed to a
function that dereferences it.

Patch description:
 The later statements in the function assumes 'info->tty != NULL', so this 
 check is not necessary.  Probably a 'BUG_ON(info->tty == NULL)' can be added.

Signed-off-by: Jayachandran C. <c.jayachandran at gmail.com>
---
 
 serial_core.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.13-rc4-git2.clean/drivers/serial/serial_core.c	2005-10-13 11:42:33.000000000 -0700
+++ linux-2.6.13-rc4-git2.jc/drivers/serial/serial_core.c	2005-10-14 16:22:13.248131850 -0700
@@ -147,8 +147,7 @@
 	 * once we have successfully opened the port.  Also set
 	 * up the tty->alt_speed kludge
 	 */
-	if (info->tty)
-		set_bit(TTY_IO_ERROR, &info->tty->flags);
+	set_bit(TTY_IO_ERROR, &info->tty->flags);
 
 	if (port->type == PORT_UNKNOWN)
 		return 0;
