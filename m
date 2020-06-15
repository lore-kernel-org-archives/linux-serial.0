Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B852BC433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C98206D7
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgFOHug (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:50:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728868AbgFOHtU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 270B2AFBC;
        Mon, 15 Jun 2020 07:49:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 25/38] vt: redefine world of cursor macros
Date:   Mon, 15 Jun 2020 09:48:57 +0200
Message-Id: <20200615074910.19267-25-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The cursor code used to use magic constants, ANDs, ORs, and some macros.
Redefine all this to make some sense.

In particular:
* Drop CUR_DEFAULT, which is CUR_UNDERLINE. CUR_DEFAULT was used only
  for cur_default variable initialization, so use CUR_UNDERLINE there to
  make obvious what's the default.
* Drop CUR_HWMASK. Instead, define CUR_SIZE() which explains it more.
  And use it all over the places.
* Define few more masks and bits which will be used in next patches
  instead of magic constants.
* Define CUR_MAKE to build up cursor value.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/tty/vt/vt.c                  |  2 +-
 drivers/video/fbdev/core/bitblit.c   |  2 +-
 drivers/video/fbdev/core/fbcon_ccw.c |  2 +-
 drivers/video/fbdev/core/fbcon_cw.c  |  2 +-
 drivers/video/fbdev/core/fbcon_ud.c  |  2 +-
 include/linux/console_struct.h       | 28 +++++++++++++++++-----------
 6 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f7d5a3c3845f..af1ef717f416 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -163,7 +163,7 @@ module_param(default_utf8, int, S_IRUGO | S_IWUSR);
 int global_cursor_default = -1;
 module_param(global_cursor_default, int, S_IRUGO | S_IWUSR);
 
-static int cur_default = CUR_DEFAULT;
+static int cur_default = CUR_UNDERLINE;
 module_param(cur_default, int, S_IRUGO | S_IWUSR);
 
 /*
diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index c750470a31ec..3b002b365a5a 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -325,7 +325,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		ops->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (ops->p->cursor_shape & CUR_HWMASK) {
+		switch (CUR_SIZE(ops->p->cursor_shape)) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 9d06446a1a3b..5b67bcebe34c 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -325,7 +325,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		ops->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (ops->p->cursor_shape & CUR_HWMASK) {
+		switch (CUR_SIZE(ops->p->cursor_shape)) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 4b5f76bb01e5..f1aab3ae3bc9 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -308,7 +308,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		ops->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (ops->p->cursor_shape & CUR_HWMASK) {
+		switch (CUR_SIZE(ops->p->cursor_shape)) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 7e0ae3549dc7..81ed6f6bed67 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -348,7 +348,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, int mode,
 		ops->p->cursor_shape = vc->vc_cursor_type;
 		cursor.set |= FB_CUR_SETSHAPE;
 
-		switch (ops->p->cursor_shape & CUR_HWMASK) {
+		switch (CUR_SIZE(ops->p->cursor_shape)) {
 		case CUR_NONE:
 			cur_height = 0;
 			break;
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 40ed52f67bc5..153734816b49 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -173,17 +173,23 @@ struct vc {
 extern struct vc vc_cons [MAX_NR_CONSOLES];
 extern void vc_SAK(struct work_struct *work);
 
-#define CUR_DEF		0
-#define CUR_NONE	1
-#define CUR_UNDERLINE	2
-#define CUR_LOWER_THIRD	3
-#define CUR_LOWER_HALF	4
-#define CUR_TWO_THIRDS	5
-#define CUR_BLOCK	6
-#define CUR_HWMASK	0x0f
-#define CUR_SWMASK	0xfff0
-
-#define CUR_DEFAULT CUR_UNDERLINE
+#define CUR_MAKE(size, change, set)	((size) | ((change) << 8) |	\
+		((set) << 16))
+#define CUR_SIZE(c)		 ((c) & 0x00000f)
+# define CUR_DEF			       0
+# define CUR_NONE			       1
+# define CUR_UNDERLINE			       2
+# define CUR_LOWER_THIRD		       3
+# define CUR_LOWER_HALF			       4
+# define CUR_TWO_THIRDS			       5
+# define CUR_BLOCK			       6
+#define CUR_SW				0x000010
+#define CUR_ALWAYS_BG			0x000020
+#define CUR_INVERT_FG_BG		0x000040
+#define CUR_FG				0x000700
+#define CUR_BG				0x007000
+#define CUR_CHANGE(c)		 ((c) & 0x00ff00)
+#define CUR_SET(c)		(((c) & 0xff0000) >> 8)
 
 bool con_is_visible(const struct vc_data *vc);
 
-- 
2.27.0

