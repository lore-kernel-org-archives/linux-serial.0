Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED96DC0044D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8C620736
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDZl1d29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgCPKTs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:19:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39363 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730553AbgCPKTs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 06:19:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id b22so3493749pgb.6;
        Mon, 16 Mar 2020 03:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPh2v6rboqGsR7FnWEK3neMPf908hbiMF6P6NLj2Bck=;
        b=jDZl1d29vMjDXNW7wOCAwvhnMCOwg9a0+ctc1R3B4iWoR/FB+KMY2ygBeY4r4lsfw1
         IQvUQCXSHzKntIOFBsroofAYgi0t3zsIBVZEuuT69e9r6J8Q+7+/SPlf4H+YocRRJrQc
         nP8u37bAV+tTM3TG7nY+xjLmzyLwHoRVnKuX0edwe5I18zhu8dlz7WpOR9HNJtb5ZL3J
         wthvvavjvyFEaOpB7H6scogN3o3Dkb83gVNYvydS94LBw1vArf7oAhmpOD1hc1UzKISN
         jZnhPggoKvhMF9y+qJBchGRVk3ju1ZTCGVQ7qrisWMl5tDZWvRhmXBWb9c3zg37Uq5be
         E4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPh2v6rboqGsR7FnWEK3neMPf908hbiMF6P6NLj2Bck=;
        b=Ai2Cl3uiZHmdB3pAM5YCI/SOuUQ509qXLsNs5cEmaWUi2NJWFWyNTiv8aHIqwplnT6
         gHrKzxqFedElOXTfVe9flZMhQvsSByPDgDB9lHGBddJ6KGAykedisZC6GmbAsgDWFRGC
         DRLmvfMjE13VIQkBG6PJOPlkfwMCS4RgFGOliMWpct/B3wEzQY/kv2g2obvLC0vkt/5z
         bzVGTe+jKqzdqHDf4r0h7GS7mVHQztHhdyl6kdI6xzMqCz/YDwpNLr0E3z9PooFMjcin
         KDFHYYIBmSWGVj+BvSPywxVVlXhTUJlHvq8llcwlw6UwOqgaanZ7bSFQKQGLrPakmAUI
         gX0w==
X-Gm-Message-State: ANhLgQ182rUZUR39ENOUyotlFzqJFS1fiqbnVluWRrldMc4iVWw/x7Gq
        1kGSRI1aPm4KUOm/xDt8rsOB9dTW
X-Google-Smtp-Source: ADFU+vu70buys/rhgauZak4xaam/tL0A5q4Vd3qiM/gBGqugbn1nlNb6MHhqXEw6aZEAkuu8bp6PNw==
X-Received: by 2002:a63:9553:: with SMTP id t19mr26815129pgn.247.1584353987690;
        Mon, 16 Mar 2020 03:19:47 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id u3sm21676491pfb.36.2020.03.16.03.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 03:19:47 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 3/3] serial: sprd: cleanup the sprd_port when return -EPROBE_DEFER
Date:   Mon, 16 Mar 2020 18:19:30 +0800
Message-Id: <20200316101930.9962-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316101930.9962-1-zhang.lyra@gmail.com>
References: <20200316101930.9962-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

cleanup the sprd_port for the device when its .probe() would be called
later, and then alloc memory for its sprd_port again.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/tty/serial/sprd_serial.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 914862844790..9917d7240172 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1230,8 +1230,13 @@ static int sprd_probe(struct platform_device *pdev)
 	up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
 
 	ret = sprd_clk_init(up);
-	if (ret)
+	if (ret) {
+		if (ret == -EPROBE_DEFER) {
+			devm_kfree(&pdev->dev, sprd_port[index]);
+			sprd_port[index] = NULL;
+		}
 		return ret;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	up->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
2.20.1

