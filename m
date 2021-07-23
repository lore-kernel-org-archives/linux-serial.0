Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F29C432BE
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D381E60E91
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhGWJvP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55588 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhGWJvP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 111AA22643;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlGuP3MmpXdR0dqFHucfih0ppa44KlBB5tHq5tZ3i6Y=;
        b=E2EDJ5JED4mjN+u557FjyeAZChLdJn8e31MAvbTSv9dRaZ7bhHzy7ymSVk034fA55Qaho4
        yNnnWi5Y8q0p1TlzZ9cZhC6hOnns0//QnLwRMlOeCCaqM0fKFAdpkiY1+4DDdo4tj0E3dv
        zdOgtxSbaQQz5RqKwyqn9olLKfL4+pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nlGuP3MmpXdR0dqFHucfih0ppa44KlBB5tHq5tZ3i6Y=;
        b=dfFbQN5d1J5FH+3mhUG2YNKzYl45xn8v+NcIpylEhwWHkpI2v4Rpkbo1pa8M9nXTZ0OMGr
        cSqYE1tIWhcjC+DA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E9865A3B9F;
        Fri, 23 Jul 2021 10:31:47 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/8] tty: include kref.h in tty_driver.h
Date:   Fri, 23 Jul 2021 12:31:41 +0200
Message-Id: <20210723103147.18250-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We use kref in tty_driver.h, but do not include kref.h. It is currently
included by linux/cdev.h -> linux/kobject.h -> linux/kref.h chain, so
everything is in order only implicitly. So make this dependency
explicit.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_driver.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index e15f8635aa36..a798e7f8890a 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -233,6 +233,7 @@
 
 #include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/cdev.h>
 #include <linux/termios.h>
-- 
2.32.0

