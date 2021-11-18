Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA86C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 736A761875
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243831AbhKRHeq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:34:46 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52168 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243858AbhKRHe3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:34:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ED7FC1FD35;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637220688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQfPNCvMsV45lTVux6ZWYFbItH2EDYay7/F/1O6/mYQ=;
        b=I8ZZIypKElViC34h8agyjYcqNLgkVqW5rDD5rcDVH5OZ7Mymis4/pL+4D9nQbEdPNoXGwW
        4rD6XYuQZY37P+LLGALqCfMLXGSsl7G5R7SCnKlDlnrplFTxtT2bJ/5V/Ws6lltZFyDcHH
        qoSZj/XmppqA9jsRAREVz7g6YQmxjh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637220688;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQfPNCvMsV45lTVux6ZWYFbItH2EDYay7/F/1O6/mYQ=;
        b=CSLr1VAFAkI8XBYeDPxyVSbd2obhS8IK1IPjyEgoQqdjbMEQnqajhEmel1Nhu3Hji7N4Ce
        jPy0JqaDuDx6cHBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C61F3A3B83;
        Thu, 18 Nov 2021 07:31:28 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 12/19] mxser: use msleep_interruptible() in mxser_wait_until_sent()
Date:   Thu, 18 Nov 2021 08:31:18 +0100
Message-Id: <20211118073125.12283-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118073125.12283-1-jslaby@suse.cz>
References: <20211118073125.12283-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Instead of schedule_timeout_interruptible(), because:
1) we don't have to bother with the task state, and
2) msleep* guarantees to sleep that time (if not interrupted).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index fb26670b5a0b..b3ae3b105af0 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1443,6 +1443,9 @@ static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 		char_time = 1;
 	if (timeout && timeout < char_time)
 		char_time = timeout;
+
+	char_time = jiffies_to_msecs(char_time);
+
 	/*
 	 * If the transmitter hasn't cleared in twice the approximate
 	 * amount of time to send the entire FIFO, it probably won't
@@ -1456,13 +1459,12 @@ static void mxser_wait_until_sent(struct tty_struct *tty, int timeout)
 		timeout = 2 * info->timeout;
 
 	while (mxser_tx_empty(info)) {
-		schedule_timeout_interruptible(char_time);
+		msleep_interruptible(char_time);
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
 			break;
 	}
-	set_current_state(TASK_RUNNING);
 }
 
 /*
-- 
2.33.1

