Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA9EC49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7796361260
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhFRGSf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46938 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbhFRGRr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 077FE1FDFA;
        Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARHILmTdoR9Ny5uAo9t9Abt9U5Ou2+Fs0cR+3waViTA=;
        b=haqDy7N61o79ABvcOep2LDPDJiFlDNMb8OvybahFQCPBXgu13nFBoVdIHKe7d2TdSzURIg
        CUrMJoaZ8Zxtp/U3rirRxe8d/tEm73rGAmQYIzN65GYnOuwmG5dGG5ZdH3ZNn7PCPv6Duh
        aGmI6VpcuafMzKkwRZPKG/FNLqTm43g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARHILmTdoR9Ny5uAo9t9Abt9U5Ou2+Fs0cR+3waViTA=;
        b=IqzyjOTUHhAJxH2lX8p7ele82BFDFfBiFkV7DqMc9O96NzTbGfACvCMGC7fUQcXjFTzB+m
        vMgYJLs0CpXWqaDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D49D1A3BA3;
        Fri, 18 Jun 2021 06:15:24 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 37/70] mxser: cleanup mxser_change_speed
Date:   Fri, 18 Jun 2021 08:14:43 +0200
Message-Id: <20210618061516.662-38-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* use UART macros instead of magic constants
* let the default case reuse already existing code (CS5 case)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index c4ee5cb6952e..2a8bbce790f3 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -657,24 +657,23 @@ static void mxser_change_speed(struct tty_struct *tty)
 
 	/* byte size and parity */
 	switch (cflag & CSIZE) {
+	default:
 	case CS5:
-		cval = 0x00;
+		cval = UART_LCR_WLEN5;
 		break;
 	case CS6:
-		cval = 0x01;
+		cval = UART_LCR_WLEN6;
 		break;
 	case CS7:
-		cval = 0x02;
+		cval = UART_LCR_WLEN7;
 		break;
 	case CS8:
-		cval = 0x03;
+		cval = UART_LCR_WLEN8;
 		break;
-	default:
-		cval = 0x00;
-		break;		/* too keep GCC shut... */
 	}
+
 	if (cflag & CSTOPB)
-		cval |= 0x04;
+		cval |= UART_LCR_STOP;
 	if (cflag & PARENB)
 		cval |= UART_LCR_PARITY;
 	if (!(cflag & PARODD))
-- 
2.32.0

