Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496A7C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 00:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3260D613AD
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 00:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352891AbhKPApt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 19:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343848AbhKOTWQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 14:22:16 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB44C03D7B6;
        Mon, 15 Nov 2021 10:24:25 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z6so15792454pfe.7;
        Mon, 15 Nov 2021 10:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCxDFY+0bqD62b34/rFa5A2Juqua3/U3zvKTU3Kdu2Y=;
        b=mhz5cBelKbmEs4wQkoGCaCWd9KJRdTx7OX8yzuL1by5+CQeFJUN0W8IoBLOiSsI/pD
         zqeAqQRVaoGADveUoZR/SiN6ZFmasYGwBmqu/gMUT9nNwq7VGJ7FklhQ3f/ar1VHbAf1
         IsCRhekikDVEkpyEcYGe6zG6hsPj6wT+vy8Q5oaUb7hzYj+p7dyEjp4e0EevHVPih7wj
         BP6UXfENuL0htwhWaKL794aqbfRkwUkBT5fVT3Tsz44v7yh7KgZTyqjiIsGZfr1t2nJY
         dv9uKeKw+Uod1+bsXuV0YNKX+TpJl9qoMGl6p4S9BPmK9Vdm/73nhY8tIoYfHnqNkzbt
         +d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QCxDFY+0bqD62b34/rFa5A2Juqua3/U3zvKTU3Kdu2Y=;
        b=kX90QNK400L4jFKg1fQBA3DgOiKOTDFhxjBxvUqFB6uL+/GWaKO6KX7yyRu6lk9Epi
         aLDOEduZz9sKHCZ1OgQ1y+L8qgAQuHLKwkWNZ2g7c5TAmOe4GuhRlSn+buEntFGSSvz5
         GFR8si4qvXwi4h43bElALrpmf/siTHPccyFL2ReVVNUJkUvmKbXj3lTVXtmM1uHiNVmT
         PVeVaK1S5wtdTNxN1guhTUbuR7fmFfru+QNW0hmBQ3hVQZxCfbOG2ZLUl1Kom62mkJ6j
         G4+Q/dW+HvpR3lsY1gPmUt+LgUoKv0i+of+ADbncsBm1sWchl+TrXDEMAq2/Wk5gQVyA
         nQdQ==
X-Gm-Message-State: AOAM531xqCkLBZFol4cx/XzthWXhpGemu6QK4SDwN3Ft3kfW9wqzjzzA
        LTeaSnpVSg4c+ZBTUatu/ClcmpAT0gc=
X-Google-Smtp-Source: ABdhPJwdfvCve1AKJ6Nkk3X9unILjFXghJxIx9DyxHJEd1SibsjjzKl1dBtuB6EptC47lTRbQETh6w==
X-Received: by 2002:a62:7e4c:0:b0:4a2:678e:8793 with SMTP id z73-20020a627e4c000000b004a2678e8793mr27744961pfc.75.1637000665584;
        Mon, 15 Nov 2021 10:24:25 -0800 (PST)
Received: from fedora.. ([157.34.150.230])
        by smtp.gmail.com with ESMTPSA id x20sm41340pjp.48.2021.11.15.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 10:24:25 -0800 (PST)
From:   Sahil Patidar <sahilpatidar4051@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sahil Patidar <sahilpatidar4051@gmail.com>
Subject: [PATCH] tty: serial:  jsm_tty: fixed a assignment in if condition
Date:   Mon, 15 Nov 2021 23:54:13 +0530
Message-Id: <20211115182413.10861-1-sahilpatidar4051@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixed assignment in if condition.

Signed-off-by: Sahil Patidar <sahilpatidar4051@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index d74cbbbf33c6..44507b1ff93a 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -746,10 +746,10 @@ static void jsm_carrier(struct jsm_channel *ch)
 void jsm_check_queue_flow_control(struct jsm_channel *ch)
 {
 	struct board_ops *bd_ops = ch->ch_bd->bd_ops;
-	int qleft;
+	int qleft = ch->ch_r_tail - ch->ch_r_head - 1;
 
 	/* Store how much space we have left in the queue */
-	if ((qleft = ch->ch_r_tail - ch->ch_r_head - 1) < 0)
+	if (qleft < 0)
 		qleft += RQUEUEMASK + 1;
 
 	/*
-- 
2.32.0

