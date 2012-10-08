From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH v2] serial: vt8500: fix possible memory leak in vt8500_serial_probe()
Date: Mon, 8 Oct 2012 10:35:46 +0800
Message-ID: <CAPgLHd9oM+AnBenTNivOT+w8iK+GvPH+i4xyFjn1qqt65Tys+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:48707 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab2JHCfq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 Oct 2012 22:35:46 -0400
Received: by mail-qc0-f174.google.com with SMTP id d3so2515832qch.19
        for <linux-serial@vger.kernel.org>; Sun, 07 Oct 2012 19:35:46 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux@prisktech.co.nz, alan@linux.intel.com, gregkh@linuxfoundation.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

vt8500_port is malloced in vt8500_serial_probe() and should be freed
before leaving from the error handling cases, otherwise it will
cause memory leak.
Fix it by move the allocation of vt8500_port after those test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Acked-by: Tony Prisk <linux@prisktech.co.nz>
---
v1 -> v2: move the allocation of vt8500_port after those test
---
 drivers/tty/serial/vt8500_serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 205d4cf..4354fe5 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -567,10 +567,6 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 	if (!mmres || !irqres)
 		return -ENODEV;
 
-	vt8500_port = kzalloc(sizeof(struct vt8500_port), GFP_KERNEL);
-	if (!vt8500_port)
-		return -ENOMEM;
-
 	if (np)
 		port = of_alias_get_id(np, "serial");
 		if (port > VT8500_MAX_PORTS)
@@ -593,6 +589,10 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
+	vt8500_port = kzalloc(sizeof(struct vt8500_port), GFP_KERNEL);
+	if (!vt8500_port)
+		return -ENOMEM;
+
 	vt8500_port->uart.type = PORT_VT8500;
 	vt8500_port->uart.iotype = UPIO_MEM;
 	vt8500_port->uart.mapbase = mmres->start;


