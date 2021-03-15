Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09DEC4332D
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B239464EDD
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhCOJo5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCOJom (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:44:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEF9C061574;
        Mon, 15 Mar 2021 02:44:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 16so6223976pfn.5;
        Mon, 15 Mar 2021 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CbjmHJRm4TcYXO0oRyf1xlZJ9yoJ0JVgkkpMngQhXU8=;
        b=H1j2kzhdT64KMrf5si5Kmdxe1wS+9hvbtJuq9Zg4C8dCWO+Q50kTlSwSOFLJtzn+zw
         d4Vayin9bFMW7muKDiWX4+nyKoIeZeVEvtyM8WPaqX8HRLBFsSXLKqyFYjjvLMFuCsBi
         w0H4Z6fr1rYY1KVZnm+eCqhgfCM1IB8nMIboxD/wryfzp6OCM9Fn3S/mguNvVHeZyXNe
         E7bzQPZt0NmjW+h8Uuz6FPMIzhs/H789Nxfdxju/yrwm8EL2+wUB3RNYNhMXRYN8r5NB
         W8a4AESNNlNLj4evdtNDXN398E6MhVuDYjB7w5uFO6JPmfcjM54kAzA5a2JDF5ceZqZE
         xqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CbjmHJRm4TcYXO0oRyf1xlZJ9yoJ0JVgkkpMngQhXU8=;
        b=Q0iUxgdxtDh4VgzFLx749+WVhXMjk6pTWwqXrAEbmqhaeHIZNETkn5uxJxU/dBeW9v
         d7+yeRwmD7SfYepjHUdpsl8nSmdQUwRr1/yhLPDGPRGFzNuHXa5bPrHs1tYS6b9UrGI9
         YjzZSlHhbvaYeVTH2azYuEgVwXJ1t8kv/kOCyX9nIBfVqLdTv9Esfc5UlHMxVLFOh78A
         dH9+xlPAic67Ui05PLeRvVOIbHLqrfTjpBAQqLXrJALnGt/b34qyxbxO60ODbHx0qWPB
         Tjj6NdaXyrKqF8IMx+Mkr1KEdmAPI3WqxoFJL6LvsWbf4xjftzsTFu9I9wyt36QZEcO1
         zHNA==
X-Gm-Message-State: AOAM531q0wqX6PQcL6QblEAlLDrOhPZdQ35VAfCklrHadCGWq6dWITT2
        2141nWSbjxQzN7hBednYd4k=
X-Google-Smtp-Source: ABdhPJztu409uQ2Dy417gMeHfVcQEiZV38uPkhABQvq+zLb4CMKg9RaCsrvGtU4YhefVXak2zSRu5g==
X-Received: by 2002:a63:8c0b:: with SMTP id m11mr22268013pgd.306.1615801481736;
        Mon, 15 Mar 2021 02:44:41 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.44.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:44:41 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 2/9] dt-bindings: arm: stm32: Add compatible strings for ART-PI board
Date:   Mon, 15 Mar 2021 17:43:49 +0800
Message-Id: <1615801436-3016-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Art-pi based on stm32h750xbh6, with following resources:

-8MiB QSPI flash
-16MiB SPI flash
-32MiB SDRAM
-AP6212 wifi, bt, fm

detail information can be found at:
https://art-pi.gitee.io/website/

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index e7525a3395e5..306e7551ad39 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -53,6 +53,10 @@ properties:
           - const: st,stm32h743
       - items:
           - enum:
+              - st,stm32h750i-art-pi
+          - const: st,stm32h750
+      - items:
+          - enum:
               - shiratech,stm32mp157a-iot-box # IoT Box
               - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
-- 
1.9.1

