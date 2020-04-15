Return-Path: <SRS0=rV5n=57=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C938FC2BB85
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 18:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65BD206D5
	for <linux-serial@archiver.kernel.org>; Wed, 15 Apr 2020 18:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3JyXvws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411686AbgDOSFC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404726AbgDOSE5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Apr 2020 14:04:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F65BC061A0E
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2020 11:04:57 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h25so4700729lja.10
        for <linux-serial@vger.kernel.org>; Wed, 15 Apr 2020 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R4VyF39PNZBMJfN3TXSTtWGJK3s/GehNl82ghUjPcTg=;
        b=Z3JyXvwsnfv3c0IF27x4gJlyJIeGBafb0/1Rqi/XEe0fQXWcCGmpTfRgXlOK16f299
         oJByjsbc1seILTKlApJI/7UaC2iPg2dVTIQK3lSO1jX1HS+e/GHDvwDOABKELhntUdWT
         OjBgUMLCxNGrIEIXwaPCOBWcaDieO/s7oe+1nYLm3wFYP7x9cXzpwtdyDp/uwWmOEB3c
         0wRkMYpslbki9C/JyJ+qOiOx97GEGXpKKMXDRBYO6tDMEPSxDqsQJ+5/WstKiTIHdnP1
         bNOEacehfRBKBr2xl8WXbdo4zzjb8J7MkPHYx9PXbJqX2rdNlXQ+KjDGLhNWKb0T26uh
         ySBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R4VyF39PNZBMJfN3TXSTtWGJK3s/GehNl82ghUjPcTg=;
        b=GM60GK8x1tpLznXGxhTMZscv8e1II4lt0T1Kinfa6CV2cv0+KeF9pHN07IRaDQozMm
         UbdiM7o4X1V0MAG4dQAY8WbSKD9jBaEeQpCbUbV3DZj5WSqTLE/xU2eQEbKZJ9C8/NXp
         82F5yB6L2x4LK3Ui8p6fD+bMkjUSBbX/wH4KzpmPluDWpYhywO44yxqzO3tvTPAthuGB
         6GYCafkXOogwXKrTPOfOmbGFvOzx8ljIBtpl4cHlfnKjQ3eTuywgs7Sug8Ji/Qxklsf4
         s9QJTKvPnXnoipr1k67SRvXTPu3ggWlskatPO69r2AOd1nFlfDN+QNXxixfR55qmrj0I
         1M9g==
X-Gm-Message-State: AGi0PuY+SOtrmKas76O+fnMb+3Q9ztrpMk/UoaFVfIlRhvP/oxkzbxzS
        vyghcBw0NA1PzUrUCoWBQB2evPB8F2Q=
X-Google-Smtp-Source: APiQypJlkYy6Q+VyH14tyjSA1uFPyIADxAhhKqqIyKlmRt0aA7yOu5wNhgdnMqDwQSA/7Xs4WJ2sRg==
X-Received: by 2002:a2e:b4cc:: with SMTP id r12mr4095990ljm.50.1586973895361;
        Wed, 15 Apr 2020 11:04:55 -0700 (PDT)
Received: from localhost.localdomain (c-f3d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.243])
        by smtp.gmail.com with ESMTPSA id j8sm13210928lfk.88.2020.04.15.11.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 11:04:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "George G . Davis" <george_davis@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Drop unused include
Date:   Wed, 15 Apr 2020 20:02:50 +0200
Message-Id: <20200415180250.221762-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The sh-sci.h file includes the legacy <linux/gpio.h> header
but the driver is actually migrated to use the mctrl_gpio
library so this is not needed.

Cc: George G. Davis <george_davis@mentor.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/sh-sci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.h b/drivers/tty/serial/sh-sci.h
index 0b9e804e61a9..c0dfe4382898 100644
--- a/drivers/tty/serial/sh-sci.h
+++ b/drivers/tty/serial/sh-sci.h
@@ -2,7 +2,6 @@
 #include <linux/bitops.h>
 #include <linux/serial_core.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 
 #define SCI_MAJOR		204
 #define SCI_MINOR_START		8
-- 
2.25.2

