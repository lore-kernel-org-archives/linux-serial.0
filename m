From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 01/11] tty: debug buffer work race with tty free
Date: Fri, 14 Dec 2012 13:22:40 -0500
Message-ID: <1355509370-5883-2-git-send-email-peter@hurleysoftware.com>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ilya Zykov <ilya@ilyx.ru>, Sasha Levin <levinsasha928@gmail.com>, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/pty.c        | 3 ++-
 drivers/tty/tty_buffer.c | 2 +-
 drivers/tty/tty_io.c     | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index be6a373..baf52b4 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -407,8 +407,9 @@ static void pty_unix98_shutdown(struct tty_struct *tty)
 
 static void pty_cleanup(struct tty_struct *tty)
 {
-	tty->port->itty = NULL;
+	tty->port->itty = ERR_PTR(-2);
 	tty_port_put(tty->port);
+	tty->port = NULL;
 }
 
 /* Traditional BSD devices */
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index b29ba87..cc9cbcf 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -432,7 +432,7 @@ static void flush_to_ldisc(struct work_struct *work)
 	struct tty_ldisc *disc;
 
 	tty = port->itty;
-	if (WARN_RATELIMIT(tty == NULL, "tty is NULL\n"))
+	if (WARN_RATELIMIT(IS_ERR_OR_NULL(tty), "tty is bad=%ld", PTR_ERR(tty)))
 		return;
 
 	disc = tty_ldisc_ref(tty);
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index da9fde8..78c3000 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1553,7 +1553,7 @@ static void release_tty(struct tty_struct *tty, int idx)
 		tty->ops->shutdown(tty);
 	tty_free_termios(tty);
 	tty_driver_remove_tty(tty->driver, tty);
-	tty->port->itty = NULL;
+	tty->port->itty = ERR_PTR(-1);
 
 	if (tty->link)
 		tty_kref_put(tty->link);
-- 
1.8.0.1
