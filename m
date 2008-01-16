From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2/2] 8250_pnp: register x86 COM ports at the conventional ttyS names
Date: Wed, 16 Jan 2008 18:42:06 +0000
Message-ID: <20080116184206.GC23371@flint.arm.linux.org.uk>
References: <20080116170541.511233227@ldl.fc.hp.com> <20080116170914.959390017@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55401 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbYAPSmV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2008 13:42:21 -0500
Content-Disposition: inline
In-Reply-To: <20080116170914.959390017@ldl.fc.hp.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Jan 16, 2008 at 10:05:43AM -0700, Bjorn Helgaas wrote:
>  static int __devinit
> +serial_pnp_line(struct uart_port *port)
> +{
> +#ifdef CONFIG_X86
> +	switch (port->iobase) {
> +	case 0x3f8:	return 0;	/* COM1 -> ttyS0 */
> +	case 0x2f8:	return 1;	/* COM2 -> ttyS1 */
> +	case 0x3e8:	return 2;	/* COM3 -> ttyS2 */
> +	case 0x2e8:	return 3;	/* COM4 -> ttyS3 */
> +	}
> +#endif

So what if someone intentionally modifies SERIAL_DEFN_PORTS to point
ttyS[0-3] somewhere else?  They also have to modify this code as well.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
