From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/79] tty: clearify structure initializer in notify_write()
Date: Wed, 26 Oct 2011 14:12:16 +0200
Message-ID: <1319631204-23262-11-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:60934 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932832Ab1JZMNc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:32 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Mathias Krause <minipli@googlemail.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Mathias Krause <minipli@googlemail.com>

Even though this is valid C we should not mix C99 initializers with
obfuscated ANSI C. Stick to C99 and initialize c by its name.

Found by clang:
drivers/tty/vt/vt.c:262:55: warning: explicitly assigning a variable of
type 'unsigned int' to itself [-Wself-assign]
    struct vt_notifier_param param = { .vc = vc, unicode = unicode };
                                                 ~~~~~~~ ^ ~~~~~~~

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/vt/vt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b3915b7..e716839 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -259,7 +259,7 @@ EXPORT_SYMBOL_GPL(unregister_vt_notifier);
 
 static void notify_write(struct vc_data *vc, unsigned int unicode)
 {
-	struct vt_notifier_param param = { .vc = vc, unicode = unicode };
+	struct vt_notifier_param param = { .vc = vc, .c = unicode };
 	atomic_notifier_call_chain(&vt_notifier_list, VT_WRITE, &param);
 }
 
-- 
1.7.7

