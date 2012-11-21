From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH] tty/8250 Add check for pci_ioremap_bar failure
Date: Wed, 21 Nov 2012 10:39:18 -0600
Message-ID: <CAJp1Oe7qRpz0dr9Yua+AWQsKGKnoPTSe8vvKM27BnEH3H64ikA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55977 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200Ab2KUQjk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Nov 2012 11:39:40 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so3720975vcm.19
        for <linux-serial@vger.kernel.org>; Wed, 21 Nov 2012 08:39:40 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <greg@kroah.com>

Add check for pci_ioremap_bar failure

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: 1e619a1bf9ac878e6a984e4e279ccf712a65bc23

This depends on my previous patch submission:
[PATCH v3] Add support for new devices: Exar's XR17V35x family of
multi-port PCIe UARTs

 drivers/tty/serial/8250/8250_pci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c
b/drivers/tty/serial/8250/8250_pci.c
index 4302c05..4867b70 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1172,6 +1172,8 @@ pci_xr17v35x_setup(struct serial_private *priv,
 	u8 __iomem *p;

 	p = pci_ioremap_bar(priv->dev, 0);
+	if (p == NULL)
+		return -ENOMEM;

 	port->port.flags |= UPF_EXAR_EFR;

-- 
1.7.2.5
