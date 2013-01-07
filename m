From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/5] serial: imx: Use <linux/io.h> instead of <asm/io.h>
Date: Mon,  7 Jan 2013 10:25:03 +0530
Message-ID: <1357534506-30206-3-git-send-email-sachin.kamat@linaro.org>
References: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:51260 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab3AGFDX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 7 Jan 2013 00:03:23 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so8541014dad.41
        for <linux-serial@vger.kernel.org>; Sun, 06 Jan 2013 21:03:22 -0800 (PST)
In-Reply-To: <1357534506-30206-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, jslaby@suse.cz, shawn.guo@linaro.org, s.hauer@pengutronix.de, sachin.kamat@linaro.org, patches@linaro.org

Silences the following checkpatch warning:
WARNING: Use #include <linux/io.h> instead of <asm/io.h>

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/tty/serial/imx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d6bce6c..426253c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -48,8 +48,8 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <linux/platform_data/serial-imx.h>
 
-- 
1.7.4.1

