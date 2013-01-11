From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: PL011: Add support for Rx DMA buffer polling
Date: Fri, 11 Jan 2013 16:18:28 +0000
Message-ID: <20130111161828.GD23505@n2100.arm.linux.org.uk>
References: <006c01cdefc2$c7e1cb90$57a562b0$@min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44869 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754921Ab3AKQTC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jan 2013 11:19:02 -0500
Content-Disposition: inline
In-Reply-To: <006c01cdefc2$c7e1cb90$57a562b0$@min@lge.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chanho Min <chanho.min@lge.com>
Cc: 'Alan Cox' <alan@linux.intel.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 'Linus Walleij' <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Jan 11, 2013 at 03:13:31PM +0900, Chanho Min wrote:
> In DMA support, Received data is not triggered until the DMA buffer is filled.
> In order to actually use Rx DMA, We would like to suggest the use of the timer
> for polling DMA buffer. It makes possible character-level trigger.
> In our test, no data loss occurred at high-baudrate as compared with interrupt
> driven (We tested with 3Mbps). We know it will be because of the increased Rx
> buffer rather than DMA effect. but,It is very useful for high speed uart device.
> We changes:
> 
> - CONFIG_SERIAL_AMBA_PL011_DMAPOLL is added to select this feature.
> 
> - add timer and last_residue for polling. Every polling, timer handler checks
>   the residue in the dma buffer and transfer data to the tty. Also, last_residue
>   is updated for the next polling.
> 
> - We use consistent DMA mappings instead of streaming DMA mappings to avoid from
>   the frequent cache operation.
> 
> - pl011_dma_rx_chars is modified. the pending size is recalculated because data
>   can be taken by polling.
> 
> - add module parameter for adjusting polling interval.

Here's the question: what is the effect of having to poll every tick on
the overall system?

What I'm getting at is: what is the cost of that polling with DMA enabled
over not having DMA on the receive side at all?  What is the trade-off
vs baud rate?  Should we scale the polling interval according to baud
rate?
