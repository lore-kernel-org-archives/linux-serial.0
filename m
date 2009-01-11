From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/6] pty: Fix documentation
Date: Sun, 11 Jan 2009 19:48:25 +0000
Message-ID: <20090111194822.16074.93976.stgit@localhost.localdomain>
References: <20090111194656.16074.14975.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41719 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752178AbZAKTsj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Jan 2009 14:48:39 -0500
In-Reply-To: <20090111194656.16074.14975.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Alan Cox <alan@redhat.com>

The pty changes and updates for window sizing forgot to correct the
kerneldoc

Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/pty.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)


diff --git a/drivers/char/pty.c b/drivers/char/pty.c
index 146c976..31038a0 100644
--- a/drivers/char/pty.c
+++ b/drivers/char/pty.c
@@ -230,9 +230,7 @@ static void pty_set_termios(struct tty_struct *tty,
 /**
  *	pty_do_resize		-	resize event
  *	@tty: tty being resized
- *	@real_tty: real tty (not the same as tty if using a pty/tty pair)
- *	@rows: rows (character)
- *	@cols: cols (character)
+ *	@ws: window size being set.
  *
  *	Update the termios variables and send the neccessary signals to
  *	peform a terminal resize correctly

