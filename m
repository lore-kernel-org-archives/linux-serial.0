Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74CBC35DF5
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53CC222C2
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 08:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="JkRNezg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgBYIqZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:46:25 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46870 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgBYIqZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 03:46:25 -0500
Received: by mail-lf1-f66.google.com with SMTP id u2so6416687lfk.13
        for <linux-serial@vger.kernel.org>; Tue, 25 Feb 2020 00:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=z1Qahvm7KnmiXYASqq9Hf+eApJtHkcbwnGtdfFCR58I=;
        b=JkRNezg1xTJbkzROqNPOSM7N/KDneMzf5fQc37XnkxK6A7mvmUCD8yCzb0FcbcAYdn
         h1gK7sDUGueciXFuXPXj+pm+S+9wWeN7p7Uy2Lrml34l54S8shvQe8jh1v73UljsECco
         AYGiNRWphBxpBmtLFW0lzTz2OXczZJ8G5JMzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=z1Qahvm7KnmiXYASqq9Hf+eApJtHkcbwnGtdfFCR58I=;
        b=eCGdN2pIvxfWjvmgysyeA6xuSwyYrSlj+qXLSqe4g0aTI3mrRUl51DzrvnwzCYuspK
         j+Yi/eT9cTVeM6DYOhyP2Fmj5AGYH6Y91jt5OSaIeXfwsEvJpgJLLYtIaoeaYJUh7Kz2
         wnJlgio8sFed7BjUx4A8LFITnkBhGU8GHEn/ZhiSWKqWjOzZ4BKtg6LMSXaY8pHnUSo/
         LJQEXT2dHimcOJFBoPb887I5dG4QXtYIeAYmbYlgKBYYkOSliYAYIhu7TnUQYXuI0z6Z
         DWlye9ve9DU/4lWyKv4AqVN2uyTiwdnlumtuuu8imacnpKasXP2sdgALe1aiTw96s+9g
         jynw==
X-Gm-Message-State: APjAAAVeTaa7WJtpWOMGLCL+HP4fj2+ILHUEHB676iXR4JJnBjfe5QfW
        2pNy5RxjKkpyh9UfR+f1Qz152w==
X-Google-Smtp-Source: APXvYqzyNxgyrjZV6JMCkLoX1qWII/B9Gu5Yg1+FK+C9qDt9KG3oE7u+XjroFjv1fnlh1zl/mb5EQQ==
X-Received: by 2002:a19:6e0f:: with SMTP id j15mr3693486lfc.76.1582620383320;
        Tue, 25 Feb 2020 00:46:23 -0800 (PST)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id n15sm8343233lfe.54.2020.02.25.00.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:46:22 -0800 (PST)
Date:   Tue, 25 Feb 2020 09:46:18 +0100
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
Subject: [PATCH v3 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20200225094437.4170502-0-mholenko@antmicro.com>
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
 .../soc/litex/litex,soc_controller.yaml       |  46 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   9 +
 drivers/soc/Kconfig                           |   1 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/litex/Kconfig                     |  14 +
 drivers/soc/litex/Makefile                    |   3 +
 drivers/soc/litex/litex_soc_ctrl.c            | 233 ++++++++++
 drivers/tty/serial/Kconfig                    |  32 +-
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 411 ++++++++++++++++++
 include/linux/litex.h                         |  45 ++
 include/uapi/linux/serial_core.h              |   3 +
 14 files changed, 838 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc_controller.yaml
 create mode 100644 drivers/soc/litex/Kconfig
 create mode 100644 drivers/soc/litex/Makefile
 create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
 create mode 100644 drivers/tty/serial/liteuart.c
 create mode 100644 include/linux/litex.h

-- 
2.25.0

