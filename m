From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [CFT:PATCH] Serial + Serial&Parallel PCI card cleanup
Date: Mon, 4 Jul 2005 09:57:02 +0100
Message-ID: <20050704095702.A26015@flint.arm.linux.org.uk>
References: <20050625162100.A21120@flint.arm.linux.org.uk> <20050704081500.GA24025@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12562 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261592AbVGDI5O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 4 Jul 2005 04:57:14 -0400
Content-Disposition: inline
In-Reply-To: <20050704081500.GA24025@pazke>; from pazke@donpac.ru on Mon, Jul 04, 2005 at 12:15:00PM +0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Kernel List <linux-kernel@vger.kernel.org>, Linux Serial List <linux-serial@vger.kernel.org>

On Mon, Jul 04, 2005 at 12:15:00PM +0400, Andrey Panin wrote:
> Me too, but I can confirm that my SIIG single port serial card still works
> with the patch, so at least SIIG quirk table cleanup didn't broke anything.

Thanks for testing.

> IMHO this cleanup could became a separate easy to merge patch.

I think the only split which would be reasonable is to make the changes
to 8250_pci separate from parport_serial.  Trying to split the changes
to parport_serial would be a recipe for disaster.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
