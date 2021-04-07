Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949CC43461
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BF6613A0
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350335AbhDGJwl (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350319AbhDGJwh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A86D4610F9;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=dhB3YFRGCnQZZsZ+E5N95bf1LTkpUAsAw9RDkY2EEo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYRgajsEvz0DP6HnsPm4ern3ZNY4RO8P+edgeDM9njQ+hbRA9YDQz/Tpuj/k9Fb/V
         IngmXtyzgCEpoLOpGpn+HSdyl1Ram87m+J0p1M1SHfklXjZlDSeC2SUnlp4xFSsnL9
         V29tXd82kKtxGiXQ7KT4XfWKq5Egcs8abWC4KAz38rU8bmjH9PnF0FgW6ZA11rkf+d
         MoOu3mFXRe3FE0RvDZHm4v2iS7uI/jZCRKoFKeUZ0gAfsbFFlWJGOZLcrXxIzSfUiO
         OJsw6Ki+NzOt7J5ViXy+7KREslACcOYuOBPPGU8sJmeY1TwcfCo2H23clZp6G9FH4a
         ss/nRrVWwOrlw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rD-0008IP-QJ; Wed, 07 Apr 2021 11:52:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/8] tty: actually undefine superseded ASYNC flags
Date:   Wed,  7 Apr 2021 11:52:01 +0200
Message-Id: <20210407095208.31838-2-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407095208.31838-1-johan@kernel.org>
References: <20210407095208.31838-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some kernel-internal ASYNC flags have been superseded by tty-port flags
and should no longer be used by kernel drivers.

Fix the misspelled "__KERNEL__" compile guards which failed their sole
purpose to break out-of-tree drivers that have not yet been updated.

Fixes: 5c0517fefc92 ("tty: core: Undefine ASYNC_* flags superceded by TTY_PORT* flags")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/uapi/linux/tty_flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 900a32e63424..6a3ac496a56c 100644
--- a/include/uapi/linux/tty_flags.h
+++ b/include/uapi/linux/tty_flags.h
@@ -39,7 +39,7 @@
  * WARNING: These flags are no longer used and have been superceded by the
  *	    TTY_PORT_ flags in the iflags field (and not userspace-visible)
  */
-#ifndef _KERNEL_
+#ifndef __KERNEL__
 #define ASYNCB_INITIALIZED	31 /* Serial port was initialized */
 #define ASYNCB_SUSPENDED	30 /* Serial port is suspended */
 #define ASYNCB_NORMAL_ACTIVE	29 /* Normal device is active */
@@ -81,7 +81,7 @@
 #define ASYNC_SPD_WARP		(ASYNC_SPD_HI|ASYNC_SPD_SHI)
 #define ASYNC_SPD_MASK		(ASYNC_SPD_HI|ASYNC_SPD_VHI|ASYNC_SPD_SHI)
 
-#ifndef _KERNEL_
+#ifndef __KERNEL__
 /* These flags are no longer used (and were always masked from userspace) */
 #define ASYNC_INITIALIZED	(1U << ASYNCB_INITIALIZED)
 #define ASYNC_NORMAL_ACTIVE	(1U << ASYNCB_NORMAL_ACTIVE)
-- 
2.26.3

