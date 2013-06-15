From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 20/24] n_tty: Move chars_in_buffer() to factor throttle/unthrottle
Date: Sat, 15 Jun 2013 09:14:32 -0400
Message-ID: <1371302076-4688-21-git-send-email-peter@hurleysoftware.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
 <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Prepare to factor throttle and unthrottle into helper functions;
relocate chars_in_buffer() to avoid forward declaration.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index b78ee464..9ec0c68 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -202,6 +202,18 @@ static void n_tty_set_room(struct tty_struct *tty)
 	}
 }
 
+static ssize_t chars_in_buffer(struct tty_struct *tty)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+	ssize_t n = 0;
+
+	if (!ldata->icanon)
+		n = read_cnt(ldata);
+	else
+		n = ldata->canon_head - ldata->read_tail;
+	return n;
+}
+
 /**
  *	put_tty_queue		-	add character to tty
  *	@c: character
@@ -285,18 +297,6 @@ static void n_tty_flush_buffer(struct tty_struct *tty)
 	up_write(&tty->termios_rwsem);
 }
 
-static ssize_t chars_in_buffer(struct tty_struct *tty)
-{
-	struct n_tty_data *ldata = tty->disc_data;
-	ssize_t n = 0;
-
-	if (!ldata->icanon)
-		n = read_cnt(ldata);
-	else
-		n = ldata->canon_head - ldata->read_tail;
-	return n;
-}
-
 /**
  *	n_tty_chars_in_buffer	-	report available bytes
  *	@tty: tty device
-- 
1.8.1.2
