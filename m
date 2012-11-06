From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] serial: cast before shifting on port io
Date: Tue, 06 Nov 2012 14:30:28 +0000
Message-ID: <20121106143007.21886.98666.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:41291 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab2KFOYz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Nov 2012 09:24:55 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Without this we will shift data into oblivion and give wrong results on
some configurations

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/serial_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 31af2a4..b2b77fd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2409,7 +2409,7 @@ static ssize_t uart_get_attr_port(struct device *dev,
 	struct tty_port *port = dev_get_drvdata(dev);
 
 	uart_get_info(port, &tmp);
-	return snprintf(buf, PAGE_SIZE, "0x%lX\n", (unsigned long)(tmp.port | (tmp.port_high << HIGH_BITS_OFFSET)));
+	return snprintf(buf, PAGE_SIZE, "0x%lX\n", (unsigned long)(tmp.port | (((unsigned long)tmp.port_high) << HIGH_BITS_OFFSET)));
 }
 
 static ssize_t uart_get_attr_irq(struct device *dev,

