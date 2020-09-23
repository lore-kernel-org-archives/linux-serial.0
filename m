Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D558C2D0A8
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66B22193E
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 10:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="Hc3fZODe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgIWKIk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKIj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 06:08:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D85C0613CE
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2020 03:08:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u4so16712975ljd.10
        for <linux-serial@vger.kernel.org>; Wed, 23 Sep 2020 03:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=h+dZ5D6pS4gjIc+KJuuILJXM3/8dUhWSCqXJ1HQz3q8=;
        b=Hc3fZODeNB6nf8d5QkIVwJz0JxK/8W7biWXmKgQI092FgkqrSPYy6sQjKW2n1Y45OM
         KwDZY0GN2aan6+fxwYb77rZhsD53A+PUhirfFlwXkqBk5QRZiY3Zy9u3MD9tenTHzENB
         q49LrkBU7j0FNptkEKFxEy7HAfRHJ4MQ/rvKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=h+dZ5D6pS4gjIc+KJuuILJXM3/8dUhWSCqXJ1HQz3q8=;
        b=rwTGq8f0fbgFdHR7tbPFYmiEO4c776RGsOJvC1jBZdAQQ0JMnlFym+6XggvTWv5zWV
         BHlVVsFkRMQd+7m5694U8y08xG9ysWGE11EJPDFZsL/IqOiqWapAcFxZPT3PAZ1vHdpl
         bFUcK38ID5u+rHgFVdJ6LCXdmMSLBUqvJn3a45ijRN051YE69bLiNt32i98kkzguprnO
         JaT6NWqBdwrT7Z3unjUYhfz99gJtYyLTeaQyzP4O2T1GP3THZWlOwY6MYPfKhPaUW5Vc
         yWCQ9rnOFy832uGxDlWhTf1p1JRXaubhYorsGkRBYrqQvtQw5YcbyCUY3QVkYGksD7w7
         ImHw==
X-Gm-Message-State: AOAM530gBTBTdsXXI+4zPlT8DgoYhO25x5SvBLXgd39MwJ4iFH3fMnSp
        Y0oIJOZvyQhbufqiC2oKebElDw==
X-Google-Smtp-Source: ABdhPJzQCzrBPn3hsgZC0y7hsS6Lsbc3NvE0FAuf9A7HsIKqGRoolhDhkp2kbnykI4BRp79BX7i9vQ==
X-Received: by 2002:a2e:5357:: with SMTP id t23mr2878457ljd.394.1600855717817;
        Wed, 23 Sep 2020 03:08:37 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id z10sm4556740lfa.10.2020.09.23.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:08:36 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:08:30 +0200
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
Subject: [PATCH v11 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200923120817.1667149-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Changes in v11:
    - added Reviewed-by tag
    - reformatted some comments
    - switched to WARN instead of BUG on CSR validation fail

Changes in v10:
    - added casting to avoid sparse warnings in the SoC Controller's driver

Changes in v9:
    - fixed the `reg` node notation in the DT example
    - added exporting of the `litex_set_reg`/`litex_get_reg` symbols

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
 drivers/soc/litex/litex_soc_ctrl.c            | 194 +++++++++
 drivers/tty/serial/Kconfig                    |  32 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 402 ++++++++++++++++++
 include/linux/litex.h                         |  24 ++
 13 files changed, 761 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1

