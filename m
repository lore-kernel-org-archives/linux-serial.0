From: Wang Hongcheng <annie.wang@amd.com>
Subject: [PATCH 2/9] 8250/Kconfig: add config option CONFIG_SERIAL_8250_AMD
Date: Fri, 4 Dec 2015 11:24:19 +0800
Message-ID: <1449199466-6081-3-git-send-email-annie.wang@amd.com>
References: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1449199466-6081-1-git-send-email-annie.wang@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, Borislav Petkov <bp@alien8.de>, Huang Rui <ray.huang@amd.com>, Wan Zongshun <vincent.wan@amd.com>, Ken Xue <ken.xue@amd.com>, Tony Li <tony.li@amd.com>, Wang Hongcheng <annie.wang@amd.com>
List-Id: linux-serial@vger.kernel.org

Add config option  CONFIG_SERIAL_8250_AMD in use of AMD carrizo.
Because carrizo's UART DMA device is an amba device, it selects
ARM_AMBA option. Anything uses amba devices must select ARM_AMBA.

Signed-off-by: Wang Hongcheng <annie.wang@amd.com>
---
 drivers/tty/serial/8250/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 6412f14..d9717c1 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -378,3 +378,11 @@ config SERIAL_8250_MID
 	  Selecting this option will enable handling of the extra features
 	  present on the UART found on Intel Medfield SOC and various other
 	  Intel platforms.
+
+config SERIAL_8250_AMD
+        bool "AMD carrizo serial port support"
+        depends on SERIAL_8250
+	select ARM_AMBA
+        help
+           If you have a Carrizo  based board and want to use the
+           serial port, say Y to this option. If unsure, say N.
-- 
1.9.1

