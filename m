Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDD5C49EA5
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9745E6120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhFRGTU (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59874 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbhFRGSQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:18:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D34BA21B74;
        Fri, 18 Jun 2021 06:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoskkITiw49w3uZEefKbBo96jqnzZoI9tXr0fMMFiLQ=;
        b=wWPTurKxxnrz4+iEHARlmL56iWTviiV30kmhhy4ZbyGqaBgiCQzM8R+nA5AMmJZPMmcQXx
        Gy4CcQSWdCXCNhsCGSXhKqadpA+BUohvj1IrUkMWlmcdMSTN18X8ZBqbx2TIXflR3nS2lH
        jpRaTmJ44fFdREmCpCsPJjM8sUCw2Zc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IoskkITiw49w3uZEefKbBo96jqnzZoI9tXr0fMMFiLQ=;
        b=YonQeFepMZPVSZCzTKvcj8QMuwirRZLOwZ8djjgBviTlwgNpT/vBBcOb/PEtQ26Ol0EAmX
        NB5arb2MfT1sR1BA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9F50FA3BA3;
        Fri, 18 Jun 2021 06:15:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 64/70] mxser: use port variable in mxser_set_serial_info
Date:   Fri, 18 Jun 2021 08:15:10 +0200
Message-Id: <20210618061516.662-65-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_set_serial_info already defined a local 'port' of type struct
tty_port. So use it in the code everywhere.

This eliminates some text from the code there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 5dd121450813..2f724b4d3f43 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1080,14 +1080,14 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 
 	if (!capable(CAP_SYS_ADMIN)) {
 		if ((ss->baud_base != MXSER_BAUD_BASE) ||
-				(close_delay != info->port.close_delay) ||
-				(closing_wait != info->port.closing_wait) ||
-				((ss->flags & ~ASYNC_USR_MASK) != (info->port.flags & ~ASYNC_USR_MASK))) {
+				(close_delay != port->close_delay) ||
+				(closing_wait != port->closing_wait) ||
+				((ss->flags & ~ASYNC_USR_MASK) != (port->flags & ~ASYNC_USR_MASK))) {
 			mutex_unlock(&port->mutex);
 			return -EPERM;
 		}
-		info->port.flags = ((info->port.flags & ~ASYNC_USR_MASK) |
-				(ss->flags & ASYNC_USR_MASK));
+		port->flags = (port->flags & ~ASYNC_USR_MASK) |
+				(ss->flags & ASYNC_USR_MASK);
 	} else {
 		/*
 		 * OK, past this point, all the error checking has been done.
-- 
2.32.0

