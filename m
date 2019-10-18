Return-Path: <SRS0=Hh8y=YL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7750CA9EA0
	for <linux-serial@archiver.kernel.org>; Fri, 18 Oct 2019 12:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE13222C9
	for <linux-serial@archiver.kernel.org>; Fri, 18 Oct 2019 12:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="I8XtwIaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410083AbfJRMxG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:53:06 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43032 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410066AbfJRMwy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Oct 2019 08:52:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id n14so6089804ljj.10
        for <linux-serial@vger.kernel.org>; Fri, 18 Oct 2019 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zynimEHSa2z793BfmzBbQkfkisgqCtAkV6BR9OsqlmE=;
        b=I8XtwIaYLYlfxg9NNy6ELtflmn8AM1cj4JKiG746px15j1nQkF152ypbwtndZWIK6U
         fpsGGyBDxtjg7QmbR17VQAv77y3IUubgjwsdpncHc0qga1+kFg35E3D1g6NMY/X4MLte
         gBtvKk3S2nRNRmpwOlubL7lPWAZnrDp9bGpmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zynimEHSa2z793BfmzBbQkfkisgqCtAkV6BR9OsqlmE=;
        b=MOTa5Ist1Q+kXhsJNR7mjDq9CpP54TEc2zAvCKi7Cw3V7p5vQnLUWBN0e7abWB+OI4
         OAspNn15q7P9e8LqMx73Awyy3TU24PN289SofL9oF+e5+AzSTkoCJVV9dO6FhYfcL3kc
         cH/vxuHry3OD7aIs8MvT9sZ7E64vSwWsapPpvwJPogUF98zMuy/Soh7wx7/HE+jqwPxn
         bywe6gMLhpYxWieWJd0j83kv/lG9GRJZbolCwq3eYPmiflKEM1Gdfz3bmb1bdr9qu5nl
         GLrVNLnuJsao790OssT6U9opAZCB8OrutgOAd34GrrwbVwb3Hn49/gP1cQ1Uu/JaV5hA
         no4w==
X-Gm-Message-State: APjAAAW7iClXllGfxEHVKnCVpNAu5JYhL7dCrdEd57JIKhCNpG3pI5nP
        gLYrAKlSnjsoDQbJhwQPaLwx6A==
X-Google-Smtp-Source: APXvYqzL15xzNiCg30fEr7XFvHwNNnUijyABeFrBXYL+96A0QzVaeXNN1l+/dWTNB2mw6SlvUo0HFQ==
X-Received: by 2002:a2e:584b:: with SMTP id x11mr6266881ljd.36.1571403171701;
        Fri, 18 Oct 2019 05:52:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m17sm7454792lje.0.2019.10.18.05.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:52:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] serial: ucc_uart.c: explicitly include asm/cpm.h
Date:   Fri, 18 Oct 2019 14:52:33 +0200
Message-Id: <20191018125234.21825-7-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
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
2.20.1

