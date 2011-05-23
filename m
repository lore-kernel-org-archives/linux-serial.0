From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 33/48] drivers/tty/moxa.c: Put correct tty value
Date: Mon, 23 May 2011 12:10:39 -0700
Message-ID: <1306177854-18172-33-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42083 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932660Ab1EWTLl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:41 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Julia Lawall <julia@diku.dk>, Greg Kroah-Hartman <gregkh@suse.de>

From: Julia Lawall <julia@diku.dk>

The tty value that should be put is the one that was just gotten by
tty_port_tty_get, not the one that is the argument to the enclosing
function.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@exists@
local idexpression struct tty_struct *x;
expression ra,rr;
statement S1,S2;
@@

x = tty_port_tty_get(...)
... when != x = rr
    when any
    when != tty_kref_put(x,...)
    when != if (...) { ... tty_kref_put(x,...) ...}
(
if(<+...x...+>) S1 else S2
|
if(...) { ... when != x = ra
     when forall
     when != tty_kref_put(x,...)
*return...;
}
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/moxa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 6255561..ba679ce 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -371,7 +371,7 @@ static int moxa_ioctl(struct tty_struct *tty,
 					tmp.cflag = p->cflag;
 				else
 					tmp.cflag = ttyp->termios->c_cflag;
-				tty_kref_put(tty);
+				tty_kref_put(ttyp);
 copy:
 				if (copy_to_user(argm, &tmp, sizeof(tmp)))
 					return -EFAULT;
-- 
1.7.4.2

