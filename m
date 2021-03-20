Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23E0C433E2
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 01:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801B76198A
	for <linux-serial@archiver.kernel.org>; Sat, 20 Mar 2021 01:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCTB4j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 21:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTB4c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 21:56:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916C5C061760;
        Fri, 19 Mar 2021 18:56:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso5683266pjb.4;
        Fri, 19 Mar 2021 18:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3ShiRqmN0JVa7UhRNey/XzmB81pk8gwokmcnEoRtZ68=;
        b=lnoO8EC47b1zev1YAg9sLSZDt1rQHZQoUIj/W3gCgf+drSwZ+9MYBho+okxDktJsm8
         hHyDWAZYIvN4i0qlDyd3McRuEw1EolhomoTxxuaIvuLpoaLiowy05aun5VSTcJJKG6r9
         jBGC/88rD3WhGq3s6f7CpGNGaUAct3Fx1yXFnOgXBsEb8NBuB23OKUdlOc3pD+O4hyPd
         fuKUztdmDf7QT8agMlCXPH0Z/3raGueZN1nlMAJwmsdCNQMc0/L86nOSLTxl+tODMKU1
         1cFVomOWc7XCBJI7RKjjaV/ONtrKPrIkbchoh1jeMKKkVj85jSXUwMW7tAiZYe6hCcrB
         BA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3ShiRqmN0JVa7UhRNey/XzmB81pk8gwokmcnEoRtZ68=;
        b=c8oU9QkQWJXhWOo5vyb3RAYNIjLiIel2gZSL0vHE+92X+XgScLPpdI7ZdbKDutvVuN
         wGkO3/FNG4dlFjUcb763okrjkKPtIWQ/9HwRW0KhPoMiOVnzfLrFHUJDW+etCCO0n+xe
         yh1wDM8gXrKTbkSYcvvVZumEEdsA1hkfUDNoO3R3oTIgB9NWIdMN2tRkbEwrgJ/7pYTB
         3jIrI3lKNjgWf+R0RI11VJ8cBlcWotCQb2DR35vUB/4mz18xxIZNQZeHcQQ6fOy7eaPV
         ptFTPbfFP99hjkEeMfpF90r3xc0FjU8JzGB9z9qLo7zH1JJ7XE+UXsRhYAFrEjpkeYmY
         gypQ==
X-Gm-Message-State: AOAM530MFo5qCxmgShEk+y+Qu1ZqoW/UG/GgBnws81xBv9scOIyP0Wre
        h6Wy3KMWaXjziJ0hTUcioQQ38Tyctpvp2/Mh
X-Google-Smtp-Source: ABdhPJwdmLZ9tPsAf4H46sMWQthR3e7xLPl69X/OObl2TUeDve+jHfupOIAJ8yGrtV6h3MSoHoleZw==
X-Received: by 2002:a17:90b:fce:: with SMTP id gd14mr1345409pjb.64.1616205392029;
        Fri, 19 Mar 2021 18:56:32 -0700 (PDT)
Received: from localhost.localdomain ([204.44.111.4])
        by smtp.gmail.com with ESMTPSA id y7sm5755904pgp.23.2021.03.19.18.56.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Mar 2021 18:56:31 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        robh+dt@kernel.org, a.fatoum@pengutronix.de,
        mcoquelin.stm32@gmail.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, linux-serial@vger.kernel.org,
        lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v4 0/9] ARM: STM32: add art-pi(stm32h750xbh6) board support
Date:   Sat, 20 Mar 2021 09:56:16 +0800
Message-Id: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset intend to add art-pi board support, this board developed
by rt-thread(https://www.rt-thread.org/).

Board resources:
8MiB QSPI flash
16MiB SPI flash
32MiB SDRAM
AP6212 wifi,bt,fm comb

sw context:
- as stm32h750 just has 128k bytes internal flash, so running a fw on
  internal flash to download u-boot/kernel to qspi flash, boot
  u-boot/kernel from qspi flash. this fw is based on rt-thread.
- kernel can be xip on qspi flash or load to sdram
- root filesystem is jffs2(created by buildroot), stored on spi flash

to support the boad, add following changes.
- fix r0-r3, r12 register restore failed after svc call,
- add dts binding
- update yaml doc

changes in v4:
- use unevaluatedProperties: false to fix dtbs_check warrnings instead of
  add 'bluetooth' in st,stm32-uart.yaml

changes in v3:
- fix dtbs_check warrning: (8002cbd78fd5 and 4bc21d3dd678)
  >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: pin-controller:
     {'type': 'object'} is not allowed for {'#address-cells': [[1]], '#size-cells':
     [[1]], 'ranges': [[0,
  
  >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: 'i2c@40005C00',
     'i2c@58001C00' do not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$',
     '^[^@]+$', 'pinctrl-[0-9]+'
  >> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800:
     'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

changes in v2:
- reorganize the pinctrl device tree about
  stm32h7-pinctrl/stm32h743/750-pinctrl
  stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi --> stm32h743i-disco.dts
                         |                          |-> stm32h743i-eval.dts
                         |-> stm32h750-pinctrl.dtsi --> stm32h750i-art-pi.dts
  same to the stm32f7/f4's pinctrl style
- fix author name/copyright mistake
- add compatible string st,stm32h750-pinctrl to pinctl-stm32h743.c as they
  have same pin alternate functions, update Kconfig description
- make item in stm32h750i-art-pi.dts sort by letter

dillon min (9):
  Documentation: arm: stm32: Add stm32h750 value line doc
  dt-bindings: arm: stm32: Add compatible strings for ART-PI board
  dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
  ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
  ARM: dts: stm32: add stm32h750-pinctrl.dtsi
  ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
  ARM: stm32: Add a new SOC - STM32H750
  pinctrl: stm32: Add STM32H750 MCU pinctrl support
  dt-bindings: serial: stm32: Use 'unevaluatedProperties' instead of
    'additionalProperties'

 Documentation/arm/index.rst                        |   1 +
 Documentation/arm/stm32/stm32h750-overview.rst     |  34 +++
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   1 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   2 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 274 ++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 307 +--------------------
 arch/arm/boot/dts/stm32h743.dtsi                   | 153 +++++++++-
 arch/arm/boot/dts/stm32h750-pinctrl.dtsi           |  12 +
 arch/arm/boot/dts/stm32h750.dtsi                   |   6 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts            | 229 +++++++++++++++
 arch/arm/mach-stm32/board-dt.c                     |   1 +
 drivers/pinctrl/stm32/Kconfig                      |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32h743.c          |   3 +
 15 files changed, 725 insertions(+), 305 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

-- 
1.9.1

