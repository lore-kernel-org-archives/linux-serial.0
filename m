From: Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: [PATCH] serial: tegra: Fix compilation error
Date: Wed, 23 Jan 2013 12:52:13 +0530
Message-ID: <1358925733-20206-1-git-send-email-vbyravarasu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-kernel@vger.kernel.org, swarren@wwwdotorg.org, linux-serial@vger.kernel.org, Venu Byravarasu <vbyravarasu@nvidia.com>
List-Id: linux-serial@vger.kernel.org

Fix compilation error, by adding the correct header file
for Tegra clocks.

Signed-off-by: Venu Byravarasu <vbyravarasu@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index 30d6ff6..4f5e629 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -43,7 +43,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
-#include <mach/clk.h>
+#include <linux/clk/tegra.h>
 
 #define TEGRA_UART_TYPE				"TEGRA_UART"
 #define TX_EMPTY_STATUS				(UART_LSR_TEMT | UART_LSR_THRE)
-- 
1.7.0.4
