Return-Path: <SRS0=tOPF=XZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B692EC388F4
	for <linux-serial@archiver.kernel.org>; Mon, 30 Sep 2019 13:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E52B21924
	for <linux-serial@archiver.kernel.org>; Mon, 30 Sep 2019 13:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro-com.20150623.gappssmtp.com header.i=@antmicro-com.20150623.gappssmtp.com header.b="Et0O9/tG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731184AbfI3NED (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:04:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34463 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbfI3NEC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Sep 2019 09:04:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id r22so6980703lfm.1
        for <linux-serial@vger.kernel.org>; Mon, 30 Sep 2019 06:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=NKz061ZKrfKpmulUXMfGM39xSIQHkJ/qfJErKxufWTs=;
        b=Et0O9/tGHYkgEKZtIGpCcrr6TOROMY5wZ7ALUslSNVg39r1XOCZMKomLMfcH3uf3B0
         xz/WiE0S/yexoIOk0AC9NqaNvBNPiEDC/rvvm4LOhFU5fOFQJb9pSYD/h80DeicEjkLr
         NBcHoNV03AGP8s5x3LHa2Kh80NJLv9U049I8U0H3F1K0A6torSBtsWAYizr1SGifdh6+
         GMFWfoXAPEpIHtVoMz6JPUQOm1XlzGfql0LM/YNnyF5CZYsrYtX8vOJXKT5fa4qmxBdr
         dBnGYVnKR4uulhidzNqkHG9o2Vt49/UssWx3sAhNimhrTLuryWGb2pMJks51PKwL1ju5
         cJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=NKz061ZKrfKpmulUXMfGM39xSIQHkJ/qfJErKxufWTs=;
        b=CBiWsz/lj5Ajd8k8sGEHugsbBTkDFxor2c2BbTA1unq1kwfxYaor12fdUZKYdCBwMZ
         SQH/ejpoPE9rFrLqFQlYbLIJ+7vzPkmvCm80oYnxaCRTOXcaljAcARce3niw3sL9euxS
         j+CpiLQ1iYNGoQQmLxVjW9cKNMwoy4KnLrJo5lKsSFHIsDogXB1awjE4mTVfg32C+t3u
         5bTrEHMD1YcZg2xSNMMAAODfpmiJuC4RkgrF7BkoI6jb/NqAr+ms9LlTNR/VSNM4+pcF
         op2WnGrQ54W/trP4SEtZtxwJrI/mju8d0HBBBcn3AEcW+uK0sNRShC4fl+iKsGaaJ7Kc
         ScfA==
X-Gm-Message-State: APjAAAXrSkoX5GWTLDxQQP5sNmf6U995GA9aCufiZeowaPhbYONWe+J3
        yqxxXJUem5iAPn2klgt3nUEQdQ==
X-Google-Smtp-Source: APXvYqzDz/EV5ey9sKE1NK4jYT+12yoR14i2vO/m28H9eOEdKF9EPYknV1nV56KgFRg+yVNgqwUEhQ==
X-Received: by 2002:a19:c709:: with SMTP id x9mr11722949lff.20.1569848640277;
        Mon, 30 Sep 2019 06:04:00 -0700 (PDT)
Received: from localhost.localdomain (d79-196.icpnet.pl. [77.65.79.196])
        by smtp.gmail.com with ESMTPSA id 4sm3315620ljv.87.2019.09.30.06.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 06:03:59 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:03:52 +0200
From:   Mateusz Holenko <mholenko@antmicro.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 0/3] LiteUART serial driver
Message-ID: <20190930130352.GA5898@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Message-ID: <20190930130352.cAl6lGgEwUBSBss0DYoWw2Rv5LdOUUTTkt1hbit1Kfo@z>

This patchset introduces support for LiteUART
- serial device from LiteX SoC builder
(https://github.com/enjoy-digital/litex).

In the following patchset I will add
a new mor1kx-based (OpenRISC) platform that
uses this device.

Later I plan to extend this platform by
adding support for more devices from LiteX suite.

Filip Kokosinski (3):
  dt-bindings: vendor: add vendor prefix for LiteX
  dt-bindings: serial: document LiteUART bindings
  drivers/tty/serial: add LiteUART driver

 .../bindings/serial/litex,liteuart.txt        |  12 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   7 +
 drivers/tty/serial/Kconfig                    |  30 ++
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/liteuart.c                 | 382 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 7 files changed, 437 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.txt
 create mode 100644 drivers/tty/serial/liteuart.c

-- 
2.23.0

