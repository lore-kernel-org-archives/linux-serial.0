Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1790AC001E0
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jul 2023 09:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjGaJAN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jul 2023 05:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGaJAL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jul 2023 05:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024AEE9;
        Mon, 31 Jul 2023 02:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AF3760DFF;
        Mon, 31 Jul 2023 09:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30F3C433CC;
        Mon, 31 Jul 2023 09:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690794009;
        bh=Q8cO9OqlmUpHgysSy3lZuv3L9XFPNu27/Az5bHOtWnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEWZ7h0PajWZhY2EA136xYaMzlkL6izi0Hb/xdWCOs6b6p1hmjqsC1ntIglf7/U4s
         9nOm5UCnHStSEayQLC0/Vd1I84cqyIhnNuzJNsf/m+rKLo7aIiJ6jQ1orOMdu/ZlMm
         TAE7zAS+FMNbt+EQarpPerH+C67YVtN/aTuxej6BDLk53wr5IdozWl3UZs/0Y8J4hZ
         d5haD6pG7iUxs82UpwIw0uq9ravWPDwE4fW1NiOv6erIeqK/+6V3UgT2D/1SQijDSr
         4u6a9ZI7uRCIBlwAOZnpxzc5vs6zNgPH4NUTYAzrh5vFDojIhPFHAu2sxjRv3/WP2b
         yk06RiIIcUM3g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/7] tty: synclink_gt: define global strings as const strings
Date:   Mon, 31 Jul 2023 10:59:58 +0200
Message-ID: <20230731090002.15680-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731090002.15680-1-jirislaby@kernel.org>
References: <20230731090002.15680-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

And not non-const pointers to strings.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/synclink_gt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index c2ab7ecf0900..a8716a81ac74 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -87,8 +87,8 @@
 /*
  * module identification
  */
-static char *driver_name     = "SyncLink GT";
-static char *tty_dev_prefix  = "ttySLG";
+static const char driver_name[] = "SyncLink GT";
+static const char tty_dev_prefix[] = "ttySLG";
 MODULE_LICENSE("GPL");
 #define MAX_DEVICES 32
 
-- 
2.41.0

