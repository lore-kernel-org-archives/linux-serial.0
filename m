From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] tty: serial: vt8500: fix return value check in vt8500_serial_probe()
Date: Sun, 2 Dec 2012 05:10:44 -0500
Message-ID: <CAPgLHd_gx3BmZh+L1k6koa6eH5SKKEVFedSC_M=nju+Dzq=rug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:35722 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab2LBKKp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 2 Dec 2012 05:10:45 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1017265qcr.19
        for <linux-serial@vger.kernel.org>; Sun, 02 Dec 2012 02:10:44 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux@prisktech.co.nz, alan@linux.intel.com, gregkh@linuxfoundation.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, function of_clk_get() returns ERR_PTR()
and never returns NULL. The NULL test in the return value
check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/vt8500_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 205d4cf..f528cc2 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -604,7 +604,7 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
 
 	vt8500_port->clk = of_clk_get(pdev->dev.of_node, 0);
-	if (vt8500_port->clk) {
+	if (!IS_ERR(vt8500_port->clk)) {
 		vt8500_port->uart.uartclk = clk_get_rate(vt8500_port->clk);
 	} else {
 		/* use the default of 24Mhz if not specified and warn */


