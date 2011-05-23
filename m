From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 37/48] pch_uart: Support new device ML7223 IOH
Date: Mon, 23 May 2011 12:10:43 -0700
Message-ID: <1306177854-18172-37-git-send-email-gregkh@suse.de>
References: <20110523190539.GA17519@kroah.com>
 <1306177854-18172-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:42110 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932346Ab1EWTL4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 May 2011 15:11:56 -0400
In-Reply-To: <1306177854-18172-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>

Support new device OKI SEMICONDUCTOR ML7223 IOH(Input/Output Hub).
The ML7223 IOH is for MP(Media Phone) use.
The ML7223 is companion chip for Intel Atom E6xx series.
The ML7223 is completely compatible for Intel EG20T PCH.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/Kconfig    |   12 +++++++-----
 drivers/tty/serial/pch_uart.c |    8 ++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 84876ec..2f96ce9 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1577,7 +1577,7 @@ config SERIAL_IFX6X60
 	  Support for the IFX6x60 modem devices on Intel MID platforms.
 
 config SERIAL_PCH_UART
-	tristate "Intel EG20T PCH UART/OKI SEMICONDUCTOR ML7213 IOH"
+	tristate "Intel EG20T PCH / OKI SEMICONDUCTOR IOH(ML7213/ML7223) UART"
 	depends on PCI
 	select SERIAL_CORE
 	help
@@ -1585,10 +1585,12 @@ config SERIAL_PCH_UART
 	  which is an IOH(Input/Output Hub) for x86 embedded processor.
 	  Enabling PCH_DMA, this PCH UART works as DMA mode.
 
-	  This driver also can be used for OKI SEMICONDUCTOR ML7213 IOH(Input/
-	  Output Hub) which is for IVI(In-Vehicle Infotainment) use.
-	  ML7213 is companion chip for Intel Atom E6xx series.
-	  ML7213 is completely compatible for Intel EG20T PCH.
+	  This driver also can be used for OKI SEMICONDUCTOR IOH(Input/
+	  Output Hub), ML7213 and ML7223.
+	  ML7213 IOH is for IVI(In-Vehicle Infotainment) use and ML7223 IOH is
+	  for MP(Media Phone) use.
+	  ML7213/ML7223 is companion chip for Intel Atom E6xx series.
+	  ML7213/ML7223 is completely compatible for Intel EG20T PCH.
 
 config SERIAL_MSM_SMD
 	bool "Enable tty device interface for some SMD ports"
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 26403b8..c63d0d1 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -253,6 +253,8 @@ enum pch_uart_num_t {
 	pch_ml7213_uart0,
 	pch_ml7213_uart1,
 	pch_ml7213_uart2,
+	pch_ml7223_uart0,
+	pch_ml7223_uart1,
 };
 
 static struct pch_uart_driver_data drv_dat[] = {
@@ -263,6 +265,8 @@ static struct pch_uart_driver_data drv_dat[] = {
 	[pch_ml7213_uart0] = {PCH_UART_8LINE, 0},
 	[pch_ml7213_uart1] = {PCH_UART_2LINE, 1},
 	[pch_ml7213_uart2] = {PCH_UART_2LINE, 2},
+	[pch_ml7223_uart0] = {PCH_UART_8LINE, 0},
+	[pch_ml7223_uart1] = {PCH_UART_2LINE, 1},
 };
 
 static unsigned int default_baud = 9600;
@@ -1534,6 +1538,10 @@ static DEFINE_PCI_DEVICE_TABLE(pch_uart_pci_id) = {
 	 .driver_data = pch_ml7213_uart1},
 	{PCI_DEVICE(PCI_VENDOR_ID_ROHM, 0x8029),
 	 .driver_data = pch_ml7213_uart2},
+	{PCI_DEVICE(PCI_VENDOR_ID_ROHM, 0x800C),
+	 .driver_data = pch_ml7223_uart0},
+	{PCI_DEVICE(PCI_VENDOR_ID_ROHM, 0x800D),
+	 .driver_data = pch_ml7223_uart1},
 	{0,},
 };
 
-- 
1.7.4.2

