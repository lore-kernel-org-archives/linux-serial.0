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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA3C433C1
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19DE561A32
	for <linux-serial@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhCZLPp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhCZLPO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Mar 2021 07:15:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280AFC0613AA;
        Fri, 26 Mar 2021 04:15:11 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so745072plg.1;
        Fri, 26 Mar 2021 04:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qZewbGCBGre6IA2gdv0UNHMD5H0zzQah+h3wfcdLeno=;
        b=tKL5BNZEjoNFlbXFV/ArdRgMvL4T8BHwa0S+Z8gMGRwVo1Y/dRR/V+fcO04mfQpfOq
         wXN56SeqyByp+GB+lutZYuHPodRdGxGxAisZwXXcZSJIB3SzjEkwGCvlIUAwYT2Inha3
         ZcmFDdaoydbOafXA/hKGsLwzrrL0pg9yH5QgeVFouDfnEilt3oJ76mUnq3xpWoHs4aJl
         ckkmW52s0OxzYfVEcBLPUaaYe/56RfPxqV7Npgl9jnIJ49HXyx3TY+xdgZkESH8fFatY
         wwzOfmNicX7ehvXEwF0bWrlpty3h9Fv2MdVlVVaTqZza+TvVRf5dRXiin6nDRRKY4WwP
         Opbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qZewbGCBGre6IA2gdv0UNHMD5H0zzQah+h3wfcdLeno=;
        b=ZtgVVczE11qXXniRsS7G65GuDUL8hKWWgJ+JM69pwwS+2ZZf6Nfp0ZEWmnOKnfrsR6
         78YU5VBcK8EgISnboNmH9OfsyRy4eE1rm/2loi4/Tk8eHx49DvgXT4l+vNB7/fKcY+Oi
         58k0SpPOp4r/o9f+0K82HRWfOpUkT+55acJ1TZ34g4MBVurHW0H/Oc1ElB+jnIw3FiuL
         TKMCZmUfYN9GAOvXNdT7KfqZsmDlCoiqUMOfUVBgABdGfuvv61fr047ypJS1oNhs9dd+
         p48fWHl7w2Y/pvj/btJJVRdZSk2H8rtBrBqGEZM5Zi8O5X8VJkSFbyxf9sajcsPO7LVg
         qS3Q==
X-Gm-Message-State: AOAM533i6fuflmn9KFUrVDZCwmV2h91SGOHzgIVoK8WYEz8BqYj5N3bm
        NDQ6UzcX6s/OISKpH2HA4W4=
X-Google-Smtp-Source: ABdhPJz1uyjnspJYTp77tANzqqBj5hZuWWfsI9BlnFhTkzVcn9qymlzZCesOvqehYIkQmit0/JiV6Q==
X-Received: by 2002:a17:902:bf92:b029:e6:bc0:25ac with SMTP id v18-20020a170902bf92b02900e60bc025acmr14865974pls.49.1616757310569;
        Fri, 26 Mar 2021 04:15:10 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id l3sm8108414pfc.81.2021.03.26.04.15.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 04:15:09 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh@kernel.org, valentin.caron@foss.st.com,
        Alexandre.torgue@foss.st.com, rong.a.chen@intel.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com, gregkh@linuxfoundation.org,
        erwan.leray@foss.st.com, erwan.leray@st.com,
        linux-serial@vger.kernel.org, lkp@intel.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 0/9] ARM: STM32: add art-pi(stm32h750xbh6) board support
Date:   Fri, 26 Mar 2021 19:14:55 +0800
Message-Id: <1616757302-7889-1-git-send-email-dillon.minfei@gmail.com>
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

dillon min (9):
  Documentation: arm: stm32: Add stm32h750 value line doc
  dt-bindings: arm: stm32: Add compatible strings for ART-PI board
  dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
  ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
  ARM: dts: stm32: add stm32h750-pinctrl.dtsi
  ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
  ARM: stm32: Add a new SOC - STM32H750
  pinctrl: stm32: Add STM32H750 MCU pinctrl support
  dt-bindings: serial: stm32: Use 'type: object' instead of false for
    'additionalProperties'

 Documentation/arm/index.rst                        |   1 +
 Documentation/arm/stm32/stm32h750-overview.rst     |  34 ++
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   1 +
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   3 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 341 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 307 +------------------
 arch/arm/boot/dts/stm32h743.dtsi                   | 164 +++++++++-
 arch/arm/boot/dts/stm32h750-pinctrl.dtsi           |  12 +
 arch/arm/boot/dts/stm32h750.dtsi                   |   6 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts            | 229 ++++++++++++++
 arch/arm/mach-stm32/board-dt.c                     |   1 +
 drivers/pinctrl/stm32/Kconfig                      |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32h743.c          |   3 +
 15 files changed, 804 insertions(+), 305 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

-- 
2.7.4

