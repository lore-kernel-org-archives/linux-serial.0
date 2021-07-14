Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A674FC11F67
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F6C61396
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhGNJQK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57872 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbhGNJQI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A2D0020279;
        Wed, 14 Jul 2021 09:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4M+qX9cSLk1l4S8eJFVK2aqiBTbmVS4Y3AlM1bztRFE=;
        b=fnXRzyvSWiEmQFqGghbJ41+Y+EytqxM550DFafwmjBXHnZkvQJ/ISwDNWdejXo6scSnG4g
        nHhIpKtGBSKVy8mdeC+D0zejLVbn7tDVYfXyhKM5D4bfHHOMFIS7THRrN3hBjNDDtLWQYn
        0kJa5mM8mbtY3c9GV/yUcP8SjUYSs9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4M+qX9cSLk1l4S8eJFVK2aqiBTbmVS4Y3AlM1bztRFE=;
        b=AKtBJchcCJA/+5SFJYukn+znraXbKE1+6afA6qS39d1IMm9UW+MmzVefN1G8B6M6OFyEem
        X1DsrqL2SnGzh4Dg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 63EB2A3B8A;
        Wed, 14 Jul 2021 09:13:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 01/11] amiserial: remove unused DBG_CNT
Date:   Wed, 14 Jul 2021 11:13:04 +0200
Message-Id: <20210714091314.8292-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The ugly DBG_CNT macro is unused, so remove.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 5ec19c48fb7a..08987c438408 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -31,15 +31,6 @@
 #undef SERIAL_DEBUG_FLOW
 #undef SERIAL_DEBUG_RS_WAIT_UNTIL_SENT
 
-/* Sanity checks */
-
-#if defined(MODULE) && defined(SERIAL_DEBUG_MCOUNT)
-#define DBG_CNT(s) printk("(%s): [%x] refc=%d, serc=%d, ttyc=%d -> %s\n", \
- tty->name, (info->tport.flags), serial_driver->refcount,info->count,tty->count,s)
-#else
-#define DBG_CNT(s)
-#endif
-
 /*
  * End of serial driver configuration section.
  */
-- 
2.32.0

