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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AB9C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318156195C
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 08:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhC3I7H (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Mar 2021 04:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbhC3I6f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Mar 2021 04:58:35 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B3C061762;
        Tue, 30 Mar 2021 01:58:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ay2so5806296plb.3;
        Tue, 30 Mar 2021 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v9G2KuPIg00fMkHFtxzc36ViAJiRyj7R2G3zNb7KNvo=;
        b=hPsn56mwY+F0xi8rkTRM9xqDEsa2cBbCaN0oUfCF37/qW4kLGxOzvWJvKRHx7NvvyC
         SmV4dAzrGLeOVnlg72NqYGXZJJgXXd2OwJuBEMR/xeULu8iwMsKDSnrU/QIaLaXDNuf2
         yzL4irYPCDLf+oJuzeLhwuZnH2blmdviTXjkyTetHHngdYr0KRgslMkrcFCNDKLyGWnC
         xav0MGI/F7jekmFUcm6zApkqi2ZzSZCEYdw/e8TtxwmJ1K9bVV7K1hoUqQCswDugT9gx
         LOoRn3yQzQspSmC70c6MxE4uOt0xgLlGG+AiEykzvRXr/hUulMhorKvjll4FdvBfXESY
         8S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v9G2KuPIg00fMkHFtxzc36ViAJiRyj7R2G3zNb7KNvo=;
        b=kVuXzAze7PZYIQad1jpyKwIs/3EAVHfqn0CELgtdRKhwlV9/AliTiKSYKNjXxOnIQN
         2HWUXysU55IYoCsaWr91shQWsOb0Tn0+eZGcTPYEPFmUVztB/MtmOZZHyTiVUphtlg73
         H14g5SjWoOoMEbIe1vD1OQoLw0yqlIy/wKb+Azk5N97cpYnJeJCpxhU5ens6kocvN3MO
         GQTiEN2FWPm/KbN+bs4xctqvQOAkWhSNn2UjRWjg9eozyUjFyEsYU+aeWrUcGEmfNR6n
         t6QnYgrIM5RQ0O8aJo0er0wUCyMhj8pF/AAw7EAtSSfxPvoOfRFsyL9374VVpLNXWGUO
         LqyQ==
X-Gm-Message-State: AOAM532jhJqOMx5N0Mmrqy3OvimzNkcc54iTztzXrSwm1P8QvbaR6HXC
        ufT2LT3UNhRd4tMi1phbFeg=
X-Google-Smtp-Source: ABdhPJxe3KK+4Nqy5pQI1XwboPWMy5d6xSYu8sF6E23d0LEZA2IVhbeDRqckAk3uauw67+swQjM1Tw==
X-Received: by 2002:a17:902:7407:b029:e4:9b2c:528b with SMTP id g7-20020a1709027407b02900e49b2c528bmr32968487pll.6.1617094715188;
        Tue, 30 Mar 2021 01:58:35 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id y8sm20952642pfp.140.2021.03.30.01.58.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 01:58:34 -0700 (PDT)
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
Subject: [PATCH v8 1/6] Documentation: arm: stm32: Add stm32h750 value line doc
Date:   Tue, 30 Mar 2021 16:58:19 +0800
Message-Id: <1617094704-10040-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
References: <1617094704-10040-1-git-send-email-dillon.minfei@gmail.com>
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
v8: no changes

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

