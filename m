Return-Path: <SRS0=YkBk=4W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B1DC3F2D8
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 10:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BD624671
	for <linux-serial@archiver.kernel.org>; Thu,  5 Mar 2020 10:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnfP0bOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCEKc7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:32:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36728 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCEKc7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 5 Mar 2020 05:32:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id g12so2465461plo.3;
        Thu, 05 Mar 2020 02:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vsmWfQHYKO+IuisE4zoMrrWqQil3RoLQ09NM/R4vXz8=;
        b=PnfP0bOcQb6PjDSK6KH7VyFI6lPRcbRKxQXVVwlFjpqKwUREnrvNYwuGVOOeteK46l
         +ziFUEWNEhZ4HH1r5D4yvLldZTqLP1B2uxtlFvEFbevqxE6Q4PWw4Z0APOak1KTgfX6U
         hxzlSAPkg/84vnQwYAIdOSZr9isyzANmrggt0Yn8ZrmbqAilHz1ctIexj6h3qljDRYgn
         SrJhXCHML0kTVTJQCkBTiF3orv1usOgLZbXjj82UJBqjpho02d0GIUNX6w7cLLFdtpIV
         ln3u6zd2iGo7YHWIlXYb4wBvy/339xHyTqYqRlQEi/0djWXaw8YHz1QSS5ERq1mG5x4z
         5MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vsmWfQHYKO+IuisE4zoMrrWqQil3RoLQ09NM/R4vXz8=;
        b=sgKtQ4NInQR02M+Aa+/FOdE3oti94Y8ZU4jA5EsoBwj/movIPdf6KXGmc+5O9Wa5oa
         vstb20e4CK4TgQxbFUxFmdA2DfpzCfn347C7JbYY61loXg3PJ/BYKuYUKPGjcEoCvv/L
         CEzVvpY6PhvNIxkqrHTaTj3pz+driULzWFwSu6RkTJASggUlF6lWC9xWJBAZaWVRX1u1
         LgvJcz+HgIIZ7GdQGUeBc864FD5mf3qNJ1/Tua0qSAW4Tq7ZymbJwkxziJVlpD6KWynG
         X6Yhe3b16xHyg3in/fkUbs438lTwJzu44ezBLwI5EOkCn/ogYw3bOI/HUenl5gzv8Zra
         Y6Mw==
X-Gm-Message-State: ANhLgQ0JX0T9kdQ+LPtJ0MtbdVBfN5w59uySXoscSKcYpisuA5oJOxG9
        SJTu99Vry5MqUWnDjmxtezuDv8nr
X-Google-Smtp-Source: ADFU+vuvup2OQ+LkXonFteqL3x/Q3zHIPTB1pvus9Rdsa06vHb/D3yAFoir8AtziitgcAYM/Iw/3Pg==
X-Received: by 2002:a17:90a:e654:: with SMTP id ep20mr8005006pjb.60.1583404378204;
        Thu, 05 Mar 2020 02:32:58 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t17sm31540145pgn.94.2020.03.05.02.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:32:57 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 2/2] tty: serial: make SERIAL_SPRD not depend on ARCH_SPRD
Date:   Thu,  5 Mar 2020 18:32:28 +0800
Message-Id: <20200305103228.9686-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305103228.9686-1-zhang.lyra@gmail.com>
References: <20200305103228.9686-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Remove the dependency with ARCH_SPRD from sprd serial/console Kconfig-s,
since we want them can be built-in when ARCH_SPRD is set as 'm'.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 52eaac21ff9f..2b9addc0afb5 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1452,7 +1452,6 @@ config SERIAL_MEN_Z135
 
 config SERIAL_SPRD
 	tristate "Support for Spreadtrum serial"
-	depends on ARCH_SPRD
 	select SERIAL_CORE
 	help
 	  This enables the driver for the Spreadtrum's serial.
-- 
2.20.1

