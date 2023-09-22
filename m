Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B3CD484B
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 17:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjIVRyq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 13:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjIVRy0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 13:54:26 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064A71982
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 10:52:47 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0ecb9a075so20943835ad.2
        for <linux-serial@vger.kernel.org>; Fri, 22 Sep 2023 10:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405167; x=1696009967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ6jwPkyyUPUihDFvg8XivaDrAIcNkn4eIr05k1aNqo=;
        b=HHQQWH3P1Tg3hUpLX6jbe5d/oOItnMfupL9C2YUKqirNRxZ1NhkjtYhO/YMWunS1X/
         na3ThauRHbv1iYFYmDXaG56tOreKU0dtTNn1Jix0qxJnYlc4EtlJq7Y8MAY6L2rEEQL9
         L3PNjU/6b8GJYmpurZqLyV9SyBUhw8o0mWwlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405167; x=1696009967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQ6jwPkyyUPUihDFvg8XivaDrAIcNkn4eIr05k1aNqo=;
        b=E0OuvgvdD8irqIBuYMwnk90Pwgc80pTtZ9C0rsOwJfaBHOiNyGNZXsD/D9fiFV16nl
         I60VdGtlwkHUQk8LI4j3WQAnVIKeCumPMJGwrblFWwB99RXa4NZSNQCd3u/FNH5t0gyj
         UjKRDqRfe2jmZHnTeWeTJGUwQe74LsPsLY4uvlNky9WxVOj+g0MkRCGXDRinLiJRhwdz
         cEd+7a1BydJdMxxNirYwJkq0X+Rt+smHCoAWJdyumLdnqy31p9ne+MrkoJzDaZM5VPHj
         FnHwGX1tdNpu0UM/cQ3C5LYrN6FVFMq3B5yxDrVemS1L5sou+HPiCGEumCYtXJDjnNVr
         lusA==
X-Gm-Message-State: AOJu0YzTq48BbRFM39PliXIpPUTNE8mrkxGOWxjbc+yyfkJOwZXbot5s
        2YPgUErSUkPz2bh/CPrdfLs0Rg==
X-Google-Smtp-Source: AGHT+IHK3gRykvqfXJ9KPG1xk8JjWYE+L3KukDHCn22hNF6awNX8UG77Va89x7qeOpxognyckL1BPw==
X-Received: by 2002:a17:903:2281:b0:1c3:bc2a:f6b4 with SMTP id b1-20020a170903228100b001c3bc2af6b4mr225525plh.42.1695405167472;
        Fri, 22 Sep 2023 10:52:47 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001c582de968dsm3780689plb.72.2023.09.22.10.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] mxser: Annotate struct mxser_board with __counted_by
Date:   Fri, 22 Sep 2023 10:52:45 -0700
Message-Id: <20230922175245.work.196-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400; i=keescook@chromium.org;
 h=from:subject:message-id; bh=EF4J3adktVfobyY2g9VoH112mQT3HIJCM8AoszQv0eY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRtJNIux5LoCOcVzIv6wUz7ihnbHZEwbcqTg
 pn+/5MuR9mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UbQAKCRCJcvTf3G3A
 JonqD/sGsiP5krTXtLdtu/hVDGnXK5tfys6LaoqTOjcqrYNSjPh/NIuv/rqHb+YzfzFOJIQRSZ0
 HZAnHwpvjK7E2pSIcUYN0JqqA4DzASGV/MHa6BwsIMeTdsKJuFRECHikDcLVx+bs34ca1C8mVVE
 kGTNZuXBQ5aaYQm2sfBxZeBkBCUeVOOIeoNJMpJe65rhDFGCsiyMfu6y+sLoMI3sx3R03MkpxfG
 ++mCJQEsSjZl+mWB2yZq5aIKwat6HBhE1RQcHfOStLO6M+/0+Q3J89z2MCgj5ds4ZfO3wdXARz5
 kd0TniAInQZRMzjvnFE22IJQk98TOdrKyQtGcKcorlVdFL/Dq+5KbSvICHOCy5L7jgZ/ZPML2B6
 ByKmLs7DzdruyUsPiTvLRK+N0dPZ2QKEYUD/f7HO0gxKU+Uk8ItuJSliYo2ELn5I0D0IrtyiUpS
 /3ie1n/5nWYxVLyqLUYX303LNZSlfOUfn7CMZ0JhOpwZGk1SSpnJnve5oUmjbecse5GZydC8wPG
 5x3YoHeS4t9E6EP3AGmNMq5o2OdQlTdVHNnAHbH6G/9QnTwPvxrnhrKf2wnHO0mHnPsLJB5Wyoh
 qHR9Y99dUyU8+LW0meomOlfg6B6zRuWDbWedOl0gYjzaAI9s6SG9AhW3ZrAHIegVz3nFw/0wv/j
 GwhUkPI DqtPoZzQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mxser_board.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/mxser.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 10aa4ed38793..6ce7f259968f 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -288,7 +288,7 @@ struct mxser_board {
 	enum mxser_must_hwid must_hwid;
 	speed_t max_baud;
 
-	struct mxser_port ports[];
+	struct mxser_port ports[] __counted_by(nports);
 };
 
 static DECLARE_BITMAP(mxser_boards, MXSER_BOARDS);
-- 
2.34.1

