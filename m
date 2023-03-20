Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B4C6FD1D
	for <linux-serial@archiver.kernel.org>; Mon, 20 Mar 2023 08:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCTIMN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Mar 2023 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCTIMM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Mar 2023 04:12:12 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7A718166
        for <linux-serial@vger.kernel.org>; Mon, 20 Mar 2023 01:12:10 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 32K7v6wj088828;
        Mon, 20 Mar 2023 15:57:07 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from Chiawei-PC03.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 20 Mar
 2023 16:11:39 +0800
From:   Chia-Wei Wang <chiawei_wang@aspeedtech.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <pmenzel@molgen.mpg.de>,
        <ilpo.jarvinen@linux.intel.com>, <hdanton@sina.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <openbmc@lists.ozlabs.org>
Subject: [PATCH v3 5/5] ARM: dts: aspeed-g6: Add UDMA node
Date:   Mon, 20 Mar 2023 16:11:33 +0800
Message-ID: <20230320081133.23655-6-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 32K7v6wj088828
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add the device tree node for the UART DMA (UDMA) controller.

Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed-g6.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index 8246a60de0d0..172dd748d807 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -863,6 +863,15 @@ fsim1: fsi@1e79b100 {
 				clocks = <&syscon ASPEED_CLK_GATE_FSICLK>;
 				status = "disabled";
 			};
+
+			udma: dma-controller@1e79e000 {
+				compatible = "aspeed,ast2600-udma";
+				reg = <0x1e79e000 0x1000>;
+				interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
+				dma-channels = <28>;
+				#dma-cells = <1>;
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.25.1

