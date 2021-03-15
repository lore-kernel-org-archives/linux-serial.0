Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216FFC433E6
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D185364EC3
	for <linux-serial@archiver.kernel.org>; Mon, 15 Mar 2021 09:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhCOJo5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhCOJo2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Mar 2021 05:44:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ADCC061574;
        Mon, 15 Mar 2021 02:44:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y13so6236395pfr.0;
        Mon, 15 Mar 2021 02:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PebrTRd7u+mXcD0wI0/r7L8uXu0acD1j/prwx8M6TtQ=;
        b=mgfUkEAhC5LIP4cR11FtlMukCLh8h7kKe5twBI1WEyhd7xUdhj1i8iTjZ/7mKxoa9/
         ZRP3xBOqP77EMZACzKyglNCTIXkjWV3yE9Cfu0WusHlHUiSO6L2gpP1+3hboEGXMzsTK
         KYZIiusAqG+RSgeu7uwWIn0rkJcui2XLLaRrHxAcdTlXOPmvhgNat1Lek2AfeLQ5idED
         AuLghNnlRUptu5SInWNSdYcPM5L/an58Jn6sHD++YFOxj6RCscQwcvd7DUdzr5DOCzHa
         9qV/Vw3h+BZX3PGlg6W2wzSM6yltcGIiWQvLiiEkWT4NrusBNwEY2Txy5YiKtASFevVq
         jNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PebrTRd7u+mXcD0wI0/r7L8uXu0acD1j/prwx8M6TtQ=;
        b=lK7FyxYSb6kNeZ9gwrEEPn0CwdFd6IjeoittuZuVLmWhoHQwkBqk8IehYauTJrsT2W
         3zzU8p+Vi09MKQvQzL9VJkbmzx1fY+rlB+wdXtxqyrJnlphW9Pdbx8h3xOFDN6ZwsXM/
         3huIFXhCMEHZKmdsGQZOnBRq2XkCQ7LV9oNZ2YS45IkUkr+LdBLLEA9zo+Fhsp2J0p0c
         g086GGcvQTJ9drYztEoytO9oUsCJc8H1deSPx2c92y5+cH1e+CuzzFubXpffM+3uTxJF
         vUhG+9v3fTWXmzQDpgzcaYBGW0IVFgRcpTYm2UmSBO/C47CwXorDOJoqcFXx385mFQtL
         Z77A==
X-Gm-Message-State: AOAM532laBPuj8HHBLSAfSBTuP0SPn3mQlpoOc11Ht0HDJsa+gqiNMrb
        68NubsvYHgI3B3PEukGYraoLaV3rvjtD6JzG
X-Google-Smtp-Source: ABdhPJyFz059kcqdKDWKYRE9rrtCXh8qyZNW192MKG6rY97k9ZUQnsfTnmv1Q9gOJdHwfTrAPZ5GnQ==
X-Received: by 2002:a63:4d4e:: with SMTP id n14mr22311393pgl.37.1615801467944;
        Mon, 15 Mar 2021 02:44:27 -0700 (PDT)
Received: from localhost.localdomain ([120.245.122.54])
        by smtp.gmail.com with ESMTPSA id 14sm12780811pfy.55.2021.03.15.02.44.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Mar 2021 02:44:27 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@st.com, erwan.leray@foss.st.com,
        linux-serial@vger.kernel.org
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v3 0/9] ARM: STM32: add art-pi(stm32h750xbh6) board support
Date:   Mon, 15 Mar 2021 17:43:47 +0800
Message-Id: <1615801436-3016-1-git-send-email-dillon.minfei@gmail.com>
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

changes in v3:
- fix dtbs_check warrning: (8002cbd78fd5 and 4bc21d3dd678)
  >> arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: pin-controller: {'type':
  'object'} is not allowed for {'#address-cells': [[1]], '#size-cells':
  [[1]], 'ranges': [[0,

  arch/arm/boot/dts/stm32h743i-eval.dt.yaml: soc: 'i2c@40005C00',
  'i2c@58001C00' do not match any of the regexes: '@(0|[1-9a-f][0-9a-f]*)$',
  '^[^@]+$', 'pinctrl-[0-9]+'

  >> arch/arm/boot/dts/stm32h750i-art-pi.dt.yaml: serial@40004800: 'bluetooth'
  does not match any of the regexes: 'pinctrl-[0-9]+'

changes in v2:
- reorganize the pinctrl device tree about
  stm32h7-pinctrl/stm32h743/750-pinctrl
  stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi --> stm32h743i-disco.dts
      	      	         |                          |-> stm32h743i-eval.dts
      	      	         |-> stm32h750-pinctrl.dtsi --> stm32h750i-art-pi.dts
  same to the stm32f7/f4's pinctrl style
- fix author name/copyright mistake
- add compatible string	st,stm32h750-pinctrl to pinctl-stm32h743.c as they
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
  dt-bindings: serial: stm32: add phandle 'bluetooth' to fix dtbs_check
    warrning

 Documentation/arm/index.rst                        |   1 +
 Documentation/arm/stm32/stm32h750-overview.rst     |  33 +++
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   1 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   5 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 273 ++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 307 +--------------------
 arch/arm/boot/dts/stm32h743.dtsi                   | 153 +++++++++-
 arch/arm/boot/dts/stm32h750-pinctrl.dtsi           |  11 +
 arch/arm/boot/dts/stm32h750.dtsi                   |   5 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts            | 228 +++++++++++++++
 arch/arm/mach-stm32/board-dt.c                     |   1 +
 drivers/pinctrl/stm32/Kconfig                      |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32h743.c          |   3 +
 15 files changed, 724 insertions(+), 304 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

-- 
1.9.1

