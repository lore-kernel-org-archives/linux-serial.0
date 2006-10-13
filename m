From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: handle pci_enable_device() failure upon resume
Date: Sat, 14 Oct 2006 00:15:43 +0100
Message-ID: <1160781343.25218.89.camel@localhost.localdomain>
References: <20061012014720.GA12935@havoc.gtf.org>
	 <20061013075953.GC28654@flint.arm.linux.org.uk>
	 <20061013131516.227e99ee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44165 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751959AbWJMWuS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Oct 2006 18:50:18 -0400
In-Reply-To: <20061013131516.227e99ee.akpm@osdl.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Jeff Garzik <jeff@garzik.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Ar Gwe, 2006-10-13 am 13:15 -0700, ysgrifennodd Andrew Morton:
> Right now, we get silent failure *and* a compile-time warning.  It's hard
> to see how that situation could be made worse.

I support Russells NAK but for another reason. You can't use printk in
the paths of a serial driver that may be the console. There is already a
whole ordering issue here and I'm not convinced it is handled correctly
reviewing the diff. Printks will make it worse in any driver (and waste
memory on handling impossible untestable situations that don't appen)

The printk case and serial first ordering want fixing correctly because
serial console is about the only sane way to debug resume in the first
place.

Alan
