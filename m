Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97070C3F2D1
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 17:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698DA214DB
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 17:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="JCQRnvQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCCRnh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:43:37 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:46731 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbgCCRn1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 3 Mar 2020 12:43:27 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 02B1023EA8;
        Tue,  3 Mar 2020 18:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583257404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bZm6ZfNU9396+MJXOBRUscy8hxQ1AdgyZ3RSnP5KrZU=;
        b=JCQRnvQ0RfsASdqbjilVtJFwBdG52LcArELQ5fRw6X6RI35xaH5MOfCLY04NM464eEflCl
        RJUHJO0PKErB3whrtEKIVbLDTLN6dUOXB4BlXPEU215VZOm8a2KhPK4iKi0gXH4EyGX/Lz
        /5MFvkVDye0iyd+U/JfhtkG4ROVv5pQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH v3 9/9] arm64: dts: ls1028a: add missing LPUART nodes
Date:   Tue,  3 Mar 2020 18:43:06 +0100
Message-Id: <20200303174306.6015-10-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303174306.6015-1-michael@walle.cc>
References: <20200303174306.6015-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 02B1023EA8
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.479];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.34.163.48:email,0.34.124.32:email,0.34.241.80:email,0.34.202.64:email];
         RCPT_COUNT_TWELVE(0.00)[14];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The LS1028A has six LPUART controllers. Add the nodes.

This was tested on a custom board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 0843cfbe7ae1..df51e81ebe84 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -333,6 +333,79 @@
 			status = "disabled";
 		};
 
+
+		lpuart0: serial@2260000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x2260000 0x0 0x1000>;
+			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			dma-names = "rx","tx";
+			dmas = <&edma0 1 32>,
+			       <&edma0 1 33>;
+			status = "disabled";
+		};
+
+		lpuart1: serial@2270000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x2270000 0x0 0x1000>;
+			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			dma-names = "rx","tx";
+			dmas = <&edma0 1 30>,
+			       <&edma0 1 31>;
+			status = "disabled";
+		};
+
+		lpuart2: serial@2280000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x2280000 0x0 0x1000>;
+			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			dma-names = "rx","tx";
+			dmas = <&edma0 1 28>,
+			       <&edma0 1 29>;
+			status = "disabled";
+		};
+
+		lpuart3: serial@2290000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x2290000 0x0 0x1000>;
+			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			dma-names = "rx","tx";
+			dmas = <&edma0 1 26>,
+			       <&edma0 1 27>;
+			status = "disabled";
+		};
+
+		lpuart4: serial@22a0000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x22a0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			dma-names = "rx","tx";
+			dmas = <&edma0 1 24>,
+			       <&edma0 1 25>;
+			status = "disabled";
+		};
+
+		lpuart5: serial@22b0000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x22b0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			dma-names = "rx","tx";
+			dmas = <&edma0 1 22>,
+			       <&edma0 1 23>;
+			status = "disabled";
+		};
+
 		edma0: dma-controller@22c0000 {
 			#dma-cells = <2>;
 			compatible = "fsl,ls1028a-edma", "fsl,vf610-edma";
-- 
2.20.1

