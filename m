Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10CDC4332E
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4D822AAE
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbhAEMED (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:04:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:39244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729975AbhAEMED (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 07:04:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B64D0ADD9;
        Tue,  5 Jan 2021 12:02:41 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 09/12] vgacon: drop BROKEN_GRAPHICS_PROGRAMS
Date:   Tue,  5 Jan 2021 13:02:36 +0100
Message-Id: <20210105120239.28031-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

BROKEN_GRAPHICS_PROGRAMS is defined when CONFIG_VGA_CONSOLE=y. And
vgacon.c is built exclusively in that case too. So the check for
BROKEN_GRAPHICS_PROGRAMS is pointless in vgacon.c as it is always true.
So remove the test and BROKEN_GRAPHICS_PROGRAMS completely.

This also eliminates the need for vga_font_is_default global as it is
only set and never read.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/console/vgacon.c | 19 -------------------
 include/linux/vt_kern.h        | 12 ------------
 2 files changed, 31 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 17876f0179b5..962c12be9774 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -90,7 +90,6 @@ static unsigned int	vga_video_num_lines;			/* Number of text lines */
 static bool		vga_can_do_color;			/* Do we support colors? */
 static unsigned int	vga_default_font_height __read_mostly;	/* Height of default screen font */
 static unsigned char	vga_video_type		__read_mostly;	/* Card type */
-static bool		vga_font_is_default = true;
 static int		vga_vesa_blanked;
 static bool 		vga_palette_blanked;
 static bool 		vga_is_gfx;
@@ -878,7 +877,6 @@ static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
 		beg = 0x0a;
 	}
 
-#ifdef BROKEN_GRAPHICS_PROGRAMS
 	/*
 	 * All fonts are loaded in slot 0 (0:1 for 512 ch)
 	 */
@@ -886,24 +884,7 @@ static int vgacon_do_font_op(struct vgastate *state, char *arg, int set,
 	if (!arg)
 		return -EINVAL;	/* Return to default font not supported */
 
-	vga_font_is_default = false;
 	font_select = ch512 ? 0x04 : 0x00;
-#else
-	/*
-	 * The default font is kept in slot 0 and is never touched.
-	 * A custom font is loaded in slot 2 (256 ch) or 2:3 (512 ch)
-	 */
-
-	if (set) {
-		vga_font_is_default = !arg;
-		if (!arg)
-			ch512 = false;	/* Default font is always 256 */
-		font_select = arg ? (ch512 ? 0x0e : 0x0a) : 0x00;
-	}
-
-	if (!vga_font_is_default)
-		charmap += 4 * cmapsz;
-#endif
 
 	raw_spin_lock_irq(&vga_lock);
 	/* First, the Sequencer */
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 349e39c3ab60..94e7a315479c 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -16,18 +16,6 @@
 #include <linux/consolemap.h>
 #include <linux/notifier.h>
 
-/*
- * Presently, a lot of graphics programs do not restore the contents of
- * the higher font pages.  Defining this flag will avoid use of them, but
- * will lose support for PIO_FONTRESET.  Note that many font operations are
- * not likely to work with these programs anyway; they need to be
- * fixed.  The linux/Documentation directory includes a code snippet
- * to save and restore the text font.
- */
-#ifdef CONFIG_VGA_CONSOLE
-#define BROKEN_GRAPHICS_PROGRAMS 1
-#endif
-
 void kd_mksound(unsigned int hz, unsigned int ticks);
 int kbd_rate(struct kbd_repeat *rep);
 
-- 
2.30.0

