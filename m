Return-Path: <SRS0=rV5n=57=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3187EC3815B
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 19:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053A0206D5
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 19:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGtbPPdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411779AbgDOTIP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416850AbgDOSpG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Apr 2020 14:45:06 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5CBC061A0C
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2020 11:45:05 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h6so3507713lfc.0
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2020 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q2DhW19F5pMEECv7CQj1MOdLm5s6TFmrwq5m6p9uEbQ=;
        b=mGtbPPdiDEvHBdOFRyf6r9msqXIjJa8ORhZJYQwbHpaa55v0yt+KzBUY8n2AEhRUOZ
         +h4MJxCPm8j6B78dtVB9KdYgdzHoLiOg/lWU7saQSPfWEFEuzTJChJUv6CXnl5qSPKp0
         pG56jWsN1GjJh1KH9EdJ8fn76XW2ICxVQT7Q9+b+9cQW0Mu8Kxixo8GNv7dgxd26xppG
         vT3j3DkVSBPtDPqMIs/YfCOAEmmt/vIdOS3UudGHwTI/bIZV4ZYOPPqGLYlOmE1SU7V5
         Z4HCIRQhFUqL928Y//wUwu7Go0n8HZaO4VcRaKuqzJHuAbefNP2orqZ/oF/T5uxe1EPb
         KwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q2DhW19F5pMEECv7CQj1MOdLm5s6TFmrwq5m6p9uEbQ=;
        b=EmezkkuKMEwu9qd6CKAlpM+5mwc7r8fw+PNAtMNJars25qS+cJ5AS0Z48Gku0LhFDq
         V5dnKV2mSDjkBv0NsjV+E+CxSha2mlJ5HGv5c0neqJm0ZnfTB6i8tAeNmjgwerny5HQb
         QweFj/kIiRk+VdSPZ+lSMP28Xuzn58n2jlaPLa6aQkNGWBbox4QRIqVz88zsVznOoamy
         hFQQjXfr8D6mVw6M5NAhY8UHRy31ySC4UohvnyT5YnCnhOYKFwrPsMyaG4r9FgNGoD+q
         5AC3FVb/ebGPIBKimGPMjjj0/sfWCnMfLOLmFJQwEYnZaxICfcAjBTN7uBnRqrZ/E8cn
         a9hg==
X-Gm-Message-State: AGi0PuaiaH3ipfDcf0Vc76a7eIZFCceaZOJAKrjq3BiZClAtb196UlTK
        PbFGafdKoZp2RK3lypE/Cp0TgjXP0/Q=
X-Google-Smtp-Source: APiQypLJy6DCsG92z5VSfTC9R/Tmy7DQHk81PyZk9ryQeeEGHaxQzbeE3YjKK+5DApyQdl8ZzGxmGg==
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr3919775lfe.14.1586976303837;
        Wed, 15 Apr 2020 11:45:03 -0700 (PDT)
Received: from localhost.localdomain (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id q26sm2965571ljg.47.2020.04.15.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:45:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Roland Stigge <stigge@antcom.de>
Subject: [PATCH] serial: lpc32xx_hs: Drop surplus include
Date:   Wed, 15 Apr 2020 20:43:00 +0200
Message-Id: <20200415184300.269889-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver includes <linux/gpio.h> but does not use any symbols
from the file so drop this include.

Cc: Roland Stigge <stigge@antcom.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/lpc32xx_hs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index 9a836dcac157..b5898c932036 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -23,7 +23,6 @@
 #include <linux/nmi.h>
 #include <linux/io.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/sizes.h>
 #include <linux/soc/nxp/lpc32xx-misc.h>
-- 
2.25.2

