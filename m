From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/19] sh-sci: Platform data simplification
Date: Wed, 11 Jan 2017 09:04:37 +0100
Message-ID: <20170111080437.GA24055@kroah.com>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 04, 2017 at 01:06:20AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> Most of the patches in this series have been sitting in my development tree
> for three years now. While rebasing all my development branches I decided it
> was time to send them out in case they're considered useful. I've then thrown
> a few additional patches in to move the driver further in the right direction
> (or at least the direction I consider right).
> 
> The idea behind this series is to move towards removal of the sh-sci platform
> data. This won't be possible until SH platforms move to DT (and I won't hold
> my breath), but we can get rid of most of the platform data fields already and
> cleanup the sh-sci driver at the same time.
> 
> The series already removes the capabilities, port_reg, regshift, dma_slave_tx
> and dma_slave_rx fields. We should be able to go further:
> 
> - The flags field is only used by sh5 to set UPF_IOREMAP. It should be
>   possible to find another way to determine in the driver whether to ioremap
>   the registers.
> 
> - The sampling_rate field is only used by sh7723 and sh7724 to override the
>   value hardcoded in the driver, even though the datasheets of those SoCs
>   don't mention any restriction. This might not be needed and should be
>   investigated.
> 
> - The scscr REIE bit should be possible to compute in the driver, as it's set
>   for all SCIF ports except SCIx_SH3_SCIF_REGTYPE, SCIx_SH7705_SCIF_REGTYPE,
>   and the sh7343 SCIx_SH4_SCIF_REGTYPE. The latter will be trickier to handle.
> 
> - Now that we have support for baud rate generators and externel clocks, the
>   scscr CKE1 bit should be computed in the driver in all cases.
> 
> - The scscr TOIE bit doesn't seem to follow a clear rule, but given that it's
>   the last scscr bit to handle I'm sure we'll find something :-)
> 
> - It might make sense to merge the type and regtype fields in a single type.
> 
> Finally, it might be time to drop support for the SH platforms that would get
> in the way of sh-sci cleanup.

I've merged patches 1, 2, 12, 13, 14, 15, 16, 17, and 18 in my tty tree.

If I should take any others there as well, please let me know.

thanks,

greg k-h
