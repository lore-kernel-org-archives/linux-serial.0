Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D0FC6FA99
	for <linux-serial@archiver.kernel.org>; Fri, 10 Mar 2023 22:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCJWbn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Mar 2023 17:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjCJWbE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Mar 2023 17:31:04 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E82D125DB8
        for <linux-serial@vger.kernel.org>; Fri, 10 Mar 2023 14:30:07 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i34so26426870eda.7
        for <linux-serial@vger.kernel.org>; Fri, 10 Mar 2023 14:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678487400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfAnBF3g741TiPzTIl5lEA7CxOn5O6//kz+XhRgZSMg=;
        b=KCksCGjuozvf9t3pQuRKsQ6j9bn3QXgThECi/h9uEhyqJ3NeE1wvdToOdTLZDHQP0I
         WIek/23cU4Hl2Ze9cXFtzuM8WI0IIc+8Zj50Fg+wICisJGlpQqfLz9DN/IOK5m2M37m8
         aECzi3PHtQdNAyJMFO/33JWhsGtqViTauq9mNDLFXdyqhqtkpdEd3h+lXxJBr/V+lGt6
         fytL7xzuxWXBNK4KIZNDPnPwfNpLC3NTWMgww1d4sO3v36yV/RIOKwPwy7KFu3hPsVP9
         IiAOw2uCIjZXHO4O/BmXwMw+OJ4KIpZs/qC9oCLnhpE6Jj16zr+Kig1DPN+TJn5UMMTl
         9mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678487400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfAnBF3g741TiPzTIl5lEA7CxOn5O6//kz+XhRgZSMg=;
        b=krATuDE97uhG6KVFj5skgp6OGT6R2UZLCSIkGFcBxVnHNQnBxeHwvmLpiG/mal4n90
         vUkT9lBqznxZR8WrGCkPhlFCsYYJDGqaTQMeSsbxYCX0grp85FMrJByjcJl6Vvq5v+7E
         OWEqmd/dic00XmKYHFdjJUa9eglvMonbv8WjbGRCn7x7fRwcNxBFMqcPMKtkWv58d3KD
         YxkrdrMkLog842bbT0OWGLSb78ToKLVeLzlCpPeoQo7dm0NGfC0FwXe9u8vXR5wRHpY0
         hNvTDpGBdBwpjAQQt3Gbqjdole8Y7sxZeBIsbIHFKTAkmJccsBnZtgszN0revb5Y25Up
         PR8Q==
X-Gm-Message-State: AO0yUKUTIh3/1mdAJI2f5+eeWYNLmV3VCd3C4XLxXx059/qY1UtS2i5Q
        rC1VH6LI97TmsX2NMRbcJWHzdQ==
X-Google-Smtp-Source: AK7set+xIXxBUv468Gv8sCZh7XsYa+Q7aM3Zvjox18LXhpRFhM+3CphKaCz5Hq4hF7oZCQk8nzR+KA==
X-Received: by 2002:a17:906:f143:b0:8b1:2d0e:281 with SMTP id gw3-20020a170906f14300b008b12d0e0281mr26131830ejb.18.1678487400771;
        Fri, 10 Mar 2023 14:30:00 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id k10-20020a50c08a000000b004c2158e87e6sm495695edf.97.2023.03.10.14.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 14:30:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] serial: sprd: Drop of_match_ptr for ID table
Date:   Fri, 10 Mar 2023 23:29:57 +0100
Message-Id: <20230310222957.315848-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310222957.315848-1-krzysztof.kozlowski@linaro.org>
References: <20230310222957.315848-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).

  drivers/tty/serial/sprd_serial.c:1242:34: error: ‘serial_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/tty/serial/sprd_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 492a3bdab5ba..b58f51296ace 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1250,7 +1250,7 @@ static struct platform_driver sprd_platform_driver = {
 	.remove		= sprd_remove,
 	.driver		= {
 		.name	= "sprd_serial",
-		.of_match_table = of_match_ptr(serial_ids),
+		.of_match_table = serial_ids,
 		.pm	= &sprd_pm_ops,
 	},
 };
-- 
2.34.1

