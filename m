From: Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] Another one ISA PnP modem (USR0009)
Date: Tue, 19 Oct 2004 18:16:07 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20041019161607.GB1960@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3077 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S269516AbUJSQQj (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 19 Oct 2004 12:16:39 -0400
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+serial@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Denis Zaitsev <zzz@anda.ru>


Below is a patch from Denis Zaitsev <zzz@anda.ru> with the following two 
adjustments:
- applies with -p1 (not -p0)
- USRobotics -> U.S. Robotics (consistent with the rest of the entries)


Original comment of Denis Zaitsev:

<--  snip  -->

This patch adds the USR Courier INT (one of them?) into the list of
the PnP devices IDs in 8250_pnp.  Before the patch this modem hasn't
been activated by 8250_pnp.

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- l/drivers/serial/8250_pnp.c.orig	2004-08-14 16:54:47.000000000 +0600
+++ l/drivers/serial/8250_pnp.c	2004-10-10 03:33:53.000000000 +0600
@@ -293,6 +293,8 @@ static const struct pnp_device_id pnp_de
 	{	"USR0006",		0	},
 	/* U.S. Robotics 33.6K Voice EXT PnP */
 	{	"USR0007",		0	},
+	/* U.S. Robotics Courier V.Everything INT PnP */
+	{	"USR0009",		0	},
 	/* U.S. Robotics 33.6K Voice INT PnP */
 	{	"USR2002",		0	},
 	/* U.S. Robotics 56K Voice INT PnP */
