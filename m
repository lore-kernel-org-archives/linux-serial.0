Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CD0C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E10611C0
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbhDGJwr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237061AbhDGJwi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2C49613B8;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=IgBa8dYaN5jkJy/C8Lgpw5iZd6wr56gfI75KoDel5YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MH1204XjOiqVwJlf4vI5PVxxJpFhRp6qXvHnWlYO2gAM3R3c0IiXiGDZDF+jNGDc/
         ste6e6a2eABcDtnXdrpcuHdyXKT1Yd0wqaP5FSmNFU7p3ac/+sZ7+1TwoJwBTMN1/A
         JG90R7kgkmD8AjHD0thoX5IsYZuw3729B4b1VY5cOT9cVl0q8Zf2C7YMWfZIDmJn1q
         E+mgehfy7q2cHKWY9YsQlLhT9gW5Mjg0NhUEMhJFyOxsa3Lf1idmpp3LEG2xDqAoXX
         qnBMbCq8feV4JEWlBAEgeEt3nnyOM1PyZCfMvin1iSKkdCqx6z3pDj6mcYKNspObWh
         +YNDDnioPr+HQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rE-0008Ia-5b; Wed, 07 Apr 2021 11:52:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/8] tty: refactor TIOCSSERIAL handling
Date:   Wed,  7 Apr 2021 11:52:05 +0200
Message-Id: <20210407095208.31838-6-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407095208.31838-1-johan@kernel.org>
References: <20210407095208.31838-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Factor out the deprecated serial flags handling and tty-operation check
shared with the compat TIOCSSERIAL handler.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_io.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index e00efd299abd..36e6b28fb80d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2624,23 +2624,31 @@ static int tty_tiocgicount(struct tty_struct *tty, void __user *arg)
 	return 0;
 }
 
-static int tty_tiocsserial(struct tty_struct *tty, struct serial_struct __user *ss)
+static int tty_set_serial(struct tty_struct *tty, struct serial_struct *ss)
 {
 	char comm[TASK_COMM_LEN];
-	struct serial_struct v;
 	int flags;
 
-	if (copy_from_user(&v, ss, sizeof(*ss)))
-		return -EFAULT;
-
-	flags = v.flags & ASYNC_DEPRECATED;
+	flags = ss->flags & ASYNC_DEPRECATED;
 
 	if (flags)
 		pr_warn_ratelimited("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
 				__func__, get_task_comm(comm, current), flags);
+
 	if (!tty->ops->set_serial)
 		return -ENOTTY;
-	return tty->ops->set_serial(tty, &v);
+
+	return tty->ops->set_serial(tty, ss);
+}
+
+static int tty_tiocsserial(struct tty_struct *tty, struct serial_struct __user *ss)
+{
+	struct serial_struct v;
+
+	if (copy_from_user(&v, ss, sizeof(*ss)))
+		return -EFAULT;
+
+	return tty_set_serial(tty, &v);
 }
 
 static int tty_tiocgserial(struct tty_struct *tty, struct serial_struct __user *ss)
@@ -2838,10 +2846,8 @@ struct serial_struct32 {
 static int compat_tty_tiocsserial(struct tty_struct *tty,
 		struct serial_struct32 __user *ss)
 {
-	char comm[TASK_COMM_LEN];
 	struct serial_struct32 v32;
 	struct serial_struct v;
-	int flags;
 
 	if (copy_from_user(&v32, ss, sizeof(*ss)))
 		return -EFAULT;
@@ -2852,14 +2858,7 @@ static int compat_tty_tiocsserial(struct tty_struct *tty,
 	v.port_high = v32.port_high;
 	v.iomap_base = 0;
 
-	flags = v.flags & ASYNC_DEPRECATED;
-
-	if (flags)
-		pr_warn_ratelimited("%s: '%s' is using deprecated serial flags (with no effect): %.8x\n",
-				__func__, get_task_comm(comm, current), flags);
-	if (!tty->ops->set_serial)
-		return -ENOTTY;
-	return tty->ops->set_serial(tty, &v);
+	return tty_set_serial(tty, &v);
 }
 
 static int compat_tty_tiocgserial(struct tty_struct *tty,
-- 
2.26.3

