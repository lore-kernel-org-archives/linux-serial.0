Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD8C63777
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 19:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EBF32240A
	for <linux-serial@archiver.kernel.org>; Fri, 20 Nov 2020 19:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgLWOaHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgKTTpq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Nov 2020 14:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgKTTpq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Nov 2020 14:45:46 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457FEC0613CF;
        Fri, 20 Nov 2020 11:45:46 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g7so8875976pfc.2;
        Fri, 20 Nov 2020 11:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZVzA6BcrTZh0tSWw4NpPHXuO0gXGORPvDJECx8JucK8=;
        b=FgLWOaHjZ0f+Ob1LQWqJroVeWbvc+ZBQztZWdvWC6x4t/WBpFRk09IcVpP4QRpthDn
         oPeVexHzxtZdgbrPhoGqHyRPEYKEbbqEOOUeC5WEBQlhNdrtJMGxy5mv3fwr2Hl8hRMu
         t7LVKxvUZ/G7DrJwgvt8tqFkcgdOJR2baAkH+2zQYsKf2pUGLRQgrnDY2gXp+MHBiBzV
         +jinJhhWEFgOOg1cht7FQLBhbJoCkRey96s8mFFvJjlDuAUODFepKa7qwSYUbdgIUevb
         cngtkLq/9NET42s07yDzUpaaTnjv5m1UAModYjAExVtwIyaiO/jD7SX2YVBXYrKRENRZ
         SPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZVzA6BcrTZh0tSWw4NpPHXuO0gXGORPvDJECx8JucK8=;
        b=LcxYp/qKqIR6fc5Vbdm6ZRJluWtMSDwmSt7VIWlHLvtiYyXvTuEEPcfgeyyBIoUyec
         h30Ye/ArwhztlbC1fTLoD1Kxuv5z003XNpi+I9OHlIF1zF42+hdZOvqJef4nZ8O30/PH
         Oz6ti/qc032gVnK6RT1BhJGezAYmaNnYhBIx0/DiLHrXI927ooJR/3q7joNpd1Gq8ETf
         ac6px8gGIuYWWQf/DxyYyNII0TDbqsEgRi4NilcEhIWTpcT1n/E+Fdp6NnvwSyZXbPNp
         bOVWyaQlzAkxi2ivE6+Noq+rzYh8G9IpLPV73ENVItJOX7zdmSoAbWxw2fnj2YGYetZn
         pWQA==
X-Gm-Message-State: AOAM531oKdEFJRL743eX4boJVdwQTQ0kL3o3pwsCtsD41sgS/ldzliJk
        FWB7uI6fFMT2RxDpcwX8sZMkGI9iyf0=
X-Google-Smtp-Source: ABdhPJzQf/Rj1Vsba1yzL0jn1ipKLmVplUbWUrOf/qQASTlqZCh+KP4IKf9FenQVkaFIwoXym73Jcg==
X-Received: by 2002:a17:90a:f318:: with SMTP id ca24mr12180801pjb.100.1605901545652;
        Fri, 20 Nov 2020 11:45:45 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id b1sm3755884pgg.74.2020.11.20.11.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:45:45 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/3] serial: 8250: Add driver for Broadcom UART
Date:   Fri, 20 Nov 2020 14:43:02 -0500
Message-Id: <20201120194305.8847-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add UART driver for the new Broadcom 8250 based STB UART. The new
UART is backward compatible with the standard 8250, but has some
additional features. The new features include a high accuracy baud
rate clock system and DMA support.

Al Cooper (2):
  dt-bindings: Add support for the Broadcom UART driver
  serial: 8250: Add new 8250-core based Broadcom STB driver

Jim Quinlan (1):
  serial: 8250: of: Check for CONFIG_SERIAL_8250_BCM7271

 .../bindings/serial/brcm,bcm7271-uart.yaml    |   94 ++
 MAINTAINERS                                   |    8 +
 drivers/tty/serial/8250/8250_bcm7271.c        | 1131 +++++++++++++++++
 drivers/tty/serial/8250/8250_of.c             |    4 +
 drivers/tty/serial/8250/Kconfig               |   11 +
 drivers/tty/serial/8250/Makefile              |    1 +
 drivers/tty/serial/8250/bcm7271_uart.h        |  158 +++
 7 files changed, 1407 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c
 create mode 100644 drivers/tty/serial/8250/bcm7271_uart.h

-- 
2.17.1

