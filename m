Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A461C2BB3F
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165D323331
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgLEScO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgLES3W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Dec 2020 13:29:22 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577A9C02B8E8;
        Sat,  5 Dec 2020 06:20:30 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so5390301pgb.4;
        Sat, 05 Dec 2020 06:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfMlRUVz5l7XVnc/HFInF5rSPBCWYyUgC3VCNT+TRWQ=;
        b=C9A4i/ZALuE1Vy3sg0nA47KkXJR2u7TdvhzKNb1tvirxxpBn+gDKjl9Q1PkFxZOLLQ
         XFS9CGJA0urf7u0Hqm4BKTHb3MCDBBnseIg6qS5DowyelXQTKpMPqIYwWHg29j4rtu0Z
         9G4S9dZv+XBwC+0xInQc1kkcc94P7axOUSK42vNlFm7s5GGS2tQ29UBhtI5mn+C8ZyvE
         3HZvkOhRuMBqotdx00JiyK//pTYyCHALUI8n6W7YGKhlvTDWdJolxMB1UYMz+lrug/42
         tlJp3E5SVK2mQNvKNaLXu5cZTY8lkPjHh3CL2C3AhrPNkEW3vTwW7/FFoG86dphTVtL3
         gnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfMlRUVz5l7XVnc/HFInF5rSPBCWYyUgC3VCNT+TRWQ=;
        b=aCCUm/ZMbJr2UBKjBY8YP/D/Q6MkSkHYh/YiXvABgZvGU+hdvDMJTbCD5wsnsV0/ZG
         iBq6RELBNn1KU/7ghogQfpDe9mjfJupSnX+PxbibV6W+C1mveeyYZFxnsjJGkqMvQBmC
         FRY8LGZo20DHT146Olt1Q7zsbjAGXqZHnRykyac/iqy3jUm7+laAIdogWuBK+Pc7wAjS
         0b0eng9UY+E042zHR4YD33/AgYZzvq6nuyErwZjG17AeglcVnuncgjR+kXvBqq6jVdD2
         2M/YcfKIDBLXcReSqJG6SuZ/sJ8PGWy4O7xOEL5pMjqR2zP9PKx/Amo8t7wTxR+cDhlX
         XTRg==
X-Gm-Message-State: AOAM5324bOfus9bxIAW4k8wQbGr+P2TUbC7ds0wXmHPvIbkVRitKkYS/
        +RihFAafQuycaBdmK0zg2OM=
X-Google-Smtp-Source: ABdhPJyzN4hCePBAMRuRECzzPa2JcopEIz/7HOGFbRN/OXfx6azO6plsWS9xJmtR4O2/wwvzDzODNA==
X-Received: by 2002:a05:6a00:acc:b029:198:2ba6:c0f6 with SMTP id c12-20020a056a000accb02901982ba6c0f6mr8333748pfl.53.1607178029710;
        Sat, 05 Dec 2020 06:20:29 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:3f6:a1c3:a34c:b902])
        by smtp.gmail.com with ESMTPSA id m4sm9400202pfd.203.2020.12.05.06.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 06:20:28 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 1/8] tty: serial: jsm: Fixed file by added more spacing in line 610
Date:   Sat,  5 Dec 2020 19:50:08 +0530
Message-Id: <0c203c3dfd32ea016ed7c0de7a1e83a09eb91806.1607177807.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1607177807.git.rclemsmith@gmail.com>
References: <cover.1607177807.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 689774c073ca..512b77195e9f 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -607,7 +607,7 @@ void jsm_input(struct jsm_channel *ch)
 				 * Give the Linux ld the flags in the
 				 * format it likes.
 				 */
-				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
+				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
 				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
-- 
2.27.0

