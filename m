Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF2C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 24 Mar 2022 12:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350258AbiCXMp7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350254AbiCXMp4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Mar 2022 08:45:56 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E7839147
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:25 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q19so3738035pgm.6
        for <linux-serial@vger.kernel.org>; Thu, 24 Mar 2022 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SLVt+LP5JlIBRjXydemyTJQgjjrmA7sE29HqyrFPgYU=;
        b=o1iPt0Kzh/aZygLvoGUzfUh5P2m2ASuWdnPFEclHMemAGBXk45lP+UiRZNctpixQMf
         1tm1akMN40R10d41d30DU3Jhs2ftnoEUInbHz08qMk1soQTQlFq7rmoshpDbmJNNDHmF
         lU3QaqQepvZYNdKmuHD/3/SaBvWWAxutuJkeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SLVt+LP5JlIBRjXydemyTJQgjjrmA7sE29HqyrFPgYU=;
        b=QxYxUWYl3Ks+LW2U/qHIMGNHX3mkgd8huM65YLmDdhigE7RcpS0gNNHEkJKBKvYNgs
         lj/vSXJqf39vWIuKBFmvu5pdPrGAH9wts6daIBg+2FuiJGORxeSqybG7jI0C9EFcCk+z
         RcNq6xC72vlb59x9uGcrBGh6Iv2aNJ8Gf/l8oleWqSnSn/z3AEMGbneU9RNbAUb1r/v3
         UON7yCKcoXTW69EzWkHioAd+8BFJovqy3T6nAS065Ih/3i3TtQOcEs8udqEMOJzdq5F4
         FV9uLEHgDltuvw5yvR0xJYG1hoZEBey4KMKjfQa30bM9PVD6E4yU60/RjHcYC0s9ZHzy
         0pIA==
X-Gm-Message-State: AOAM532ARCPNVNI2Jr0gE+RUYEX1ru0DgIEqH9cuDeZ8y6QO0eDsFWZb
        gJuYWAGTqzw2olCELkUe2QAPkw==
X-Google-Smtp-Source: ABdhPJxCHkBGZ3KgXajz2GetPxKcpCh8kcbeG4/uD1RX7HLgooBcQxqBPmxkrHhsygwWEJZzCdpNtg==
X-Received: by 2002:a05:6a00:2354:b0:4fa:f195:b0c9 with SMTP id j20-20020a056a00235400b004faf195b0c9mr2365161pfj.33.1648125864708;
        Thu, 24 Mar 2022 05:44:24 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:24 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/4] dt-bindings: serial: snps-dw-apb-uart: Add MStar MSC313 uarts
Date:   Thu, 24 Mar 2022 21:43:59 +0900
Message-Id: <20220324124402.3631379-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324124402.3631379-1-daniel@0x0f.com>
References: <20220324124402.3631379-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add compatible for the MStar MSC313 uarts.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 12137fe80acf..486e9deaef0f 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -45,6 +45,9 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
           - const: snps,dw-apb-uart
+      - items:
+          - const: mstar,msc313-uart
+          - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
 
   reg:
-- 
2.35.1

