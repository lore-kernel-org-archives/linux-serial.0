Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A428FC433E0
	for <linux-serial@archiver.kernel.org>; Mon,  8 Mar 2021 17:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CE76522C
	for <linux-serial@archiver.kernel.org>; Mon,  8 Mar 2021 17:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCHRFk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhCHRFi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Mar 2021 12:05:38 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802AC06174A;
        Mon,  8 Mar 2021 09:05:38 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id mz6-20020a17090b3786b02900c16cb41d63so3496938pjb.2;
        Mon, 08 Mar 2021 09:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lfj24uHfDXCDzPAd0u/gSCrkDQTvvskC3Jc39hYhWaM=;
        b=AzEIhwMdG3Hgbd1sqDWBlueOlLVvaMKnRdgDXZY68sdW/wTVrUikrHnYI/Enoruig6
         sHl5iUhRnEaLTcdEv98BoXvH2BOzkCPkQs27PNXXESIgkBW1wB0DlhHjvv0jzLmjxsZi
         Rmb2m67nZv60XJqWGNS1Ie7W4cPEY3YEzZ3KJ4YWbMoihZl0K51fxD1e5IxieX7Uh1VD
         fRys1udaF21b1X/h+91Ss1epEiQGI1YhShbw6E/alxaIQIGTEWo1X6PF6+OZbCLskdGY
         K7JRMiCE0im+XubZdXw3RB5xYc8qVL/q/L02D9hitP+iJ3g+0RvVsvHOIIR6CA28RZmr
         Gy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lfj24uHfDXCDzPAd0u/gSCrkDQTvvskC3Jc39hYhWaM=;
        b=eq9RYyXwC+aVx4uNe+NpMAYQlqUwBiJvC6zG5QBKXak/577M5v0yt75tHGEJ2xYCrA
         +fwQYnm8qpM2TLWPLMc25UkUUkpu++iMnbjZz/2ORfV0vkf2YXEmcJEyfS696w+RjBXs
         5uhdICml9v4mY33uCsXF/SFhtC+0F+rXH1tNdXLexpWdYpt+sEwgtVUgjuQu+UhtlNRy
         /6bzHIf4YDWzLI8PiKMpHsgQan7XIWQy2DQSfp3aluIqnUaaegtxUGPoVoXaSPG/uSN1
         aTTbCBOT3C8v+1N0YySgz+OPvEhsg5MdAspwPjV/BiHVV51m2z9Pcv68/dEnxffAcVTV
         6RIw==
X-Gm-Message-State: AOAM532a3FP/EQ2MztNJRFKNH8dMk0vFNrjrbiC9cdX8Yqu74KfDs2cK
        h6HjzS8/RhUtj4PU1d6NN/pp1e3dads=
X-Google-Smtp-Source: ABdhPJz6MrKazSqaRRattcXcCrDEHoxpAXXCzYxkO4nArhQuIYwzk0NGshAGxUG2tbXJsgwxtGQ8BA==
X-Received: by 2002:a17:90a:fd89:: with SMTP id cx9mr25586635pjb.93.1615223138001;
        Mon, 08 Mar 2021 09:05:38 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a21sm4980477pfh.31.2021.03.08.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:05:37 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 0/2] 8250: Add driver for Broadcom UART
Date:   Mon,  8 Mar 2021 12:05:20 -0500
Message-Id: <20210308170522.4272-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

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

 .../bindings/serial/brcm,bcm7271-uart.yaml    |   96 ++
 MAINTAINERS                                   |    8 +
 drivers/tty/serial/8250/8250_bcm7271.c        | 1207 +++++++++++++++++
 drivers/tty/serial/8250/Kconfig               |   10 +
 drivers/tty/serial/8250/Makefile              |    1 +
 5 files changed, 1322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
 create mode 100644 drivers/tty/serial/8250/8250_bcm7271.c

-- 
2.17.1

