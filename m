Return-Path: <SRS0=gv8u=3T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A0C33C9E
	for <linux-serial@archiver.kernel.org>; Thu, 30 Jan 2020 11:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CFF2082E
	for <linux-serial@archiver.kernel.org>; Thu, 30 Jan 2020 11:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgA3L6q (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:58:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:54932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgA3L6q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Jan 2020 06:58:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D1A98B028;
        Thu, 30 Jan 2020 11:58:44 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] n_tty: check printk arguments for n_tty_trace
Date:   Thu, 30 Jan 2020 12:58:43 +0100
Message-Id: <20200130115843.7452-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When N_TTY_TRACE is undefined (the default), define n_tty_trace to use
no_printk. That way, arguments are still checked during compilation.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f9c584244f72..640fdd1e4c1d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -84,7 +84,7 @@
 #ifdef N_TTY_TRACE
 # define n_tty_trace(f, args...)	trace_printk(f, ##args)
 #else
-# define n_tty_trace(f, args...)
+# define n_tty_trace(f, args...)	no_printk(f, ##args)
 #endif
 
 struct n_tty_data {
-- 
2.25.0

