Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6C0C2B9F4
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 14:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D76E61984
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 14:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhFYOjS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 10:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFYOjR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 10:39:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAAD86195F;
        Fri, 25 Jun 2021 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624631817;
        bh=x4F6s4pMzEp3ZbRURx1AquHX+ONtsSBHXaOwkV+FOi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTtFjp+HxQX+CAvlZhTJTrRvkGf+tza6yZ1zVxif1Un1aP9z0xvjAvs6mzuOCGOlO
         Iim0J9nRCa+NWmqizEZtK/WTYnQlYJL0ab20YzNLIRXi/1aJ1dSbA2NHSHzRWrT0cD
         XLd5LUWuyHOFHKP97RouT9KP36Q+CjUtRToTuqeZIHXJ6SUZtdhb/YFDu24pkfM2Il
         JMjpfvh15S82RqGEDas9BHlryGRZBMUpzN7G2519D3zsCVEeYMyAMI/uANO1SWFmzN
         LfXuDt6MtNe+xhvtVFsaTdjsMpB6XosJpacT7u2lT1M5GZDxw/JbCNttLyhhwkTTeg
         dsuwJPvs3pujQ==
Received: by pali.im (Postfix)
        id 46A5D60E; Fri, 25 Jun 2021 16:36:54 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 00/11] serial: mvebu-uart: Fixes and new support for higher baudrates
Date:   Fri, 25 Jun 2021 16:36:06 +0200
Message-Id: <20210625143617.12826-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series fixes mvebu-uart driver used on Marvell Armada 37xx
boards and add support for baudrates higher than 230400.

In v2 was added patch with DIV_U64_ROUND_CLOSEST helper and changed
patch "implement UART clock driver for configuring UART base clock" to
fix compile errors on 32-bit archs, including usage of new math helper.

Pali Rohár (11):
  serial: mvebu-uart: fix calculation of clock divisor
  serial: mvebu-uart: do not allow changing baudrate when uartclk is not
    available
  serial: mvebu-uart: correctly calculate minimal possible baudrate
  dt-bindings: mvebu-uart: fix documentation
  arm64: dts: marvell: armada-37xx: Fix reg for standard variant of UART
  serial: mvebu-uart: remove unused member nb from struct mvebu_uart
  math64: New DIV_U64_ROUND_CLOSEST helper
  serial: mvebu-uart: implement UART clock driver for configuring UART
    base clock
  dt-bindings: mvebu-uart: document DT bindings for
    marvell,armada-3700-uart-clock
  arm64: dts: marvell: armada-37xx: add device node for UART clock and
    use it
  serial: mvebu-uart: implement support for baudrates higher than 230400

 .../bindings/clock/armada3700-uart-clock.txt  |  24 +
 .../devicetree/bindings/serial/mvebu-uart.txt |  15 +-
 .../arm64/boot/dts/marvell/armada-3720-db.dts |   4 +
 .../dts/marvell/armada-3720-espressobin.dtsi  |   4 +
 .../dts/marvell/armada-3720-turris-mox.dts    |   4 +
 .../boot/dts/marvell/armada-3720-uDPU.dts     |   4 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  17 +-
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/mvebu-uart.c               | 605 +++++++++++++++++-
 include/linux/math64.h                        |  13 +
 10 files changed, 661 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt

-- 
2.20.1

