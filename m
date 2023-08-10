Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD24C001DB
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 08:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjHJIut (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 04:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjHJIus (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 04:50:48 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984282115
        for <linux-serial@vger.kernel.org>; Thu, 10 Aug 2023 01:50:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317716a4622so641919f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 10 Aug 2023 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691657446; x=1692262246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUA6Uop1470tUJbDViYaX4LRHpvZYJIyke3HCwbN6+o=;
        b=o2dv9R0JA3ZxL9ing7at6nqKjTLilmMT0IQRbfsOpS8nBL9yjoITmy2fRO+my3ZMRu
         s+5a+R+fxQDERaGpBHUyUsDhTzQNOaKC1pNAuNA+P2i1Xra3XgkKLHODmJEyEABz5lIc
         TXXVcRuElWHjZU30tkr19+P3PI+9FiD2x5wOPq0sKGOuxqcPPX5lDd0IdorEgvYuO69p
         y+gy90/0W/HJqjb4yqVFS9X0OzWyl7T/ieaeEWoX9DIa9bDckj/75hVKwniRSqhnIkHo
         Z/2LKe7ax2ZNTZUzXO+Wr1qNfv94J30qMRMfgJb1ULBW+y9rLXuhZHfbeeMvy2Gto9tr
         s/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691657446; x=1692262246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUA6Uop1470tUJbDViYaX4LRHpvZYJIyke3HCwbN6+o=;
        b=hFQsv4bxMtvc0wLydL1i/IarbTEvxMWlxDk5rN7iN0w/9Qrhw4pRKemVahd2a39E8C
         VqjIPqQBNMNGhqWE62n237m2sYu06T18JnhCKS4e5KhDuN5buULKE1IcbiejWVTRR359
         +32gGcUfmT/RT9CDqfB5m8W2sA0vKA9wKo43+tSV0KQhP6Qa5OTv2KIBcFhA3JZxByvu
         ssWHDzAThFO7Ugg8rrQ5Q4hd8+djNc0X7lCm31O4ihDDdnOVeR/TRO+aVK7GKdb+2qx+
         NGG99jCheqtRQDuPcSpPkPZ53fI7tvptXi70tOAPoxZ/1symD6rE4AKe4CFEP7mVuo5e
         2dXA==
X-Gm-Message-State: AOJu0YyBX55n31sIxHfJR6BZK6JA5h+az9xfSkgyMAPe5GAV2w+fb0z8
        H+lWI/1jlCznUSxpvtU7qbvusw==
X-Google-Smtp-Source: AGHT+IFb8oMsS0S9gnDkp6ZtkyHaO2DhrB8218z+QoY+VxqPi+V1z6jMgz1d8pK94alrz+7qUBOzLQ==
X-Received: by 2002:adf:f011:0:b0:317:43e0:3f47 with SMTP id j17-20020adff011000000b0031743e03f47mr1605618wro.36.1691657445994;
        Thu, 10 Aug 2023 01:50:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b003180155493esm1395013wrj.67.2023.08.10.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:50:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH] serial: mxs-uart: fix Wvoid-pointer-to-enum-cast warning
Date:   Thu, 10 Aug 2023 10:50:42 +0200
Message-Id: <20230810085042.39252-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

`devtype` is enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  mxs-auart.c:1598:15: error: cast to smaller integer type 'enum mxs_auart_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Cc: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/tty/serial/mxs-auart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 8eeecf8ad359..a9b32722b049 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1595,7 +1595,7 @@ static int mxs_auart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	s->devtype = (enum mxs_auart_type)of_device_get_match_data(&pdev->dev);
+	s->devtype = (uintptr_t)of_device_get_match_data(&pdev->dev);
 
 	ret = mxs_get_clks(s, pdev);
 	if (ret)
-- 
2.34.1

