Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271B3C4320A
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 117E160F45
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhGWHCu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:02:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55420 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhGWHCr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:02:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7FCE6225F9;
        Fri, 23 Jul 2021 07:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627026200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cIEi2isQm2jMxTVsxhNhXIEo6JubJYloVdowmH38ZI=;
        b=jiV+wpGxtLb6LAJHWfKs6gaDnfj0aE2Am+6UEdaY5KcVQ26Q3IQjs4hJt99S1k7AsyYVe1
        EzhgEP8Ly2+Wa563SsO1E696XOJTTA0Za9R9r4SI7rieVIYwuiCpS184oceOYVDd0uB+vi
        olp3MN2pS5T82lCvQMdMsVUTDHY4vtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627026200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7cIEi2isQm2jMxTVsxhNhXIEo6JubJYloVdowmH38ZI=;
        b=bTXYvaIJkJCWG/n1miyz8gKoyJ23ncfSXFCcuXA34tz3JTAyQIxs0rR94+0fTl2rOsG9aj
        19W1DEq0N9sL88AA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6595BA3B93;
        Fri, 23 Jul 2021 07:43:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 5/8] tty: drop alloc_tty_driver
Date:   Fri, 23 Jul 2021 09:43:14 +0200
Message-Id: <20210723074317.32690-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723074317.32690-1-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Noone uses this deprecated function now. So we can remove it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_driver.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index a798e7f8890a..c7746dee58a6 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -340,18 +340,6 @@ extern void tty_driver_kref_put(struct tty_driver *driver);
 #define tty_alloc_driver(lines, flags) \
 		__tty_alloc_driver(lines, THIS_MODULE, flags)
 
-/*
- * DEPRECATED Do not use this in new code, use tty_alloc_driver instead.
- * (And change the return value checks.)
- */
-static inline struct tty_driver *alloc_tty_driver(unsigned int lines)
-{
-	struct tty_driver *ret = tty_alloc_driver(lines, 0);
-	if (IS_ERR(ret))
-		return NULL;
-	return ret;
-}
-
 static inline struct tty_driver *tty_driver_kref_get(struct tty_driver *d)
 {
 	kref_get(&d->kref);
-- 
2.32.0

