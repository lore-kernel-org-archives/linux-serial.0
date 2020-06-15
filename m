Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2A6C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C432068E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgFOHt0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40176 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbgFOHtW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEAFDB071;
        Mon, 15 Jun 2020 07:49:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 31/38] vt_ioctl: move K* ioctls to a separate function
Date:   Mon, 15 Jun 2020 09:49:03 +0200
Message-Id: <20200615074910.19267-31-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We create a new vt_k_ioctl here and move there all the K* ioctls.  This
makes vt_ioctl significantly smaller.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 294 ++++++++++++++++++++------------------
 1 file changed, 157 insertions(+), 137 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 911edd8d1272..1b423bdc488e 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -241,133 +241,15 @@ int vt_waitactive(int n)
 #define GPLAST 0x3df
 #define GPNUM (GPLAST - GPFIRST + 1)
 
-
-
-static inline int 
-do_fontx_ioctl(int cmd, struct consolefontdesc __user *user_cfd, int perm, struct console_font_op *op)
-{
-	struct consolefontdesc cfdarg;
-	int i;
-
-	if (copy_from_user(&cfdarg, user_cfd, sizeof(struct consolefontdesc))) 
-		return -EFAULT;
- 	
-	switch (cmd) {
-	case PIO_FONTX:
-		if (!perm)
-			return -EPERM;
-		op->op = KD_FONT_OP_SET;
-		op->flags = KD_FONT_FLAG_OLD;
-		op->width = 8;
-		op->height = cfdarg.charheight;
-		op->charcount = cfdarg.charcount;
-		op->data = cfdarg.chardata;
-		return con_font_op(vc_cons[fg_console].d, op);
-	case GIO_FONTX: {
-		op->op = KD_FONT_OP_GET;
-		op->flags = KD_FONT_FLAG_OLD;
-		op->width = 8;
-		op->height = cfdarg.charheight;
-		op->charcount = cfdarg.charcount;
-		op->data = cfdarg.chardata;
-		i = con_font_op(vc_cons[fg_console].d, op);
-		if (i)
-			return i;
-		cfdarg.charheight = op->height;
-		cfdarg.charcount = op->charcount;
-		if (copy_to_user(user_cfd, &cfdarg, sizeof(struct consolefontdesc)))
-			return -EFAULT;
-		return 0;
-		}
-	}
-	return -EINVAL;
-}
-
-static inline int 
-do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud, int perm, struct vc_data *vc)
-{
-	struct unimapdesc tmp;
-
-	if (copy_from_user(&tmp, user_ud, sizeof tmp))
-		return -EFAULT;
-	switch (cmd) {
-	case PIO_UNIMAP:
-		if (!perm)
-			return -EPERM;
-		return con_set_unimap(vc, tmp.entry_ct, tmp.entries);
-	case GIO_UNIMAP:
-		if (!perm && fg_console != vc->vc_num)
-			return -EPERM;
-		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct), tmp.entries);
-	}
-	return 0;
-}
-
-/* deallocate a single console, if possible (leave 0) */
-static int vt_disallocate(unsigned int vc_num)
-{
-	struct vc_data *vc = NULL;
-	int ret = 0;
-
-	console_lock();
-	if (vt_busy(vc_num))
-		ret = -EBUSY;
-	else if (vc_num)
-		vc = vc_deallocate(vc_num);
-	console_unlock();
-
-	if (vc && vc_num >= MIN_NR_CONSOLES)
-		tty_port_put(&vc->port);
-
-	return ret;
-}
-
-/* deallocate all unused consoles, but leave 0 */
-static void vt_disallocate_all(void)
-{
-	struct vc_data *vc[MAX_NR_CONSOLES];
-	int i;
-
-	console_lock();
-	for (i = 1; i < MAX_NR_CONSOLES; i++)
-		if (!vt_busy(i))
-			vc[i] = vc_deallocate(i);
-		else
-			vc[i] = NULL;
-	console_unlock();
-
-	for (i = 1; i < MAX_NR_CONSOLES; i++) {
-		if (vc[i] && i >= MIN_NR_CONSOLES)
-			tty_port_put(&vc[i]->port);
-	}
-}
-
-
-/*
- * We handle the console-specific ioctl's here.  We allow the
- * capability to modify any console, not just the fg_console. 
- */
-int vt_ioctl(struct tty_struct *tty,
-	     unsigned int cmd, unsigned long arg)
+static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
+		unsigned long arg, bool perm)
 {
 	struct vc_data *vc = tty->driver_data;
-	struct console_font_op op;	/* used in multiple places here */
-	unsigned int console = vc->vc_num;
 	void __user *up = (void __user *)arg;
-	int i, perm;
+	unsigned int console = vc->vc_num;
 	int ret;
 
-	/*
-	 * To have permissions to do most of the vt ioctls, we either have
-	 * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
-	 */
-	perm = 0;
-	if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
-		perm = 1;
- 
 	switch (cmd) {
-	case TIOCLINUX:
-		return tioclinux(tty, arg);
 	case KIOCSOUND:
 		if (!perm)
 			return -EPERM;
@@ -387,7 +269,7 @@ int vt_ioctl(struct tty_struct *tty,
 			return -EPERM;
 	{
 		unsigned int ticks, count;
-		
+
 		/*
 		 * Generate the tone for the appropriate number of ticks.
 		 * If the time is zero, turn off sound ourselves.
@@ -433,11 +315,11 @@ int vt_ioctl(struct tty_struct *tty,
 #endif
 
 	/* Linux m68k/i386 interface for setting the keyboard delay/repeat rate */
-		
+
 	case KDKBDREP:
 	{
 		struct kbd_repeat kbrep;
-		
+
 		if (!capable(CAP_SYS_TTY_CONFIG))
 			return -EPERM;
 
@@ -573,6 +455,157 @@ int vt_ioctl(struct tty_struct *tty,
 		spin_unlock_irq(&vt_spawn_con.lock);
 		break;
 
+	case KDFONTOP: {
+		struct console_font_op op;
+
+		if (copy_from_user(&op, up, sizeof(op)))
+			return -EFAULT;
+		if (!perm && op.op != KD_FONT_OP_GET)
+			return -EPERM;
+		ret = con_font_op(vc, &op);
+		if (ret)
+			return ret;
+		if (copy_to_user(up, &op, sizeof(op)))
+			return -EFAULT;
+		break;
+	}
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+
+	return 0;
+}
+
+static inline int do_fontx_ioctl(int cmd,
+		struct consolefontdesc __user *user_cfd, int perm,
+		struct console_font_op *op)
+{
+	struct consolefontdesc cfdarg;
+	int i;
+
+	if (copy_from_user(&cfdarg, user_cfd, sizeof(struct consolefontdesc)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case PIO_FONTX:
+		if (!perm)
+			return -EPERM;
+		op->op = KD_FONT_OP_SET;
+		op->flags = KD_FONT_FLAG_OLD;
+		op->width = 8;
+		op->height = cfdarg.charheight;
+		op->charcount = cfdarg.charcount;
+		op->data = cfdarg.chardata;
+		return con_font_op(vc_cons[fg_console].d, op);
+	case GIO_FONTX: {
+		op->op = KD_FONT_OP_GET;
+		op->flags = KD_FONT_FLAG_OLD;
+		op->width = 8;
+		op->height = cfdarg.charheight;
+		op->charcount = cfdarg.charcount;
+		op->data = cfdarg.chardata;
+		i = con_font_op(vc_cons[fg_console].d, op);
+		if (i)
+			return i;
+		cfdarg.charheight = op->height;
+		cfdarg.charcount = op->charcount;
+		if (copy_to_user(user_cfd, &cfdarg, sizeof(struct consolefontdesc)))
+			return -EFAULT;
+		return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static inline int do_unimap_ioctl(int cmd, struct unimapdesc __user *user_ud,
+		int perm, struct vc_data *vc)
+{
+	struct unimapdesc tmp;
+
+	if (copy_from_user(&tmp, user_ud, sizeof tmp))
+		return -EFAULT;
+	switch (cmd) {
+	case PIO_UNIMAP:
+		if (!perm)
+			return -EPERM;
+		return con_set_unimap(vc, tmp.entry_ct, tmp.entries);
+	case GIO_UNIMAP:
+		if (!perm && fg_console != vc->vc_num)
+			return -EPERM;
+		return con_get_unimap(vc, tmp.entry_ct, &(user_ud->entry_ct),
+				tmp.entries);
+	}
+	return 0;
+}
+
+/* deallocate a single console, if possible (leave 0) */
+static int vt_disallocate(unsigned int vc_num)
+{
+	struct vc_data *vc = NULL;
+	int ret = 0;
+
+	console_lock();
+	if (vt_busy(vc_num))
+		ret = -EBUSY;
+	else if (vc_num)
+		vc = vc_deallocate(vc_num);
+	console_unlock();
+
+	if (vc && vc_num >= MIN_NR_CONSOLES)
+		tty_port_put(&vc->port);
+
+	return ret;
+}
+
+/* deallocate all unused consoles, but leave 0 */
+static void vt_disallocate_all(void)
+{
+	struct vc_data *vc[MAX_NR_CONSOLES];
+	int i;
+
+	console_lock();
+	for (i = 1; i < MAX_NR_CONSOLES; i++)
+		if (!vt_busy(i))
+			vc[i] = vc_deallocate(i);
+		else
+			vc[i] = NULL;
+	console_unlock();
+
+	for (i = 1; i < MAX_NR_CONSOLES; i++) {
+		if (vc[i] && i >= MIN_NR_CONSOLES)
+			tty_port_put(&vc[i]->port);
+	}
+}
+
+/*
+ * We handle the console-specific ioctl's here.  We allow the
+ * capability to modify any console, not just the fg_console.
+ */
+int vt_ioctl(struct tty_struct *tty,
+	     unsigned int cmd, unsigned long arg)
+{
+	struct vc_data *vc = tty->driver_data;
+	struct console_font_op op;	/* used in multiple places here */
+	void __user *up = (void __user *)arg;
+	int i, perm;
+	int ret;
+
+	/*
+	 * To have permissions to do most of the vt ioctls, we either have
+	 * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
+	 */
+	perm = 0;
+	if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
+		perm = 1;
+
+	ret = vt_k_ioctl(tty, cmd, arg, perm);
+	if (ret != -ENOIOCTLCMD)
+		return ret;
+
+	switch (cmd) {
+	case TIOCLINUX:
+		return tioclinux(tty, arg);
 	case VT_SETMODE:
 	{
 		struct vt_mode tmp;
@@ -922,19 +955,6 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 #endif
 
-	case KDFONTOP: {
-		if (copy_from_user(&op, up, sizeof(op)))
-			return -EFAULT;
-		if (!perm && op.op != KD_FONT_OP_GET)
-			return -EPERM;
-		ret = con_font_op(vc, &op);
-		if (ret)
-			return ret;
-		if (copy_to_user(up, &op, sizeof(op)))
-			return -EFAULT;
-		break;
-	}
-
 	case PIO_SCRNMAP:
 		if (!perm)
 			return -EPERM;
-- 
2.27.0

