From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 1/5] serial: sprd: Remove unused structure
Date: Fri, 10 Aug 2018 18:34:23 -0700
Message-ID: <50e1f7f4673bff9d71936b4eb34cbf2571b0fda9.1533950271.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, broonie@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Remove the unused reg_backup structure.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/tty/serial/sprd_serial.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 828f114..1b0e3fb 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -95,19 +95,8 @@
 #define SPRD_IMSR_BREAK_DETECT		BIT(7)
 #define SPRD_IMSR_TIMEOUT		BIT(13)
 
-struct reg_backup {
-	u32 ien;
-	u32 ctrl0;
-	u32 ctrl1;
-	u32 ctrl2;
-	u32 clkd0;
-	u32 clkd1;
-	u32 dspwait;
-};
-
 struct sprd_uart_port {
 	struct uart_port port;
-	struct reg_backup reg_bak;
 	char name[16];
 };
 
-- 
1.9.1
