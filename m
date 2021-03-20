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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8196C433E1
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 01:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE3E61984
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 01:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbhCTB5O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 21:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCTB4s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 21:56:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AE0C061760;
        Fri, 19 Mar 2021 18:56:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so250293pjb.0;
        Fri, 19 Mar 2021 18:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NZqCG1BKSopctCZmH8MjxDzkFx6uDWuPlT5Y4Y0AE4Q=;
        b=frzQP6Zrz7NAje5ocuXuKRjW8oXfDthDtHOBsW4rTw1GPYDlTJxnWKAOEwMWsHFd0o
         X8ducxiNn2UgFMDiiFAls7nxZkhfIie//B/7CzE68WitjNUQ0zhjfKVI/fM9dnuZduEa
         vCgqwkesklnfnfeHkRV1cix7alp1MJ6bM78313LBYwkMcfHmZbwHH71YPSOekOOhBfp0
         LqslE9Gc6AWgPVZdtjYgxFC9gEZCjlD6KlrGzIL0aaiqq/7tVojQ7L5VLhGOrX/BgWnC
         ppHJFyM5wRTXOGnl9EmrgRyh4hFO+Zs+FLlszb2bGHOofDif41Bz17U095nIq6vrR/US
         tm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NZqCG1BKSopctCZmH8MjxDzkFx6uDWuPlT5Y4Y0AE4Q=;
        b=h3Ui1pWUMHmEteS74hnSE2pwGj97hh8Q/UWMmMI5Lvb/rxmln0A4t8Ny3tlTObrsvV
         GgrPeRkwJbitaaC8YiP8wqN5fT7XeAQ0HJR2SLZDgPI59ADZ/R//ZYZncKDgthTwZ3S7
         zgzvDP6rm8jcmk6e+jCSW6nNkoVBCIDOXG6LEjqmhU8L19rUc6soDbxStya+mUCFwPMo
         LubE/YTI+7lJGpUZO0s0c8mv789OebYAV0FBHP82cgFCRVGHgvOPEyTc4wtyoDQiWJK9
         7jrWQ5kMOiEB7ck50DpUva30cL4aS5TakkUeOIOmViKGzYRdTnG40weqbtpiFW0H3xCx
         5WAg==
X-Gm-Message-State: AOAM530spCUNY/jZmUCWOxZvR0cSLQ1/MhvY+/68z4cjmt1K4bexZxwB
        SnzLTxN5uKpQ/lsLAR7TDWo=
X-Google-Smtp-Source: ABdhPJxwZo6kRPPnRKE5RmrlkQ0bmgXeR87LlgDSM7i4D1+trkj1aBL8lLhzh2HAC3guEeCSWyze9w==
X-Received: by 2002:a17:902:8d8a:b029:e6:b2ea:9074 with SMTP id v10-20020a1709028d8ab02900e6b2ea9074mr17180579plo.30.1616205408157;
        Fri, 19 Mar 2021 18:56:48 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id y7sm5755904pgp.23.2021.03.19.18.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:56:47 -0700 (PDT)
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
Subject: [PATCH v4 5/9] ARM: dts: stm32: add stm32h750-pinctrl.dtsi
Date:   Sat, 20 Mar 2021 09:56:19 +0800
Message-Id: <1616205383-24114-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
References: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch add stm32h750-pinctrl.dtsi which just
reference stm32h7-pinctrl.dtsi

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v4: no changes

 arch/arm/boot/dts/stm32h750-pinctrl.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/stm32h750-pinctrl.dtsi b/arch/arm/boot/dts/stm32h750-pinctrl.dtsi
new file mode 100644
index 000000000000..ef8c4d881dba
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h750-pinctrl.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) STMicroelectronics 2021 - All Rights Reserved
+ * Author: Dillon Min  <dillon.minfei@gmail.com> for STMicroelectronics.
+ */
+
+#include "stm32h7-pinctrl.dtsi"
+
+&pinctrl{
+	compatible = "st,stm32h750-pinctrl";
+};
+
-- 
1.9.1

