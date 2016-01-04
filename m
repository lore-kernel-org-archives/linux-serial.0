From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 1/6] 8250/Kconfig: add config option CONFIG_SERIAL_8250_AMD
Date: Mon, 4 Jan 2016 13:31:36 +0800
Message-ID: <1451885501-2710-2-git-send-email-annie.wang@amd.com>
References: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1451885501-2710-1-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Robin Murphy <robin.murphy@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, Tony Li <tony.li@amd.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

Add config option  CONFIG_SERIAL_8250_AMD in use of AMD carrizo.
Because carrizo's UART DMA device is an amba device, it selects
ARM_AMBA option. Anything uses amba devices must select ARM_AMBA.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/tty/serial/8250/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 6412f14..c9ebc31 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -378,3 +378,11 @@ config SERIAL_8250_MID
 	  Selecting this option will enable handling of the extra features
 	  present on the UART found on Intel Medfield SOC and various other
 	  Intel platforms.
+
+config SERIAL_8250_AMD
+	bool "AMD carrizo serial port support"
+	depends on SERIAL_8250
+	select ARM_AMBA
+	help
+	  If you have a Family 15h, models 0x60-0x6F based board and want to
+	  use the serial port, say Y to this option. If unsure, say N.
-- 
1.9.1

