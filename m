From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 48/75] tty: PTYs set TTY_DO_WRITE_WAKEUP when they don't need
	to
Date: Fri, 02 Jan 2009 13:47:20 +0000
Message-ID: <20090102134719.13472.84654.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:37614 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754755AbZABNrG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:47:06 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

The write wakeup is done anyway for the poll while DO_WRITE_WAKUP is
cleared, set and managed by the ldisc layer and is no business of the pty
code.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/pty.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)


diff --git a/drivers/char/pty.c b/drivers/char/pty.c
index b5daaaa..112a6ba 100644
--- a/drivers/char/pty.c
+++ b/drivers/char/pty.c
@@ -5,8 +5,6 @@
  *
  *  Added support for a Unix98-style ptmx device.
  *    -- C. Scott Ananian <cananian@alumni.princeton.edu>, 14-Jan-1998
- *  Added TTY_DO_WRITE_WAKEUP to enable n_tty to send POLL_OUT to
- *      waiting writers -- Sapan Bhatia <sapan@corewars.org>
  *
  *  When reading this code see also fs/devpts. In particular note that the
  *  driver_data field is used by the devpts side as a binding to the devpts
@@ -217,7 +215,6 @@ static int pty_open(struct tty_struct *tty, struct file *filp)
 
 	clear_bit(TTY_OTHER_CLOSED, &tty->link->flags);
 	set_bit(TTY_THROTTLED, &tty->flags);
-	set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	retval = 0;
 out:
 	return retval;

