From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH RFC 6/6] ARM: multi_v7_defconfig: Adopt to UART driver renaming
Date: Tue,  4 Mar 2014 09:17:29 -0800
Message-ID: <1393953449-28551-7-git-send-email-soren.brinkmann@xilinx.com>
References: <1393953449-28551-1-git-send-email-soren.brinkmann@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393953449-28551-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: Michal Simek <michal.simek@xilinx.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Soren Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-serial@vger.kernel.org

The Xilinx UARTPS driver has been renamed to Cadence UART.  Remove
the stale Xilinx UARTPS config options and add Cadence UART instead.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Peter Crosthwaite <peter.crosthwaite@xilinx.com>
---
 arch/arm/configs/multi_v7_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ee6982976d66..4054c97a97e8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -151,8 +151,8 @@ CONFIG_SERIAL_VT8500_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_OMAP=y
 CONFIG_SERIAL_OMAP_CONSOLE=y
-CONFIG_SERIAL_XILINX_PS_UART=y
-CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
+CONFIG_SERIAL_CADENCE_UART=y
+CONFIG_SERIAL_CADENCE_UART_CONSOLE=y
 CONFIG_SERIAL_FSL_LPUART=y
 CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
 CONFIG_SERIAL_ST_ASC=y
-- 
1.9.0.1.g4196000
