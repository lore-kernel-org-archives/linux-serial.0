Return-Path: <SRS0=2m+P=4R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F2AC3F2CD
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFCF21D7D
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 21:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZ1cGsOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgB2VZh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Feb 2020 16:25:37 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44097 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgB2VZh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Feb 2020 16:25:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id 7so4735221lfz.11
        for <linux-serial@vger.kernel.org>; Sat, 29 Feb 2020 13:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kky8mfhPQ8KKnNkQyA3CeK4eo/7P5j0q3GN68omEw6s=;
        b=WZ1cGsOmsZw91k0RVSwT/sBOUz5juQmU/1iilMzZyXAEdcK45K/oi6UWrcqAtTZ+Uy
         YShmab1i0FIzCQBrnmLa6y6z2+bIk4K3UsbG2A/pQR+EF4Tm9Uwl6ztDGEqKB23luE08
         vS17pN24Dh0KIWZsCBEjtIzhZBMrhrRqjr40858qljZ0AGhYoXXbYPTDeMAleDtNDQ5X
         r2eQwa2sn8DFgKhofE+Vv1vth46NxkCDfokCx4fLcSWg74/KLmahw9dZ21U2Uv4SzPB8
         2yF2m/GaqgF7LjE/+WQ/C1v8LDIor9wUwUxAin2y/3iMjVHhswdQk8gO6Q3m0SCHyBW9
         QaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kky8mfhPQ8KKnNkQyA3CeK4eo/7P5j0q3GN68omEw6s=;
        b=ZJgXwWmuTiJdKRvjCnSIBM+k/RqBq7ZRKLu0P7Tpzx8b3p5raUW88UvS222RHMPwfT
         mY1nR9YYNNCqJhMw1qLjKq1gk+pn2tsdd4drlYX30eF6xkciUYLu+lP/Q5Fwr7OYsOgN
         7wFsoKMRDDnL54jbhacpt6/i1xd9xaEraUc1ezIQ6KjoEX6Gr680mxyqH3enS8HRjIRN
         OuiMjI89P/7ud3n6I/h6RFmCkXkw+gOCKkaAhtG+EdlGzN1AVEKueDTxtligEK94g3jK
         B9kCjDVnT6UtdheKcYj2cNtgs7tV8CxrWqYcoft+Q3G0Ew91TfPY2ruzNBpRRln81Qu3
         Vgiw==
X-Gm-Message-State: ANhLgQ3u1p72k+Bvc79nvLg/Gb5AE5gAjX+dGb2IUyeRs2DF54q4HdXD
        wLOpecQmkX1VdTes9y3r6GG4KAeTx6M=
X-Google-Smtp-Source: ADFU+vvI+UlnwM0gPuh9Jk+ov9u3vCu5fQSGi9QpDsw0+Kgl3JMGxS8smlJoXsQvDY3+k6wGG66+FQ==
X-Received: by 2002:ac2:4c82:: with SMTP id d2mr4454926lfl.78.1583011535172;
        Sat, 29 Feb 2020 13:25:35 -0800 (PST)
Received: from localhost.localdomain (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id r15sm8505465ljh.11.2020.02.29.13.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 13:25:34 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] tty: serial: lantiq: Drop GPIO include
Date:   Sat, 29 Feb 2020 22:23:31 +0100
Message-Id: <20200229212331.174946-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Nothing in this driver uses the symbols from <linux/gpio.h>
so drop this include.

Cc: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc: Songjun Wu <songjun.wu@linux.intel.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: John Crispin <john@phrozen.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/lantiq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index f67226df30d4..c5e46ff972e4 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -11,7 +11,6 @@
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/device.h>
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
-- 
2.24.1

