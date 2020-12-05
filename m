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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D96C18E57
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEB92251D
	for <linux-serial@archiver.kernel.org>; Sat,  5 Dec 2020 18:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgLEST3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 5 Dec 2020 13:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgLESSU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 5 Dec 2020 13:18:20 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A81C02B8EF;
        Sat,  5 Dec 2020 06:20:49 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id n10so5365838pgv.8;
        Sat, 05 Dec 2020 06:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dc0LFkjcwgaxWcJJWroMzUjPziQ2S7lUjtXMZ/tjszA=;
        b=GDH71cKIElYybGZjiw00GeP5D3OUl0/tQRPkkXTqRMQ89wsTO8qtb0gQ371G+t6YsK
         UROAhE2V57HYYL56bMjOut462GRtle6D9mlvnlgi2+h3g3XxVGloadss99ivJnAyCU1O
         zkaxhZCiyQUguS4hNDbyZtMlfLZ7VSA4XcC+klTjMW8uTeq/avI9EPX+pOAc4DolF1h9
         HSu60qp2+zJxYvLyc5kOAJbT9wo5EIlTxoFfMCAUPxojFAJRMfYCUErTcZh45m89D+fo
         LCuL0XPKUUXy0qzC1UTO04uu/6iEEupOAeyb6wBupmHl/03EsSOGQKQDRfZM4ttiEAh/
         HABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dc0LFkjcwgaxWcJJWroMzUjPziQ2S7lUjtXMZ/tjszA=;
        b=CNKWrU6GaCOFVtyFZdtZWrQ0fojWQncjavYuBZTQeRmWbauK/VL/WzRzEeRsF1fmnJ
         A2hDBAEhRo/CZfaA1S6V14z6Y6pc+zKUXEt7q0M377PiMRrE2fnWst3zZppDQYCsO0C1
         ujhRw3VW3CfS9Zdaqo/l0Qh5SPBsu//wf8KZKYSgSISzaUL/zObXCzM74SBjSX29JQzo
         WByIanJ3bfxOXSPxiaxBaFTVq19NGUVsyz7fbgyFrphs6oK92lzuxfWjiHG/1UKWaSM9
         NtqN8dON70DqxVBCw42gpu/eQJ6WldWckzCX05R4sl6+E+nEw0BUi/jlrXCyefOnn06v
         RcQA==
X-Gm-Message-State: AOAM530gljZWtFT3OEaQRBlGelMWTxGZ2yw9+v/CDZNavVODtG/Qwr8d
        n1xtYg3angjjD7jP1XhSGcw=
X-Google-Smtp-Source: ABdhPJxTiLevWvI7pyUtA+j/f7VQCyy6drnlOAoxh4X9NPngOWz1w/5HcwHrbVGgDtOursc+XRV9Eg==
X-Received: by 2002:a63:eb10:: with SMTP id t16mr6956780pgh.210.1607178048619;
        Sat, 05 Dec 2020 06:20:48 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e004:f0c9:3f6:a1c3:a34c:b902])
        by smtp.gmail.com with ESMTPSA id m4sm9400202pfd.203.2020.12.05.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 06:20:48 -0800 (PST)
From:   Clement Smith <rclemsmith@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clement Smith <rclemsmith@gmail.com>
Subject: [PATCH 8/8] tty: serial: jsm: Removed assignment in if statement
Date:   Sat,  5 Dec 2020 19:50:15 +0530
Message-Id: <e47a6d011ec8d660cad78448984097a4922eaf9c.1607177807.git.rclemsmith@gmail.com>
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

