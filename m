From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 43/75] tty: tty port zero baud open
Date: Fri, 02 Jan 2009 13:46:43 +0000
Message-ID: <20090102134639.13472.79703.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37598 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757142AbZABNq3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:46:29 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

If we have no speed set at some point then we should not raise DTR/RTS at
that point when opening as the tty is not ready

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/tty_port.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/drivers/char/tty_port.c b/drivers/char/tty_port.c
index ff94182..0723664 100644
--- a/drivers/char/tty_port.c
+++ b/drivers/char/tty_port.c
@@ -216,7 +216,8 @@ int tty_port_block_til_ready(struct tty_port *port,
 
 	while (1) {
 		/* Indicate we are open */
-		tty_port_raise_dtr_rts(port);
+		if (tty->termios->c_cflag & CBAUD)
+			tty_port_raise_dtr_rts(port);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		/* Check for a hangup or uninitialised port. Return accordingly */

