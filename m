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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF98C433E8
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 06:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF09C61A0E
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 06:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCYGTu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 02:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhCYGTl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 02:19:41 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F3C06174A;
        Wed, 24 Mar 2021 23:19:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ha17so612279pjb.2;
        Wed, 24 Mar 2021 23:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hMTMgDP5KgynP82z79q6WdnAk8Vb5kqZCsaqfEY6s6w=;
        b=ZUzX3kSMQx0D3ecxwsVzDU7oykbu3A4V/Be9Rg3fxvHz4pXA16tVgS8F5LelhuaD+j
         DPeDeJF0q2Gk032lhqq0nvgfinR5X1NdwV8DYSwVLbcuP31ymHJHAY3RD57x+4RDoAxz
         gRpDt4+IQWCJCEBXWV82vZZSsUkfymnAt/NraHa9ScsG4tEhRFRbBki8p8CbUMfCKn7+
         YdInz2MlbAssdqmUf1gtJMAOMdXbD7WJPxe4QSQnuEjW0IuOPG+Z+X0jd0gyJ++Rc5je
         YJyTh/rK02guSJOACfX7KFEnlUmf/zOHDutiA5+ljmM1ABd/P4aHXayx/zz1dMhlTGOl
         ib2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hMTMgDP5KgynP82z79q6WdnAk8Vb5kqZCsaqfEY6s6w=;
        b=ImJTJyf+DKJWeS9SkWEGuT+fy1tvEaLiIlLsT2g03jRT+RbV3eb2kzy7wgTJfPPu5w
         UoyL+16/OwnMv1U7CNXzzeunLO6qcd666UCOPossYQshlJcjWh/TjN8jyA4iM0Wsb2ia
         IX6c8otkr89ci7VseYndCBuXvu8KV2h3T+hwXrwU99OEGuydpjHfgUC7/Q84XwQ8uDFs
         HwKNWHf7g4aO9oj8qj/lhXtvwq2oyeXFJsaHDChkMOC74DynhNHtsZFwScvL1ln5Te6x
         2yo90Ci1yndRJ5mqa4olZ+pjghhUzZ8j18OHt38KL1QD9FgI3Umvv+bRNlcMgK5id7G1
         OOJA==
X-Gm-Message-State: AOAM532X66AJKa8OIknfi5P0hyXoyxvQgNo7HsoZOrz62if1uPNCEhEc
        uA/WZsEUwWvNZqv+irNpe+c=
X-Google-Smtp-Source: ABdhPJxsn1s7ZxAnDAyfj8LK68kGgP/q0iGXelo6xxh8qY6gTqMDj903e3alPP9rxHrNFtWFIbmfag==
X-Received: by 2002:a17:90a:cb0a:: with SMTP id z10mr7385707pjt.170.1616653181218;
        Wed, 24 Mar 2021 23:19:41 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id b19sm4393086pfo.7.2021.03.24.23.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Mar 2021 23:19:40 -0700 (PDT)
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
Subject: [PATCH v5 5/9] ARM: dts: stm32: add stm32h750-pinctrl.dtsi
Date:   Thu, 25 Mar 2021 14:19:18 +0800
Message-Id: <1616653162-19954-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
References: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patch add stm32h750-pinctrl.dtsi which just
reference stm32h7-pinctrl.dtsi

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

v5: no changes

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
2.7.4

