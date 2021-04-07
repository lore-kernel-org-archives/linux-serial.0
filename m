Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D001FC43461
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982B8610F9
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238413AbhDGJwu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350328AbhDGJwi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B52B3613C0;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=htsE9psDyAopAgk5SadKKKzdBmf+5z0IORwtCSmi050=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgRr9j+7Bgmvl7RE1qnbySifGNasUNWN8Tmb8qO6US/t/mcaf1Eh4toiH39Phj/nz
         +qJHt99g6+79o0XB9YFk5qhDZ4GqGWNZxSquCULbBf7SZuB74IjUA33BWJU+TXrz7O
         ++lE54w9f58+rsHUTgGKfD0bdg6+5Nkb+oS+k7GvKj5IfBFikoE2ttnMDPdz+OUkut
         VaJd/b75lDM3dfppgsCwGE0/fkWpOyoXqbpRZik/g1G94tBLQFTKRAHdjmhN40WoNe
         XaR6AUZMM30ywWVf8WzKremzdyGhDQsBATTfFDRQXyNHxECzeG/BC13l+mkEgZT2xf
         48bQRKgynwXVA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rD-0008IR-TC; Wed, 07 Apr 2021 11:52:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/8] tty: fix return value for unsupported ioctls
Date:   Wed,  7 Apr 2021 11:52:02 +0200
Message-Id: <20210407095208.31838-3-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407095208.31838-1-johan@kernel.org>
References: <20210407095208.31838-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Drivers should return -ENOTTY ("Inappropriate I/O control operation")
when an ioctl isn't supported, while -EINVAL is used for invalid
arguments.

Fix up the TIOCMGET, TIOCMSET and TIOCGICOUNT helpers which returned
-EINVAL when a tty driver did not implement the corresponding
operations.

Note that the TIOCMGET and TIOCMSET helpers predate git and do not get a
corresponding Fixes tag below.

Fixes: d281da7ff6f7 ("tty: Make tiocgicount a handler")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_io.c       | 10 +++++-----
 include/linux/tty_driver.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ebcde1f96adb..7738514a15fe 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2529,14 +2529,14 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
  *	@p: pointer to result
  *
  *	Obtain the modem status bits from the tty driver if the feature
- *	is supported. Return -EINVAL if it is not available.
+ *	is supported. Return -ENOTTY if it is not available.
  *
  *	Locking: none (up to the driver)
  */
 
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 {
-	int retval = -EINVAL;
+	int retval = -ENOTTY;
 
 	if (tty->ops->tiocmget) {
 		retval = tty->ops->tiocmget(tty);
@@ -2554,7 +2554,7 @@ static int tty_tiocmget(struct tty_struct *tty, int __user *p)
  *	@p: pointer to desired bits
  *
  *	Set the modem status bits from the tty driver if the feature
- *	is supported. Return -EINVAL if it is not available.
+ *	is supported. Return -ENOTTY if it is not available.
  *
  *	Locking: none (up to the driver)
  */
@@ -2566,7 +2566,7 @@ static int tty_tiocmset(struct tty_struct *tty, unsigned int cmd,
 	unsigned int set, clear, val;
 
 	if (tty->ops->tiocmset == NULL)
-		return -EINVAL;
+		return -ENOTTY;
 
 	retval = get_user(val, p);
 	if (retval)
@@ -2606,7 +2606,7 @@ int tty_get_icount(struct tty_struct *tty,
 	if (tty->ops->get_icount)
 		return tty->ops->get_icount(tty, icount);
 	else
-		return -EINVAL;
+		return -ENOTTY;
 }
 EXPORT_SYMBOL_GPL(tty_get_icount);
 
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 61c3372d3f32..2f719b471d52 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -228,7 +228,7 @@
  *
  *	Called when the device receives a TIOCGICOUNT ioctl. Passed a kernel
  *	structure to complete. This method is optional and will only be called
- *	if provided (otherwise EINVAL will be returned).
+ *	if provided (otherwise ENOTTY will be returned).
  */
 
 #include <linux/export.h>
-- 
2.26.3

