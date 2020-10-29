Return-Path: <SRS0=FKk9=EE=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A24EC55178
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B9020719
	for <linux-serial@archiver.kernel.org>; Thu, 29 Oct 2020 11:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgJ2Ldk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Oct 2020 07:33:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:57048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgJ2LcZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Oct 2020 07:32:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 940C7B20E;
        Thu, 29 Oct 2020 11:32:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/17] vt: keyboard, sort key types by their number
Date:   Thu, 29 Oct 2020 12:32:09 +0100
Message-Id: <20201029113222.32640-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201029113222.32640-1-jslaby@suse.cz>
References: <20201029113222.32640-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

KT_LETTER was numerically missorted. So sort all KT_* entries.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/uapi/linux/keyboard.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/keyboard.h b/include/uapi/linux/keyboard.h
index 4846716e7c5c..36d230cedf12 100644
--- a/include/uapi/linux/keyboard.h
+++ b/include/uapi/linux/keyboard.h
@@ -27,7 +27,6 @@
 #define MAX_NR_FUNC	256	/* max nr of strings assigned to keys */
 
 #define KT_LATIN	0	/* we depend on this being zero */
-#define KT_LETTER	11	/* symbol that can be acted upon by CapsLock */
 #define KT_FN		1
 #define KT_SPEC		2
 #define KT_PAD		3
@@ -38,6 +37,7 @@
 #define KT_META		8
 #define KT_ASCII	9
 #define KT_LOCK		10
+#define KT_LETTER	11	/* symbol that can be acted upon by CapsLock */
 #define KT_SLOCK	12
 #define KT_DEAD2	13
 #define KT_BRL		14
-- 
2.29.1

