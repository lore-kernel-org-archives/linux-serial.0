Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C3DC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 10 Mar 2022 16:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiCJQXp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244449AbiCJQXB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Mar 2022 11:23:01 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED93195300
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 08:21:04 -0800 (PST)
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C1F05D07CD
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 16:17:14 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 26342C000A;
        Thu, 10 Mar 2022 16:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646929029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjUPIaxQ1WBMLteeByIABCjhVWOu3Y3N20N5eUaJ/3w=;
        b=X7iP3eV6hikcEbM46cBxOKlShAsQUKQBFFesGuHsRkK7cJRwU0HGQCcpGhHRvfMYpL4MWE
        yLmovwzysfDt/8A+n683PbYnLsOwrNMmlrv90BvdgyHU2IldsffiPuRNFpULVjCMThwiIS
        r9TfkxOrBjRfhFZ1VisfjGgHX4S6gp1Nv4bDDVkpONx4k5h49PwAt0ab9Q+E9Qm+FlY/Kv
        r9ZiPJYmDSHO5M5KtR0l3gNxlteOU2BIgSRcBxHPMXMtAxSQNCAiEtkvtxilFwL80muP4K
        VPSLN3OS0oZAjJ42/Q1yY9OYacRbUL5Pp4ln6xfxrQHaKf3JhZqmpyoJpIvx4Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 7/7] ARM: dts: r9a06g032: Fill the UART DMA properties
Date:   Thu, 10 Mar 2022 17:16:50 +0100
Message-Id: <20220310161650.289387-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220310161650.289387-1-miquel.raynal@bootlin.com>
References: <20220310161650.289387-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

UART 0 to 2 do not have DMA support, while UART 3 to 7 do.

Fill the "dmas" and "dma-names" properties for each of these nodes.

Please mind that these nodes go through the dmamux node which will
redirect the requests to the right DMA controller. The first 4 cells of
the "dmas" properties will be transferred as-is to the DMA
controllers. The last 2 cells are consumed by the dmamux. Which means
cell 0 and 4 are almost redundant, one giving the controller request ID
and the other the dmamux channel which is a 1:1 translation of the
request IDs, shifted by 16 when pointing to the second DMA controller.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm/boot/dts/r9a06g032.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a06g032.dtsi
index 804f2d6f416f..aa447e2622e0 100644
--- a/arch/arm/boot/dts/r9a06g032.dtsi
+++ b/arch/arm/boot/dts/r9a06g032.dtsi
@@ -128,6 +128,9 @@ uart3: serial@50000000 {
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART3>, <&sysctrl R9A06G032_HCLK_UART3>;
 			clock-names = "baudclk", "apb_pclk";
+			dmas =  <&dmamux 0 0 0 0 0 1>,
+				<&dmamux 1 0 0 0 1 1>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -139,6 +142,9 @@ uart4: serial@50001000 {
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART4>, <&sysctrl R9A06G032_HCLK_UART4>;
 			clock-names = "baudclk", "apb_pclk";
+			dmas =  <&dmamux 2 0 0 0 2 1>,
+				<&dmamux 3 0 0 0 3 1>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -150,6 +156,9 @@ uart5: serial@50002000 {
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART5>, <&sysctrl R9A06G032_HCLK_UART5>;
 			clock-names = "baudclk", "apb_pclk";
+			dmas =  <&dmamux 4 0 0 0 4 1>,
+				<&dmamux 5 0 0 0 5 1>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -161,6 +170,9 @@ uart6: serial@50003000 {
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART6>, <&sysctrl R9A06G032_HCLK_UART6>;
 			clock-names = "baudclk", "apb_pclk";
+			dmas =  <&dmamux 6 0 0 0 6 1>,
+				<&dmamux 7 0 0 0 7 1>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -172,6 +184,9 @@ uart7: serial@50004000 {
 			reg-io-width = <4>;
 			clocks = <&sysctrl R9A06G032_CLK_UART7>, <&sysctrl R9A06G032_HCLK_UART7>;
 			clock-names = "baudclk", "apb_pclk";
+			dmas =  <&dmamux 4 0 0 0 20 1>,
+				<&dmamux 5 0 0 0 21 1>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.27.0

