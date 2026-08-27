Received: from mail.muc.de (mail.muc.de [193.149.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3B7415F20
	for <linux-serial@vger.kernel.org>; Thu, 27 Aug 2026 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.149.48.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857140; cv=none; b=l2/MWcFnHVhHfz4ztXCyxpnhWKV23HpldQfUr8hKStEyfWrpsIUjKirr0jLoCOfXGDRCAqQoezS3NvnpMUUeKEkfqFXk18KWPy5iBYEY2wr20EDurRAObcpll46PpakG2IT1wL36d+6aexBLaZXZBWwlOElSnh1yOnhM1B+tU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857140; c=relaxed/simple;
	bh=HjViuf1CgFYHCz//y2JoY6sU4NK6J/e0fdh+7UIi3Ss=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=qmHZikxEridXsN1rHYSg7hYJ7smcvOow2J6qhx2mGHC+4VsljRwLXfy8u5RyvxZfLCiewPHIpS26OtWTUbop+er/3Ps3uM4fzBKExK9KS7ylvwqoRxpyi0KPo8mCbZu1+Gy3xWpydH7Ya+vssK4eZXYAEtvzo2BG10yR7uxTeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de; spf=pass smtp.mailfrom=muc.de; arc=none smtp.client-ip=193.149.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=muc.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=muc.de
Received: (qmail 25821 invoked by uid 3782); 27 Aug 2026 20:58:49 +0200
Received: from muc.de (p4fe15cdf.dip0.t-ipconnect.de [79.225.92.223]) (using
 STARTTLS) by colin.muc.de (tmda-ofmipd) with ESMTP;
 Thu, 27 Aug 2026 20:58:48 +0200
Received: (qmail 31226 invoked by uid 1000); 27 Aug 2026 18:58:48 -0000
Date: Thu, 27 Aug 2026 18:58:48 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Jiri Slaby <jirislaby@kernel.org>, Simona Vetter <simona@ffwll.ch>,
  linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
  Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
  linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: acm@muc.de
Subject: [Patch 9/9]: vt: Misc changes, e.g. to #include directives
Message-ID: <apCI6JhoH5D7ss34@MAC.fritz.box>
References: <apCEDM2sWv_M354-@MAC.fritz.box>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apCEDM2sWv_M354-@MAC.fritz.box>
X-Submission-Agent: TMDA/1.3.x (Ph3nix)
From: Alan Mackenzie <acm@muc.de>
X-Primary-Address: acm@muc.de

vt: 32b glyph: 9. Misc changes, e.g. to #include directives

Rearrange some #include directives, add some clarifying
comments, and some code changes which didn't fit elsewhere.

Signed-off-by: Alan Mackenzie <acm@muc.de>

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dfdea0842149..35da5e127a49 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -25,7 +25,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/consolemap.h>
 #include <linux/init.h>
 #include <linux/input.h>
 #include <linux/jiffies.h>
@@ -46,6 +45,7 @@
 #include <linux/tty.h>
 #include <linux/uaccess.h>
 #include <linux/vt_kern.h>
+#include <linux/consolemap.h>
 
 #include <asm/irq_regs.h>
 
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 13f4e48b4142..18affdb3c7c5 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -48,6 +48,8 @@ static struct vc_selection {
 	.start = -1,
 };
 
+static unsigned int size_row;
+
 /* clear_selection, highlight and highlight_pointer can be called
    from interrupt (via scrollback/front) */
 
@@ -340,6 +342,7 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
 {
 	int ps, pe;
 
+	size_row = vc->vc_size_row;
 	poke_blanked_console();
 
 	if (v->sel_mode == TIOCL_SELCLEAR) {
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 7d40eacc21b3..f23d61fe10c1 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -201,6 +201,8 @@ static struct vc_data *vcs_vc(struct inode *inode, bool *viewed)
 
 /**
  * vcs_size - return size for a VC in @vc
+ * The size is the number of bytes required by a buffer reading to/writing from
+ * the entire device.
  * @vc: which VC
  * @attr: does it use attributes?
  * @unicode: is it unicode?
@@ -307,7 +314,9 @@ static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
 		getconsxy(vc, con_buf + 2);
 
 		*skip += pos;
-		count += pos;
+		count += pos;	/* COUNT is now the byte offset of the end
+				 * position from the start of the header.
+				 */
 		if (count > CON_BUF_SIZE) {
 			count = CON_BUF_SIZE;
 			filled = count - pos;
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8f467b22b799..0c389a564357 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -89,6 +89,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/vt_kern.h>
+#include <linux/vt_buffer.h>
 #include <linux/selection.h>
 #include <linux/tiocl.h>
 #include <linux/kbd_kern.h>
@@ -4910,15 +4967,17 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 {
 	struct console_font font;
 	int c;
-	unsigned int vpitch = op->op == KD_FONT_OP_GET_TALL ? op->height : 32;
+	unsigned int vpitch =
+		op->op == KD_FONT_OP_GET_TALL ? vc->vc_font.height : 32;
 
 	if (vpitch > max_font_height)
 		return -EINVAL;
 
 	void *font_data __free(kvfree) = NULL;
+	c = DIV_ROUND_UP(vc->vc_font.width, 8) * vpitch * vc->vc_font.charcount;
 	if (op->data) {
-		font.data = font_data = kvzalloc(max_font_size, GFP_KERNEL);
+		font.data = font_data = kvzalloc(c, GFP_KERNEL);
 		if (!font.data)
 			return -ENOMEM;
 	} else
@@ -4935,8 +4994,6 @@ static int con_font_get(struct vc_data *vc, struct console_font_op *op)
 			return ret;
 	}
 
-	c = DIV_ROUND_UP(font.width, 8) * vpitch * font.charcount;
-
 	if (op->data && font.charcount > op->charcount)
 		return -ENOSPC;
 	if (font.width > op->width || font.height > op->height)
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fe915afdece5..5afce52057ca 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -13,6 +13,7 @@
 #ifndef _LINUX_CONSOLE_STRUCT_H
 #define _LINUX_CONSOLE_STRUCT_H
 
+#include <linux/consolemap.h>
 #include <linux/vt.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>


-- 
Alan Mackenzie (Nuremberg, Germany).
