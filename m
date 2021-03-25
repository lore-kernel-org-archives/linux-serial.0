Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFB0C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 15:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6516061A2F
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 15:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhCYPY2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 11:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhCYPYU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 11:24:20 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C64C06175F
        for <linux-serial@vger.kernel.org>; Thu, 25 Mar 2021 08:24:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j9so961978wrx.12
        for <linux-serial@vger.kernel.org>; Thu, 25 Mar 2021 08:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1E9sF10HVEC86a98PFuWKJ9Mp74ZD46Q6KDRkjpEZM4=;
        b=aEGht26bWiYnI/bWudlTQ+gOMbnqlc8w4EQYhzEYVrx5udt6E6ps2sXMD48X2qbsuN
         y92CKzFQ9Lfb8SpbMUm3rcp2ThcEH0FaGHeaxY3COdRc4qxVYh2Bm3XOPeNiqikr5qkc
         uEgrrkIW+YBt/eVRSDBIg3Y/89i1G3WhHly8noKVLeJlcIdUBJ8GVIOE554/CSvgCgLp
         Wo+iyNx8hQ/b3ZRUsfpWOvuxp4K49Cw/wYZdUP1KbYDm7dWS6ArLmmlvY72HE0kXdMOG
         xKFKIuv4I1jXPPoNKtLE+0EmWepzGjCa/YkCJ3QCbDNX1Jpp5u1avM3aFMiR9PYO6yO3
         gdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1E9sF10HVEC86a98PFuWKJ9Mp74ZD46Q6KDRkjpEZM4=;
        b=XXQzhcZ3K2l4A79U17u9M/XX0JTrhLYifi3wxW4NV1rg/gODMdGC7Jb50niltxQ5Z2
         tJXLpVDvqTOCYxVoOjYHZmXZoyzm6V07cLAx9wJFrZFLoZx00eUKhkNfc1pNavXeBDRr
         578QfJZ63V7K35o6guxfyLI5gq/XLlVm7biVpYbIsZ1hFYwoqoheqU96aP39hnL/L1/g
         NPZwRBrjfOP5Zq9y7lXM6k4H6rf3enkxl0HHB3K1sEOHmnGEH8tnyDn0lsFrHwCk1zNx
         FIXr+xDjaIqqaKZmCrrhrJmP1AOQktW+BeZ/S5bNZ2UTqAOBPIA2jxNV6DAIlTjB+9si
         LvNg==
X-Gm-Message-State: AOAM531WTlTm6GW/Y2/EMkAdhgtQf2qIXS5eF5aRoiO5HxTL78smPKZ4
        j+ZrGx5GF+yJz7U6MyasQsligg==
X-Google-Smtp-Source: ABdhPJzqTDL4lVT0INpPHTS+dzfkxTVO9rRKAg7IxpMLVWIsTbtXmKcT+OazzGEAYTUZL1Wj1b51hA==
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr9433139wru.259.1616685858371;
        Thu, 25 Mar 2021 08:24:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:b105:9672:b0a:5820])
        by smtp.gmail.com with ESMTPSA id p18sm7395260wrs.68.2021.03.25.08.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 08:24:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/3] dt-bindings: serial: amlogic,meson-uart: add fifo-size property
Date:   Thu, 25 Mar 2021 16:24:08 +0100
Message-Id: <20210325152410.1795557-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210325152410.1795557-1-narmstrong@baylibre.com>
References: <20210325152410.1795557-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
a different FIFO size from the other ports (64bytes).

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 75ebc9952a99..8ece7f420c19 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -55,6 +55,12 @@ properties:
       - const: pclk
       - const: baud
 
+
+  fifo-size:
+    description: The fifo size supported by the UART channel.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [64, 128]
+
 required:
   - compatible
   - reg
-- 
2.25.1

