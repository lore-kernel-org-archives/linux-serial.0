Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2207C433B4
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74849613A0
	for <linux-serial@archiver.kernel.org>; Wed,  7 Apr 2021 09:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350344AbhDGJwo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 7 Apr 2021 05:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350322AbhDGJwh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Apr 2021 05:52:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB967613A7;
        Wed,  7 Apr 2021 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617789147;
        bh=+1jxiKQ2Q4L9ndWwyEg8xyNIvSMH3iSiEPyYdtL1cwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pjX1ityVfqCk7lHz+FyOxEBtN4CWfTF448w8CTP5aK6Q2aLdu5/o1yujUfVlsLSM9
         WVh9P0v1B4HCNdPy6TKxuxId7Sdh9ZDzQxPXdcyxUbzB4lsfYof1LmNrV1V9lDPztJ
         8H4Fn/7HvOZG9pOSBl3r4vIYaQPJoeLBviOY5DcwSIJUQxkErz8yVIYeUbk3GsvPBk
         Fa+OCEjZWUEnEC2HvCecFoDi6SVdWyKRwN7kpxAa2L/qYXAGu3eOTbziP9pefF2hJ4
         I6GnpV2m/pqHdr27Kb6Bv5go7yem8QaEK9SR0S4CInXmsLlgp87KDwzGJCteYmL7vv
         c7ASa/eeICZOA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lU4rE-0008Id-86; Wed, 07 Apr 2021 11:52:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/8] tty: add ASYNC_SPLIT_TERMIOS to deprecation mask
Date:   Wed,  7 Apr 2021 11:52:06 +0200
Message-Id: <20210407095208.31838-7-johan@kernel.org>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210407095208.31838-1-johan@kernel.org>
References: <20210407095208.31838-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Callout devices are long-gone, but the ASYNC_SPLIT_TERMIOS flag was
never added to the deprecation mask.

Add it so that a warning is printed if it is ever used.

Fixes: 8a8ae62f8296 ("tty: warn on deprecated serial flags")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/uapi/linux/tty_flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tty_flags.h b/include/uapi/linux/tty_flags.h
index 6a3ac496a56c..cf25056d4b27 100644
--- a/include/uapi/linux/tty_flags.h
+++ b/include/uapi/linux/tty_flags.h
@@ -73,8 +73,8 @@
 #define ASYNC_MAGIC_MULTIPLIER	(1U << ASYNCB_MAGIC_MULTIPLIER)
 
 #define ASYNC_FLAGS		((1U << (ASYNCB_LAST_USER + 1)) - 1)
-#define ASYNC_DEPRECATED	(ASYNC_SESSION_LOCKOUT | ASYNC_PGRP_LOCKOUT | \
-		ASYNC_CALLOUT_NOHUP | ASYNC_AUTOPROBE)
+#define ASYNC_DEPRECATED	(ASYNC_SPLIT_TERMIOS | ASYNC_SESSION_LOCKOUT | \
+		ASYNC_PGRP_LOCKOUT | ASYNC_CALLOUT_NOHUP | ASYNC_AUTOPROBE)
 #define ASYNC_USR_MASK		(ASYNC_SPD_MASK|ASYNC_CALLOUT_NOHUP| \
 		ASYNC_LOW_LATENCY)
 #define ASYNC_SPD_CUST		(ASYNC_SPD_HI|ASYNC_SPD_VHI)
-- 
2.26.3

