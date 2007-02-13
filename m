From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Date: Mon, 12 Feb 2007 23:36:56 -0800
Message-ID: <20070212233656.3b4550dd.akpm@linux-foundation.org>
References: <200702121804.l1CI488t024555@pasqua.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:57751 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751163AbXBMHhC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 13 Feb 2007 02:37:02 -0500
In-Reply-To: <200702121804.l1CI488t024555@pasqua.pmc-sierra.bc.ca>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Marc St-Jean <stjeanma@pmc-sierra.com>
Cc: linux-serial@vger.kernel.org

On Mon, 12 Feb 2007 12:04:08 -0600 Marc St-Jean <stjeanma@pmc-sierra.com> wrote:

> Sixth attempt at the serial driver patch for the PMC-Sierra MSP71xx device.
> Identical to last patch but respun for 8 character tabs.
> 
> There are three different fixes:
> 1. Fix for DesignWare THRE errata
> - Dropped our fix since the "8250-uart-backup-timer.patch" in the "mm"
> tree also fixes it. This patch needs to be applied on top of "mm" patch.
> 
> 2. Fix for Busy Detect on LCR write
> - No changes since last patch.
> 
> 3. Workaround for interrupt/data concurrency issue
> - No changes since last patch.

A couple of things.

- When preparing a changelog, please just tell us what the patch does. 
  The information about how this patch differes from a previous version of
  the patch is irrelevant when the patch hits the mainline repository hence
  I must edit it all.

  It's OK to add the what-i-changed-since-last-time details, but please make
  that separate and remember that it will be removed for when the patch goes
  upstream.

- When fixing a bug, please tell us in detail what that bug *is*.  None
  of the above three items tell us any of this, which is essential
  information for those who are to review the change.

>  
> +	case UPIO_DWAPB:
> +		/* Save the LCR value so it can be re-written when a
> +		 * Busy Detect interrupt occurs. */
> +		if (save_offset == UART_LCR)
> +			up->lcr = value;
> +		writeb(value, up->port.membase + offset);
> +		/* Read the IER to ensure any interrupt is cleared before
> +		 * returning from ISR. */
> +		if ((save_offset == UART_TX || save_offset == UART_IER) && in_irq())

The in_irq() is a worry.  If the serial driver is used as the system
console, then it can be called from _any_ interrupt handler.  eg a printk()
in the sata code.

What happens then?

> @@ -1383,6 +1399,19 @@ static irqreturn_t serial8250_interrupt(
>  			handled = 1;
>  
>  			end = NULL;
> +		} else if (up->port.iotype == UPIO_DWAPB &&
> +			  (iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
> +			/* The DesignWare APB UART has an Busy Detect (0x07)
> +			 * interrupt meaning an LCR write attempt occured while the
> +			 * UART was busy. The interrupt must be cleared by reading
> +			 * the UART status register (USR) and the LCR re-written. */
> +			unsigned int status;
> +			status = *(volatile u32 *)up->port.private_data;

Are you sure this is right?  The use of volatile is generally discouraged
and is a sign that something is wrong.  What is the driver attempting to
read here?  Should it be using readl()?

Also, the newly-added private_data field is not being initialised to
anything anywhere in this patch.

