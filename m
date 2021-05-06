Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7AFC433B4
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 17:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E8F610E7
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 17:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhEFRfD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbhEFRe6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 13:34:58 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D0C061761;
        Thu,  6 May 2021 10:33:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n15so2485726edw.8;
        Thu, 06 May 2021 10:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcThJDtQ981B2x/N73MHCvt7MQmPMdERZyhj+4MLJ2A=;
        b=n940lKCUxawS1BhdCJB2Dhl0QKq7WDa6YOQvt9BCAMKfMZYWEJrpJmTKeJxkJLJ7zB
         Bm/hhJV4yhJNSnQauhJ7K4Atx1IMWqj86Am7NMXDdMvsnsU9r0itUU2g9pn61kJbX/ZY
         vDQv2WmRWq49gYIQb2YpBraBqcfZImV5wGcU8fDuiGLCthZ2huK0w9PDH72V8jffUxNV
         RTc3OFiI9WNCVz3cqfOshKcuZMCfCbHiSfAX9EX8VW1nY3EMvfKL7LsqxB7W7i8Er32A
         z4n+qMC8ncARY5/Db62qCZs6drdMRjsMaH3GKEZg/kGgK6r1qmsafJr1tI/c60QeMOoJ
         nezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CcThJDtQ981B2x/N73MHCvt7MQmPMdERZyhj+4MLJ2A=;
        b=FSBcZqWpY9KWjoq2iTF0a8IMMtBB/qndjmyqyWg5F45G+KqTuPcgHHZlFiDeywAtMg
         VWWXaRpCDRLn+MsMnNi0DSTkuqqAcI7h3aErucKS3Y/uNeAcUWHFhkyrf08jE9giZiZ6
         SZu5G19xXoYD4ZXzXgiTxgTd+5SjUl9KzySrluvk/H6rbdc6XrZn3og+tPX3cPd4swsn
         nzenkzwR1yEk4u+wCsCH5JhgIXY03MmqR3PdryzpM3wfYIKMtVzHiqy+Am7hbeC+3cqH
         PMYyvNpoTQo0NGz5d6Z5FfyU+Odkt9SafSf+jm2n0fgcuPsThrH8xzbIy/BBHsRWhXgr
         LtWA==
X-Gm-Message-State: AOAM5315BH/2F9dukEJeKHxdjadP9LwXn0f0cPNdWPA+e+GqgbU4ROz/
        032PPsKnmMyGee+t/OZTJPM=
X-Google-Smtp-Source: ABdhPJz/HzA4DZ2bzXhVn81vPZQ+z436nEd9211YTbTDxTNCwn5GeRK+iD873rdkN8yTQnPzIsINBw==
X-Received: by 2002:aa7:c495:: with SMTP id m21mr6637964edq.123.1620322438192;
        Thu, 06 May 2021 10:33:58 -0700 (PDT)
Received: from localhost.localdomain ([212.15.177.85])
        by smtp.gmail.com with ESMTPSA id ca20sm1801800ejb.84.2021.05.06.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 10:33:57 -0700 (PDT)
From:   Ivan Bakula <wamreu@gmail.com>
To:     robh@kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Bakula <wamreu@gmail.com>
Subject: [PATCH] TTY: serdev: Replace depricated macros
Date:   Thu,  6 May 2021 20:32:28 +0200
Message-Id: <20210506183228.33981-1-wamreu@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Replace depricated macros ida_simple_get and ida_simple_remove with
appropriate function calls to ida_alloc and ida_free.

Signed-off-by: Ivan Bakula <wamreu@gmail.com>
---
 drivers/tty/serdev/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index aead0c0c9..5f873960b 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -75,7 +75,7 @@ static bool is_serdev_device(const struct device *dev)
 static void serdev_ctrl_release(struct device *dev)
 {
 	struct serdev_controller *ctrl = to_serdev_controller(dev);
-	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	ida_free(&ctrl_ida, ctrl->nr);
 	kfree(ctrl);
 }
 
@@ -488,7 +488,7 @@ struct serdev_controller *serdev_controller_alloc(struct device *parent,
 	if (!ctrl)
 		return NULL;
 
-	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(parent,
 			"unable to allocate serdev controller identifier.\n");
-- 
2.31.1

