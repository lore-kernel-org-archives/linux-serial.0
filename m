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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE144C433E5
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66312619B6
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhC3C3Q (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhC3C3K (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Mar 2021 22:29:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C7C061762;
        Mon, 29 Mar 2021 19:29:10 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w11so5372843ply.6;
        Mon, 29 Mar 2021 19:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ANuxb7gF/2uSjo8wAVVkzCbU+cgTOCTj6IKlURPEBH4=;
        b=WqOGyjGK0dUpRDlIHt2FK03UP/unGRyJqJf7lTtjsRwFDnJnxR4DTtEDF8R/JB/8HT
         c2AE8dHUpRXfWSHUoJfRXqckycLvUrQbF5+nUaDNrCQm1sPT+THiNZHEXAXeHb5PBpe8
         07foIprOHyBxfl3/gDvpFRU/tUdRWsxuNLB/7og1d9bjeiwtIsd6WQQhAILiGxia+luz
         rGleDSazC/0ENNVLmLuhnnAnm5fv7rMFAMKbUXX0oOSc4fs+db1saUD+KfIB40/jaMBI
         n4Hr5OHg8Zm0amxnMXoChz8Hf5cW75Giy9q4JkllPHP2QKkSIPUw6kyjk9lkNKhaPg3o
         n2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ANuxb7gF/2uSjo8wAVVkzCbU+cgTOCTj6IKlURPEBH4=;
        b=Wwq55Gg8d+8/1HT76Q+l2Cy0uJ6D3CLS8ihchu3sYkkOXuL7PvJBSUtGEelvJ2bTwQ
         1c+LY4wfmQt6nlLS5RmwEZ7sdjYBKFikeuJqCMap2opThI5S4el3jShS4X3qGZnH+B1Q
         4nWOMRqkWTs03OnF+GC1Bgrl/S9ggC7nHX/tA+5fJfOTiR6FcK5pt2StpfqupiNwM4cI
         bYr1kczZ0MBQeyIe4lApKLNHujuAmJfbeLi+zVJ5XxYdzjJYeZVvzZ8yO9jx5j1tkjun
         Xo1r03UV3OizQB80iAn6Yv/ayediCgsOiT1v0ikgnq7brmeNITkBtya+QguYfUJd+oj0
         8y8Q==
X-Gm-Message-State: AOAM533QKrzRrMMJHUmOr3LsTlFqGGEGw5zuYmbSJX6Ymg7PDlfTP45k
        YxGzqQj+FmYq/bd3Fiew+k4=
X-Google-Smtp-Source: ABdhPJwdALX+37u6+nPfUkSA0LqCb29AuIL/icgTQRftJeqnQf4tdEwYJO4k4sfSU8UAEYLhO7SvBQ==
X-Received: by 2002:a17:903:2285:b029:e6:faf5:eaff with SMTP id b5-20020a1709032285b02900e6faf5eaffmr30957762plh.70.1617071349721;
        Mon, 29 Mar 2021 19:29:09 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id i13sm17681385pgi.3.2021.03.29.19.29.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 19:29:09 -0700 (PDT)
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
Subject: [PATCH v7 1/6] Documentation: arm: stm32: Add stm32h750 value line doc
Date:   Tue, 30 Mar 2021 10:28:53 +0800
Message-Id: <1617071338-9436-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
References: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset add support for soc stm32h750, stm32h750 has mirror
different from stm32h743

item            stm32h743     stm32h750
flash size:     2MiB          128KiB
adc:            none          3
crypto-hash:    none          aes/hamc/des/tdes/md5/sha

detail information can be found at:
https://www.st.com/en/microcontrollers-microprocessors/stm32h750-value-line.html

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
v7: no changes

 Documentation/arm/index.rst                    |  1 +
 Documentation/arm/stm32/stm32h750-overview.rst | 34 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst

diff --git a/Documentation/arm/index.rst b/Documentation/arm/index.rst
index b4bea32472b6..d4f34ae9e6f4 100644
--- a/Documentation/arm/index.rst
+++ b/Documentation/arm/index.rst
@@ -52,6 +52,7 @@ SoC-specific documents
    stm32/stm32f746-overview
    stm32/overview
    stm32/stm32h743-overview
+   stm32/stm32h750-overview
    stm32/stm32f769-overview
    stm32/stm32f429-overview
    stm32/stm32mp157-overview
diff --git a/Documentation/arm/stm32/stm32h750-overview.rst b/Documentation/arm/stm32/stm32h750-overview.rst
new file mode 100644
index 000000000000..0e51235c9547
--- /dev/null
+++ b/Documentation/arm/stm32/stm32h750-overview.rst
@@ -0,0 +1,34 @@
+==================
+STM32H750 Overview
+==================
+
+Introduction
+------------
+
+The STM32H750 is a Cortex-M7 MCU aimed at various applications.
+It features:
+
+- Cortex-M7 core running up to @480MHz
+- 128K internal flash, 1MBytes internal RAM
+- FMC controller to connect SDRAM, NOR and NAND memories
+- Dual mode QSPI
+- SD/MMC/SDIO support
+- Ethernet controller
+- USB OTFG FS & HS controllers
+- I2C, SPI, CAN busses support
+- Several 16 & 32 bits general purpose timers
+- Serial Audio interface
+- LCD controller
+- HDMI-CEC
+- SPDIFRX
+- DFSDM
+
+Resources
+---------
+
+Datasheet and reference manual are publicly available on ST website (STM32H750_).
+
+.. _STM32H750: https://www.st.com/en/microcontrollers-microprocessors/stm32h750-value-line.html
+
+:Authors: Dillon Min <dillon.minfei@gmail.com>
+
-- 
2.7.4

