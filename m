From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
Date: Fri, 2 Dec 2011 00:57:52 +0000
Message-ID: <20111202005752.10ce5eea@bob.linux.org.uk>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>
	<1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:56050 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755770Ab1LBAqD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Dec 2011 19:46:03 -0500
In-Reply-To: <1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: gregkh@suse.de, galak@kernel.crashing.org, scottwood@freescale.com, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org


> @@ -1553,7 +1554,15 @@ static void serial8250_handle_port(struct
> uart_8250_port *up) 
>  	spin_lock_irqsave(&up->port.lock, flags);
>  
> -	status = serial_inp(up, UART_LSR);
> +	/* Workaround for IRQ storm errata on break with Freescale
> 16550 */
> +	if (UART_BUG_FSLBK & up->port.bugs && up->lsr_last &
> UART_LSR_BI) {
> +		up->lsr_last &= ~UART_LSR_BI;
> +		serial_inp(up, UART_RX);
> +		spin_unlock_irqrestore(&up->port.lock, flags);
> +		return;
> +	}
> +
> +	status = up->lsr_last = serial_inp(up, UART_LSR);

We've now had a recent pile of IRQ function changes adding more quirk
bits and special casing. This doesn't scale. We either need to make
handle_port a method the specific drivers can override or you could
hide the mess in your serial_inp implementation and not touch any core
code.

I really don't mind which but I suspect dealing with it in your
serial_inp handler so that when you read UART_LSR you do the fixup
might be simplest providing you can just do that.

Sorting out a ->handle_port override is probably ultimately the right
thing to do and then we can push some of the other funnies out further.

At this point it's becoming increasingly clear that 8250 UART cloners
are both very bad at cloning the things accurately, and very busy adding
extra useful features so we need to start to treat 8250.c as a library
you can wrap.

Alan
