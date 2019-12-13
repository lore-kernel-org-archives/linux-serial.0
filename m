Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C4C2D0C9
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588BC24654
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="pBO83T+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731731AbfLMAIo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38536 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbfLMAIn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id a17so387469pls.5
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Er5nAZa0dzjPGmbpRmr/URcdpkFHKxX1ZKta5byo+BA=;
        b=pBO83T+3pLGQIG/lo6bFoz3CUjfvRFotL/CE9Az3B2XbEMhTbp5PLKYjAfoPEB59vG
         2O/Zb2NN55/9N+nZmWeNlYp6Oe8nfM6fsSMmX8PTAhDYuqlPfhNP4mKs72qMKmPPrbIx
         FroUhUeinf4yNuUDSVTwcyDaHsbQsmcKQHadhavR4Q/K4Ythj3VCPcDC2t/lX+djVWGb
         FJvI5rWb9ge9+7O5dOjCdbau4XrTsCJqZhcPniOAiTcyOXRklo0qM2XUVtqr7yEl2jwF
         e0oa/s10DoYmA7d/8PvJ4sP5ApdnsU35p4NUC4vRnyOX5JMGGyKH9dHSmHZjr6QvqiaG
         2VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Er5nAZa0dzjPGmbpRmr/URcdpkFHKxX1ZKta5byo+BA=;
        b=CqAVjYUSgySPGOEMC9L4dPe2RzXGM4Is0v/YEIJHbJDDLirt8dTSmfsLLAE4tDrm+H
         jB99tArPmLvn2Qpg1cYj26Kcit16Oyt6Odpslu7y/X9+HeQ/Tm88eE9mPyQkog2EUf2r
         qv34O2fQIktkeYe44jhYfEhTo138YDSkYfjAK0bIRlVvSYITFefyVObvvjErXPkGgv4v
         7XPgP5kOtobYYTU4nLs9BSipck32GSU5zhhcUz4G97omctaEiVDUO95fLmNjhSsHpucF
         huJAYsjk4farYWqdUi+D2WnkNBq9ffVfw2qXbpzeecr5iW+u3vxDBJCGnBDIMDfz9Hkp
         DuxA==
X-Gm-Message-State: APjAAAVpqhNhBHh1KAki+SiEj7NpWJPIn7Ap15ViShCTWI8gLZCjqS9c
        /KsiwH/jPUxi1QHC5GxWa+ZPBg==
X-Google-Smtp-Source: APXvYqwB3D0kINS7nIHxvaSLTZkj+rB5xcPZkkmxepOINemcjk0j3BsedcI0tT2o8OES5EGFzhUJVw==
X-Received: by 2002:a17:90a:8989:: with SMTP id v9mr13191061pjn.119.1576195723176;
        Thu, 12 Dec 2019 16:08:43 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:42 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 30/58] tty/serial: Don't check port->sysrq
Date:   Fri, 13 Dec 2019 00:06:29 +0000
Message-Id: <20191213000657.931618-31-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_handle_sysrq_char() already handles it.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/pch_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index c625bf7b8a92..0a96217dba67 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -584,10 +584,8 @@ static int pch_uart_hal_read(struct eg20t_port *priv, unsigned char *buf,
 			if (uart_handle_break(port))
 				continue;
 		}
-		if (port->sysrq) {
-			if (uart_handle_sysrq_char(port, rbr))
-				continue;
-		}
+		if (uart_handle_sysrq_char(port, rbr))
+			continue;
 
 		buf[i++] = rbr;
 	}
-- 
2.24.0

