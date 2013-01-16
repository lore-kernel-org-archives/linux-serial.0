From: Cong Ding <dinggnu@gmail.com>
Subject: [PATCH] tty: serial/crisv10.c: remove unnecessary null pointer check
Date: Wed, 16 Jan 2013 23:30:44 +0100
Message-ID: <1358375444-13026-2-git-send-email-dinggnu@gmail.com>
References: <1358375444-13026-1-git-send-email-dinggnu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358375444-13026-1-git-send-email-dinggnu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Cong Ding <dinggnu@gmail.com>
List-Id: linux-serial@vger.kernel.org

The pointer tty is dereferened in line 3135, so it is not necessary to check
null again in line 3140.

Signed-off-by: Cong Ding <dinggnu@gmail.com>
---
 drivers/tty/serial/crisv10.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 35ee6a2..3b24965 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3137,7 +3137,7 @@ static int rs_raw_write(struct tty_struct *tty,
 
 	/* first some sanity checks */
 
-	if (!tty || !info->xmit.buf)
+	if (!info->xmit.buf)
 		return 0;
 
 #ifdef SERIAL_DEBUG_DATA
-- 
1.7.10.4
