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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7ACC433E1
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BC7619AA
	for <linux-serial@archiver.kernel.org>; Tue, 30 Mar 2021 02:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhC3C3O (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbhC3C3H (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Mar 2021 22:29:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D855AC061762;
        Mon, 29 Mar 2021 19:29:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v8so5363576plz.10;
        Mon, 29 Mar 2021 19:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lu4a0Lz+tvaJ+7tvKxJ5rrNZMNtgZSuhMggyHT8ei7Y=;
        b=rk9YOylG0DefTSPGN/Odz2q5+vEbI6WB3FVAKOvZrIZ83K4CuDIGyl72XYJCD+diCg
         Q/ynC83KMQq5ZbPNbeLzLYPFKRZD4NcA8J13fGzlDuF98DiwJ4edHqApzKKlOl6vTg9T
         QVa2iTNguVD8Q3nL+Ug4ni/kfbgzswNKHfZzu1ihC/3RZvyu8RS/j3SLHL3X8UxnI/F0
         WEPoQyFvkltff26M9BxUTSv+EuCDS7m3BOYoQG2DxrCmx+F26KpWOfhiJVBE98V4YQK7
         Sz2SjSDjbW3M4H4SK4e26sLEH3SFSnaxZp3SUxUmQrvqYWrRCqU2mPCeNVZWw/UdIUYu
         KqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lu4a0Lz+tvaJ+7tvKxJ5rrNZMNtgZSuhMggyHT8ei7Y=;
        b=sDJzF70ndNgBM8bkLB+tXe3r1O6ud4fByDSqyjN1uwt+JbqZp2kFsobNw8NrNaM8Fs
         G9ty/2Dfk30lF+52J1o9B2LyrhUnX8QxE0Sz852mnbmp7pcNbLwcy4z0YDYzsCserUqN
         dCuKObX89XjUDqhLTGnHMerwZv5WVnY+za9awMe1Buw2dBwCMddM+3/44GdiDs0uA9IH
         nBI8KHQBuh3tqseGel4t2N80BCX8I3Y3oXLjo3lGl9ZpjDO8VondlpBWMy9JB+GWD98X
         hzeB1cxYTwNjaPWzRGfciWNCYU+MTDcEwCBnKy3busIb6uUcvTcT2SwH/3ek1o/9erIv
         5ccw==
X-Gm-Message-State: AOAM530+WpjI/WZEUgIIjgBJTgBd5Cw2JjkhdHpBcvLynx7DhAiNBJil
        58bfY8msAGP6J+J7Xgbe18I=
X-Google-Smtp-Source: ABdhPJwh3gFqmwyzNbfqSdUMLgcsziEuxOYiGIZ8EhkeN0eWDe2/COfEvthZaBJk8UeraaKVWfEzxQ==
X-Received: by 2002:a17:90a:7f87:: with SMTP id m7mr2011924pjl.64.1617071345387;
        Mon, 29 Mar 2021 19:29:05 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id i13sm17681385pgi.3.2021.03.29.19.29.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Mar 2021 19:29:04 -0700 (PDT)
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
Subject: [PATCH v7 0/6] ARM: STM32: add art-pi(stm32h750xbh6) board support
Date:   Tue, 30 Mar 2021 10:28:52 +0800
Message-Id: <1617071338-9436-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
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

---
changes in v7:
- remove changes in
  Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
  Hi Rob Herring
  as you has already ack this patch, please ignore it. thanks
  history link:
  https://lore.kernel.org/lkml/1614758717-18223-4-git-send-email-dillon.minfei@gmail.com/
  https://lore.kernel.org/lkml/20210308195033.GA2855292@robh.at.kernel.org/
- remove "[PATCH v6 8/9] pinctrl: stm32: Add STM32H750 MCU pinctrl support"
  remove "[PATCH v6 5/9] ARM: dts: stm32: add stm32h750-pinctrl.dtsi"
- reference to stm32h743-pinctrl.dtsi in stm32h750i-art-pi.dts
v6 link:
https://lore.kernel.org/lkml/1616757302-7889-1-git-send-email-dillon.minfei@gmail.com/

changes in v6:
- add gpiox{gpio-ranges, ngpios} in stm32h7-pinctrl.dtsi
- add status="disabled" in stm32h743.dtsi 

changes in v5:
- accroding to rob's suggestion, replace false with 'type: object'
  of 'additionalProperties'.
- add Tested-by: Valentin Caron <valentin.caron@foss.st.com>

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

*** BLURB HERE ***

dillon min (6):
  Documentation: arm: stm32: Add stm32h750 value line doc
  dt-bindings: arm: stm32: Add compatible strings for ART-PI board
  ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
  ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
  ARM: stm32: Add a new SOC - STM32H750
  dt-bindings: serial: stm32: Use 'type: object' instead of false for
    'additionalProperties'

 Documentation/arm/index.rst                        |   1 +
 Documentation/arm/stm32/stm32h750-overview.rst     |  34 ++
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   3 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 341 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 307 +------------------
 arch/arm/boot/dts/stm32h743.dtsi                   | 164 +++++++++-
 arch/arm/boot/dts/stm32h750.dtsi                   |   6 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts            | 229 ++++++++++++++
 arch/arm/mach-stm32/board-dt.c                     |   1 +
 11 files changed, 787 insertions(+), 304 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

-- 
2.7.4

