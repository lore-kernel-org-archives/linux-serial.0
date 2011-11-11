From: Richard Zhao <richard.zhao@linaro.org>
Subject: [PATCH V3 06/14] ARM: mxc: arch_reset: add clk_prepare/clk_unprepare
Date: Fri, 11 Nov 2011 18:50:29 +0800
Message-ID: <1321008637-19999-7-git-send-email-richard.zhao@linaro.org>
References: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-va3.bigfish.com ([216.32.180.10]:23134 "EHLO
	VA3EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754660Ab1KKKvJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Nov 2011 05:51:09 -0500
In-Reply-To: <1321008637-19999-1-git-send-email-richard.zhao@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-serial@vger.kernel.org
Cc: linux@arm.linux.org.uk, amit.kucheria@canonical.com, kernel@pengutronix.de, ben-linux@fluff.org, cjb@laptop.org, alan@linux.intel.com, eric.miao@linaro.org, Richard Zhao <richard.zhao@linaro.org>

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/system.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/system.c b/arch/arm/plat-mxc/system.c
index 9dad8dc..a667adc 100644
--- a/arch/arm/plat-mxc/system.c
+++ b/arch/arm/plat-mxc/system.c
@@ -54,7 +54,7 @@ void arch_reset(char mode, const char *cmd)
 
 		clk = clk_get_sys("imx2-wdt.0", NULL);
 		if (!IS_ERR(clk))
-			clk_enable(clk);
+			clk_prepare_enable(clk);
 		wcr_enable = (1 << 2);
 	}
 
-- 
1.7.5.4


