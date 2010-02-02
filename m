From: leitao@linux.vnet.ibm.com
Subject: [PATCH 1/2] jsm: removing the uart structure and filename on error
Date: Mon,  1 Feb 2010 20:34:35 -0500
Message-ID: <ca4d83709f14810b7ae9a3d1567f0ae370eb9ad0.1265074258.git.root@devhv4e-phantom-lp3.austin.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e24smtp05.br.ibm.com ([32.104.18.26]:60121 "EHLO
	e24smtp05.br.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0BBBfx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Feb 2010 20:35:53 -0500
Received: from mailhub1.br.ibm.com (mailhub1.br.ibm.com [9.18.232.109])
	by e24smtp05.br.ibm.com (8.14.3/8.13.1) with ESMTP id o121Ol2X004483
	for <linux-serial@vger.kernel.org>; Mon, 1 Feb 2010 23:24:47 -0200
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o121cJD2733496
	for <linux-serial@vger.kernel.org>; Mon, 1 Feb 2010 23:38:19 -0200
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
	by d24av04.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o121Zo03006049
	for <linux-serial@vger.kernel.org>; Mon, 1 Feb 2010 23:35:50 -0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, scottk@digi.com
Cc: Breno Leitao <leitao@linux.vnet.ibm.com>

If jsm fails to load, then remove the uart stuff, otherwise,
the things (as files), will be there forever (even when the module
is unloaded). If you try to reload the module, the following message
appears:

kobject_add_internal failed for ttyn1 with -EEXIST, don't try to
register things with the same name in the same directory.

This patch remove the uart things when the driver fails.

Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
---
 drivers/serial/jsm/jsm_driver.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/jsm/jsm_driver.c b/drivers/serial/jsm/jsm_driver.c
index 108c3e0..12cb5e4 100644
--- a/drivers/serial/jsm/jsm_driver.c
+++ b/drivers/serial/jsm/jsm_driver.c
@@ -179,6 +179,7 @@ static int __devinit jsm_probe_one(struct pci_dev *pdev, const struct pci_device
 
 	return 0;
  out_free_irq:
+	jsm_remove_uart_port(brd);
 	free_irq(brd->irq, brd);
  out_iounmap:
 	iounmap(brd->re_map_membase);
-- 
1.6.0.2

