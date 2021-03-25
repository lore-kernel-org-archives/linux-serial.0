Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF196C433E3
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 18:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD3A61A39
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCYSx3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 14:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhCYSxR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 14:53:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957EFC06174A;
        Thu, 25 Mar 2021 11:53:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so1345232pjb.0;
        Thu, 25 Mar 2021 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4LGaMRFJFSfjAnJik4GpOAMJdv6vPiTAVHF3TBntEwU=;
        b=C9BVJHxrjTf5laIPZ7AyMhIPsYqr8O9pG54bvFEIJe9JxDBGCJRIQnCiCSJp6I/u5C
         BHPGiw+yNEIsbh153KPQEGi98oStG5tw5f93KV1+I6oFvq3nTbkKIaa82Q7WeNGdtk2Y
         8e3Ig1KeXSGTBxUoyq2tdaqQ+qm3d/mz3sRPQ39J+0sWtovO4NXRsn/V1nRti2XpRdlL
         0FtGSOJZGyGbDRh3E3OmF+xvmGxeniR7YFLyEy7eWuOwpAFtpdOomCm0prnde3xrwREJ
         /t3BbJH431AsX6J7PxZMfqw6WSkNrVDMgEGBOz757MK4YvOKWuIexGhWpgsvVkfdPcnc
         PjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4LGaMRFJFSfjAnJik4GpOAMJdv6vPiTAVHF3TBntEwU=;
        b=Q1cMwNVD1ADOEzeX8LGZlUz15YpFOP8QOkkvVA6xyaup/4mJJt6Dd3Wm5mO976V9lK
         mLVQDtoka5VAq/L7ETBH1EpbVj+ZFB5OQzk1ILFTt+vSJfY4AfAlVMJqTeO4aVyEV/Z1
         7JC4ZL/WsVZkC45Yqw5gQV9Uo5yHmeGlB5+43j2p29hsF8VWKlG8bdcFfOargUuEXnfu
         68I6dkL8Z9ENWzvQawLvErLcatlcUXuniClCPb8Sy81yLJmRe044uo7cg8PsF1QMlFgy
         TmOi6RjpxTzN8osz+lDyEN2TBpa0DcWDmWll5Nx/aqPldZ5bmD9qLrpQOQijq4zFEktT
         wT9g==
X-Gm-Message-State: AOAM530yTVPID1NnPKt6anYhNfUu0pxGh6i5d0pGJ4OsNotbvzzPLoaq
        bYRnJKYhjsV88gWC/9T2pKvcPccEpIM=
X-Google-Smtp-Source: ABdhPJz3JRqBT3uumHeTGbTCodAIOp3xBR0A6ocgKg8cR/KLqOWCMNohHoXO/FXl0O6apGFoCJrP+Q==
X-Received: by 2002:a17:90a:fd89:: with SMTP id cx9mr9940463pjb.93.1616698396899;
        Thu, 25 Mar 2021 11:53:16 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id k11sm6085961pjs.1.2021.03.25.11.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 11:53:16 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v7 0/2] 8250: Add driver for Broadcom UART
Date:   Thu, 25 Mar 2021 14:52:54 -0400
Message-Id: <20210325185256.16156-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

v7 - Change Kconfig for SERIAL_8250_BCM7271 from "bool" to "tristate"
     so the driver can be built as a module.

v6 - A few more changes based on requests from Greg Kroah-Hartman
     - Don't save the debugfs file handle in priv because it was
       never used.
     - Change all dev_info() messages to dev_dbg() messages.
   - Fix warnings from the kernel test robot
   - Use --base with "git format-patch"
   - Fixes in the .yaml file based on requests from Rob Herring
     - Change "oneOf" to "minItems: 1".
     - Reference serial.yaml instead of using "$nodname".
     - Add missing newline.

v5 - Changes based on requests from Greg Kroah-Hartman
     - Move sysfs stats to debugfs.
     - Merge the .h file into the .c file.
     - Convert "flags" with only one flag to bool
     - Remove most dev_dbg() messages. Some can be replaced by using
       ftrace and some would cause a crash if the driver was used
       for the console.

v4 - Fix MAINTAINERS
   - Make all changes requested by Jira Slaby. The only functional
     change was to handle errors returned by brcmuart_arbitration()
     in brcmuart_resume().

v3 - remove "disable_dma" module param because it can be done
     by modifying the device tree node instead. Reduce size by
     removing some debug fuctionality that was no longer used.
   - Fix error from yaml compiler in bindings

v2 - remove the patch that modified 8250_of.c to keep it from
     registering before this driver when this driver was deferred
     as it was getting it's "clocks". This was fixed by changing
     the Device Tree entry to remove "clock-frequency". This results
     in both drivers getting "clocks" and getting same the deferral.


Al Cooper (2):
  dt-bindings: Add support for the Broadcom UART driver
  serial: 8250: Add new 8250-core based Broadcom STB driver

 .../bindings/serial/brcm,bcm7271-uart.yaml    |   95 ++
 MAINTAINERS                                   |    8 +
 drivers/tty/serial/8250/8250_bcm7271.c        | 1202 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   10 +
 drivers/tty/serial/8250/Makefile              |    1 +
 5 files changed, 1316 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c


base-commit: e138138003eb3b3d06cc91cf2e8c5dec77e2a31e
-- 
2.17.1

