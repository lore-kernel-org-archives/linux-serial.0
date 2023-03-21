Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C2C76195
	for <linux-serial@archiver.kernel.org>; Tue, 21 Mar 2023 21:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCUV5C (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Mar 2023 17:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjCUV4s (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Mar 2023 17:56:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C651A5291F;
        Tue, 21 Mar 2023 14:56:43 -0700 (PDT)
Received: from localhost (unknown [188.24.179.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59F2166030E0;
        Tue, 21 Mar 2023 21:56:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679435802;
        bh=N/ZvfamKX7ttvXbRjuUCngvIStvDvApje9cACLj84nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DqaZ5y5wGDXGe9EAD5npPYnOvO8wTs3kNVCLiDkTuyJH7ci44MX8ygIEFgwNjQNyv
         sqBKfbH5NULmGNhEnqAny3aDt1UklimcwMHGKe3QsS4C18Php76Uwvcy5C5acRqSgU
         9ymwDXiVb3HW6dfk2SD+FWFK00TmK8vZVuyHZfdSzqLZwJb3Rp66yXy5Wd+mniHzQm
         HbaocTMIi2y2VmHj5H97kNMjZNVLXihy5ZuEYBfvyQ+vcefBsOSeIeE9tCqVfiLsna
         mtjcISN1N3a5tKbCODUy2AMlT5JCuwLsdKudj5rXfD1XCRuVVo74Qv8JEVlTjMCfyB
         s20AE7DVsgyug==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 04/10] ARM: dts: sun8i: v3s: Switch dma-names order for snps,dw-apb-uart nodes
Date:   Tue, 21 Mar 2023 23:56:18 +0200
Message-Id: <20230321215624.78383-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
References: <20230321215624.78383-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
dma-names properties") documented dma-names property to handle Allwinner
D1 dtbs_check warnings, but relies on the rx->tx ordering, which is the
reverse of what a bunch of different boards expect.

The initial proposed solution was to allow a flexible dma-names order in
the binding, due to potential ABI breakage concerns after fixing the DTS
files. But luckily the Allwinner boards are not affected, since they are
using a shared DMA channel for rx and tx.

Hence, the first step in fixing the inconsistency was to change
dma-names order in the binding to tx->rx.

Do the same for the snps,dw-apb-uart nodes in the DTS file.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index db194c606fdc..b001251644f7 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -479,7 +479,7 @@ uart0: serial@1c28000 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART0>;
 			dmas = <&dma 6>, <&dma 6>;
-			dma-names = "rx", "tx";
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
@@ -492,7 +492,7 @@ uart1: serial@1c28400 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART1>;
 			dmas = <&dma 7>, <&dma 7>;
-			dma-names = "rx", "tx";
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART1>;
 			status = "disabled";
 		};
@@ -505,7 +505,7 @@ uart2: serial@1c28800 {
 			reg-io-width = <4>;
 			clocks = <&ccu CLK_BUS_UART2>;
 			dmas = <&dma 8>, <&dma 8>;
-			dma-names = "rx", "tx";
+			dma-names = "tx", "rx";
 			resets = <&ccu RST_BUS_UART2>;
 			pinctrl-0 = <&uart2_pins>;
 			pinctrl-names = "default";
-- 
2.40.0

