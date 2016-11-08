From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/3] tty: amiserial: fix invalid user-pointer check
Date: Tue,  8 Nov 2016 13:24:53 +0100
Message-ID: <1478607895-23447-2-git-send-email-johan@kernel.org>
References: <1478607895-23447-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478607895-23447-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Drop invalid user-pointer check from TIOCGSERIAL handler.

A NULL-pointer can be valid in user space and copy_to_user() takes care
of sanity checking.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/amiserial.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 208f573495dc..dfbb974927f2 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1012,8 +1012,6 @@ static int get_serial_info(struct tty_struct *tty, struct serial_state *state,
 {
 	struct serial_struct tmp;
    
-	if (!retinfo)
-		return -EFAULT;
 	memset(&tmp, 0, sizeof(tmp));
 	tty_lock(tty);
 	tmp.line = tty->index;
-- 
2.7.3
