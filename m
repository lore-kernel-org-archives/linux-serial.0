From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Early serial port problems
Date: Wed, 30 Mar 2005 10:41:10 +0100
Message-ID: <20050330104110.D6239@flint.arm.linux.org.uk>
References: <5895.1109773145@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62226 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261827AbVC3JlN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 30 Mar 2005 04:41:13 -0500
Content-Disposition: inline
In-Reply-To: <5895.1109773145@redhat.com>; from dhowells@redhat.com on Wed, Mar 02, 2005 at 02:19:05PM +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: linux-serial@vger.kernel.org

On Wed, Mar 02, 2005 at 02:19:05PM +0000, David Howells wrote:
>  (2) The boot console log lines for the serial ports and the proc tty listing
>      show an address of 0 because __frv_uart0.mapbase and __frv_uart1.mapbase
>      aren't set:
> 
> 	Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> 	ttyS0 at MMIO 0x0 (irq = 1) is a 16550A
> 	ttyS1 at MMIO 0x0 (irq = 2) is a 16550A
> 	io scheduler noop registered
> 
>      If I set .mapbase as well as .membase before calling early_serial_setup(),
>      then I see the kernel console output appear, but userspace can't access
>      the serial ports, and the serial driver doesn't record the existence of
>      the ports in the console log:
> 
> 	Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
> 	io scheduler noop registered
> 
>      Adding in UPF_IOREMAP makes no difference.
> 
>      Unsetting .membase and just leaving .mapbase set and UPF_IOREMAP set means
>      that you don't even get kernel console output, though the kernel still
>      boots.
> 
> I wonder if (1) is related to (2).

Don't think so.  It sounds like a problem with claiming the MMIO resources.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
