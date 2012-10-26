From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] 8250_pci: use module_pci_driver to simplify the code
Date: Fri, 26 Oct 2012 23:04:22 +0800
Message-ID: <CAPgLHd9=JVqT1yi_0Y2bM8766-c-BUfACuPKHJDosFwqkahTwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49164 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2JZPEY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Oct 2012 11:04:24 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so1358860qcr.19
        for <linux-serial@vger.kernel.org>; Fri, 26 Oct 2012 08:04:22 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Use the module_pci_driver() macro to make the code simpler
by eliminating module_init and module_exit calls.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/tty/serial/8250/8250_pci.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index cec8852..508063b 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -4332,18 +4332,7 @@ static struct pci_driver serial_pci_driver = {
 	.err_handler	= &serial8250_err_handler,
 };
 
-static int __init serial8250_pci_init(void)
-{
-	return pci_register_driver(&serial_pci_driver);
-}
-
-static void __exit serial8250_pci_exit(void)
-{
-	pci_unregister_driver(&serial_pci_driver);
-}
-
-module_init(serial8250_pci_init);
-module_exit(serial8250_pci_exit);
+module_pci_driver(serial_pci_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 PCI serial probe module");


