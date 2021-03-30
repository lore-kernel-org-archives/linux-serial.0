Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33473C433C1
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021776198A
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhC3C3q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhC3C3O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Mar 2021 22:29:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB31C061762;
        Mon, 29 Mar 2021 19:29:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so8657160pjq.5;
        Mon, 29 Mar 2021 19:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKGtGSsjwoHtJFr3M0CNb0hFT3328bYsnKTNhdz1+J0=;
        b=KCUUKPoEkJSxEAY+pq0+lHepheu2iead7MOhXCLlUWFZATTIGIezl1oyYDl2XyzBW2
         nMWduP5Z+ElmbTF6ta4y9euJjqLAQKWX0ICYibeZoGbKiDvtKvfmLfw1yva9hmRw5wNc
         Cjgqz3fbddFbJ1U+bEAR3+64q72hrBkVb5MeUmMHR8BZ73ukt72e82Xup+D4vPCZPVkl
         uGGjYuSgJ1eOig08HKufxtz3PjDEg2BfBP6BMOmWRX0mwDiVbfrhOsbiyeZwcdBlSQSE
         3hlkgoPojKk4+//cf/DWgULq4AY9L4Tls2DYj9CVPkeKZ5U28VRXeDSy6EkAdgLg0FT3
         wB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKGtGSsjwoHtJFr3M0CNb0hFT3328bYsnKTNhdz1+J0=;
        b=DkyETKqiU+iENxMB48pn2z8rm5Vblj6erO9htO1IragvCxx6iZXMDnqNGHNSoxWJb9
         /9XfAkXCGAi9qH+1VdtKluYPf/7ztLnLTUaTlXmRxXB4tg9UM9boTNSEPAuaBLABSxIc
         bn2jfIJ/01rBaAHajtCnbX71Tlw0vsH/oRmSnAPH3ZQBA5PePXKi7c5WAPtWFhR5ikdn
         sgGeU9j/zl22zBBWxFoV8i72q9na6X4VY5eYQhmjJCrsG3Gk/XQtZz4PvyqCB0e5HdTs
         Op/gXoiX54PVz5RnID2HA2K9RUyM5cDJMttFTmxkcIUQguJ0wBH0SLB2raGd1JWpQz6T
         L1Jw==
X-Gm-Message-State: AOAM533b80wiIa+Jnp6KtJnBSS7heO92mLQbi4UTpgU8TAuLDOJXxJux
        iKv7hzqWCAuFMyrRGhXqOUs=
X-Google-Smtp-Source: ABdhPJzdSx7869JvXOsXcy/+RGdQeHVpD2NpRnN6n/+s3hjGKuhnPU67L9sUEA7gWa8XR26TzckNpw==
X-Received: by 2002:a17:902:c40b:b029:e7:32fe:1ce with SMTP id k11-20020a170902c40bb02900e732fe01cemr18602326plk.44.1617071354019;
        Mon, 29 Mar 2021 19:29:14 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id i13sm17681385pgi.3.2021.03.29.19.29.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 19:29:13 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, afzal.mohd.ma@gmail.com,
        gregkh@linuxfoundation.org, erwan.leray@foss.st.com,
        erwan.leray@st.com, linux-serial@vger.kernel.org, lkp@intel.com,
        patrice.chotard@foss.st.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v7 2/6] dt-bindings: arm: stm32: Add compatible strings for ART-PI board
Date:   Tue, 30 Mar 2021 10:28:54 +0800
Message-Id: <1617071338-9436-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
References: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
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
Acked-by: Rob Herring <robh@kernel.org>
---
v7: no changes

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
2.7.4

