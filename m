From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/16] vt: document vc_data by example
Date: Thu, 23 Jun 2016 13:34:24 +0200
Message-ID: <20160623113437.28416-3-jslaby@suse.cz>
References: <20160623113437.28416-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160623113437.28416-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

All those members of vc_data are each explained in short. But it needs
an example for one to understand the whole picture.

So add an ascii art depicting the most important vc_data members.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/console_struct.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index e329ee2667e1..5fa605c93428 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -21,6 +21,38 @@ struct uni_pagedir;
 
 #define NPAR 16
 
+/*
+ * Example: vc_data of a console that was scrolled 3 lines down.
+ *
+ *                              Console buffer
+ * vc_screenbuf ---------> +----------------------+-.
+ *                         | initializing W       |  \
+ *                         | initializing X       |   |
+ *                         | initializing Y       |    > scroll-back area
+ *                         | initializing Z       |   |
+ *                         |                      |  /
+ * vc_visible_origin ---> ^+----------------------+-:
+ * (changes by scroll)    || Welcome to linux     |  \
+ *                        ||                      |   |
+ *           vc_rows --->< | login: root          |   |  visible on console
+ *                        || password:            |    > (vc_screenbuf_size is
+ * vc_origin -----------> ||                      |   |   vc_size_row * vc_rows)
+ * (start when no scroll) || Last login: 12:28    |  /
+ *                        v+----------------------+-:
+ *                         | Have a lot of fun... |  \
+ * vc_pos -----------------|--------v             |   > scroll-front area
+ *                         | ~ # cat_             |  /
+ * vc_scr_end -----------> +----------------------+-:
+ * (vc_origin +            |                      |  \ EMPTY, to be filled by
+ *  vc_screenbuf_size)     |                      |  / vc_video_erase_char
+ *                         +----------------------+-'
+ *                         <---- 2 * vc_cols ----->
+ *                         <---- vc_size_row ----->
+ *
+ * Note that every character in the console buffer is accompanied with an
+ * attribute in the buffer right after the character. This is not depicted
+ * in the figure.
+ */
 struct vc_data {
 	struct tty_port port;			/* Upper level data */
 
-- 
2.9.0
