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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AE8C433E5
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8EC61990
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhC3C3u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhC3C3b (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Mar 2021 22:29:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA885C061762;
        Mon, 29 Mar 2021 19:29:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l76so10644989pga.6;
        Mon, 29 Mar 2021 19:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JoG99J7INRpYRP07ioU0aX0n1p4zIOqkYI0fl0yVkzY=;
        b=oTZQcyFMGGMpCxxl3ssVEU7AGA7xOw4Lr6snuy237SRb5Wax+sp0e6pcJhCZ3mWTUZ
         LD/3t7z7HZ6vRsPTmCZb3nQ+ONQV8+JnYyRcjOr3ed0WqVMaSrtj9V2wed6pmJe8X0IJ
         zqXX12pThrfNGTId2hYIkARj+5jVdcC3Z0aM0ISUWVGJTuyJBQzvuoog58p40bVJmoFc
         WeoCy8tvoj2qJXdW/4LxeFtGnFqEj0cAAis8rbii23OMbQBExT7TjxRArz+SUfJiPTBp
         7wO9WlnBQQzHWYAknZKc7VOC5agDPpDAG3G5avM78xJs2ve2XlQWjW7MVdq2A3oTG8wO
         zSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JoG99J7INRpYRP07ioU0aX0n1p4zIOqkYI0fl0yVkzY=;
        b=UJXe9egV08sk2rh/EwTX3QCC7lb+h6Ql4OaTxXbkvWu6bW+BwwrVApMlHvD8T1azDu
         +gF8ClNuZHwvVCiIWr7i4ncwQfmo5kE3SQZAwrrqlHn3AFtgXnqqyRl15HElqCTmnY3l
         NrrJoKylj9PL9U1gzHZ1D0XpPlQrt4j65Kr4oUX0JJinExsrpSkAL9CRv+7j7EGlnycK
         kDvXAFFo2DhGmNoTYUsvpOjU1QV3vk5fyKM/4k4Pmg6B4o5Bg7m59ISj5xSdQHA+vCAG
         r2dVbm7oHZ3BIxKozGbE2G6ndtf3Lj2dhTloUon5GhPu1VgFEVykc95c9XpWkdaZGAzi
         iuVQ==
X-Gm-Message-State: AOAM530fuiMvc9Z6U2fj409iuuwk/xzZpckO0r12pFNkXkZ4BTPZbhGz
        iwabukwbAbL7r5RbxAs+4qg=
X-Google-Smtp-Source: ABdhPJwilL2jw4bU/1idwK9Bl1VKCj2/sWv62/R+U/1Az6XtxNbOdTM6Hj0A0OtDWHH/exXmniX2aA==
X-Received: by 2002:aa7:93af:0:b029:1ef:1bb9:b1a1 with SMTP id x15-20020aa793af0000b02901ef1bb9b1a1mr28475386pff.49.1617071371305;
        Mon, 29 Mar 2021 19:29:31 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id i13sm17681385pgi.3.2021.03.29.19.29.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 19:29:31 -0700 (PDT)
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
Subject: [PATCH v7 6/6] dt-bindings: serial: stm32: Use 'type: object' instead of false for 'additionalProperties'
Date:   Tue, 30 Mar 2021 10:28:58 +0800
Message-Id: <1617071338-9436-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
References: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

To use additional properties 'bluetooth' on serial, need replace false with
'type: object' for 'additionalProperties' to make it as a node, else will
run into dtbs_check warnings.

'arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800:
'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

Fixes: af1c2d81695b ("dt-bindings: serial: Convert STM32 UART to json-schema")
Reported-by: kernel test robot <lkp@intel.com>
Tested-by: Valentin Caron <valentin.caron@foss.st.com>
Signed-off-by: dillon min <dillon.minfei@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1616757302-7889-8-git-send-email-dillon.minfei@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v7: no changes, was merged to tty-next by Greg Kroah-Hartman

 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..865be05083c3 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -80,7 +80,8 @@ required:
   - interrupts
   - clocks
 
-additionalProperties: false
+additionalProperties:
+  type: object
 
 examples:
   - |
-- 
2.7.4

