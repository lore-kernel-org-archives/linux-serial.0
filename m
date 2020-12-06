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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48730C433FE
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189EB22D2A
	for <linux-serial@archiver.kernel.org>; Sun,  6 Dec 2020 07:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgLFHlJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 6 Dec 2020 02:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLFHlI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 6 Dec 2020 02:41:08 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B40EC061A52;
        Sat,  5 Dec 2020 23:39:56 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id f14so5555472pju.4;
        Sat, 05 Dec 2020 23:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mY730pQY4f7hiiZSJZ1dsvBjTccfJ3EnnECf6jd+G5Y=;
        b=gs3+8c8u/dELkNCuiK2EBzgoemJ/rweOmDg84xp/ocAouzuMBL/HCwUaz5MXuxAb0j
         dkE2nhwnabXGk6iz3qU5nCTAkmtMDoicDZYZ+mdy/gyeEgmqMfGVi82h8MCGHsAi1/HH
         3boWTZ5adhQnvD9PYvDUx8uxk5bk2RNL8Au3iRD9b5dimebYbglI4Cx0fT8//3qOgZBt
         IwXwjFnf+r3Wo6NliOxHUBrr236R/np1/JkK7k0he3V9fa3g4JYuO3YZrnjyv5VVGWDy
         acTq701sRTtFrA2m2S5bajxbmVsfMgfywvuUc/kOe72ssiIYW7H/SAC/YOYICNq55c/0
         p9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mY730pQY4f7hiiZSJZ1dsvBjTccfJ3EnnECf6jd+G5Y=;
        b=f50lPVaM/cu95hxNoeH9ZK7TuFIw1TvJa6cjzCOQ0tyT1P3uXiGoaGe/bQDU1n3Ocn
         3VvCW9lL+AU9veoyCgQwbIrF7CI5UUcVa5hZBRcXMeiAl1oBm2qI3yH5/h0lCH57+yDe
         EBCPKm1/UBsTyCy5XMIS419HQGb+2meRHDJ9YnBjZPCBzg3K+NoIiMZNBqHieH6vmp6x
         2DaRsOHR7yKicvT1vhu7Qf0apfJ77seG1aXlEAUL1bJpGqxGuD6y7giIV4jaXoNKX+2M
         0i+k7kQTfcA0T15pTKufDUQyrX4rGdaIpfobVRNuFYeEcHTw8XRC79weC/bgLlUX2qZ3
         1rgw==
X-Gm-Message-State: AOAM530DC9OVCc6mRhpb9zOHT2F5KXT/u00Zy17VDgLoSKaGxvn1npMh
        ZHturdGWqYobt0SnY7O4ddORpPcXZ6/SaP2q
X-Google-Smtp-Source: ABdhPJx/5Q+koM2NmdK4AIEPu2cayjT6ALuoCv+QDxlf7pvd7QBCPJ5WjaYwl9Ie49c2mIfbGOKP2g==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr11948356pjp.68.1607240396107;
        Sat, 05 Dec 2020 23:39:56 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f092:5562:8d65:7204:31e])
        by smtp.gmail.com with ESMTPSA id mz1sm4101275pjb.33.2020.12.05.23.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 23:39:55 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 6/8] tty: serial: jsm: Fixed file by added more spacing
Date:   Sun,  6 Dec 2020 13:09:30 +0530
Message-Id: <ac913ac8270bc41d6a2ab2c61db8d9a77f1891cf.1607240285.git.rclemsmith@gmail.com>
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
 drivers/tty/serial/jsm/jsm_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 75c9bfa5077c..19d2f0bc6c10 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -612,7 +612,7 @@ void jsm_input(struct jsm_channel *ch)
 				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
 					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_PARITY);
 				else if (*(ch->ch_equeue + tail + i) & UART_LSR_FE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_FRAME);
 				else
 					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
 			}
-- 
2.27.0

