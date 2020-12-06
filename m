Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C986C19425
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A77F230FB
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgLFHlM (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 02:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLFHlL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 02:41:11 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2307C061A54;
        Sat,  5 Dec 2020 23:40:02 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q22so6852338pfk.12;
        Sat, 05 Dec 2020 23:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q/fZnwmILAVwVRxmPc3BHj+xLD6tYNXImx9x9q0Upnw=;
        b=ZAx7M6wWmDzPZG3EX7H+qQsDujWgHIPCKeoIVHntI2zdDNgbI1itIEnpRLS5NffHm9
         /xc4gO+Kf/OMj9uzbr5aNGif6Omn/PH0PCJdU/SwngX7ay4roXdNIT7BFiNq+A4KP+tK
         LhMT0DnR3Rk7EEdG8HlMm3uLf/bKTC5NM5si8Ihj0HOs9ei9xahlqHHY3adEhcG8ZJyZ
         TLGVAWz2TByTT6Pha/qPrrwKbqHBrk+yZQ9/dahX9gkmtBbto8gjWkkkDDiP53OsV18D
         PZXFljFKNp91Lu6yQQmF0BQXPftUkvH9G0EyfVTK0k/ycQ/my/RpjRXEG9kBgtO9+Y12
         x9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q/fZnwmILAVwVRxmPc3BHj+xLD6tYNXImx9x9q0Upnw=;
        b=tHdQeKYCLcs293rLDViMPxZw+3hIJk6ZiZYd/f0X4CgQ1oE7K4l2zX41vLVO8w3EVR
         v3GDHUeqDJuG+9v04X3A0fX5U0tFUElTRekuTK8F0h4YrGjZp2JdW6SFOYld3cjbqfZZ
         +xiEoHA72b5iyZV9BzJy6vvpQw1aF6RgCoOwZN/hDPRYJOZQmfKxXTacaAQkkb6/cCJH
         lQSO+TrB8n91n19lR27OaUOSwZ+3M47VkSQG3vStto9lpEUn44AvlHOmNnNibK70C0iE
         quRKq5mx5oDWkBvVd6K1HAh4fpgXGZLOi3jsQZm6JKR9XOUnWToBG9KGZ3dnyIb3KI7x
         XXeQ==
X-Gm-Message-State: AOAM530rw11PrSAqJNtqa7jKT4SuFSaxVhdMoNQYZRisRkFbTSRswBIE
        7an8AbwCHGN96GhoUMOgdJI=
X-Google-Smtp-Source: ABdhPJyAp3OZKwpgywPLKMgjKPVNgtCjt6bYS9NrbsD4aMwQsD80ubg5hhhiwgMeuQlWusBH6yFotg==
X-Received: by 2002:aa7:963c:0:b029:19d:dcd3:b2ae with SMTP id r28-20020aa7963c0000b029019ddcd3b2aemr3605310pfg.76.1607240402253;
        Sat, 05 Dec 2020 23:40:02 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f092:5562:8d65:7204:31e])
        by smtp.gmail.com with ESMTPSA id mz1sm4101275pjb.33.2020.12.05.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 23:40:01 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 8/8] tty: serial: jsm: Removed assignment in if statement
Date:   Sun,  6 Dec 2020 13:09:32 +0530
Message-Id: <818b6f6e0a0fb31dbde5ac778501ae287781ea5f.1607240285.git.rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
References: <0d1fde4c82ce4b9f20f5d1ae2c6b34314f9d9942.1607240285.git.rclemsmith@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index eab82fb6b384..bfd4b55e6c74 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -742,7 +742,8 @@ void jsm_check_queue_flow_control(struct jsm_channel *ch)
 	int qleft;
 
 	/* Store how much space we have left in the queue */
-	if ((qleft = ch->ch_r_tail - ch->ch_r_head - 1) < 0)
+    qleft = ch->ch_r_tail - ch->ch_r_head - 1;
+	if (qleft < 0)
 		qleft += RQUEUEMASK + 1;
 
 	/*
-- 
2.27.0

