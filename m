Return-Path: <SRS0=5Xrm=YS=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAEACA9EA0
	for <linux-serial@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E617E21D71
	for <linux-serial@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="E1hiJE/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504519AbfJYMmG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:42:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38060 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504545AbfJYMlc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id q28so1629554lfa.5
        for <linux-serial@vger.kernel.org>; Fri, 25 Oct 2019 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iGJonh7VqgV4Y1nWqTZdSXnTXxbR6q5lO30wl6/it2Q=;
        b=E1hiJE/N8uyirc34yldY8uoOKyp6Aafi6pTD1KNMz37l7ZxFuQTs1ly4mphyCyeoLm
         BIfJpTGn7JnPGMw2F/xN60qCJErNEMevmCpDy0g8zwOdSCaqJCYYVHT4CQPIamvwj2L3
         MdqAsCo4b5XqddEjICpt0BEm/DeSmy611x/Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iGJonh7VqgV4Y1nWqTZdSXnTXxbR6q5lO30wl6/it2Q=;
        b=t0RGHfR4oYwk5X3PDuF2Tj7EZ49CmYKBuUKSajju4QvpwpCcC+zfCisn6NlYUSEhSt
         rlcic1KYo6ANEDMmw/PEXQO4TC/yjMjyANHS4gwgtvMI8b++puDO/OaOfEGG4xSYeHmQ
         vVMdDxDWfuL+5dg0jiRIub99kBBN8HftFBJPUaOnd1xSOq5o8yvIn5hD2G1Ln2FlHxn/
         VsYgqFuimqyaWAhZFUL9lJt5FP58gvGHiObSYk8h+XkpUm3IitxJM+Wqr6stZ35QTzQR
         qevX9WxjDqGmbq8/1Z1DZsy3XOhnh2dg9PgH5WEeK/lxvz2nIUr6MUHynK63qTrPbW4Q
         4YdQ==
X-Gm-Message-State: APjAAAWCTLq8or9CDQxMnG9Th5umthEpGhJsgoypFLf6U/YrXjtrNx90
        v+n/S5C4SFqysFLrKZVU1Na7iQ==
X-Google-Smtp-Source: APXvYqzWdgjzit8ixR4YnUZ9xLOIPsZHRAlHxEezNI3JzgRLGEBgrKtCg1284a/7LWYjFvAyXUS6gA==
X-Received: by 2002:ac2:4c15:: with SMTP id t21mr2581867lfq.7.1572007290172;
        Fri, 25 Oct 2019 05:41:30 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:29 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 21/23] serial: ucc_uart.c: explicitly include asm/cpm.h
Date:   Fri, 25 Oct 2019 14:40:56 +0200
Message-Id: <20191025124058.22580-22-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver uses #defines from asm/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..e2c998badf81 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -33,6 +33,7 @@
 
 #include <linux/firmware.h>
 #include <asm/reg.h>
+#include <asm/cpm.h>
 
 /*
  * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
-- 
2.23.0

