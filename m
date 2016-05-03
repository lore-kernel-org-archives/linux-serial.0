From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] tty: vt, finish looping on duplicate
Date: Tue,  3 May 2016 17:05:55 +0200
Message-ID: <1462287955-11720-2-git-send-email-jslaby@suse.cz>
References: <1462287955-11720-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462287955-11720-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

When the console is already registered, stop crawling the
registered_con_driver array and return an error immediatelly.

This makes the code more obvious. And we do not need to initialize
retval anymore.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3ed1ae211acc..dc125322f48f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3575,7 +3575,7 @@ static int do_register_con_driver(const struct consw *csw, int first, int last)
 	struct module *owner = csw->owner;
 	struct con_driver *con_driver;
 	const char *desc;
-	int i, retval = 0;
+	int i, retval;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -3586,13 +3586,12 @@ static int do_register_con_driver(const struct consw *csw, int first, int last)
 		con_driver = &registered_con_driver[i];
 
 		/* already registered */
-		if (con_driver->con == csw)
+		if (con_driver->con == csw) {
 			retval = -EBUSY;
+			goto err;
+		}
 	}
 
-	if (retval)
-		goto err;
-
 	desc = csw->con_startup();
 	if (!desc) {
 		retval = -ENODEV;
-- 
2.8.2
