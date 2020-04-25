Return-Path: <SRS0=mx0D=6J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993AAC55185
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 11:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69BD42071E
	for <linux-serial@archiver.kernel.org>; Sat, 25 Apr 2020 11:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="kCLiymqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDYLlf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDYLle (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Apr 2020 07:41:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911AC09B04B
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:41:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f18so12631576lja.13
        for <linux-serial@vger.kernel.org>; Sat, 25 Apr 2020 04:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=gPOslaJS03IHNZDUPg+ylYPnpp4lpO0hHiVIujLXKZQ=;
        b=kCLiymqAQAvHEj/A6Vzpgk4xqpjkRSKnEdTF0U8KdlAvduMoXElnR8ohQE5BUHk4Pw
         lksqxjsBpHNnpzuZZ5/Bb7Qwvtoo02CbpPrSKb1WZKbpcd5YfuLvUByStGloyum6aSCV
         SCm5DqJMDLmpcdZgDM/o852SnCSgrnXLxy1tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gPOslaJS03IHNZDUPg+ylYPnpp4lpO0hHiVIujLXKZQ=;
        b=Maua7bclIOssqBiIi+cj1t8AVF12u/Uc+mndK8/Tn+luXWv5/TkVdMxdNfVPHdQ6t7
         oLP5Aq0IlkMGHgfnpNolWDWHJS6eVQJlGbDn1dl654AHPpirxx5oZnNMUC5oCkpoVT6q
         g9HEkxSDH2f8zkW3hBIpamYSXZKxWjAx6RBwSooqfT7/IVH4HNitfSAlOftUTcklYkjR
         GG4/0jq3LiZ7I+PkoOCzYp/skFmbVuD5oMQbqXSAoed7VXP2w/iOMgkPDT1npglSN29c
         i4qrcuPL9M7WkAfkzP0fWTeiPfuzdwipKJS2JmH0lQ8cBfbHXEPLPbz6piQQziX4NFzM
         Q2TA==
X-Gm-Message-State: AGi0PuYaKAuZpMpIuMmCkoFgprUbF8aaxOdJrAXzD5B2nxp5gL3oc3eQ
        UkEoH9I1Y4dXnGg7WM4pGNQMoA==
X-Google-Smtp-Source: APiQypIaFK4AZ/WydTF7l0S/VD/LpaimsXEHmooK4ekIzyxedqtygTYOg6ubMv49Ytj7H8/UX4iuhQ==
X-Received: by 2002:a2e:b012:: with SMTP id y18mr8675993ljk.238.1587814892733;
        Sat, 25 Apr 2020 04:41:32 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id v3sm6454896lfo.62.2020.04.25.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 04:41:32 -0700 (PDT)
Date:   Sat, 25 Apr 2020 13:41:26 +0200
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200425133939.3508912-0-mholenko@antmicro.com>
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
 drivers/soc/litex/Kconfig                     |  14 +
 drivers/soc/litex/Makefile                    |   3 +
 drivers/soc/litex/litex_soc_ctrl.c            | 197 +++++++++
 drivers/tty/serial/Kconfig                    |  31 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 411 ++++++++++++++++++
 include/linux/litex.h                         |  45 ++
 include/uapi/linux/serial_core.h              |   3 +
 14 files changed, 795 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.1

