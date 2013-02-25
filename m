From: Bastian Hecht <hechtb@gmail.com>
Subject: [PATCH v2 2/3] ARM: mach-shmobile: r8a7740: Add DT names to clock list
Date: Mon, 25 Feb 2013 13:06:54 -0600
Message-ID: <1361819215-4115-2-git-send-email-hechtb+renesas@gmail.com>
References: <1361819215-4115-1-git-send-email-hechtb+renesas@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:35363 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3BYSNY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Feb 2013 13:13:24 -0500
In-Reply-To: <1361819215-4115-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-serial@vger.kernel.org

This adds temporarily the alternative device names to the clock list
that are used when booting via Device Tree setup.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: no changes

 arch/arm/mach-shmobile/clock-r8a7740.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 71fc400..0f77823 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -593,18 +593,27 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_ceu.1",	&mstp_clks[MSTP128]),
 
 	CLKDEV_DEV_ID("sh-sci.4",		&mstp_clks[MSTP200]),
+	CLKDEV_DEV_ID("e6c80000.sci",		&mstp_clks[MSTP200]),
 	CLKDEV_DEV_ID("sh-sci.3",		&mstp_clks[MSTP201]),
+	CLKDEV_DEV_ID("e6c70000.sci",		&mstp_clks[MSTP201]),
 	CLKDEV_DEV_ID("sh-sci.2",		&mstp_clks[MSTP202]),
+	CLKDEV_DEV_ID("e6c60000.sci",		&mstp_clks[MSTP202]),
 	CLKDEV_DEV_ID("sh-sci.1",		&mstp_clks[MSTP203]),
+	CLKDEV_DEV_ID("e6c50000.sci",		&mstp_clks[MSTP203]),
 	CLKDEV_DEV_ID("sh-sci.0",		&mstp_clks[MSTP204]),
+	CLKDEV_DEV_ID("e6c40000.sci",		&mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.8",		&mstp_clks[MSTP206]),
+	CLKDEV_DEV_ID("e6c30000.sci",		&mstp_clks[MSTP206]),
 	CLKDEV_DEV_ID("sh-sci.5",		&mstp_clks[MSTP207]),
+	CLKDEV_DEV_ID("e6cb0000.sci",		&mstp_clks[MSTP207]),
 	CLKDEV_DEV_ID("sh-dma-engine.3",	&mstp_clks[MSTP214]),
 	CLKDEV_DEV_ID("sh-dma-engine.2",	&mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-dma-engine.1",	&mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("sh-dma-engine.0",	&mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("sh-sci.7",		&mstp_clks[MSTP222]),
+	CLKDEV_DEV_ID("e6cd0000.sci",		&mstp_clks[MSTP222]),
 	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
+	CLKDEV_DEV_ID("e6cc0000.sci",		&mstp_clks[MSTP230]),
 
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("sh_fsi2",		&mstp_clks[MSTP328]),
-- 
1.7.9.5

