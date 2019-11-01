Return-Path: <SRS0=4rmH=YZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D931CA9ECF
	for <linux-serial@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5494021897
	for <linux-serial@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="goNZ5OE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfKAMmw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:42:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39987 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbfKAMmv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:51 -0400
Received: by mail-lf1-f68.google.com with SMTP id f4so7137359lfk.7
        for <linux-serial@vger.kernel.org>; Fri, 01 Nov 2019 05:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=goNZ5OE4tByzOYzAc1bKhKcL9oM+UBCCFrvDNLRRvcNalh8UnNn6w3j3/Q21+wi139
         yiMCFOFtB95G2/yRPf1PDZQuswYXEi69SttUocHkc6sMbHZBdFvyxel4r9/0e7RIvZPM
         c/eVWDJF9fTGzUPSul9kKDwPdfk36qWT5Kll4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=skc4BB3FfJVhrMQufim0pPb5lTLStBal+/ZiI3PgHrk=;
        b=RsIvDk99+RC8C73t4AsGn/JcNAcxr+Zjd+GzGoBg1a5rJCx/yPEQTYp1arVcnQtZgb
         Qz+oudpoiLrg6ulDS9r5II+k+zu1OuhlZFQXd8WScxunHiZO9P5ENDwvZG8E3uc5LtJK
         uC908JkXvzLVo5b26gbGx2ELjZFWiWiCB8h440Hd/EZwS0fozPfm1JRgN0NaNch1xQOl
         lOfmxCxdUcQ5/JNQIqsDOtKbgrTTYVI+jcGaU7wSKX3lcJldnfRfBNU1H/EFCuk816iy
         qf+khh77BqnnfeZuOd9DLqaS3kBXBQDQMpAfIq9bt3U6sUiHaiZhv1keEFVqrA63Gwy/
         ysKw==
X-Gm-Message-State: APjAAAWAyY+nGTZOaYmYPI/OhOODxikNsckjoXjCDagEBZdf7FLKbGtK
        q6lty+Gg3JIvSue0xvdBOSBYmw==
X-Google-Smtp-Source: APXvYqx+LkhhsdE4uicd68kleysrFNvL7csaxcY4M/SzGwCUFxmQjOfm//4bJ58IrETbPNpw6KnCjQ==
X-Received: by 2002:a19:8c1c:: with SMTP id o28mr7221433lfd.105.1572612169565;
        Fri, 01 Nov 2019 05:42:49 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:49 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v3 28/36] serial: ucc_uart: explicitly include soc/fsl/cpm.h
Date:   Fri,  1 Nov 2019 13:42:02 +0100
Message-Id: <20191101124210.14510-29-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This driver uses #defines from soc/fsl/cpm.h, so instead of relying on
some other header pulling that in, do that explicitly. This is
preparation for allowing this driver to build on ARM.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index a0555ae2b1ef..7e802616cba8 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -32,6 +32,7 @@
 #include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
+#include <soc/fsl/cpm.h>
 #include <asm/reg.h>
 
 /*
-- 
2.23.0

