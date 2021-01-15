Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90717C4332B
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 21:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52768235F8
	for <linux-serial@archiver.kernel.org>; Fri, 15 Jan 2021 21:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbhAOVRA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 15 Jan 2021 16:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbhAOVQ6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 15 Jan 2021 16:16:58 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210AEC0613D3;
        Fri, 15 Jan 2021 13:16:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c79so6290075pfc.2;
        Fri, 15 Jan 2021 13:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P1F2p8q5a6/P2LLGT6PbiRW8fW48uJP7OTSXVwwF5MA=;
        b=smsaGFHkbJzmruXEkpuRLUcyKuZJrQLw8O3xlWLdYGLSNBskkyMhPnSjJJFugY8tkN
         q9fVLzd+l49uJIui0LvlA3Y7rKQbnYiqjl/3SUTPOTRtYpqVkaH/eWbioy0lKkUQXLX/
         aKoNM44cn7Q83F2jafUTqVircxUDuVihjI8fAOqVftKBznkQQiy9wE7Zr3uk17vKJL7e
         JNW1sRa3WVbmqFFEWuOCVqmigmYW5VPVXyUAAS+ktk4YfLdI0U7vtnAxuMRUVUikfdHj
         8HOk1DDt+fK7C8PSGoOlHYr/wAX/kUVfR12meuwOdnnqHfyuorWPDnW9iSb/ncGmFnWx
         uwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P1F2p8q5a6/P2LLGT6PbiRW8fW48uJP7OTSXVwwF5MA=;
        b=f+XxR84nc9lXu/DYAABukv1LJfndfiC9NGnz+3tO8fWCezVQZJWb5vOBX96Frh1B51
         dn1vg1i3EQV5ERuejGbdV694/q12R9ES6VhvPb4gtqgajGxgls8H41gd7lBpLy32rqU+
         BugY5TRDZp4k9NCu1rnrQkyvIeVdVZt58VmfDBUVzw+gTMTFuvTEFVSCX/ossXRwp2/a
         ViNaOyyJW9yx2edXgEnKt4v9k3JMFZJBxMFPvxEPh4QympEas+RTShe800QSrRHQImj2
         nllcfONjCeEruLKWThuj4fzX4QHWwl8/2rfoqye5P1MEFQqYv3IH1uE5DdfOybsYhGzI
         QoRQ==
X-Gm-Message-State: AOAM532aizEIlIn4wT5v3iJOkDKJgtCZStyNZYYv83YekF06Sf8kgEH8
        wiU670c/A3a5x3752AizTs/hB/vbtzw=
X-Google-Smtp-Source: ABdhPJxnMYqdYNxQBggNBk+ryw2wEC+n3MYVAbYXP54Qa3XmUNm3PJ8f62vX3almY1OHFUg4KiV/GQ==
X-Received: by 2002:a63:4f5d:: with SMTP id p29mr14430811pgl.110.1610745377498;
        Fri, 15 Jan 2021 13:16:17 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 77sm9321827pfv.16.2021.01.15.13.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 13:16:17 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/2] serial: 8250: Add driver for Broadcom UART
Date:   Fri, 15 Jan 2021 16:15:41 -0500
Message-Id: <20210115211543.33563-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

v2 - remove the patch that modified 8250_of.c to keep it from
     registering before this driver when this driver was deferred
     as it was getting it's "clocks". This was fixed by changing
     the Device Tree entry to remove "clock-frequency". This results
     in both drivers getting "clocks" and getting same deferral.

Add UART driver for the new Broadcom 8250 based STB UART. The new
UART is backward compatible with the standard 8250, but has some
additional features. The new features include a high accuracy baud
rate clock system and DMA support.

Al Cooper (2):
  dt-bindings: Add support for the Broadcom UART driver
  serial: 8250: Add new 8250-core based Broadcom STB driver

 .../bindings/serial/brcm,bcm7271-uart.yaml    |   94 ++
 MAINTAINERS                                   |    8 +
 drivers/tty/serial/8250/8250_bcm7271.c        | 1131 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   11 +
 drivers/tty/serial/8250/Makefile              |    1 +
 drivers/tty/serial/8250/bcm7271_uart.h        |  158 +++
 6 files changed, 1403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c
 create mode 100644 drivers/tty/serial/8250/bcm7271_uart.h

-- 
2.17.1

