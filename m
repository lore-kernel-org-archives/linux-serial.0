From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH] pty: Fix overlimit memory use
Date: Fri, 16 Jan 2015 15:22:14 -0500
Message-ID: <1421439734-17335-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The pty_space() computation is broken; the space already consumed
in the tty buffer is not accounted for.

Use tty_buffer_set_limit(), which enforces the limit automatically.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index a9d256d..2cf2567 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -88,19 +88,6 @@ static void pty_unthrottle(struct tty_struct *tty)
 }
 
 /**
- *	pty_space	-	report space left for writing
- *	@to: tty we are writing into
- *
- *	Limit the buffer space used by ptys to 8k.
- */
-
-static int pty_space(struct tty_struct *to)
-{
-	int n = tty_buffer_space_avail(to->port);
-	return min(n, 8192);
-}
-
-/**
  *	pty_write		-	write to a pty
  *	@tty: the tty we write from
  *	@buf: kernel buffer of data
@@ -141,7 +128,7 @@ static int pty_write_room(struct tty_struct *tty)
 {
 	if (tty->stopped)
 		return 0;
-	return pty_space(tty->link);
+	return tty_buffer_space_avail(tty->link->port);
 }
 
 /**
@@ -429,6 +416,8 @@ static int pty_common_install(struct tty_driver *driver, struct tty_struct *tty,
 	o_tty->link = tty;
 	tty_port_init(ports[0]);
 	tty_port_init(ports[1]);
+	tty_buffer_set_limit(ports[0], 8192);
+	tty_buffer_set_limit(ports[1], 8192);
 	o_tty->port = ports[0];
 	tty->port = ports[1];
 	o_tty->port->itty = o_tty;
-- 
2.2.2
