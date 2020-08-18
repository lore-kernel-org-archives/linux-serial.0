Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302E2C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119252075E
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHRI61 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:58:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:37752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbgHRI5A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0EF5B033;
        Tue, 18 Aug 2020 08:57:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 6/8] tty: vt, fix kernel-doc
Date:   Tue, 18 Aug 2020 10:56:53 +0200
Message-Id: <20200818085655.12071-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085655.12071-1-jslaby@suse.cz>
References: <20200818085655.12071-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As in the previous patches, fix kernel-doc in vt.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 2 +-
 drivers/tty/vt/vt.c         | 7 ++++---
 drivers/tty/vt/vt_ioctl.c   | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5d5a5fd2dce7..5d778c0aa009 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -708,7 +708,7 @@ EXPORT_SYMBOL(con_set_default_unimap);
 /**
  *	con_copy_unimap		-	copy unimap between two vts
  *	@dst_vc: target
- *	@src_vt: source
+ *	@src_vc: source
  *
  *	The caller must hold the console lock when invoking this method
  */
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 0f7064d41e92..71f972675fee 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1181,7 +1181,6 @@ static inline int resize_screen(struct vc_data *vc, int width, int height,
 /**
  *	vc_do_resize	-	resizing method for the tty
  *	@tty: tty being resized
- *	@real_tty: real tty (different to tty if a pty/tty pair)
  *	@vc: virtual console private data
  *	@cols: columns
  *	@lines: lines
@@ -2607,6 +2606,9 @@ static inline int vc_sanitize_unicode(const int c)
 
 /**
  * vc_translate_unicode -- Combine UTF-8 into Unicode in @vc_utf_char
+ * @vc: virtual console
+ * @c: character to translate
+ * @rescan: we return true if we need more (continuation) data
  *
  * @vc_utf_char is the being-constructed unicode character.
  * @vc_utf_count is the number of continuation bytes still expected to arrive.
@@ -3982,7 +3984,7 @@ EXPORT_SYMBOL(con_is_visible);
 
 /**
  * con_debug_enter - prepare the console for the kernel debugger
- * @sw: console driver
+ * @vc: virtual console
  *
  * Called when the console is taken over by the kernel debugger, this
  * function needs to save the current console state, then put the console
@@ -4040,7 +4042,6 @@ EXPORT_SYMBOL_GPL(con_debug_enter);
 
 /**
  * con_debug_leave - restore console state
- * @sw: console driver
  *
  * Restore the console state to what it was before the kernel debugger
  * was invoked.
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 91c301775047..7726df6b9b6f 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -181,7 +181,7 @@ static void vt_event_wait(struct vt_event_wait *vw)
 
 /**
  *	vt_event_wait_ioctl	-	event ioctl handler
- *	@arg: argument to ioctl
+ *	@event: argument to ioctl (the event)
  *
  *	Implement the VT_WAITEVENT ioctl using the VT event interface
  */
@@ -208,7 +208,6 @@ static int vt_event_wait_ioctl(struct vt_event __user *event)
 
 /**
  *	vt_waitactive	-	active console wait
- *	@event: event code
  *	@n: new console
  *
  *	Helper for event waits. Used to implement the legacy
-- 
2.28.0

