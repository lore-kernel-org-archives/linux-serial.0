Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C7C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 13 Sep 2021 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EED60FA0
	for <linux-serial@archiver.kernel.org>; Mon, 13 Sep 2021 08:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbhIMItY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:49:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35022 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237849AbhIMItY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 13 Sep 2021 04:49:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CBA4A202A17;
        Mon, 13 Sep 2021 10:48:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BE8D0202A2E;
        Mon, 13 Sep 2021 10:48:07 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 434B6202EC;
        Mon, 13 Sep 2021 10:48:07 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 00/10] arm64: dts: Add i.MX8DXL initial support
Date:   Mon, 13 Sep 2021 11:47:44 +0300
Message-Id: <1631522874-19862-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This allows i.MX8DXL EVK board to boot to prompt.

Abel Vesa (5):
  arm64: dts: imx8-ss-lsio: Add mu5a mailbox
  arm64: dts: freescale: Add adma subsystem dtsi for imx8dxl
  dt-bindings: fsl: scu: add i.MX8DXL ocotp binding
  dt-bindings: i2c: imx-lpi2c: Add i.MX8DXL compatible match
  dt-bindings: serial: fsl-lpuart: Add i.MX8DXL compatible

Jacky Bai (5):
  arm64: dts: freescale: Add the top level dtsi support for imx8dxl
  arm64: dts: freescale: Add the imx8dxl connectivity subsys dtsi
  arm64: dts: freescale: Add ddr subsys dtsi for imx8dxl
  arm64: dts: freescale: Add lsio subsys dtsi for imx8dxl
  arm64: dts: imx8dxl: Add i.MX8DXL evk board support

 .../bindings/arm/freescale/fsl,scu.txt        |   3 +-
 .../bindings/i2c/i2c-imx-lpi2c.yaml           |   2 +
 .../bindings/serial/fsl-lpuart.yaml           |   1 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      |   7 +
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 266 ++++++++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |  53 ++++
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   | 137 +++++++++
 .../boot/dts/freescale/imx8dxl-ss-ddr.dtsi    |  36 +++
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   |  78 +++++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi    | 245 ++++++++++++++++
 11 files changed, 828 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl.dtsi

-- 
2.31.1

