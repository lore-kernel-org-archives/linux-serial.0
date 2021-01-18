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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BF6C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jan 2021 15:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE22D22C7E
	for <linux-serial@archiver.kernel.org>; Mon, 18 Jan 2021 15:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405752AbhARP0w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393476AbhARPZF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 Jan 2021 10:25:05 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA93C061575
        for <linux-serial@vger.kernel.org>; Mon, 18 Jan 2021 07:24:24 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c7so18953180qke.1
        for <linux-serial@vger.kernel.org>; Mon, 18 Jan 2021 07:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0b9CaA4Bc7y+TEKj5gSB2sbAAmphg7oUV44F5rDl2MM=;
        b=RMRuK8TrWgqmHMw7/L+05cE2rfZg5Qx9cW9iwmYpnPNHynRMCRyGBKFoN43WfztTb2
         RMVXzEsTBcFgtN7tDu7zZPmo+35BGX5nx+xzu856/p4EUb5RcuJqT6W3FJxBHKEKYMen
         vdAJbfbPve4InEJXXEEtmERqec7qG0SRwkduXQxPLvvDTpkV+nQpLLY/T6ugvmK5g/9R
         fQ3czENfzjCD0CNzG/iTeDDRXmO6eAQThAqPHKWI/sFTOX9PeHJu32/idKCpNvEyyO5A
         VE89rWRUPFFFDY804UAggbi51xq0zr0ipoVsZZTOmWu84F3Z3If3uskbPLxqyetTiuZC
         GGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0b9CaA4Bc7y+TEKj5gSB2sbAAmphg7oUV44F5rDl2MM=;
        b=KTbudTYsAqQAoGmCAhl4Y8JRhMCQHaq5tbZgUdJTFx48X41ccGvZdk5yujVnO6jyFE
         OuS5bFrcf8tooDZEiJgwRoysFpVW7+VkYYcIgEVGoNx0nu6JMq5yr/1ui/smKU28f8Ct
         ClyilNwEA6H8Elua0Sqk0L+3ub9Vs8zLvf0zB/8rFhU7SDwSRRoxexWrSG92zGE/ZDZ5
         En688SvQUJIoosHuMsw0/fawVMtiOdrz4UrfPN0BYZYWpnYKlfrNdAUziUFjjyo0HbOz
         yK7aKEt5COL6x+7H8x+tbmW+F2HBqZ00PmtdPWRm3BIA88iDldJAqgYwgJmACuntGzwR
         tRJg==
X-Gm-Message-State: AOAM533tsa3OQl0AJ4H8DUEW1R1K+wKoisePJnrzx8M4Ym2AsY4jcG6X
        S8RuXtExXFoFuHNBlnGmGj8=
X-Google-Smtp-Source: ABdhPJydi/r9biCjv0lt+5mP/fWfxheimupgms8SuJbXPKfPDKydVUG4l1lLN32c9g+wJa8rK5hEEg==
X-Received: by 2002:a05:620a:406:: with SMTP id 6mr106501qkp.494.1610983463447;
        Mon, 18 Jan 2021 07:24:23 -0800 (PST)
Received: from localhost.localdomain ([177.194.79.136])
        by smtp.gmail.com with ESMTPSA id b12sm10284404qtj.12.2021.01.18.07.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:24:22 -0800 (PST)
From:   Fabio Estevam <festevam@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     u.kleine-koenig@pengutronix.de, linux-serial@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] serial: mxs-auart: Remove <asm/cacheflush.h>
Date:   Mon, 18 Jan 2021 12:21:54 -0300
Message-Id: <20210118152154.1644569-2-festevam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118152154.1644569-1-festevam@gmail.com>
References: <20210118152154.1644569-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is nothing in the driver that uses the definitions
from <asm/cacheflush.h>.

Remove the unused header file inclusion.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/tty/serial/mxs-auart.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 01fedb41cf93..f414d6acad69 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -34,8 +34,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 
-#include <asm/cacheflush.h>
-
 #include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/irq.h>
-- 
2.17.1

