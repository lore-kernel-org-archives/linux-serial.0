From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH 28/41] drivers: tty: serial: sunzilog: fix includes
Date: Sat, 27 Apr 2019 14:52:09 +0200
Message-ID: <1556369542-13247-29-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, andrew@aj.id.au, andriy.shevchenko@linux.intel.com, macro@linux-mips.org, vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com, liviu.dudau@arm.com, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk, linux@prisktech.co.nz, matthias.bgg@gmail.com, linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Fix checkpatch warning:

    WARNING: Use #include <linux/io.h> instead of <asm/io.h>
    #38: FILE: drivers/tty/serial/sunzilog.c:38:
    +#include <asm/io.h>

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sunzilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 17b0520..85edb0d 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -34,8 +34,8 @@
 #endif
 #include <linux/init.h>
 #include <linux/of_device.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 #include <asm/setup.h>
-- 
1.9.1
