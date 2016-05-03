From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/2] tty: vt, return error when con_startup fails
Date: Tue,  3 May 2016 17:05:54 +0200
Message-ID: <1462287955-11720-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

When csw->con_startup() fails in do_register_con_driver, we return no
error (i.e. 0). This was changed back in 2006 by commit 3e795de763.
Before that we used to return -ENODEV.

So fix the return value to be -ENODEV in that case again.

Fixes: 3e795de763 ("VT binding: Add binding/unbinding support for the VT console")
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: "Dan Carpenter" <dan.carpenter@oracle.com>
---
 drivers/tty/vt/vt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f9f8ed3ed09..3ed1ae211acc 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3594,9 +3594,10 @@ static int do_register_con_driver(const struct consw *csw, int first, int last)
 		goto err;
 
 	desc = csw->con_startup();
-
-	if (!desc)
+	if (!desc) {
+		retval = -ENODEV;
 		goto err;
+	}
 
 	retval = -EINVAL;
 
-- 
2.8.2
