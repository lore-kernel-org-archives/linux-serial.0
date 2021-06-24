Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8371C49EA5
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B80613C9
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:49:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhFXWwP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFXWwM (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 18:52:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFD9360FEA;
        Thu, 24 Jun 2021 22:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624574993;
        bh=XHzIArEs04I4ZPQ2dDXvTjAfIIUr3VwtEY21rEvVH9M=;
        h=From:To:Cc:Subject:Date:From;
        b=g4UPq7fOSifptYk2UAyWcYaNegosp3zV76mkC3dPHSDT5AYwYw3ARzX3xVTuGouKT
         1onTajtDLP5TF1YNCLdjTG77fUJdkFzelbPkos7Qpthzu0W+q8FlqThOMSHDBXsbek
         NiIA6624pvlrSGLCRKkJRBCNea8Je9J7LTIRP7NjrtW3Y6TvLL6xsNGF+ZThE7f3uO
         hbJZfBd+hSlwOvabRDH06gTMLPY0H6ZZ+7yNBZSGNPcP/f25KpB7lvh8npGJZN5JRW
         ZIwGBMyzI2MLSzJog7o7lCowEhBqVzvhX6Gy7TKIuXOna2ZR0OyFflmJP7UFqnfut8
         Pe8DLzwsMhcDQ==
Received: by pali.im (Postfix)
        id 697FB8A3; Fri, 25 Jun 2021 00:49:50 +0200 (CEST)
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
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/10] serial: mvebu-uart: Fixes and new support for higher baudrates
Date:   Fri, 25 Jun 2021 00:48:59 +0200
Message-Id: <20210624224909.6350-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series fixes mvebu-uart driver used on Marvell Armada 37xx
boards and add support for baudrates higher than 230400.

Pali Rohár (10):
  serial: mvebu-uart: fix calculation of clock divisor
  serial: mvebu-uart: do not allow changing baudrate when uartclk is not
    available
  serial: mvebu-uart: correctly calculate minimal possible baudrate
  dt-bindings: mvebu-uart: fix documentation
  arm64: dts: marvell: armada-37xx: Fix reg for standard variant of UART
  serial: mvebu-uart: remove unused member nb from struct mvebu_uart
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
 drivers/tty/serial/mvebu-uart.c               | 603 +++++++++++++++++-
 8 files changed, 645 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt

-- 
2.20.1

