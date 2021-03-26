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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF115C433F1
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB21C61A44
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCZLPt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCZLPh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 07:15:37 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33391C0613AA;
        Fri, 26 Mar 2021 04:15:37 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v3so4407576pgq.2;
        Fri, 26 Mar 2021 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJm2ylLmMokI00w8ehr07VS3lbjTqezFF/dbtRH1gMU=;
        b=qYMWPg6y3yfZTWJdbs+M8yjrTQa4u+bTqn65LtFAHgkb28m46IG6JCjFPdYa33Gx4o
         9EdcXMkLGRU/y7mJD7WAD3b/726QoFpw/ag3lAj0SYAgoY76oxY86E3XLAx42FzsqZE8
         XMM8LOY10QqAYlXOjXohVr8pmSV9FjARs6uOCdJTTs/RbZnlIWnyyIqWdcjmqiIkbInE
         AfPxryslLhe03kSPO4EAtVZowx8ezkDDgQern3Z6P+snO4kTTv0tQPUTO4oBYtyFatNR
         M6W5/GuFpXoHT3ec89gtEjymC+JpVuuxBo7HfRudSvRmzIRgEIG0n4xL03z8hO8qGWOF
         b2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bJm2ylLmMokI00w8ehr07VS3lbjTqezFF/dbtRH1gMU=;
        b=OISZ5YVCX58Q8cvgJ8fxbiMgqqVyYRTQXlM/xz2CRa1B1bQf38HG5ZMUIvfzGTAqjs
         bkXS94X16ZQDFw9n7e/hYytXmMHDTDCIEpFYUYh4efdcn75R8pYuSeGF03dsSAB9+X97
         CU3UHMUWqkqA8aOo0yGkz5S1VTqWtOWeLG8UqUyaiRbHCU3A/idz+JM2kwwveG2BH/kh
         xBi1nXDEeQ735WIJJivIkBfdWnglDkwn4xOgSwjP8hJ3obx9HKpVjqortL1sUoZ/vW8z
         IX4sZfcCdUDI1s/u/iovxBVrkDwXtsbI1cImAXaCjQ6mmCRmKYm+i52bYvJVRM6I8+EA
         erEQ==
X-Gm-Message-State: AOAM5333e4jtxHDtFv7HSabcUnqytSCkKGXvtMunUC6XaA5YgAYYm+jN
        j0WJAH/eTIP1GMvxKNEyqo8=
X-Google-Smtp-Source: ABdhPJzP55PHzHMDGvhOF3VjKRhU/ux4MZF4RBUmgCRBH+8oz1Hp1T3uYNnZU8+C+ELudGgTOflLYg==
X-Received: by 2002:aa7:990d:0:b029:21d:7aef:c545 with SMTP id z13-20020aa7990d0000b029021d7aefc545mr12257039pff.77.1616757336833;
        Fri, 26 Mar 2021 04:15:36 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id l3sm8108414pfc.81.2021.03.26.04.15.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 04:15:36 -0700 (PDT)
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
Subject: [PATCH v6 8/9] pinctrl: stm32: Add STM32H750 MCU pinctrl support
Date:   Fri, 26 Mar 2021 19:15:01 +0800
Message-Id: <1616757302-7889-7-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
References: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
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

v6: no changes

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

