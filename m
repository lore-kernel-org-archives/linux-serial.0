Return-Path: <SRS0=G31y=A2=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9E0C433E3
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 11:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B553E2072E
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jul 2020 11:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="tvY8PQWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgGOLHI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jul 2020 07:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGOLHI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jul 2020 07:07:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3B2C08C5DB
        for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2020 04:07:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so2073118lji.9
        for <linux-serial@vger.kernel.org>; Wed, 15 Jul 2020 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LS4hCUEzoSELDF8hz/hUz8/P4swJmb1Knux4DAvwCKg=;
        b=tvY8PQWQZsDh/YAzpSCW8KgGWfH/ut9NLsu5C5/0X9wPFGorLTcyD1G44JFNQm6oZV
         K2TpoM4gFya+SxV4S10GEWIFI6ILbEhuUIHR/w2ViF/aBdf0eeQG7+RwKPlEezU4PFGI
         1LQEJTyjDCvNu4rN3aM32w9MRpSKGQfRO3O7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LS4hCUEzoSELDF8hz/hUz8/P4swJmb1Knux4DAvwCKg=;
        b=pVkwCJ+KBbq+Dtb+Z+RCPPCGou3H18Ls2lIfiDe3RVrYMfV9ZJMayb+5vigmjwJJoK
         WQ5VSwLBz/4Rm9n5Zzhp66A00WEpwRawMqogzqd/Ue42WRFSVtyNfzZYzUuV0Z0PLYpu
         Hkln4+HRr5dzYW1qGSCh0DQ9CCoafY+raDVNnOavlYWUcOs6oUnTey0NvqXqE/Ucn7D5
         XlyPZXwWZrNWLjZx0YVHig49eo1V76Rm1h8atN9BhhroLycY12vN5vB/YQMoA9dAv0jP
         JcyFZS8kRFvRJoNhy2GxFd1lJlKfyMbHB8hgI3fOtwQiAnJ1D/qTk/PohOipz3SvDdTF
         hd9w==
X-Gm-Message-State: AOAM531VJxYj782NCNhbXsLG7xzc7HjUjLa1ReEwHTP+HAq7rlr3g5fG
        VWZDf9HYGSYdkT9VQ41jCOCHxg==
X-Google-Smtp-Source: ABdhPJy1PC3WtzZvS6+3qsGyi9RvAdJfykrkOKNKr8hT+mKebr7eUBDBcbenv+FYYIgZFXzoLaKNLA==
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr4723355lji.450.1594811226020;
        Wed, 15 Jul 2020 04:07:06 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id u7sm513117lfi.45.2020.07.15.04.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 04:07:05 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:06:59 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Subject: [PATCH v8 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200715130641.1953227-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patchset introduces support for LiteX SoC Controller
and LiteUART - serial device from LiteX SoC builder
(https://github.com/enjoy-digital/litex).

In the following patchset I will add
a new mor1kx-based (OpenRISC) platform that
uses this device.

Later I plan to extend this platform by
adding support for more devices from LiteX suite.

Changes in v8:
    - fixed help messages in LiteUART's KConfig
    - removed dependency between LiteUART and LiteX SoC drivers
    - removed `litex_check_accessors()` helper function
    - added crashing (BUG) on the failed LiteX CSR access test

Changes in v7:
    - added missing include directive in UART's driver

Changes in v6:
    - changed accessors in SoC Controller's driver
    - reworked UART driver

Changes in v5:
    - added Reviewed-by tag
    - removed custom accessors from SoC Controller's driver
    - fixed error checking in SoC Controller's driver

Changes in v4:
    - fixed copyright headers
    - fixed SoC Controller's yaml 
    - simplified SoC Controller's driver

Changes in v3:
    - added Acked-by and Reviewed-by tags
    - introduced LiteX SoC Controller driver
    - removed endianness detection (handled now by LiteX SoC Controller driver)
    - modified litex.h header
    - DTS aliases for LiteUART made optional
    - renamed SERIAL_LITEUART_NR_PORTS to SERIAL_LITEUART_MAX_PORTS
    - changed PORT_LITEUART from 122 to 123

Changes in v2:
    - binding description rewritten to a yaml schema file
    - added litex.h header with common register access functions

Filip Kokosinski (3):
  dt-bindings: vendor: add vendor prefix for LiteX
  dt-bindings: serial: document LiteUART bindings
  drivers/tty/serial: add LiteUART driver

Pawel Czarnecki (2):
  dt-bindings: soc: document LiteX SoC Controller bindings
  drivers/soc/litex: add LiteX SoC Controller driver

 .../bindings/serial/litex,liteuart.yaml       |  38 ++
 .../soc/litex/litex,soc-controller.yaml       |  39 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/litex/Kconfig                     |  15 +
 drivers/soc/litex/Makefile                    |   3 +
 drivers/soc/litex/litex_soc_ctrl.c            | 192 +++++++++
 drivers/tty/serial/Kconfig                    |  32 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 402 ++++++++++++++++++
 include/linux/litex.h                         |  24 ++
 13 files changed, 759 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1

