Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9407CC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 19:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D2364E13
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 19:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhBLT6b (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Feb 2021 14:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhBLT6a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Feb 2021 14:58:30 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E5C061574;
        Fri, 12 Feb 2021 11:57:50 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id o63so362380pgo.6;
        Fri, 12 Feb 2021 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x0lAXp3U/g0l3OJrFf2vZ9CuZA+kZKT7TY6/m3gZV8g=;
        b=WPlnAWDts8qNdBgjoZyOVL7Agv+5C28OhkgbPV3F8Yk51n1a0Z7PxswJD3beYsH9iH
         bc86/OmNTRcKQEP4wMY46jV3SAk/PFWeGAkNcvpXNgtw3AmVjAdFLTkPosar4CSw7nOE
         qhNfR9qZ5Z0LRT/490Bn7ij8K10jNY84DJw+MRwvvP/gd8v+BBvyY2CZEzeBJIw2QajY
         1s77ptJHXVPVqLNKoYQ7cgRrqBYJCc3qgrTMD5XtcrWVNNkIWQ6IYRRbvU7jGyC6SfC1
         p9DR9PbFUSQN2B8/SRCAI1rGzs5GOEDMQmVbc3xiwhbJ/iGqoUqgBVTDQmrFQ8tZ3sIn
         wesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x0lAXp3U/g0l3OJrFf2vZ9CuZA+kZKT7TY6/m3gZV8g=;
        b=LXJbr5Zdvzn8sDzQKSyQjHH+Y7z7pdAu271d4GTO/nCFko8e0x72wfDq9ZUAweiF9D
         xSEzJ1dqGFWp3qEN+JKB7s9g9OvF+5zD5c384PfkftdlbyrJRq8nUald8JCDkzGrDHlS
         x2C//89K4NAYCRnPFD723UmaPCbP3JaTylGJrYot6KGcvxJ6+bur5slopcAFgxE5PAu9
         HyBXRQspGg9wNGthXTBLUhJoknlRp0m0f0CHC21L5ND83/JKeZo41DuAKLJo5lBwHcoI
         YumyXaqIseFagZYEog7/j3kOZnOaCTUdmMzbTHbl7ZnPnKmsLbemfM+JlavKsS0c4et4
         Fl0A==
X-Gm-Message-State: AOAM531MHaGUw+uBrkrUZo6mPcVaens5meuHdSkzGmSkC+KrjnQmygRv
        WYeoPqSB5RJml0erSkbdNNvyNpr7jeY=
X-Google-Smtp-Source: ABdhPJzgXmnV6GTKNCYNE5+/45uPJlRehFyW77kFWMvvRlfz6UX51akptA/xe1Lou7+k46JXh7uV+A==
X-Received: by 2002:aa7:9a46:0:b029:1db:57ba:5e2 with SMTP id x6-20020aa79a460000b02901db57ba05e2mr4255277pfj.5.1613159869674;
        Fri, 12 Feb 2021 11:57:49 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id t25sm10003819pgo.87.2021.02.12.11.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 11:57:49 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 0/2] serial: 8250: Add driver for Broadcom UART
Date:   Fri, 12 Feb 2021 14:57:34 -0500
Message-Id: <20210212195736.45328-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

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

 .../bindings/serial/brcm,bcm7271-uart.yaml    |   96 ++
 MAINTAINERS                                   |    8 +
 drivers/tty/serial/8250/8250_bcm7271.c        | 1099 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   11 +
 drivers/tty/serial/8250/Makefile              |    1 +
 drivers/tty/serial/8250/bcm7271_uart.h        |  158 +++
 6 files changed, 1373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c
 create mode 100644 drivers/tty/serial/8250/bcm7271_uart.h

-- 
2.17.1

