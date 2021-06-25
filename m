Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5371EC49EBB
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 14:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAFB61982
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 14:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbhFYOjX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 10:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhFYOjV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 10:39:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAE7061984;
        Fri, 25 Jun 2021 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624631820;
        bh=T0mW93bAWjjD43SpwigpxEzfcq2OO0t/qVju3EV9cn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGtDlqZ0WBvnxjKkRsX6H6REf7GmUk3IjdwP765Jd61LP1y1T4RC5yom4NlBiWXsZ
         dp5nT13A1UHxJZU5G3dKWsIAQI2RtyjH4SqAhM2ADPeZs71GfSYcF0BnHZJLp/3xGw
         x6HreA0HuLto59EgT93L+Z909+Su8YQ9sMWJkd4dF3W4uBO84RNzWRAoJbRaRkwtzQ
         Xhc6mkdXhGGvyAL7g9MooegEMmciNcvJ3vchw/JqLYBw2Vu5lIq3JYNn7LMqEBoRwn
         gX+rPOYfdyHQqy1ugIVRO93fOJ4Uw1j+kZcqabAI2AB0iuBVhQxOYo7TSL98oOXJml
         aq8WFHaicaK8g==
Received: by pali.im (Postfix)
        id 9B9C960E; Fri, 25 Jun 2021 16:36:59 +0200 (CEST)
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
Subject: [PATCH v2 05/11] arm64: dts: marvell: armada-37xx: Fix reg for standard variant of UART
Date:   Fri, 25 Jun 2021 16:36:11 +0200
Message-Id: <20210625143617.12826-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625143617.12826-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210625143617.12826-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

UART1 (standard variant with DT node name 'uart0') has register space
0x12000-0x12018 and not whole size 0x200. So fix also this in example.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: c737abc193d1 ("arm64: dts: marvell: Fix A37xx UART0 register size")
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 6897f1f7a7f0..20dd9d9e9d58 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -134,7 +134,7 @@
 
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
-				reg = <0x12000 0x200>;
+				reg = <0x12000 0x18>;
 				clocks = <&xtalclk>;
 				interrupts =
 				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.20.1

