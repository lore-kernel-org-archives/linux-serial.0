Return-Path: <SRS0=HiSo=DU=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6DC433E7
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3167024890
	for <linux-serial@archiver.kernel.org>; Tue, 13 Oct 2020 14:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="u8AEZInu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgJMOpU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbgJMOpU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Oct 2020 10:45:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42CC0613D5
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:45:19 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a5so20705520ljj.11
        for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2020 07:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9edqb5x1hDx2fmb/AQX+uLZnlObOSp2lA6s6SJzO18Q=;
        b=u8AEZInu/u2J5znTIxSlmJ+UbfzvtkomL1HfWc3P8MKYrJwvX+k/f1NodCf4S0ldAV
         6vNF8gZMjazFvP1k6osN6CEWZtrKVzmWcVKQlVcjecAE1xJYJFDc/6dTZJt+WN8XMGN9
         i092iuDDbSSpGF2yOvZPvlWMtAo/jdYfQ3HDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9edqb5x1hDx2fmb/AQX+uLZnlObOSp2lA6s6SJzO18Q=;
        b=OMmC/5cX9mnygxNzuGdD0KwuYHhM1w8EORjK+aZ9ieswYnCFQRh80Zc1LsIaMbNiF+
         ATjyB/sD1vap38m/PjcbtSNtOto8iG3++9wup6L5QyoKNiQ7JxZgmyx314sLj+2rI4DR
         lTsDKFpTRGUCBu1t8kc6tUFMieOtVrFCAOrX1OztA8oIw0b4WK/LJgun6VFxWvoEkHlR
         X9E5LtDpMrcY3ds4JY9L01v9NhYacWnlJp0tm5nwdBfbqlnZgDOeHbWizZA4aCo4C6qK
         FoHjP2SAA8H5eY2G5L22P5N0Ybm9FYGn1677VEH1mGzq9MEPqiyYXFnuVVsMxUSK/ioJ
         UMoQ==
X-Gm-Message-State: AOAM533i7YO7l4WZuQeotIzP6MBfGMIxj1b/rq4yNEoJnDeIP/bUi1Tl
        gaJUzLfHBqhANtPUXBvNrqyH7A==
X-Google-Smtp-Source: ABdhPJzG4EoAVlSK0YMNnG2TCpydpGCLOT0CQKlDJj+Hy/PpfnS/i3lDQhuCHFRwl15pZbNdF9wZNQ==
X-Received: by 2002:a2e:8956:: with SMTP id b22mr13434318ljk.428.1602600318348;
        Tue, 13 Oct 2020 07:45:18 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id x5sm4356334lji.78.2020.10.13.07.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:45:17 -0700 (PDT)
Date:   Tue, 13 Oct 2020 16:45:09 +0200
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
Subject: [PATCH v12 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20201013164454.2002023-0-mholenko@antmicro.com>
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

Changes in v12:
    - fixed descriptions in yaml files
    - simplified probe implementations
    - introduced litex_{read,write}{8,16,32,64}() fast accessors
    - added formal documentation of litex_get_reg()/litex_set_reg()
    - fixed possible memory leaks
    - removed spin locks from CSR accessors

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
 drivers/soc/litex/Kconfig                     |  19 +
 drivers/soc/litex/Makefile                    |   3 +
 drivers/soc/litex/litex_soc_ctrl.c            | 176 ++++++++
 drivers/tty/serial/Kconfig                    |  32 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 404 ++++++++++++++++++
 include/linux/litex.h                         | 103 +++++
 13 files changed, 831 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1

