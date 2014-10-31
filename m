From: Aaron Sierra <asierra@xes-inc.com>
Subject: [PATCH 2/2] serial: 8250_pci: Check mapping in pci_ni8430_init
Date: Thu, 30 Oct 2014 19:49:52 -0500 (CDT)
Message-ID: <1886983890.136536.1414716592751.JavaMail.zimbra@xes-inc.com>
References: <1231773431.136451.1414716402754.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xes-mad.com ([216.165.139.218]:58230 "EHLO xes-mad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161430AbaJaBuu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Oct 2014 21:50:50 -0400
In-Reply-To: <1231773431.136451.1414716402754.JavaMail.zimbra@xes-inc.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Check the return value of ioremap_nocache to make sure we got a
valid mapping.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 drivers/tty/serial/8250/8250_pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 2e8d8a4..e97eeda 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -757,6 +757,8 @@ pci_ni8430_setup(struct serial_private *priv,
 	offset += idx * board->uart_offset;
 
 	p = pci_ioremap_bar(dev, bar);
+	if (!p)
+		return -ENOMEM;
 
 	/* enable the transceiver */
 	writeb(readb(p + offset + NI8430_PORTCON) | NI8430_PORTCON_TXVR_ENABLE,
-- 
1.9.1
