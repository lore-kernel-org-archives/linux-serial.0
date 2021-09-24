Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0CDC433EF
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 10:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F190610CB
	for <linux-serial@archiver.kernel.org>; Fri, 24 Sep 2021 10:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbhIXKXG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Sep 2021 06:23:06 -0400
Received: from comms.puri.sm ([159.203.221.185]:35400 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhIXKWw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Sep 2021 06:22:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A6EB5E119D;
        Fri, 24 Sep 2021 03:21:19 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wtAukYPPuay0; Fri, 24 Sep 2021 03:21:18 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     abel.vesa@nxp.com
Cc:     a.fatoum@pengutronix.de, adrian.hunter@intel.com,
        aisheng.dong@nxp.com, catalin.marinas@arm.com,
        cw00.choi@samsung.com, devicetree@vger.kernel.org,
        djakov@kernel.org, festevam@gmail.com, kernel@pengutronix.de,
        kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        myungjoo.ham@samsung.com, robh@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, ulf.hansson@linaro.org, will.deacon@arm.com,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [RFC 00/19] Add interconnect and devfreq support for i.MX8MQ
Date:   Fri, 24 Sep 2021 12:20:26 +0200
Message-Id: <20210924102026.2679952-1-martin.kepplinger@puri.sm>
In-Reply-To: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

hi Abel,

thank you for the update (this is actually v2 of this RFC right?)!

all in all this runs fine on the imx8mq (Librem 5 and devkit) I use. For all
the pl301 nodes I'm not yet sure what I can actually test / switch frequencies.

But I still have one problem: lcdif/mxfb already has the interconnect dram
DT property and I use the following call to request bandwidth:
https://source.puri.sm/martin.kepplinger/linux-next/-/commit/d690e4c021293f938eb2253607f92f5a64f15688
(mainlining this is on our todo list).

With your patchset, I get:

[    0.792960] genirq: Flags mismatch irq 30. 00000004 (mxsfb-drm) vs. 00000004 (mxsfb-drm)
[    0.801143] mxsfb 30320000.lcd-controller: Failed to install IRQ handler
[    0.808058] mxsfb: probe of 30320000.lcd-controller failed with error -16

so the main devfreq user (mxsfb) is not there :) why?

and when I remove the interconnect property from the lcdif DT node, mxsfb
probes again, but of course it doesn't lower dram freq as needed.

Do I do the icc calls wrong in mxsfb despite it working without your
patchset, or may there be something wrong on your side that breaks
the mxsfb IRQ?

again thanks a lot for working on this! I'm always happy to test.

                          martin



---
 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 6fac6676f412..8496a90f23bf 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -381,26 +381,6 @@ &A53_3 {
 	cpu-supply = <&buck2_reg>;
 };
 
-&ddrc {
-	operating-points-v2 = <&ddrc_opp_table>;
-
-	ddrc_opp_table: ddrc-opp-table {
-		compatible = "operating-points-v2";
-
-		opp-25M {
-			opp-hz = /bits/ 64 <25000000>;
-		};
-
-		opp-100M {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-
-		opp-800M {
-			opp-hz = /bits/ 64 <800000000>;
-		};
-	};
-};
-
 &dphy {
 	status = "okay";
 };
-- 
2.30.2

