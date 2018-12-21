From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] Revert "serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250"
Date: Thu, 20 Dec 2018 20:27:16 -0800
Message-ID: <20181221042719.29954-1-f.fainelli@gmail.com>
References: <20181220173844.GA5838@roeck-us.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181220173844.GA5838@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-vger@kernel.org
Cc: linux-serial@vger.kernel.org, mpe@ellerman.id.au, arnd@arndb.de, gregkh@linuxfoundation.org, linux@roeck-us.net, benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, Florian Fainelli <f.fainelli@gmail.com>, Jiri Slaby <jslaby@suse.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Michael Moese <mmoese@suse.de>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

This reverts commit 6d11023c345e369bcb9d5a68b271764e362c1f6e ("serial:
8250: Default SERIAL_OF_PLATFORM to SERIAL_8250") since that breaks at
least mpc8544ds (PowerPC) using arch/powerpc/kernel/legacy_serial.c.

See https://lkml.org/lkml/2018/12/5/1491 for discussion and analysis

Fixes: 6d11023c345e ("serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/tty/serial/8250/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d7737dca0e48..15c2c5463835 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -484,7 +484,6 @@ config SERIAL_8250_PXA
 config SERIAL_OF_PLATFORM
 	tristate "Devicetree based probing for 8250 ports"
 	depends on SERIAL_8250 && OF
-	default SERIAL_8250
 	help
 	  This option is used for all 8250 compatible serial ports that
 	  are probed through devicetree, including Open Firmware based
-- 
2.19.1
