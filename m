From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] fix error management in 8250_pci.c pciserial_resume_one
Date: Tue, 13 Feb 2007 10:54:11 +0000
Message-ID: <20070213105411.GA6883@flint.arm.linux.org.uk>
References: <20070213113010.27125d53@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4938 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbXBMKyT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Feb 2007 05:54:19 -0500
Content-Disposition: inline
In-Reply-To: <20070213113010.27125d53@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stefano Brivio <stefano.brivio@polimi.it>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Feb 13, 2007 at 11:30:10AM +0100, Stefano Brivio wrote:
>   CC      drivers/serial/8250_pci.o
> drivers/serial/8250_pci.c: In function 'pciserial_resume_one':
> drivers/serial/8250_pci.c:1830: warning: ignoring return value of 'pci_enable_device', declared with attribute warn_unused_result
> 
> This patch fixes it.

Oh for god sake, this does not fix anything.  It creates more problems
than it solves.

Next time, check the mailing list archives and you'll see this is not
the first time this has come up.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
