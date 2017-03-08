From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250: 8250_core: Use dev_name() during
 request_irq()
Date: Wed, 8 Mar 2017 13:34:17 +0100
Message-ID: <20170308123417.GA3981@kroah.com>
References: <20170308121943.29340-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170308121943.29340-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 08, 2017 at 05:49:43PM +0530, Vignesh R wrote:
> Passing "serial" as name during request_irq() results in all serial port
> irqs have same name. This does not help much to easily identify which
> irq belongs to which serial port instance. Therefore pass dev_name()
> during request_irq() so that better identifiable name is listed for
> serial ports in cat /proc/interrupts output.
> 
> Output of cat /proc/interrupts
> Before this patch:
>  26:        689          0     GICv2 309 Edge      serial
> After this patch:
>  26:        696          0     GICv2 309 Edge      2530c00.serial
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

I need a "full" name here, unless you really do sign legal documents
with just one letter as a last/sur-name?

thanks,

greg k-h
