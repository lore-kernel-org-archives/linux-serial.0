Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4020C11D1B
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B080324673
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 17:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="Acfzjqav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgBTRxo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:53:44 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:36805 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbgBTRxo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 12:53:44 -0500
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9890223E5E;
        Thu, 20 Feb 2020 18:43:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582220634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vo4eabfDiU5MAlK7m5sK1wPAUvsnHzowKf/DJBK9M+Q=;
        b=AcfzjqavTlY6+PDzgIl2PH9++YzTtNvI3obaIk7y6bg/0SCZpTTI0yJfIqplpKvAqSBqr9
        lDAoNusvzqMO12HEisI3ByCqYQbi9dmBaFr6U5QKBZfxS26+/eSF/HjoVpPADVYtk2jdlk
        os2A33Bej4vBjTfCEchEqqnCAWZwVaI=
From:   Michael Walle <michael@walle.cc>
To:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jiri Slaby <jslaby@suse.com>, Peng Fan <peng.fan@nxp.com>,
        Yuan Yao <yao.yuan@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 7/7] arm64: dts: ls1028a: add missing LPUART nodes
Date:   Thu, 20 Feb 2020 18:43:34 +0100
Message-Id: <20200220174334.23322-7-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220174334.23322-1-michael@walle.cc>
References: <20200220174334.23322-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 9890223E5E
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.487];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.34.241.80:email,0.34.124.32:email,0.34.202.64:email,0.34.163.48:email];
         RCPT_COUNT_TWELVE(0.00)[14];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
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
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 40d82c49b174..f30ffc46063d 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -390,6 +390,61 @@
 			status = "disabled";
 		};
 
+
+		lpuart0: serial@2260000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x2260000 0x0 0x1000>;
+			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart1: serial@2270000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x2270000 0x0 0x1000>;
+			interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart2: serial@2280000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x2280000 0x0 0x1000>;
+			interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart3: serial@2290000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x2290000 0x0 0x1000>;
+			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart4: serial@22a0000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x22a0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
+		lpuart5: serial@22b0000 {
+			compatible = "fsl,ls1028a-lpuart";
+			reg = <0x0 0x22b0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clockgen 4 1>;
+			clock-names = "ipg";
+			status = "disabled";
+		};
+
 		edma0: dma-controller@22c0000 {
 			#dma-cells = <2>;
 			compatible = "fsl,ls1028a-edma";
-- 
2.20.1

