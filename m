Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7576BCD54AB
	for <linux-serial@archiver.kernel.org>; Tue, 19 Sep 2023 08:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjISIx0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Sep 2023 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjISIwn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D26102;
        Tue, 19 Sep 2023 01:52:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B557C433C8;
        Tue, 19 Sep 2023 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113540;
        bh=DHSUENlyJd4uiUZGKQE8nkqG9haGv3P+QdL7CmU1Hf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQn08LAlbbz6RAgVL829tUjtjxoeZzG+Lm2yVb1SKAWDqex4ewLDs9jHvVcIgAvai
         1cSpctU0XnIcwe2Ait94+n/9AVqmkLDh33EsLGJrXwxzWuDGxgtb3/L3mkFWI1OFPC
         VWU1KisqRD9ycP3D8G/HD+FXNcH8ozkTqMM5YBN/asOz7cOtwHIoiNfMmHKhqk4CY5
         IuKEbjLBjtILUuU+KWNfqduu1F44MweAupMkNnJ+9ZhcKgkUXijkjKkyk1DsHclNuI
         lbTmkiO07wnH5+9nrFU8rGWixSvKflIzn4bux8W6CKqV+D6arvV0pqpnESUuNs0eF3
         6PJM5Pd7mo2Lg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 14/15] tty: don't check for signal_pending() in send_break()
Date:   Tue, 19 Sep 2023 10:51:55 +0200
Message-ID: <20230919085156.1578-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
References: <20230919085156.1578-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

msleep_interruptible() will check on its own. So no need to do the check
in send_break() before calling the above.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 87bb5094e0bb..24833b31b81c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2484,8 +2484,7 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 	retval = tty->ops->break_ctl(tty, -1);
 	if (retval)
 		goto out;
-	if (!signal_pending(current))
-		msleep_interruptible(duration);
+	msleep_interruptible(duration);
 	retval = tty->ops->break_ctl(tty, 0);
 out:
 	tty_write_unlock(tty);
-- 
2.42.0

