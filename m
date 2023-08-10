Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C1DC04FDF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 09:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjHJJPy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjHJJP3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2FB2708;
        Thu, 10 Aug 2023 02:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 975EA612F0;
        Thu, 10 Aug 2023 09:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5A6C433CA;
        Thu, 10 Aug 2023 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658928;
        bh=K6YO7sVv0MXgVvyircKmSovZ078//2lSihqsxTv3b5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWS/IPA6zqXrYy7DyfgbP/FmvLzOl92e+lkEn4kzAIKh0UXCKqCt1yOT5KB66jmlC
         eP4geP49vC2JmeSKMCanpf3lIDw0mdV2zNyk4Q/ZaGBW6v+qCgyrQkR1UdXi2BGdkY
         quMLjwS74SFnLdJ4jWSX3Sb1E7MHsXXnBgUxlCTQVpIe7pLWsd1KSFZYCcIwYF+d2v
         lRVnQ5C7j9ekZ4912qCrtSO3gL7MSBEiv5He6FHBHWGhjmR53kebVwAor8owG6Qp/B
         Q97YO7/ig7yts82RoeeHzSCN4kGxBMhVAPnV53kmsnK9f7KF6ElQp90BOzWTWu+HjF
         Kuz2rXPCBt70g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/36] tty: make tty_change_softcar() more understandable
Date:   Thu, 10 Aug 2023 11:14:42 +0200
Message-ID: <20230810091510.13006-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* rename 'arg' to 'enable' as that is what it means.
* make 'bit' a tcflag_t, not int, as that is what cflags are.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index f63e8b1b9e40..7958bf6d27c4 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -737,17 +737,17 @@ static int set_ltchars(struct tty_struct *tty, struct ltchars __user *ltchars)
 /**
  *	tty_change_softcar	-	carrier change ioctl helper
  *	@tty: tty to update
- *	@arg: enable/disable CLOCAL
+ *	@enable: enable/disable CLOCAL
  *
  *	Perform a change to the CLOCAL state and call into the driver
  *	layer to make it visible. All done with the termios rwsem
  */
 
-static int tty_change_softcar(struct tty_struct *tty, int arg)
+static int tty_change_softcar(struct tty_struct *tty, bool enable)
 {
 	int ret = 0;
-	int bit = arg ? CLOCAL : 0;
 	struct ktermios old;
+	tcflag_t bit = enable ? CLOCAL : 0;
 
 	down_write(&tty->termios_rwsem);
 	old = tty->termios;
-- 
2.41.0

