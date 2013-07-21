From: Richard Zhao <rizhao@nvidia.com>
Subject: [PATCH] serial: tegra: correct help message in Kconfig from 'ttyHS' to 'ttyTHS'
Date: Sun, 21 Jul 2013 10:43:27 +0800
Message-ID: <1374374607-31183-2-git-send-email-rizhao@nvidia.com>
References: <1374374607-31183-1-git-send-email-rizhao@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:6351 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab3GUCnm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 20 Jul 2013 22:43:42 -0400
In-Reply-To: <1374374607-31183-1-git-send-email-rizhao@nvidia.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, swarren@wwwdotorg.org, ldewangan@nvidia.com, Richard Zhao <rizhao@nvidia.com>

ttyTHS is consistent with the name used in driver.

Signed-off-by: Richard Zhao <rizhao@nvidia.com>
---
 drivers/tty/serial/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 5e3d689..1456673 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -277,7 +277,7 @@ config SERIAL_TEGRA
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the NVIDIA Tegra series SOCs
-	  providing /dev/ttyHS0, 1, 2, 3 and 4 (note, some machines may not
+	  providing /dev/ttyTHS0, 1, 2, 3 and 4 (note, some machines may not
 	  provide all of these ports, depending on how the serial port
 	  are enabled). This driver uses the APB DMA to achieve higher baudrate
 	  and better performance.
-- 
1.8.1.5

