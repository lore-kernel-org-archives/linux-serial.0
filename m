Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A914FC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DBC61A3D
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbhKRHWQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:22:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51920 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243690AbhKRHWN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:22:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 553A61FD37;
        Thu, 18 Nov 2021 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637219952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5kFgAmrc13h9KHP2xvW8eufUSZnc48syO5T4/1OcEY=;
        b=XRaVFZkOiAM6ult8YzgVA5fNrfccydNR3klumndZAxY8Xr1h/xdtjnGh06NlIyq/rOWEzd
        /qDhWM9I3jjyw/G/7OVhZMIkmEW7j4dc4P2T8XFUDYtysyFBS7vDJNsE5p+/oCVZajn0D0
        dt4DifBBVWbkiyJwX5xieAJkcs2ZcP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637219952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5kFgAmrc13h9KHP2xvW8eufUSZnc48syO5T4/1OcEY=;
        b=mY9xMP7idQGgozN/55Av4Gi93XHcoQfnPHvBYgW2AgJBeYq31uu5XgVrfXfrqpGzCh378I
        k+8SKmg239O/woCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2CB06A3B84;
        Thu, 18 Nov 2021 07:19:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/4] tty: clean up whitespace in __do_SAK()
Date:   Thu, 18 Nov 2021 08:19:10 +0100
Message-Id: <20211118071911.12059-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118071911.12059-1-jslaby@suse.cz>
References: <20211118071911.12059-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Remove spaces before the 'i' variable declaration and wrap parameters of
group_send_sig_info().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 8e653bb4d7c7..99cad1560876 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3030,7 +3030,7 @@ void __do_SAK(struct tty_struct *tty)
 {
 	struct task_struct *g, *p;
 	struct pid *session;
-	int		i;
+	int i;
 	unsigned long flags;
 
 	spin_lock_irqsave(&tty->ctrl.lock, flags);
@@ -3054,7 +3054,8 @@ void __do_SAK(struct tty_struct *tty)
 		if (p->signal->tty == tty) {
 			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
 				   task_pid_nr(p), p->comm);
-			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
+			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p,
+					PIDTYPE_SID);
 			continue;
 		}
 		task_lock(p);
@@ -3062,7 +3063,8 @@ void __do_SAK(struct tty_struct *tty)
 		if (i != 0) {
 			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
 				   task_pid_nr(p), p->comm, i - 1);
-			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
+			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p,
+					PIDTYPE_SID);
 		}
 		task_unlock(p);
 	} while_each_thread(g, p);
-- 
2.33.1

