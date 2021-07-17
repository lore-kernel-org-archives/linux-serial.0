Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72192C636CB
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 12:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427A6613F5
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 12:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbhGQMlp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jul 2021 08:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhGQMlo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jul 2021 08:41:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 389D961285;
        Sat, 17 Jul 2021 12:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626525528;
        bh=2Yit2k4uDAQ+Npx8/IXzxBh/GhjT1kx6H+uYPeax3WY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oJ4/by3lNsgTX1+KqA4I3lcmb5kYVk8Mt4AZOmz38C34j9iQS00kUes7WOj50syU0
         j+U54LAqA8voUBURpN2B5/54zX69nsvgar31Bvomy9wZ9ZdTHfrQFB98baR/MEet40
         JC5lRQVCxwbBZnFXb6CJZPRkzk2VJTYH772oq5UGWacj46sDrGyW3eKcvO4rqiogxC
         qHBjsobDlIZ38T3Wsr7WZ1UaXEk5PvRyH13LGu0D/iLegumP6GyEDGTBXheiQI8QZX
         njaSIceFvdFLn8r6EKaP6gY0Ikjzz22D9VZ2+HKlzO05igPnM36rDLLyIdJXv/4CHM
         pYzCkPlI3Ocqg==
Received: by pali.im (Postfix)
        id 6CD79EA7; Sat, 17 Jul 2021 14:38:45 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Vladimir Vid" <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/5] serial: mvebu-uart: Support for higher baudrates
Date:   Sat, 17 Jul 2021 14:38:24 +0200
Message-Id: <20210717123829.5201-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series add support for baudrates higher than 230400 on
Marvell Armada 37xx boards.

This new version v3 is rebased on top of Linus master branch and all
already applied patches were dropped. There are no changes in patches
itself since v2.

Please review these patches as they touch both Device Tree bindings and
mvebu-uart.c driver.

Pali Rohár (5):
  math64: New DIV_U64_ROUND_CLOSEST helper
  serial: mvebu-uart: implement UART clock driver for configuring UART
    base clock
  dt-bindings: mvebu-uart: document DT bindings for
    marvell,armada-3700-uart-clock
  arm64: dts: marvell: armada-37xx: add device node for UART clock and
    use it
  serial: mvebu-uart: implement support for baudrates higher than 230400

 .../bindings/clock/armada3700-uart-clock.txt  |  24 +
 .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
 .../arm64/boot/dts/marvell/armada-3720-db.dts |   4 +
 .../dts/marvell/armada-3720-espressobin.dtsi  |   4 +
 .../dts/marvell/armada-3720-turris-mox.dts    |   4 +
 .../boot/dts/marvell/armada-3720-uDPU.dts     |   4 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  15 +-
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
 include/linux/math64.h                        |  13 +
 10 files changed, 649 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt

-- 
2.20.1

