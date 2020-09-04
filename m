Return-Path: <SRS0=cUMT=CN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59E6C43461
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E2520797
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599233233;
	bh=sKvZCsZobU7Bh4Xu+fGf9ZJCYmD7SquliyFmgqG50Oo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vDe47csYEnlxj5BXCoBg75HIMC+cGaJpYmujmPYI0zzPbKRGUqScW52ycwSRaX9u4
	 cWdjmPed/cfDiyTP+lFaT+Dem+PYwn0hqmFG5D84IcZWJEf0MdizeMKhAsHP18Or32
	 lFXkcxtgfrFUbV34Ukua53RMdqu7Cgcb7yKZPPgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgIDPYW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:24:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbgIDPYU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Sep 2020 11:24:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3F420770;
        Fri,  4 Sep 2020 15:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599233059;
        bh=sKvZCsZobU7Bh4Xu+fGf9ZJCYmD7SquliyFmgqG50Oo=;
        h=From:To:Cc:Subject:Date:From;
        b=sV58pfGmmWQn8uohb/hknW48UOzALop3pIk3iQCR4uyFQ0gZyZbkeRJ5Qu8MEqccx
         Mkiwo6Wf3oJFhnVa4ToV7+vibP0Ihhvq3O5bvcBpigvWvC8sLMGLbJFQuBKgZhExcg
         M/98mPuaOqB0LDnKCPaiqseidOtLyrZLK/gWkZYU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 00/14] dt-bindings: Cleanup of i.MX 8
Date:   Fri,  4 Sep 2020 17:23:50 +0200
Message-Id: <20200904152404.20636-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Rob,

I am resending the series (v3) without actual changes.  You already
reviewed many of them.  I think that subsystem maintainers are hesitant
to pick them up, so maybe this could go via your tree (all of them)?

Changes against previous revisions are in individual patches.

Best regards,
Krzysztof


Krzysztof Kozlowski (14):
  dt-bindings: perf: fsl-imx-ddr: Add i.MX 8M compatibles
  dt-bindings: pwm: imx-pwm: Add i.MX 8M compatibles
  dt-bindings: serial: fsl-imx-uart: Add i.MX 8M compatibles
  dt-bindings: serial: fsl-lpuart: Fix compatible matching
  dt-bindings: watchdog: fsl-imx-wdt: Add i.MX 8M compatibles
  dt-bindings: reset: fsl,imx7-src: Add i.MX 8M compatibles
  dt-bindings: thermal: imx8mm-thermal: Add i.MX 8M Nano compatible
  dt-bindings: nvmem: imx-ocotp: Update i.MX 8M compatibles
  dt-bindings: mfd: rohm,bd71847-pmic: Correct clock properties
    requirements
  dt-bindings: interrupt-controller: fsl,irqsteer: Fix compatible
    matching
  dt-bindings: mtd: gpmi-nand: Add i.MX 8M compatibles
  dt-bindings: mtd: gpmi-nand: Fix matching of clocks on different SoCs
  dt-bindings: mtd: nand-controller: Fix matching with size-cells==1
  dt-bindings: clock: imx8m: Integrate duplicated i.MX 8M schemas

 .../bindings/clock/imx8m-clock.yaml           | 125 ++++++++++++++++++
 .../bindings/clock/imx8mm-clock.yaml          |  68 ----------
 .../bindings/clock/imx8mn-clock.yaml          |  70 ----------
 .../bindings/clock/imx8mp-clock.yaml          |  70 ----------
 .../bindings/clock/imx8mq-clock.yaml          |  72 ----------
 .../interrupt-controller/fsl,irqsteer.yaml    |   8 +-
 .../bindings/mfd/rohm,bd71847-pmic.yaml       |   9 +-
 .../devicetree/bindings/mtd/gpmi-nand.yaml    |  94 ++++++++++---
 .../bindings/mtd/nand-controller.yaml         |   5 +-
 .../devicetree/bindings/nvmem/imx-ocotp.yaml  |  38 +++---
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml |  16 ++-
 .../devicetree/bindings/pwm/imx-pwm.yaml      |  14 +-
 .../bindings/reset/fsl,imx7-src.yaml          |  19 ++-
 .../bindings/serial/fsl-imx-uart.yaml         |   4 +
 .../bindings/serial/fsl-lpuart.yaml           |  17 ++-
 .../bindings/thermal/imx8mm-thermal.yaml      |  10 +-
 .../bindings/watchdog/fsl-imx-wdt.yaml        |  11 +-
 17 files changed, 303 insertions(+), 347 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8m-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mm-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mn-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mp-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.yaml

-- 
2.17.1

