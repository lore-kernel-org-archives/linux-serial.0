Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF89C433E2
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E62861999
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 08:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhC3I7I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Mar 2021 04:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhC3I6k (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 04:58:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBD8C061762;
        Tue, 30 Mar 2021 01:58:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so7326457pjv.1;
        Tue, 30 Mar 2021 01:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iREGzC2sZl/DyY2RLlvOKGuuLCaggN30UKHaeQRB7RQ=;
        b=dR1izMvh+/HTAyMkC6XOLt24pm2NywT4UmnbWq6sLnIhPLKctYtF2kra5Y0DJnyV24
         VuaF4FOJOK80+NWhxME51lwuFt5on1y5gvOgu6/n1bNzFdFA4G3AIL+bpXm6YwbfWp5m
         5j9XxGsVlqW88+jMBIBD42oDHP0F2QfccNsFEBQACV45x5oem6t0vgBWIZHOHyZ9Vqa+
         JoB7Ftb+V7kwOzCgiExKhChEuGESkWpqznZ84Ifjaa3bsQpsRDNLCH+kgZ+rCJsUVmYY
         wyKJhPUNAXyf0PaLqPuKBL90AjFrSoMcVoGb3gQmQ5feB6lU2EleFDq7W9WixHjPBcXH
         HkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iREGzC2sZl/DyY2RLlvOKGuuLCaggN30UKHaeQRB7RQ=;
        b=Ea6ivxNUFP3/acQodVYF8FfvjpwaGA537gRGL4RgcTUQPMcsXAPlxOGV0xl2fcbrNL
         toAMZ6xupJnUIXyx2SzYLATrP9VmppjAGDCQqeykNpfZvrTbExIzATrooRo/2IYNIeNz
         F+vvakGLQWpdpRrbYZMAxtQugmzFMLvikxOmgX2NlNgCPgC+ahEoRn17pJ0AXH/0T+N2
         l72pcr07d+x5c+ZrPVIrOFf0ElERdfYQ3RVRvw9uqA8sFqGq9eOYMx5VR9d/I+Klk4OD
         F6szupiHlz70NJnON5VqlSLIFEA9Gn3/sXTGBW6NPMzN08aLOZbVIrzDE+0kM3ME9QGL
         AZ7A==
X-Gm-Message-State: AOAM532HoVxLkDaPN47nEGMVw8D90kNpyGpFVwA5OsdRlqJgS1QjwsC4
        Ucpua9EhIY09UXpd7go/+Nk=
X-Google-Smtp-Source: ABdhPJzviLeP5ntIfm2q5brVsYs5JCoAYowXWGq+Nm1e70jjBVNbuBrt0B331QtPpsVbs2jdumfu8g==
X-Received: by 2002:a17:902:8497:b029:e6:f01d:9c9f with SMTP id c23-20020a1709028497b02900e6f01d9c9fmr32689394plo.7.1617094719480;
        Tue, 30 Mar 2021 01:58:39 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id y8sm20952642pfp.140.2021.03.30.01.58.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:58:39 -0700 (PDT)
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
Subject: [PATCH v8 2/6] dt-bindings: arm: stm32: Add compatible strings for ART-PI board
Date:   Tue, 30 Mar 2021 16:58:20 +0800
Message-Id: <1617094704-10040-3-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
References: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
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
v8: no changes

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

