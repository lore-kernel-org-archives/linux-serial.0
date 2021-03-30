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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0214BC433F2
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 08:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF97C61994
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 08:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhC3I7K (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Mar 2021 04:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbhC3I65 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 04:58:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3220AC061762;
        Tue, 30 Mar 2021 01:58:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id m11so11677556pfc.11;
        Tue, 30 Mar 2021 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F9tSrsqSDZKawmCDjVV+tzhmJdPbgKPqMa/CwWx5jps=;
        b=C0EXNuAjqJ0RYeS2/x/rgzfMvYBNcw7W0kjMnzwTG3Uo4kuGO6m+vVr0bd09QrFmhO
         /GI6tMuLAxdgtMJAn49vD7jxqQFbEjGZVf7WDLiJt7p43hqdXP03jErWYqDoBtUiezhN
         /OmmOSIWHQTjljntLn7nveNxNhYaqd2c/hVfUbCREPF/j6LJ4Q6StVtS23DXrNKS6SzZ
         vW0i8WLRZdbF7bqcVdZZz1CQ/GRLo4W7KI5dpfGcxnvK90paeAz42woR5uU5ai20PmWR
         8+XQExdk2coXf1D+jE4e7Y864IaC9mdsvSGwrtTHCQZbPdzSuV8+JQvP8YS6N+OaefTy
         PFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F9tSrsqSDZKawmCDjVV+tzhmJdPbgKPqMa/CwWx5jps=;
        b=st5Kc7Yy1Yhxsy2yzF8uzV+2PQCNiaPcC8nG6yU2DBQGowErUd+E4xGtDOJksN17Ed
         t04puVtemBg+Bp5dcrEUeeCVw0ybo//X3w6j7A7f5Uyp035glo9JUgCWlsKGnj330Pjd
         yV3PSzzrpKOJbQRkzfO9I8oTFOqLEn17/edNbLYbg3TRcbbPdsX671DamuArr71zeXpU
         kYBzDkGVDuC8INW+u/4FKvavWzc7I8YKKEIMnPSp22GIqUplHgUCVUPpyY5r1s0S2OBQ
         pKpI23NDaHA6xRbSRy9xrIS+/Ls4WmluQU9//YPEdpqnm9cn0jTP/Flg+evh5KJeQokW
         QpVA==
X-Gm-Message-State: AOAM532LHml6EX8aOWczU8LldSNYQZHskwFPISK/Y8WhdLnNdA2cqU1L
        xrZn7eKXJMGLls5Lj80wkIE=
X-Google-Smtp-Source: ABdhPJz4JEITEdJIKes5VdRLdLAriYxA0JWe625kgdkuzO430nqFP/o7RLuxlnIZtT/OtWNqDsHohQ==
X-Received: by 2002:a62:800c:0:b029:203:6990:78e2 with SMTP id j12-20020a62800c0000b0290203699078e2mr29079533pfd.3.1617094736831;
        Tue, 30 Mar 2021 01:58:56 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id y8sm20952642pfp.140.2021.03.30.01.58.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:58:56 -0700 (PDT)
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
Subject: [PATCH v8 6/6] dt-bindings: serial: stm32: Use 'type: object' instead of false for 'additionalProperties'
Date:   Tue, 30 Mar 2021 16:58:24 +0800
Message-Id: <1617094704-10040-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
References: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
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
Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v8: no changes, this patch was merged to tty-next by Greg Kroah-Hartman

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

