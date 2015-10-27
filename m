From: Denys Vlasenko <dvlasenk@redhat.com>
Subject: [PATCH 8/8] tty/tty_ldisc: Deinline tty_ldisc_put, save 368 bytes
Date: Tue, 27 Oct 2015 17:40:02 +0100
Message-ID: <1445964002-10093-9-git-send-email-dvlasenk@redhat.com>
References: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445964002-10093-1-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This function compiles to 72 bytes of machine code.

Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Peter Hurley <peter@hurleysoftware.com>
CC: Jiri Slaby <jslaby@suse.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/tty_ldisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 71750cb..14c4ad8 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -185,7 +185,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
  *
  *	Complement of tty_ldisc_get().
  */
-static inline void tty_ldisc_put(struct tty_ldisc *ld)
+static void tty_ldisc_put(struct tty_ldisc *ld)
 {
 	if (WARN_ON_ONCE(!ld))
 		return;
-- 
1.8.1.4
