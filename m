Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E34C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9F0610F9
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350329AbhDGJwi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350318AbhDGJwh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5CF8611C0;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=daOjWLsXDDRiowT/JM9ywlK4+jNhjn2FQ+fiuXXzyno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtwmBIXtAWxoEfRRWifyZsJnijQ3vyntu/2m3NLG+0AbDvz/A29T/K3rtDXgRyQL+
         mNbpLVAz/18/3UaKBBOiTveADY0g+VRhEwqEEtAYJ7rsvy5zLXmvBVMCDFsWbAczAp
         dHVAqma5dRgzrKxCHEVJf1SqthwaaqsMnEWMqbIwOll1WSOwoMlCRuyUAkC8nuPWri
         U5Luwxz0ObBW2wriDcfIycr0y+rFa6f+us0/mh8ThSt/CRexfb9KS3Hj3pPGqaFPBr
         IVNVbhnaFZE1+U21UxiBVKv9ICQdyLrLyr2/44Azt/qGsXATomSgnBDZNXCOVZIW3I
         gLLbYmAkZNvvQ==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rD-0008IT-W4; Wed, 07 Apr 2021 11:52:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/8] tty: fix return value for unsupported termiox ioctls
Date:   Wed,  7 Apr 2021 11:52:03 +0200
Message-Id: <20210407095208.31838-4-johan@kernel.org>
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

Support for termiox was added by commit 1d65b4a088de ("tty: Add
termiox") in 2008 but no driver support ever followed and it was
recently ripped out by commit e0efb3168d34 ("tty: Remove dead termiox
code").

Fix the return value for the unsupported termiox ioctls, which have
always returned -EINVAL, by explicitly returning -ENOTTY rather than
removing them completely and falling back to the default unrecognised-
ioctl handling.

Fixes: 1d65b4a088de ("tty: Add termiox")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index deffaefcf41d..420e7678330f 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -773,8 +773,8 @@ int tty_mode_ioctl(struct tty_struct *tty, struct file *file,
 	case TCSETX:
 	case TCSETXW:
 	case TCSETXF:
-		return -EINVAL;
-#endif		
+		return -ENOTTY;
+#endif
 	case TIOCGSOFTCAR:
 		copy_termios(real_tty, &kterm);
 		ret = put_user((kterm.c_cflag & CLOCAL) ? 1 : 0,
-- 
2.26.3

