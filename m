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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5DAC64E7A
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 10:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D00520809
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 10:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYUh0oko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgLAK4z (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgLAK4z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 05:56:55 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0091C0613CF;
        Tue,  1 Dec 2020 02:56:14 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id r9so994380pjl.5;
        Tue, 01 Dec 2020 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8p48Ecd4f2MK+ddbIBqEbyZIovy7SVRtFNAkfbfdX48=;
        b=fYUh0okorSUB+aEZlT0TNXbgZDw4sJgYR26aoRTqbaePe0mgOdweGm/Pk9JaaXNix3
         PamiXf0vw0JHZGFRIdjpBzGbHzeMJv0JO7fWFObntjAsh1ZZivMAD1sqo4zlZFRT3mlU
         XTqp/WLxy+o3zdtxf5g2xfP2gJ5008PwfdF7M512gwDJJC06e4QMmW5T3P3f34cKJuh+
         KsX4qDHU0sj10xfP1/Y12CssSF0rRB9kY0lxbFlsfl0OacKagOhRcvExojGZ/xwJ1uOs
         EBDRoJHc9hd6qddUdkkyD6zfyG0H27rS38wHR6tdCRoUVmZ9nKSFButWMrfts0lwbMyx
         hv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8p48Ecd4f2MK+ddbIBqEbyZIovy7SVRtFNAkfbfdX48=;
        b=NQRBJfbllsYs3K0QKN30nw1/aaXnJVLpvP+MxxVVqQ3W7Hlvc8q/R4iU5jVm3601Qh
         PgXc42TQPiymb0zV9UWplfPKTHRjF2AdJjfVi1/Sc9KW5jsarojM62+AyUERBscuoIpN
         e01ipyPTZcjjTQ8FJPldJtPby6qtkNjlz+GXbKd6bLXS7OK7JcYKDnnmhBkvN6HrAL5t
         /fNp6Oezr5D4VbrwZx5/hcWenSiDGsKFORli82h6UrcwWii5hLzxPLVjGllJIZXFF4Bb
         0XAiFQT7N1SsFmhGcsQd8NGVYA8srIl7jrBathljBIgLYTx0VB+3BtTlfS2FFXmjcK0I
         9xUQ==
X-Gm-Message-State: AOAM533wjwC/hMf3c0uDnlbG/Qu7lr0JCQIrAYBkYb65VgUgFE5sMv0C
        EOpDRZrZPk08MAmOuBxcyS4=
X-Google-Smtp-Source: ABdhPJzGd2GdY/2ouYy9s3D6SOf1WoEa5QkSUrGCJyVmLETv5WHLpD5BwmkivI5QAENbwcR3WL9WpA==
X-Received: by 2002:a17:902:b983:b029:da:8c9a:6acb with SMTP id i3-20020a170902b983b02900da8c9a6acbmr2207816pls.76.1606820174533;
        Tue, 01 Dec 2020 02:56:14 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:8d8b:3ec2:d4ff:d0b1])
        by smtp.gmail.com with ESMTPSA id p127sm2217808pfp.93.2020.12.01.02.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 02:56:14 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH] tty: serial: jsm : jsm_tty.c : fixed file by adding spacing and removing assignment in if statement
Date:   Tue,  1 Dec 2020 16:26:02 +0530
Message-Id: <20201201105602.465899-1-rclemsmith@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fixed a coding style issue

Signed-off-by: Clement Smith <rclemsmith@gmail.com>
---
 drivers/tty/serial/jsm/jsm_tty.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 689774c073ca..047e962a4529 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -607,14 +607,14 @@ void jsm_input(struct jsm_channel *ch)
 				 * Give the Linux ld the flags in the
 				 * format it likes.
 				 */
-				if (*(ch->ch_equeue +tail +i) & UART_LSR_BI)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
+				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i),  TTY_BREAK);
+				else if (*(ch->ch_equeue + tail + i) & UART_LSR_PE)
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_PARITY);
+				else if (*(ch->ch_equeue + tail + i) & UART_LSR_FE)
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_FRAME);
 				else
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
+					tty_insert_flip_char(port, *(ch->ch_rqueue + tail + i), TTY_NORMAL);
 			}
 		} else {
 			tty_insert_flip_string(port, ch->ch_rqueue + tail, s);
@@ -742,7 +742,8 @@ void jsm_check_queue_flow_control(struct jsm_channel *ch)
 	int qleft;
 
 	/* Store how much space we have left in the queue */
-	if ((qleft = ch->ch_r_tail - ch->ch_r_head - 1) < 0)
+	qleft = ch->ch_r_tail - ch->ch_r_head - 1;
+	if (qleft  < 0)
 		qleft += RQUEUEMASK + 1;
 
 	/*
-- 
2.27.0

