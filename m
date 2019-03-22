From: Arnd Bergmann <arnd@arndb.de>
Subject: [BACKPORT 4.4.y 19/25] serial: sprd: adjust TIMEOUT to a big value
Date: Fri, 22 Mar 2019 16:44:10 +0100
Message-ID: <20190322154425.3852517-20-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Wei Qiao <wei.qiao@spreadtrum.com>, Chunyan Zhang <chunyan.zhang@spreadtrum.com>, Arnd Bergmann <arnd@arndb.de>, Lanqing Liu <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Wei Qiao <wei.qiao@spreadtrum.com>

SPRD_TIMEOUT was 256, which is too small to wait until the status
switched to workable in a while loop, so that the earlycon could
not work correctly.

Signed-off-by: Wei Qiao <wei.qiao@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit e1dc9b08051a2c2e694edf48d1e704f07c7c143c)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/sprd_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 1e302caaa450..176f0a2bf9d9 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -36,7 +36,7 @@
 #define SPRD_FIFO_SIZE		128
 #define SPRD_DEF_RATE		26000000
 #define SPRD_BAUD_IO_LIMIT	3000000
-#define SPRD_TIMEOUT		256
+#define SPRD_TIMEOUT		256000
 
 /* the offset of serial registers and BITs for them */
 /* data registers */
-- 
2.20.0
