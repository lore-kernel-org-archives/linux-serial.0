From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 72/75] tty: Fix an ircomm warning and note another bug
Date: Fri, 02 Jan 2009 13:50:20 +0000
Message-ID: <20090102135012.13472.40889.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:50527 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757594AbZABNuF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:50:05 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

Roel Kluin noted that line is unsigned so one test is unneccessary. Also
add a warning for another flaw I noticed while making this change.

Signed-off-by: Alan Cox <alan@redhat.com>
---

 net/irda/ircomm/ircomm_tty.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index e4e2cae..086d5ef 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -371,9 +371,8 @@ static int ircomm_tty_open(struct tty_struct *tty, struct file *filp)
 	IRDA_DEBUG(2, "%s()\n", __func__ );
 
 	line = tty->index;
-	if ((line < 0) || (line >= IRCOMM_TTY_PORTS)) {
+	if (line >= IRCOMM_TTY_PORTS)
 		return -ENODEV;
-	}
 
 	/* Check if instance already exists */
 	self = hashbin_lock_find(ircomm_tty, line, NULL);
@@ -405,6 +404,8 @@ static int ircomm_tty_open(struct tty_struct *tty, struct file *filp)
 		 * Force TTY into raw mode by default which is usually what
 		 * we want for IrCOMM and IrLPT. This way applications will
 		 * not have to twiddle with printcap etc.
+		 *
+		 * Note this is completely usafe and doesn't work properly
 		 */
 		tty->termios->c_iflag = 0;
 		tty->termios->c_oflag = 0;

