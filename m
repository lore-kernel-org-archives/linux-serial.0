Return-Path: <SRS0=pZl0=7J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA281C433E1
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 16:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885722084C
	for <linux-serial@archiver.kernel.org>; Wed, 27 May 2020 16:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="kPEQxS0P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbgE0Q0F (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 May 2020 12:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389852AbgE0Q0D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 May 2020 12:26:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9E1C05BD1E
        for <linux-serial@vger.kernel.org>; Wed, 27 May 2020 09:26:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so7208700ljn.4
        for <linux-serial@vger.kernel.org>; Wed, 27 May 2020 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=g9s8BvA2PQumY+6SHwRlWVAr/CRDLgvzgZHFCjcSWFk=;
        b=kPEQxS0PW9dRJFegpNyWgrt8yIXYPoMQa4We9uL1uWfxS9FRb5wVnDsGlz1CY1XUDA
         6S+/oBnySjJoeIkY1F41HfrI3u+McunRtLiBkBE4i/F6YBWmiFDgNjhq2Qk5fzJfmvWQ
         ZpX96sYW4/1V1rG83f4+L9VnN1LT6HHE+Zaac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=g9s8BvA2PQumY+6SHwRlWVAr/CRDLgvzgZHFCjcSWFk=;
        b=QvNNBPC6+fELgRO4MORX+IelaYaQtViQJjgEquZ6dtF06S+2ALsio8IEfAZkFo71vJ
         BN0rh4OdQRSeCeu5A+Q74l+qBYKVFkagucPa9t/HrUvO/hDWlj9W7dfIIuGFDPHRGCk+
         qTLfT6F+bpRTUd5KQr1IoPfuXDUC9YS0jGVCkxH8NICSuamAfVzN1cNwm706cC785T8L
         6RQB0Qk4HLuXckYZ1r9x+Cnb8jYS2TPYIOziLn49mIopyTHq1+YKSgvulwxf7e9dXvyq
         fPg0LR86cr+uLH64PSO5EAFoyIE5hdvcM5yxt4xxG4XQLCjt3AVOWuVyFiDfBl7M9oVN
         bCjQ==
X-Gm-Message-State: AOAM530kZBxLnrNXKL5u6NyDiUFDdFxRbJQ1EDACMa+2cMsUEjCpMrw+
        DtEFnLSqdZJiJ9hvMIFRBxlhEw==
X-Google-Smtp-Source: ABdhPJxMdBdNzaQhOcNgRguBOidB8r8tVmkt5HJC4NDaHBBD8klKwTO/LK1I6tOhDGNUcjjIsfgfkA==
X-Received: by 2002:a2e:9252:: with SMTP id v18mr3452029ljg.337.1590596760509;
        Wed, 27 May 2020 09:26:00 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id p68sm898784lfa.71.2020.05.27.09.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:25:59 -0700 (PDT)
Date:   Wed, 27 May 2020 18:25:51 +0200
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
Subject: [PATCH v6 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200527182545.3859622-0-mholenko@antmicro.com>
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
 drivers/soc/litex/litex_soc_ctrl.c            | 197 +++++++++
 drivers/tty/serial/Kconfig                    |  31 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 399 ++++++++++++++++++
 include/linux/litex.h                         |  45 ++
 13 files changed, 781 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1

