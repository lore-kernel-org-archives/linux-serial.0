From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Date: Thu,  1 Nov 2018 11:26:06 -0700
Message-ID: <20181101182609.24142-1-f.fainelli@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: arndb@arndb.de, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Moese <mmoese@suse.de>, Lokesh Vutla <lokeshvutla@ti.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
result in the inability for the kernel to have a valid console device,
which can be seen with:

Warning: unable to open an initial console.

and then:

Run /init as init process
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100

Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
really is no drawback to defaulting this config to the value of
SERIAL_8250.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/8250/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 15c2c5463835..d7737dca0e48 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -484,6 +484,7 @@ config SERIAL_8250_PXA
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
+	default SERIAL_8250
 	help
 	  This option is used for all 8250 compatible serial ports that
 	  are probed through devicetree, including Open Firmware based
-- 
2.17.1
