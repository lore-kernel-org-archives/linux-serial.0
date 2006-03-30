From: Grant Grundler <grundler@parisc-linux.org>
Subject: ioremap_nocache() in setup_port() ok?
Date: Thu, 30 Mar 2006 00:54:10 -0700
Message-ID: <20060330075410.GB1722@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:19619 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1751311AbWC3HnB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Mar 2006 02:43:01 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk

Hi Russell,
This patch fixes a warning in the parisc-linux.org developement
tree. Helge Deller has done substantial work to enable proper
ioremap() functionality in parisc port and exposed some problems
with ioremap() vs ioremap_nocache() usage.

Most device drivers really want ioremap_nocache().
But we've been really sloppy since most implementations
treat MMIO space as uncached.

Am I correct that serial also wants _nocache() for MMIO space?

thanks,
grant

--- a/drivers/serial/8250_pci.c	13 Feb 2006 03:51:52 -0000	1.35
+++ b/drivers/serial/8250_pci.c	30 Mar 2006 07:21:03 -0000
@@ -87,7 +87,7 @@ setup_port(struct serial_private *priv, 
 		len =  pci_resource_len(dev, bar);
 
 		if (!priv->remapped_bar[bar])
-			priv->remapped_bar[bar] = ioremap(base, len);
+			priv->remapped_bar[bar] = ioremap_nocache(base, len);
 		if (!priv->remapped_bar[bar])
 			return -ENOMEM;
 
