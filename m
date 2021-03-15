Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56F5C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65ADE64EB2
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhCOJqA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhCOJpf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:45:35 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CCC061574;
        Mon, 15 Mar 2021 02:45:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y13so6238093pfr.0;
        Mon, 15 Mar 2021 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zupSwfVuCw/OguGpqqu6E+epQ1SyjYIFjZTfov01EZ0=;
        b=NIqqO+nJVJhvWsNmWY4p1PlpvFMCWNzl4sQBSEqVTVeiNgF3l6lWKRMekmQxvHSOOn
         +16C6e/302P7xY2elMVknpOmFeqF57JuYC+qYDMVnDnktQQejpeZOsE28mIn935lEbNj
         yVPnpFZ1ZagTqYQgI3Ytvx5KGBkO+UioPpoBxLt/bEFAZefCQREVOQHTJgMPCGNx2lN5
         K4nhAFDX0/NweKzaMJmIoeQljLaRn/nTFpjB8ETjw0Q/oDc2X7ZkIcB/pzdEioQA4pCg
         wziE9mjS7TOFnvxe/vrMvZZnnDjYDbLZH8LIUVPhVCEiSwNTLEjgR9M8Tku9a0KAWxD/
         lnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zupSwfVuCw/OguGpqqu6E+epQ1SyjYIFjZTfov01EZ0=;
        b=HTRT6mHvaggV0GheOTpzzgdEAOCyHLqM1l+KUCImL7z9Tz9rEo+B+vwiFXOGAbppvk
         A/GtfisjzFIUNMrK4ag4dQm+pVH443RMTHyRmbFJtbnKbVpOoej7w505lw1I7k7937TN
         wXobstqQmO2ZD8RQI2vETjqbII+wd3u5zvSyLUalkC1YBx/VX0F+AcKV2URpZ+DuTn4O
         vS1H/eG8kRw1PwMq5MeIY+oNrfTv8sc/7QuVC9U2iVO6EYGvQiV6uoBDa+4upf5g27ts
         EvNFa/dzWvOhA+V6d8FGOoLitd2MZN2woZ36XHILjkLQhSdDGOX0PgFWI5HksIApGY4M
         98cQ==
X-Gm-Message-State: AOAM532eaeOZI8mY56aOWzEp15m4YIXTkKgkCsUN/lU+qorf8+jS9wrj
        gwkuAn567AOP1jZEA989mEQ=
X-Google-Smtp-Source: ABdhPJyuO5YXdOcnHq6nThOQoNN/bPpKdfvrJ2wS8/AEBhEjresxF5u3JdBZ8Ns6PfNUaAAH49+H6Q==
X-Received: by 2002:a62:7b0b:0:b029:1ef:1999:1d57 with SMTP id w11-20020a627b0b0000b02901ef19991d57mr24210187pfc.19.1615801534609;
        Mon, 15 Mar 2021 02:45:34 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.45.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:45:34 -0700 (PDT)
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
Subject: [PATCH v3 9/9] dt-bindings: serial: stm32: add phandle 'bluetooth' to fix dtbs_check warrning
Date:   Mon, 15 Mar 2021 17:43:56 +0800
Message-Id: <1615801436-3016-10-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

when run make dtbs_check with 'bluetoothi brcm,bcm43438-bt'
dts enabled on stm32h7, there is a warrning popup:

>> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth'
   does not match any of the regexes: 'pinctrl-[0-9]+'

to make dtbs_check happy, so add a phandle bluetooth

Fixes: 500cdb23d608 ("ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board")
Signed-off-by: dillon min <dillon.minfei@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..5e674840e62d 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -50,6 +50,11 @@ properties:
     minItems: 1
     maxItems: 2
 
+  bluetooth:
+    type: object
+    description: |
+      phandles to the usart controller and bluetooth
+
 # cts-gpios and rts-gpios properties can be used instead of 'uart-has-rtscts'
 # or 'st,hw-flow-ctrl' (deprecated) for making use of any gpio pins for flow
 # control instead of dedicated pins.
-- 
1.9.1

