Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC7C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 20:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EF8464EBD
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 20:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhBSUiW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhBSUiV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 15:38:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE27C061574;
        Fri, 19 Feb 2021 12:37:41 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id a24so3992060plm.11;
        Fri, 19 Feb 2021 12:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B8EezfbVWzw/LHfKxvz9ZJM88DAwDcD9FuBD5q6oywc=;
        b=fjEtJObkQWm8bCNdL6VP3z8NEp6F4UWziWXuFlaQ43sEdCyElWnNtLEZAimhrQveqY
         SVp6pGxeGDJckCPB6T8uer2W4qOADhQnuUxtfsTbYLNE/LeiO5O4W6WNUxbtxNMyUFQq
         Xa7C7MB1+IdqXldDZNg18hRPk/hsXBnXnwFTeZjM6A1zBxnXqicgyiZ6+oJvtKfoJANN
         mcgR8+/FDsnReZXn7tdfVWF4lK13EPLFOC+2QKGY/j5TZfPmjHn9gkP3JYYu4ZVANNnl
         XLppS9FDxtdk7fJb9gr/X7oNdBDF3jv+HnBs2zEEmtDPLaI4vdTlfA1U0VpN7GHqhnow
         WWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B8EezfbVWzw/LHfKxvz9ZJM88DAwDcD9FuBD5q6oywc=;
        b=nBY87M3c2ZjDccSNbrSFWtRBzMKjCWTA+towVoX89BIi/xO2HcwFDDXC3lQCPs7YE8
         C5hx8HOc3rngfPEVm3rVR0PkSBiwanwVRkC5+0BbBNgjJQvi+uF1wahRKcHerV9+t5eS
         jhuDVgy8f4cuHHpcfTyX1hMpoQurVttYoMWexHd8enjtFkU1FKz6MNOXkAivaSvHqpGu
         1Q2Wd/1S35LkG+FqDm23ZJ8Qoj1Bv/8wqd/oFpQSccwWmYX9Ns2Sbi68Fu1k9vrlvRvz
         TY8NdzVthTbUyla5oKm7BX4BuQAS+dTk3xqOYjN7Q/+Rrm1o6DYVIKtDiet2sIC5AZts
         HMag==
X-Gm-Message-State: AOAM532MlNeS79uM4LRnTKiiiToKCqRUJCr7sQjN4vwMjzfbELlsfUq2
        ftG5hF3xuhLPdJ7FZQ/vG4SN7gYp4t0=
X-Google-Smtp-Source: ABdhPJzd9HKrlm6YV9SQZHr3S6p9Mm9kEI6Jd/xIaOD1HitAhW6w5tM+/iBd7qNORSTGDKr0eEZxSQ==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr11248012pjd.19.1613767060344;
        Fri, 19 Feb 2021 12:37:40 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id i2sm9040152pjj.35.2021.02.19.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 12:37:40 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 0/2] serial: 8250: Add driver for Broadcom UART
Date:   Fri, 19 Feb 2021 15:37:06 -0500
Message-Id: <20210219203708.49056-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

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

 .../bindings/serial/brcm,bcm7271-uart.yaml    |   96 ++
 MAINTAINERS                                   |    8 +
 drivers/tty/serial/8250/8250_bcm7271.c        | 1100 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   10 +
 drivers/tty/serial/8250/Makefile              |    1 +
 drivers/tty/serial/8250/bcm7271_uart.h        |  158 +++
 6 files changed, 1373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c
 create mode 100644 drivers/tty/serial/8250/bcm7271_uart.h

-- 
2.17.1

