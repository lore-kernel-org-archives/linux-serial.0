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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA14C433DB
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 08:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B13619DB
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 08:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbhCaI3e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCaI3G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Mar 2021 04:29:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E44BC061574;
        Wed, 31 Mar 2021 01:29:06 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id l123so14007802pfl.8;
        Wed, 31 Mar 2021 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8EA9tflx1qSoAm/gZUALECzHKvmRKxVZk9N222UGws=;
        b=RJNjoT/EsPgBrVpj3PWLbdOmYQYr7PEtKuj3m/bsNCPg1DXp35cJDtPn1sqCCjO3g+
         RYOOLwlipnT8jat/bjixkGh/Gyb6tHwW2p3iVh33ddlaHplr0swdm0kNIhMRMZ/R0wXs
         yd4j20Jqay7IF49Ksmmm6UpAEtu05XIxPk5Su1IF8YoVeYGlLie7RroMfnKnmNM0FHv6
         X5TebVyx1B2kR46wZiznaIsxUELIFq0V654OLWuBNBW7FK8KKQ6Frj256LCg2A0UEmLV
         MFe5T9ABxWSM0hpc5lF3zqUp2qOGcIveBJKiH1uSWkd+FyAgZj+O61fYH1mmN4RvN1l6
         sTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J8EA9tflx1qSoAm/gZUALECzHKvmRKxVZk9N222UGws=;
        b=aZoNeRLvhJACCLMB2S6P6spnkFZLJC7sps5/wjVk4gH9KTXEL6ygiHFG4ZghArcRod
         y8Po+80BOpsyG2RtdJqT6NwNGvxaZhK/0bgg1tYx4IVRWpHYo2DKAnPlSFNbHkc3GDlZ
         Nj/60y/LlAWHpokSMrkXSW03OeA66ky39iA9p6FwNJe4jV50Hzq2GG2hhGd0BIDUWdFf
         GqfBfLICd5l+t9ZdZl4Ik3xODxsnzcgr3Qwne0H/mdfNH8KBUe2POb8GlenM9/G9vtne
         V+jSwa0J7v9cnH51s6Fn7tGmOm1eOiuNWh32ieJcZ8gdD4mQHlP14jKAM6B+FUugwnza
         G2YA==
X-Gm-Message-State: AOAM533wIqO4weua+6xTcuXoTvnsklmu2WIK19Nb+gdN0Kd9tuc4BEs1
        NedaUku/dE8f9C8Y4Ngdyqg=
X-Google-Smtp-Source: ABdhPJyh97m0QgSx+iSbD3AjZq6ol9a6k/87G6JH0Ooh63dZyC/HysbIP2JFcldc6r4RjFzzOkqapA==
X-Received: by 2002:a65:47ca:: with SMTP id f10mr2263311pgs.206.1617179345885;
        Wed, 31 Mar 2021 01:29:05 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id v1sm1420991pjt.1.2021.03.31.01.29.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 01:29:05 -0700 (PDT)
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
        patrice.chotard@foss.st.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, pali@kernel.org,
        mchehab+huawei@kernel.org, andrew@lunn.ch
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v9 2/6] dt-bindings: arm: stm32: Add compatible strings for ART-PI board
Date:   Wed, 31 Mar 2021 16:28:41 +0800
Message-Id: <1617179325-6383-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
References: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
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
v9: no changes

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

