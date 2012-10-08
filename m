From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] serial: vt8500: fix possible memory leak in vt8500_serial_probe()
Date: Mon, 8 Oct 2012 08:47:47 +0800
Message-ID: <CAPgLHd9NrFCsp5NhjBJ4tYgY3-SfbTA-ps=rZgpmoywM6tX6KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35989 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2JHArs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 Oct 2012 20:47:48 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1734391qad.19
        for <linux-serial@vger.kernel.org>; Sun, 07 Oct 2012 17:47:47 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux@prisktech.co.nz, alan@linux.intel.com, gregkh@linuxfoundation.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

vt8500_port is malloced in vt8500_serial_probe() and should be freed
before leaving from the error handling cases, otherwise it will
cause memory leak.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/vt8500_serial.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 205d4cf..43fc369 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -584,13 +584,16 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 					sizeof(vt8500_ports_in_use));
 	}
 
-	if (port > VT8500_MAX_PORTS)
-		return -ENODEV;
+	if (port > VT8500_MAX_PORTS) {
+		ret = -ENODEV;
+		goto err;
+	}
 
 	/* reserve the port id */
 	if (test_and_set_bit(port, &vt8500_ports_in_use)) {
 		/* port already in use - shouldn't really happen */
-		return -EBUSY;
+		ret = -EBUSY;
+		goto err;
 	}
 
 	vt8500_port->uart.type = PORT_VT8500;


