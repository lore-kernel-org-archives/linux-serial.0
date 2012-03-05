From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/68] TTY: simplify tty_driver_lookup_tty a bit
Date: Mon,  5 Mar 2012 14:51:53 +0100
Message-ID: <1330955575-26641-7-git-send-email-jslaby@suse.cz>
References: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330955575-26641-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com
List-Id: linux-serial@vger.kernel.org

Remove the useless local variable and return the value itself.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index bd95cea..d0d3d1f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1230,13 +1230,10 @@ static void tty_line_name(struct tty_driver *driver, int index, char *p)
 static struct tty_struct *tty_driver_lookup_tty(struct tty_driver *driver,
 		struct inode *inode, int idx)
 {
-	struct tty_struct *tty;
-
 	if (driver->ops->lookup)
 		return driver->ops->lookup(driver, inode, idx);
 
-	tty = driver->ttys[idx];
-	return tty;
+	return driver->ttys[idx];
 }
 
 /**
-- 
1.7.9.2
