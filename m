From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 09/10] serial: tegra: use NULL instead of 0
Date: Thu, 08 Aug 2013 17:40:55 +0900
Message-ID: <006501ce9412$ff4f43b0$fdedcb10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:43592 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757633Ab3HHIk5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:40:57 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR700BT0ES7WW60@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:40:56 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Jingoo Han <jg1.han@samsung.com>

'cons' is a pointer; thus NULL should be used instead of 0.
Also, local symbols are staticized.
Fix the following sparse warnings:

drivers/tty/serial/serial-tegra.c:1209:27: warning: Using plain integer as NULL pointer
drivers/tty/serial/serial-tegra.c:1240:29: warning: symbol 'tegra20_uart_chip_data' was not declared. Should it be static?
drivers/tty/serial/serial-tegra.c:1246:29: warning: symbol 'tegra30_uart_chip_data' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/serial-tegra.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index ee7c812..94a2484 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1206,7 +1206,7 @@ static struct uart_driver tegra_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "tegra_hsuart",
 	.dev_name	= "ttyTHS",
-	.cons		= 0,
+	.cons		= NULL,
 	.nr		= TEGRA_UART_MAXIMUM,
 };
 
@@ -1237,13 +1237,13 @@ static int tegra_uart_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
-struct tegra_uart_chip_data tegra20_uart_chip_data = {
+static struct tegra_uart_chip_data tegra20_uart_chip_data = {
 	.tx_fifo_full_status		= false,
 	.allow_txfifo_reset_fifo_mode	= true,
 	.support_clk_src_div		= false,
 };
 
-struct tegra_uart_chip_data tegra30_uart_chip_data = {
+static struct tegra_uart_chip_data tegra30_uart_chip_data = {
 	.tx_fifo_full_status		= true,
 	.allow_txfifo_reset_fifo_mode	= false,
 	.support_clk_src_div		= true,
-- 
1.7.10.4


