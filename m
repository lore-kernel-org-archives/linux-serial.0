Return-Path: <SRS0=CVbj=7E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C12CC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 07:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BF82073B
	for <linux-serial@archiver.kernel.org>; Fri, 22 May 2020 07:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnOLgG6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgEVHTm (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 May 2020 03:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgEVHTm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 May 2020 03:19:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D0C061A0E;
        Fri, 22 May 2020 00:19:42 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so4611084pgn.5;
        Fri, 22 May 2020 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3/liqRuDzwdMo012gdSnRvW2Rvf3VSnwHnOageukUsY=;
        b=jnOLgG6OKYFi2ob37vBusv9IEsrnYR8tH1fTYJfHI1vnAFWu8fHOX7PxDd4c8PX2i/
         XveByleCyKjkICjF12OX/qnSEQXbEMIuXKKt50N+SZnNtROY5ce5+ETlKjpFyjqULY9R
         E+mo0NMu3xuhMxeq2juNhAPfUpYJDbR48/p8+jyO7iTjVcd+DAgqhl/YM7kbdpTyR5SG
         V6wUEOIRCOdSk5dFw2ZCGL4HRis1/pn38cE/i0jICv5NbQZA+ySwRgw4tYKRC55HDWo8
         bUoAKwjuithxERYz8taz8ZGUKPM/7FtdhbZxs5++IATy4tdg7RY1Zk9G083Y494urA1C
         UsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3/liqRuDzwdMo012gdSnRvW2Rvf3VSnwHnOageukUsY=;
        b=Q6j3ovSnIbqPOQhdpuxIrps8LAQgGxVrAfwUpyNmnfM9RtxGvKvp2WaiKiHBc4biMh
         THgmb4UDp+6pwDrq6N3L/cYfoWrGRUyVs7v9AW5lDjZbY2WhmyEx/OAbO3/zPyIbvj0p
         roLKjCiVk2FD/3dxcHq1dQlKi/vW+nNBPUraXmxkXIgOFbNk4rFlRO98/3jmLH+HrA/f
         poL87J9HCDYLIWI9ppob8RMUVGQi90BxHrW8X0z5QJqXqJT+lzRhFZwi3u2qUyvJLF7D
         nHTzBkfxPNtJvTMlpnvyrc8FRV4yYMSMfDd5U5Xv0DrJ+/ezkdBtqbRVYg3QsyV6cGY5
         wjrQ==
X-Gm-Message-State: AOAM533qlFZ+kysvui4SR8Askl5C/CFp5S02w8xGtzxeE/hCVxySD77t
        huvALp55e2RF4KuHLS6sFuk=
X-Google-Smtp-Source: ABdhPJwc7fScpawVIO4N17H/NuHm9wPyyo4CK0L7n2PHBKo99fwyie0Py1E/VacyFPRN/lQQW6UrRA==
X-Received: by 2002:a65:400d:: with SMTP id f13mr12198963pgp.336.1590131981805;
        Fri, 22 May 2020 00:19:41 -0700 (PDT)
Received: from bj616583pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t20sm6017894pjo.13.2020.05.22.00.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 00:19:41 -0700 (PDT)
From:   gengcixi@gmail.com
To:     gregkh@linuxfoundation.org, jslaby@suse.com, oberpar@linux.ibm.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     Cixi Geng <cixi.geng1@unisoc.com>
Subject: [RFC][PATCH V3] GCOV: profile by modules
Date:   Fri, 22 May 2020 15:19:17 +0800
Message-Id: <20200522071917.17163-1-gengcixi@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
to control part of the kernel modules to open gcov.

Only add SERIAL_GCOV for an example.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/tty/serial/Kconfig  |  7 +++++++
 drivers/tty/serial/Makefile |  1 +
 kernel/gcov/Kconfig         | 13 +++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index adf9e80e7dc9..6df002370f18 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1566,3 +1566,10 @@ endmenu
 
 config SERIAL_MCTRL_GPIO
 	tristate
+
+config SERIAL_GCOV
+	bool "Enable profile gcov for serial directory"
+	depends on GCOV_PROFILE_PREREQS
+	help
+	  The SERIAL_GCOV will add Gcov profiling flags when kernel compiles.
+	  Say 'Y' here if you want the gcov data for the serial directory,
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index d056ee6cca33..17272733db95 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the kernel serial device drivers.
 #
 
+GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
 obj-$(CONFIG_SERIAL_CORE) += serial_core.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3941a9c48f83..4d75fa158726 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,6 +51,19 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
+config GCOV_PROFILE_PREREQS
+	bool "Profile Kernel subsytem"
+	depends on !COMPILE_TEST
+	depends on GCOV_KERNEL
+	help
+	  This options activates profiling for the specified kernel modules.
+
+	  When some modules need Gcov data, enable this config, then configure
+	  with gcov on the corresponding modules,The directories or files of
+	  these modules will be added profiling flags after kernel compile.
+
+	  If unsure, say N.
+
 choice
 	prompt "Specify GCOV format"
 	depends on GCOV_KERNEL
-- 
2.17.1

