Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A7CC48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFE4961209
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhFRGTs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:19:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbhFRGSc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:18:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 178A721B4D;
        Fri, 18 Jun 2021 06:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhqhJJHGQgh1nSjIpUSQwyMaH6oNC00EvkhH+O8kSEw=;
        b=qFXAvluC5MMr4B6HeKKxDqKi6CyJXU7LjvUi1LOsS/5aKm+iw6T9CrPEn+Idn8KcHR6oe5
        D/ZpOmakzVP/CKB4kf5iqKGaLtJLlUfTBw/smO7yC3/+kFBfEHBClb5ZqKWtooSr7olnGo
        12X//FQ7QOf4xeanJ8cDLgzYbSKBUKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996932;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhqhJJHGQgh1nSjIpUSQwyMaH6oNC00EvkhH+O8kSEw=;
        b=C5+df4lJGtRSgQ4rb9NAedppvONpue8HmhMW0KZYFhfVC1ZPxrV3npbSTRs6G40vwR+mEo
        45thYwE3CTNdCpBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E4D70A3B9E;
        Fri, 18 Jun 2021 06:15:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 70/70] MAINTAINERS: add me back as mxser maintainer
Date:   Fri, 18 Jun 2021 08:15:16 +0200
Message-Id: <20210618061516.662-71-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I was given a few cards from MOXA (thanks a lot). Provided I can now
test changes, I cleaned up the driver a bit and can continue maintaining
it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cff342847673..314207ccc82a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12498,7 +12498,8 @@ S:	Maintained
 F:	drivers/net/phy/motorcomm.c
 
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
-S:	Orphan
+M:	Jiri Slaby <jirislaby@kernel.org>
+S:	Maintained
 F:	Documentation/driver-api/serial/moxa-smartio.rst
 F:	drivers/tty/mxser.*
 
-- 
2.32.0

