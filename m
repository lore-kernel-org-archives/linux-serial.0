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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C0DC433DB
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C4264EDB
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCOJp3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCOJpH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:45:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A91C061574;
        Mon, 15 Mar 2021 02:45:07 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso14432380pjb.3;
        Mon, 15 Mar 2021 02:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tOoCblnGCn0autrjLck7UDYY0V/VfAyg4OpABraTu5c=;
        b=cSgn3/VrdJ9K+fHgQvj0JRj+1ixTvuzgxw53V+BWiOOuuJGfVeU6aWLE/rkTeFKtNt
         Gg6ap+5Qfj6Mr7M7izHyeWOuHsN2PvAwWroYfAr9x4c2hP7/cDH3NOecfAn/yW7WDtTR
         3NWols9NvFyDVAjeRUZa0X+E1WEFxEHoHqCE/rjpIE94BoKUG4KNmb9aqybPpDej3JTP
         yS2clI/MKhGlrjCyYMiAXzTo95TFxPsVsAWNviOwBicaMCEnedgipg3KEMmtHf2VhsDG
         B8FvhoPtdUB7x4ektSH1BGL+a0BrEaUbvxBshC03evEz7N1BpYeGMBie7TIcMTfXVKv3
         7AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tOoCblnGCn0autrjLck7UDYY0V/VfAyg4OpABraTu5c=;
        b=aV513drAkdGdgiO0YK/UyZ4dQkUU6qAbBr0AF0LtjotESTI6fVRqn5TmwzWn8sKseK
         Myb37w+Mw/D7156vVAIurh9AgxcqG1F8dssZWXPczQACSQfpis+iZGhvprgy7E9fofv3
         SCQRO+pv/HDwWFRb/nmSbTDnZCI/QsjDmIPFgbKx8V1yCSxg7sc4+IUz5tO58h85ejSG
         PnmqkzcoKSERZPk9ZEg30KbWmCxGNMq0onqor6jkTZY1i40A5DwXcj1D3v0Ke9U/mlko
         YctVvah0eyo/cn8G3siliUcLK0KyLEKDyZoOSkFmWNetvUuQ6xi301Pm/V7XE1brXmEF
         e4bg==
X-Gm-Message-State: AOAM530FxH16rMiyq29x2ch4/5TRIPLwOa7j86D7zcpZsOrYsDMHIhgw
        pUE3XLHdXAIgE1MA4q+V5m4=
X-Google-Smtp-Source: ABdhPJyrNAck3eIUhrE0yMFv47thj1GYls2iF80EGKKoMadENg1YpPbxk+Hs4Yu+2BpC7WZD0SQy5A==
X-Received: by 2002:a17:90a:a584:: with SMTP id b4mr11793403pjq.186.1615801506942;
        Mon, 15 Mar 2021 02:45:06 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.45.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:45:06 -0700 (PDT)
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
Subject: [PATCH v3 5/9] ARM: dts: stm32: add stm32h750-pinctrl.dtsi
Date:   Mon, 15 Mar 2021 17:43:52 +0800
Message-Id: <1615801436-3016-6-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
References: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch add stm32h750-pinctrl.dtsi which just
reference stm32h7-pinctrl.dtsi

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32h750-pinctrl.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/stm32h750-pinctrl.dtsi b/arch/arm/boot/dts/stm32h750-pinctrl.dtsi
new file mode 100644
index 000000000000..24e99970167c
--- /dev/null
+++ b/arch/arm/boot/dts/stm32h750-pinctrl.dtsi
@@ -0,0 +1,11 @@
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
-- 
1.9.1

