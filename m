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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7514EC433E5
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7B66196C
	for <linux-serial@archiver.kernel.org>; Wed, 31 Mar 2021 08:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCaI3C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 31 Mar 2021 04:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCaI3B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 31 Mar 2021 04:29:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B58C061574;
        Wed, 31 Mar 2021 01:29:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so805109pjb.0;
        Wed, 31 Mar 2021 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F5NUtjS6dxfsjXtQ30HdpWBe6Y3/aPDV1SqF5ADpjiM=;
        b=ny/yYl4F1Pyjiht+n0Z24bFu+natEzx53+EwmBOKQUC4py/lz2p099lks0VXZZ3ys9
         KCXCofA4wVF5O1KIu4J/+VjdDZSCRIN6ZJpEcPXX6YzOh6lqjhieWlrOL7gPIMlyHKDq
         rujclv32Xv4aMtRAFb+vFoaoQEjEcwdE4JxVR6ZMUp4n42zFSH0PE053KswNQE/ikc/P
         BWpgyRGlL7RBK6bN3JNibVK7dVgfpWhNNmXpRs5QTCDLsIAxDeex+1p1Vjmx4lw5HfUD
         vWyYFRKbayN356VvQZsquLoGNjkTV4HejAwO3/9/pNEI6y/IeSNPqeIHQg7BgQImgxQv
         dAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F5NUtjS6dxfsjXtQ30HdpWBe6Y3/aPDV1SqF5ADpjiM=;
        b=B71Ow6qQBTMSH/nHHkloKqM8nIMAsHUyXhBa05tvGsQuOvXp2s/5Dr6ummhERhK4EV
         qDm5sK6SobeqewtzaRBUe6981mebCpvVLC83u1oOdh+2c+iwigVqjsq+lM/bcJxzkGGf
         mHcTjl4G0yEwx8CWA8YLVWS9XIYup9d7Ber6UXNHCvPYViFI7ic08dvYpAgUkpUK+Ra3
         A+2KP9zsX1xsXDBJCjHplLFRXWHZLnIFigLBzeQPNBaNmY95DQKLzaOe9VWXL8s9lQIn
         8OmLGXi9Seq6MV8phDkpxyRw1QUUTY4G/rgYonn0sAC4Yd4yoh+JWBu8fPu3xW4/ZR8z
         cuow==
X-Gm-Message-State: AOAM532E7IKnEgBMFCdCdjg8qOaJrqUraXki5V37LfNZpEyfdYVlG0VZ
        TpXAUzU6Kp1C0f5hMW2g9F8=
X-Google-Smtp-Source: ABdhPJxbhPeX1fiW16IOjwj6m0w3Xq2M7a5cxBDHcx304ac76E5RljQgbU9jENBAgd7Chi3afCKj1Q==
X-Received: by 2002:a17:90a:17ea:: with SMTP id q97mr2466688pja.71.1617179340565;
        Wed, 31 Mar 2021 01:29:00 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id v1sm1420991pjt.1.2021.03.31.01.28.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Mar 2021 01:29:00 -0700 (PDT)
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
        patrice.chotard@foss.st.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, pali@kernel.org,
        mchehab+huawei@kernel.org, andrew@lunn.ch
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v9 1/6] Documentation: arm: stm32: Add stm32h750 value line doc
Date:   Wed, 31 Mar 2021 16:28:40 +0800
Message-Id: <1617179325-6383-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
References: <1617179325-6383-1-git-send-email-dillon.minfei@gmail.com>
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
v9: no changes

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

