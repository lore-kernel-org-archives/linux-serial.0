From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 8/9] vt: Remove vt_get_kmsg_redirect() from uapi header
Date: Wed,  5 Nov 2014 12:26:31 -0500
Message-ID: <1415208392-16189-9-git-send-email-peter@hurleysoftware.com>
References: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415208392-16189-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

vt_get_kmsg_redirect() only has meaning to the console driver as
an alias for calling vt_kmsg_redirect(). Move the macro definition
to the only source file which uses it; remove from uapi/linux/vt.h

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/vt/vt.c     | 2 ++
 include/uapi/linux/vt.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b33b00b..3dc5d56 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2509,6 +2509,8 @@ int vt_kmsg_redirect(int new)
 		return kmsg_con;
 }
 
+#define vt_get_kmsg_redirect() vt_kmsg_redirect(-1)
+
 /*
  *	Console on virtual terminal
  *
diff --git a/include/uapi/linux/vt.h b/include/uapi/linux/vt.h
index 4b59a26..978578b 100644
--- a/include/uapi/linux/vt.h
+++ b/include/uapi/linux/vt.h
@@ -84,7 +84,4 @@ struct vt_setactivate {
 
 #define VT_SETACTIVATE	0x560F	/* Activate and set the mode of a console */
 
-
-#define vt_get_kmsg_redirect() vt_kmsg_redirect(-1)
-
 #endif /* _UAPI_LINUX_VT_H */
-- 
2.1.3
