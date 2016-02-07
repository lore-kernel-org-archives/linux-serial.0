From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] sc16is7xx: don't need "uart_handle_cts_change"
Date: Sat, 6 Feb 2016 22:46:08 -0800
Message-ID: <20160207064608.GB24131@kroah.com>
References: <BLU436-SMTP55A9A43327DDAAAAA42012FFE50@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP55A9A43327DDAAAAA42012FFE50@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
To: Wills Wang <wills.wang@live.com>
Cc: jringle@gridpoint.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Dec 22, 2015 at 05:19:56PM +0800, Wills Wang wrote:
> SC16is7xx has feature for auto hardware flow control using RTS/CTS,
> so we don't need "uart_handle_cts_change" to invoke "start_tx/stop_tx"
> for flow control.
> 
> In addition, for software CTS, interrupt "SC16IS7XX_IIR_CTSRTS_SRC"
> just report the nCTS change of state from active(low) to inactive(high),
> driver don't know when the state of nCTS change from incactive to active,
> so can't resume the transmission when a peer device is again ready and
> re-assert nRTS signal.
> ---
>  drivers/tty/serial/sc16is7xx.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
