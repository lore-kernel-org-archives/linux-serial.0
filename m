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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323CC433E4
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 01:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC6C61982
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 01:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCTB5R (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 21:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhCTB5E (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 21:57:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9C7C061760;
        Fri, 19 Mar 2021 18:57:04 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v3so4880805pgq.2;
        Fri, 19 Mar 2021 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TFzCPCHOGunTV7Nk7bbsASKOtAjRbwZHCSCbFBUgM/I=;
        b=Ur087o1MJp/2ELe1YpoBK26lNd76VNQRWNZwdv5AH7urkXmORI2K37lkMU2DIQl5Ap
         r90x7ycdFSaTUkRJ5ydBV4zPuqxnZqKfCakClzNs27hKsNiimvu/XDTXcTQApB+t+Ob6
         xo5T2nWh2JR6z9YNTb5wIqwRG31BEOLIY9K3+6zSni9DNe+gtF3o9r2XV5VxacS5z4e1
         s+1Fir4HAsqaih3o5my6kT5wcew90LRj9jTUEviphwiM7y/dWLeYiLDygAvcA7iV8jW/
         u3lvMLT1rAMN6m+mv14bCBPlxL39CraHN5S8aSArqxAToZQ2Av409PKd9wFe4VT5aKH6
         Fbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TFzCPCHOGunTV7Nk7bbsASKOtAjRbwZHCSCbFBUgM/I=;
        b=YyBU7eQ8RHH8dAkIrHRE/mVdWSwvfl5HdGr5Ip/FcN5dMx/4G8woI1KPL96BgbhkAt
         2HDiQ0YbR0pGuuVfQbMlFXvJ1nsRJLWqA8C3dfk+SL4WsidVmMy2pCkQBICySc14sCMa
         ZRBqE+lfmDZ/zwO5L8u/fnTFgqZ3u/VYs771bigAzai/nCwc8g+SLSsdRJgnGxPjZ2Zo
         6V3sMEMNHNsELt1LL5Zr+VWu7wXqVB2/FXy75EFAXU848FVfQgZZGeLFvl2NfqZDzywR
         i2vWEvSK4Kd8IO+ZPRCOi4gqnntkv/2c+wJP/JLgo826uhoBz6NFuWOQkHLqS6koc2SI
         /NyQ==
X-Gm-Message-State: AOAM5326NXRsSPbpjtqJZSFp1w45sr0LLTiI/I2dXJyN3X4XupZz89Nu
        eTU/lPnYOE6W+yEMhQ5eMec=
X-Google-Smtp-Source: ABdhPJwG+sMeeICjk5ZbpbCSzEgrYGgzg3QXDZuGx3G8W1dBBwQSH06+U5txD7x4tafuGDlixptCDg==
X-Received: by 2002:a63:e47:: with SMTP id 7mr13668938pgo.17.1616205424087;
        Fri, 19 Mar 2021 18:57:04 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id y7sm5755904pgp.23.2021.03.19.18.56.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:57:03 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        robh+dt@kernel.org, a.fatoum@pengutronix.de,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, linux-serial@vger.kernel.org,
        lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 8/9] pinctrl: stm32: Add STM32H750 MCU pinctrl support
Date:   Sat, 20 Mar 2021 09:56:22 +0800
Message-Id: <1616205383-24114-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
References: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
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

v4: no changes

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
@@ -1966,6 +1966,9 @@
 		.compatible = "st,stm32h743-pinctrl",
 		.data = &stm32h743_match_data,
 	},
+	{	.compatible = "st,stm32h750-pinctrl",
+		.data = &stm32h743_match_data,
+	},
 	{ }
 };
 
-- 
1.9.1

