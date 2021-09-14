Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACCBC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A486E60295
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhINJM6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:12:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43314 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhINJMy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:12:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F338200E0;
        Tue, 14 Sep 2021 09:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+eDAVcK/wYcv9BVgAvQDXyn91WVx/j7lKfny9JvPug=;
        b=JrZo4Du8EpRuoMd+9AKewDxaR8EzF/HT8EN4Kwtxiy07n7924gDq2V8hR3tEoJXcaBtZtO
        fC8t4G5+LFRqS0++mscKmqzupBgvFXhFpwhuxpUEvXlmfT1PXlm+ZnBbUc0Rx76cIMsjQX
        x6Xqiq4T99uL7Gjm3YT+jm0LSjpLa64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+eDAVcK/wYcv9BVgAvQDXyn91WVx/j7lKfny9JvPug=;
        b=VLMBcG0NjAUronUzkB9uGW0pmX8w0CwJKiPvHqLEjBGDGxolOSJ76P/Hc33to6KzHDfnwf
        mnp20bkCR9S1YUBw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2BBDAA3B8E;
        Tue, 14 Sep 2021 09:11:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andreas Koensgen <ajk@comnets.uni-bremen.de>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 05/16] tty: remove file from tty_mode_ioctl
Date:   Tue, 14 Sep 2021 11:11:23 +0200
Message-Id: <20210914091134.17426-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091134.17426-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The only user of 'file' parameter in tty_mode_ioctl is a BUG_ON check.
Provided it never crashed for anyone, it's an overkill to pass the
parameter to tty_mode_ioctl only for this check.

If we wanted to check 'file' there, we should handle it in more graceful
way anyway. Not by a BUG == crash.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
Cc: Paul Mackerras <paulus@samba.org>
---
 drivers/net/can/slcan.c       | 2 +-
 drivers/net/hamradio/6pack.c  | 2 +-
 drivers/net/ppp/ppp_async.c   | 2 +-
 drivers/net/ppp/ppp_synctty.c | 2 +-
 drivers/net/slip/slip.c       | 2 +-
 drivers/tty/tty_ioctl.c       | 8 ++------
 include/linux/tty.h           | 3 +--
 7 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 012da4b8abe0..9a4ebda30510 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -691,7 +691,7 @@ static int slcan_ioctl(struct tty_struct *tty, struct file *file,
 		return -EINVAL;
 
 	default:
-		return tty_mode_ioctl(tty, file, cmd, arg);
+		return tty_mode_ioctl(tty, cmd, arg);
 	}
 }
 
diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 8fe8887d506a..05404f7a3204 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -732,7 +732,7 @@ static int sixpack_ioctl(struct tty_struct *tty, struct file *file,
 			break;
 		}
 	default:
-		err = tty_mode_ioctl(tty, file, cmd, arg);
+		err = tty_mode_ioctl(tty, cmd, arg);
 	}
 
 	sp_put(sp);
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 78ec1bcebc4f..6492523fc234 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -322,7 +322,7 @@ ppp_asynctty_ioctl(struct tty_struct *tty, struct file *file,
 
 	default:
 		/* Try the various mode ioctls */
-		err = tty_mode_ioctl(tty, file, cmd, arg);
+		err = tty_mode_ioctl(tty, cmd, arg);
 	}
 
 	ap_put(ap);
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index c249db7c466a..ebbfea0e1140 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -314,7 +314,7 @@ ppp_synctty_ioctl(struct tty_struct *tty, struct file *file,
 		break;
 
 	default:
-		err = tty_mode_ioctl(tty, file, cmd, arg);
+		err = tty_mode_ioctl(tty, cmd, arg);
 		break;
 	}
 
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 8be9d0c351b5..9f3b4c1aa5ce 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -1173,7 +1173,7 @@ static int slip_ioctl(struct tty_struct *tty, struct file *file,
 	/* VSV changes end */
 #endif
 	default:
-		return tty_mode_ioctl(tty, file, cmd, arg);
+		return tty_mode_ioctl(tty, cmd, arg);
 	}
 }
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 507a25d692bb..99a29d72d294 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -675,7 +675,6 @@ static int tty_change_softcar(struct tty_struct *tty, int arg)
 /**
  *	tty_mode_ioctl		-	mode related ioctls
  *	@tty: tty for the ioctl
- *	@file: file pointer for the tty
  *	@cmd: command
  *	@arg: ioctl argument
  *
@@ -684,16 +683,13 @@ static int tty_change_softcar(struct tty_struct *tty, int arg)
  *	consistent mode setting.
  */
 
-int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
-			unsigned int cmd, unsigned long arg)
+int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 {
 	struct tty_struct *real_tty;
 	void __user *p = (void __user *)arg;
 	int ret = 0;
 	struct ktermios kterm;
 
-	BUG_ON(file == NULL);
-
 	if (tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 	    tty->driver->subtype == PTY_TYPE_MASTER)
 		real_tty = tty->link;
@@ -904,7 +900,7 @@ int n_tty_ioctl_helper(struct tty_struct *tty, struct file *file,
 		return __tty_perform_flush(tty, arg);
 	default:
 		/* Try the mode commands */
-		return tty_mode_ioctl(tty, file, cmd, arg);
+		return tty_mode_ioctl(tty, cmd, arg);
 	}
 }
 EXPORT_SYMBOL(n_tty_ioctl_helper);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 15453b0c4081..5e73f577c2b4 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -369,8 +369,7 @@ int tty_set_termios(struct tty_struct *tty, struct ktermios *kt);
 
 void tty_wakeup(struct tty_struct *tty);
 
-int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
-			unsigned int cmd, unsigned long arg);
+int tty_mode_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg);
 int tty_perform_flush(struct tty_struct *tty, unsigned long arg);
 struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 void tty_release_struct(struct tty_struct *tty, int idx);
-- 
2.33.0

