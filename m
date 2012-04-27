From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] serial/imx: add DMA support
Date: Fri, 27 Apr 2012 10:50:03 +0100
Message-ID: <20120427095003.GK24211@n2100.arm.linux.org.uk>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com> <1335436632-29499-2-git-send-email-b32955@freescale.com> <20120426111116.GF24211@n2100.arm.linux.org.uk> <4F9A4417.7080107@freescale.com> <20120427082245.GJ24211@n2100.arm.linux.org.uk> <4F9A6AEE.30005@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46974 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759924Ab2D0JuU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 27 Apr 2012 05:50:20 -0400
Content-Disposition: inline
In-Reply-To: <4F9A6AEE.30005@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Huang Shijie <b32955@freescale.com>
Cc: alan@linux.intel.com, B20596@freescale.com, B20223@freescale.com, gregkh@linuxfoundation.org, r58066@freescale.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Fri, Apr 27, 2012 at 05:46:22PM +0800, Huang Shijie wrote:
>>>> 1. How do you deal with transmitting the high-priority XON/XOFF
>>>>      characters (port->x_char) which occur with s/w flow control and
>>>>      the tty buffers fill up?
>>>> 2. How do you deal with flow control in general?  IOW, what happens
>>>>      when the remote end deasserts your CTS with h/w flow control enabled.
> If the remote end deasserts my CTS, it means the remote will not send  
> any data.
>
> My DMA for RX will expire in the following steps:
> [1] the UART only waits for 32 bytes time long
> [2] the UART triggers an IDLE Condition Detect DMA.
> [3] the dma_rx_callback() will release the DMA for Rx.

Err, hang on.  I think you're totally confused about hardware flow
control.  Certainly you're not using the correct terms for what you're
describing.

The CTS input normally controls the transmitter.  In many hardware
assisted hardware flow control setups, the deassertion of CTS merely
prevents the transmitter starting a new character.

This shouldn't have any effect on the receiver of the same UART at all.

>>>>      How does your end deal with sending RTS according to flow control
>>>>      conditions?
>>>>
> If a CTS is received after we sent out a RTS, it will follow the steps:
>  imx_int() --> imx_rtsint() --> uart_handle_cts_change() -->start_tx()
>
> The start_tx() will create an TX DMA operation, and send out the data.

The generation of RTS (connected to the remote ends CTS signal) is
supposed to control whether the remote end sends you characters.  RTS
gets deasserted either by software control when you're running out of
space to store the received characters, or (in the case of hardware
assisted hardware flow control) your receivers FIFO fills above a
certain watermark.

>> It should not.  prep_slave_sg() must be callable from atomic contexts.
>>
> the Documentation/dmaengine.txt does not explicitly force all the  dma  
> engine driver
> to do so.
>
> Add more comments for it in Documentation/dmaengine.txt?

Nevertheless, it is common practice for drivers to call prep_slave_sg()
from atomic contexts.  It sounds like your DMA driver is being fixed
anyway, so these tasklets can be killed.
