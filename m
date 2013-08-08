From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 05/10] serial: icom: fix casting warning
Date: Thu, 08 Aug 2013 17:34:03 +0900
Message-ID: <006001ce9412$09adcb70$1d096250$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29042 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933761Ab3HHIeI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 04:34:08 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MR7009S8EGMDA90@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 08 Aug 2013 17:34:03 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

>From ab11b21c1abc7499401e027ef356d2cca14c3f77 Mon Sep 17 00:00:00 2001
From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 8 Aug 2013 17:00:45 +0900
Subject: [PATCH 05/10] serial: icom: fix casting warning

icom_port->uart_port.membase is (unsigned char __iomem *); thus,
casting (unsigned char __iomem *) is necessary to fix the
following warning. Also, local symbols are staticized.

drivers/tty/serial/icom.c:108:26: warning: symbol 'start_proc' was not declared. Should it be static?
drivers/tty/serial/icom.c:116:26: warning: symbol 'stop_proc' was not declared. Should it be static?
drivers/tty/serial/icom.c:123:25: warning: symbol 'int_mask_tbl' was not declared. Should it be static?
drivers/tty/serial/icom.c:1569:54: warning: incorrect type in assignment (different address spaces)
drivers/tty/serial/icom.c:1569:54:    expected unsigned char [noderef] <asn:2>*membase
drivers/tty/serial/icom.c:1569:54:    got char *<noident>
drivers/tty/serial/icom.c:1090:9: warning: cast truncates bits from constant value (ffffff7f becomes 7f)

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/icom.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 18ed5ae..06555dd 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -105,7 +105,7 @@ static const struct pci_device_id icom_pci_table[] = {
 	{}
 };
 
-struct lookup_proc_table start_proc[4] = {
+static struct lookup_proc_table start_proc[4] = {
 	{NULL, ICOM_CONTROL_START_A},
 	{NULL, ICOM_CONTROL_START_B},
 	{NULL, ICOM_CONTROL_START_C},
@@ -113,14 +113,14 @@ struct lookup_proc_table start_proc[4] = {
 };
 
 
-struct lookup_proc_table stop_proc[4] = {
+static struct lookup_proc_table stop_proc[4] = {
 	{NULL, ICOM_CONTROL_STOP_A},
 	{NULL, ICOM_CONTROL_STOP_B},
 	{NULL, ICOM_CONTROL_STOP_C},
 	{NULL, ICOM_CONTROL_STOP_D}
 };
 
-struct lookup_int_table int_mask_tbl[4] = {
+static struct lookup_int_table int_mask_tbl[4] = {
 	{NULL, ICOM_INT_MASK_PRC_A},
 	{NULL, ICOM_INT_MASK_PRC_B},
 	{NULL, ICOM_INT_MASK_PRC_C},
@@ -1087,8 +1087,7 @@ static void icom_close(struct uart_port *port)
 
 	/* stop receiver */
 	cmdReg = readb(&ICOM_PORT->dram->CmdReg);
-	writeb(cmdReg & (unsigned char) ~CMD_RCV_ENABLE,
-	       &ICOM_PORT->dram->CmdReg);
+	writeb(cmdReg & ~CMD_RCV_ENABLE, &ICOM_PORT->dram->CmdReg);
 
 	shutdown(ICOM_PORT);
 
@@ -1567,7 +1566,7 @@ static int icom_probe(struct pci_dev *dev,
 			icom_port->uart_port.type = PORT_ICOM;
 			icom_port->uart_port.iotype = UPIO_MEM;
 			icom_port->uart_port.membase =
-					       (char *) icom_adapter->base_addr_pci;
+				(unsigned char __iomem *)icom_adapter->base_addr_pci;
 			icom_port->uart_port.fifosize = 16;
 			icom_port->uart_port.ops = &icom_ops;
 			icom_port->uart_port.line =
-- 
1.7.10.4


