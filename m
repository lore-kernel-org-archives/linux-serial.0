Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15CDC4332F
	for <linux-serial@archiver.kernel.org>; Sat, 29 Jan 2022 17:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352968AbiA2Rxt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Jan 2022 12:53:49 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36206
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352859AbiA2Rxm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Jan 2022 12:53:42 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 141F63F1D0
        for <linux-serial@vger.kernel.org>; Sat, 29 Jan 2022 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478821;
        bh=veL6ZTddJGkmWO+v+Lus/eVk85DvsY9iBADvcny/2xo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DLouUQhikh5cRDDWpdHkHLVQxRxldX2Ay9iQTA6zCfq7Hxqb8w5mnrVmeK+mtn+gq
         iaVNa+bj/1BxtKLBurE57hM73R2Y3DhhtSfNAeHNS13GHHAslic69Eguapwa+IiRGZ
         dJSkyOu1TT81C5JiHhvfRzowrRlmSoGzeso0uCH3E1JtPhELegZQ3AEJX1LEvayr6a
         uYBw49TLoPo0lI64NC06549WQMNtieD15ohYf+G6L+kceaQAofNlE16C2A/4lLZup5
         3qNoJFd2MTdBjx2N1u8w5eQ3IiN1WgX++m+ekDzYQZV1l0QYdFNJNm32BWp8Wt86dL
         J1/X9+3hB+PQw==
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a0564020f1600b00407b56326a2so4692550eda.18
        for <linux-serial@vger.kernel.org>; Sat, 29 Jan 2022 09:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veL6ZTddJGkmWO+v+Lus/eVk85DvsY9iBADvcny/2xo=;
        b=Cc4ER1cy6zEbGnZaIFLk+DSIM9LndefgCvVelnPkZYZfqAuRdGeqRHPbeMNjbUf0PX
         aozm8Cri5o4Ilghq5RnOE7yJ/N+F2okfkDJHNz5ZZ2wrbO+kNf+JsV2ofNWE1ZVCi+EN
         VWzhyA+LeiLWCJIoUvrtvu/pAVEU2VY/hw6Vz70emO/OqRkyy0LDko5LtlWZnE16cHbU
         rTrq1nTMZ6rjMRvFAe+cxfcyJz3nRyyZ239Hf0H9ywauZqi0tePJG5Kq9Hm2vyURWrnw
         dcQLCt4HlX7f9bhrpeAGCtUbCmYJaRYb2jX+aLHrhN1UJxvutB1B+SYbvBnYMFBDZTfC
         PmQw==
X-Gm-Message-State: AOAM532/yjUQU3b5MYvLH9K1m4DkelSC/txM60heY18wKN2K5Oby3EqE
        h+ZdaERVclgy8Y88iGkDyVVC0cotU9yhDbdvnxWDFotxu3cBgJamkXVWDpVDTiAJ+SzDurEVqiO
        WCXZXXMpBCoBFIDBS4o1JoebOPtZ+4zxwTlcIonCTag==
X-Received: by 2002:a17:907:7e9b:: with SMTP id qb27mr11137896ejc.524.1643478820800;
        Sat, 29 Jan 2022 09:53:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5CBLthMjPGZikxjz/GeJrdUwukf8hFoejvpxjbfEPDuwkf4B6TSZ0xs7lVYUf2VA3qmtYCA==
X-Received: by 2002:a17:907:7e9b:: with SMTP id qb27mr11137881ejc.524.1643478820636;
        Sat, 29 Jan 2022 09:53:40 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id s12sm11236266ejx.184.2022.01.29.09.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:53:39 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: serial: samsung_uart: Document Exynos5433 compatible
Date:   Sat, 29 Jan 2022 18:53:32 +0100
Message-Id: <20220129175332.298666-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
References: <20220129175332.298666-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Document the Exynos5433 UART compatible, supported since commit
31ec77aca72e ("serial: samsung: Add the support for Exynos5433 SoC").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 2940afb874b3..6aceba4a5f79 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -26,6 +26,7 @@ properties:
           - samsung,s3c6400-uart
           - samsung,s5pv210-uart
           - samsung,exynos4210-uart
+          - samsung,exynos5433-uart
           - samsung,exynos850-uart
 
   reg:
@@ -111,6 +112,7 @@ allOf:
             enum:
               - apple,s5l-uart
               - samsung,exynos4210-uart
+              - samsung,exynos5433-uart
     then:
       properties:
         clocks:
-- 
2.32.0

