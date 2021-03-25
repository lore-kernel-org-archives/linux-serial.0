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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538F5C433DB
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 06:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F8661A27
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 06:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCYGUh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 02:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhCYGTy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 02:19:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6470DC06174A;
        Wed, 24 Mar 2021 23:19:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id c204so978145pfc.4;
        Wed, 24 Mar 2021 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=31z6xcgVpgNt2rqQ4i917PEU8w/kVuNEF1a++fiq5dw=;
        b=nQ6TerCFDVxmOIgBYkQXfbaZtZgE4MkWwQ3DeGjNyiTbHdjhYHhK7j8av0reETN1yK
         01VZiWl8qS5kxwekLzQAK2Dp2gQpoU+OYFYtwKv+mtQwKW7srdnVdLgKpUwxQBse4Dta
         RKA2WPFUCvMGhriQjsKI3LK6w1GYY4alUwEP8OgcBMc8blPbb+kUNiByY8KQ3rNFan18
         Btyw0aMcpHJ+8bZSk61ZPhS4kVLz5aj272T47rUrKKGA6XxUOBCSgUA9bIDm/aqFTsHd
         ec3e/IpuZZ1XfWZLxVIOzjzq6lddK3j1nOzC2IiIX/BjSvZsJwUfp9DpUwaCcliUCDFU
         P+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=31z6xcgVpgNt2rqQ4i917PEU8w/kVuNEF1a++fiq5dw=;
        b=gKy48PM1iNgE8QRPUIWdK0Yo2+R2UPxqQFCyqMxy+zkCi7j8h6OwGsv1+OIshHdu8U
         BU5KOM23w7zTL8WC9/HRWruuFaT326a2BdQ9GlcDNE9O93Vg4wCUI3tdIIwTpR1CLg/K
         hfSCYdAchdU5KcWvBeMZzy23c5NJk4usJpIt5U8wTLJnm57LxF5agsNO7MUw7QcHsVy/
         Pv4nWZvlZL+rCA66RoZha+PKiVBdeuLjqu0tPhXaI+dpy+ivNVFIDMrMZUOebb9foTzu
         Rqjht30SEgXY1SDaOD4wZ9XzVu2DHbNQME4S+HAbdO1DHn9RJmW+3weyrEpJq/gz21ik
         ms/g==
X-Gm-Message-State: AOAM530Dvgejuxuio6p33Y6+YHT2bMUWXwFeOnlWZk1Eg3nqO8TMxOwE
        cuuDCuK58xMMe4A7gT1U3kE=
X-Google-Smtp-Source: ABdhPJxtsQ03IwysDluyYZpJWgXX97sGPpF47gdNS8CmZlpk8MrPym7e4+FukgzZIFGl0r0dsLH8FQ==
X-Received: by 2002:aa7:91d1:0:b029:1fe:2a02:73b9 with SMTP id z17-20020aa791d10000b02901fe2a0273b9mr6683276pfa.2.1616653194038;
        Wed, 24 Mar 2021 23:19:54 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id b19sm4393086pfo.7.2021.03.24.23.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:19:53 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, erwan.leray@st.com,
        linux-serial@vger.kernel.org, lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 8/9] pinctrl: stm32: Add STM32H750 MCU pinctrl support
Date:   Thu, 25 Mar 2021 14:19:21 +0800
Message-Id: <1616653162-19954-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
References: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch adds STM32H750 pinctrl and GPIO support
since stm32h750 has the same pin alternate functions
with stm32h743, so just reuse the stm32h743's pinctrl
driver

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v5: no changes

 drivers/pinctrl/stm32/Kconfig             | 2 +-
 drivers/pinctrl/stm32/pinctrl-stm32h743.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/Kconfig b/drivers/pinctrl/stm32/Kconfig
index f36f29113370..fb1ffc94c57f 100644
--- a/drivers/pinctrl/stm32/Kconfig
+++ b/drivers/pinctrl/stm32/Kconfig
@@ -35,7 +35,7 @@ config PINCTRL_STM32F769
 	select PINCTRL_STM32
 
 config PINCTRL_STM32H743
-	bool "STMicroelectronics STM32H743 pin control" if COMPILE_TEST && !MACH_STM32H743
+	bool "STMicroelectronics STM32H743/STM32H750 pin control" if COMPILE_TEST && !MACH_STM32H743
 	depends on OF && HAS_IOMEM
 	default MACH_STM32H743
 	select PINCTRL_STM32
diff --git a/drivers/pinctrl/stm32/pinctrl-stm32h743.c b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
index ffe7b5271506..700206c7bc11 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32h743.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32h743.c
@@ -1966,6 +1966,9 @@ static const struct of_device_id stm32h743_pctrl_match[] = {
 		.compatible = "st,stm32h743-pinctrl",
 		.data = &stm32h743_match_data,
 	},
+	{	.compatible = "st,stm32h750-pinctrl",
+		.data = &stm32h743_match_data,
+	},
 	{ }
 };
 
-- 
2.7.4

