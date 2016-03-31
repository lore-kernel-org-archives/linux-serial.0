From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/4] tty: vt, get rid of weird source code flow
Date: Thu, 31 Mar 2016 10:08:15 +0200
Message-ID: <1459411697-26019-2-git-send-email-jslaby@suse.cz>
References: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459411697-26019-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

Some code in vc_allocate is indented by 4 spaces. It is inside a
condition. Invert the condition and move the code to the first
indentation level (using \tab). And insert some empty lines to have
logical code blocks separated.

Then, instead of freeing in an 'if' false branch, use goto-error
label as fail path.

Maybe better to look at this patch with diff -w -b.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 70 +++++++++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 90305d569c06..d1da391febb4 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -760,46 +760,54 @@ static void visual_init(struct vc_data *vc, int num, int init)
 
 int vc_allocate(unsigned int currcons)	/* return 0 on success */
 {
+	struct vt_notifier_param param;
+	struct vc_data *vc;
+
 	WARN_CONSOLE_UNLOCKED();
 
 	if (currcons >= MAX_NR_CONSOLES)
 		return -ENXIO;
-	if (!vc_cons[currcons].d) {
-	    struct vc_data *vc;
-	    struct vt_notifier_param param;
-
-	    /* due to the granularity of kmalloc, we waste some memory here */
-	    /* the alloc is done in two steps, to optimize the common situation
-	       of a 25x80 console (structsize=216, screenbuf_size=4000) */
-	    /* although the numbers above are not valid since long ago, the
-	       point is still up-to-date and the comment still has its value
-	       even if only as a historical artifact.  --mj, July 1998 */
-	    param.vc = vc = kzalloc(sizeof(struct vc_data), GFP_KERNEL);
-	    if (!vc)
+
+	if (vc_cons[currcons].d)
+		return 0;
+
+	/* due to the granularity of kmalloc, we waste some memory here */
+	/* the alloc is done in two steps, to optimize the common situation
+	   of a 25x80 console (structsize=216, screenbuf_size=4000) */
+	/* although the numbers above are not valid since long ago, the
+	   point is still up-to-date and the comment still has its value
+	   even if only as a historical artifact.  --mj, July 1998 */
+	param.vc = vc = kzalloc(sizeof(struct vc_data), GFP_KERNEL);
+	if (!vc)
 		return -ENOMEM;
-	    vc_cons[currcons].d = vc;
-	    tty_port_init(&vc->port);
-	    INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
-	    visual_init(vc, currcons, 1);
-	    if (!*vc->vc_uni_pagedir_loc)
+
+	vc_cons[currcons].d = vc;
+	tty_port_init(&vc->port);
+	INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
+
+	visual_init(vc, currcons, 1);
+
+	if (!*vc->vc_uni_pagedir_loc)
 		con_set_default_unimap(vc);
-	    vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
-	    if (!vc->vc_screenbuf) {
-		kfree(vc);
-		vc_cons[currcons].d = NULL;
-		return -ENOMEM;
-	    }
 
-	    /* If no drivers have overridden us and the user didn't pass a
-	       boot option, default to displaying the cursor */
-	    if (global_cursor_default == -1)
-		    global_cursor_default = 1;
+	vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
+	if (!vc->vc_screenbuf)
+		goto err_free;
+
+	/* If no drivers have overridden us and the user didn't pass a
+	   boot option, default to displaying the cursor */
+	if (global_cursor_default == -1)
+		global_cursor_default = 1;
+
+	vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
+	vcs_make_sysfs(currcons);
+	atomic_notifier_call_chain(&vt_notifier_list, VT_ALLOCATE, &param);
 
-	    vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
-	    vcs_make_sysfs(currcons);
-	    atomic_notifier_call_chain(&vt_notifier_list, VT_ALLOCATE, &param);
-	}
 	return 0;
+err_free:
+	kfree(vc);
+	vc_cons[currcons].d = NULL;
+	return -ENOMEM;
 }
 
 static inline int resize_screen(struct vc_data *vc, int width, int height,
-- 
2.7.4
