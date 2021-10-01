Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C9BC4332F
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 08:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B6161A83
	for <linux-serial@archiver.kernel.org>; Fri,  1 Oct 2021 08:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352611AbhJAIOF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 1 Oct 2021 04:14:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:52584 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231280AbhJAIOE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 1 Oct 2021 04:14:04 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7DB542019CA;
        Fri,  1 Oct 2021 10:12:19 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 701792019BA;
        Fri,  1 Oct 2021 10:12:19 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id DF353202F7;
        Fri,  1 Oct 2021 10:12:18 +0200 (CEST)
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
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND v2 00/10] arm64: dts: Add i.MX8DXL initial support
Date:   Fri,  1 Oct 2021 11:11:25 +0300
Message-Id: <1633075894-10214-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This allows i.MX8DXL EVK board to boot to prompt.

CC'ed devicetree@vger.kernel.org this time and fixed
the numbering of cover letter, there are only 10 patches in
this patchset.

Abel Vesa (5):
  arm64: dts: imx8-ss-lsio: Add mu5a mailbox
  arm64: dts: freescale: Add adma subsystem dtsi for imx8dxl
  dt-bindings: fsl: scu: Add i.MX8DXL ocotp binding
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

