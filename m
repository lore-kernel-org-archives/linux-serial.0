From: John Linn <John.Linn@xilinx.com>
Subject: RE: [PATCH] [V2] uartlite: move from byte accesses to word accesses
Date: Wed, 17 Mar 2010 08:47:08 -0600
Message-ID: <bfd3a43f-66f6-457b-8753-af7067f571ce@VA3EHSMHS031.ehs.local>
References: <70e0020c-98ac-48d0-bfa6-1f2230ad2d0b@VA3EHSMHS026.ehs.local> <87tyuflv98.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:5731 "EHLO
	VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754432Ab0CQOrU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Mar 2010 10:47:20 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <87tyuflv98.fsf@macbook.be.48ers.dk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-serial@vger.kernel.org, grant.likely@secretlab.ca, michal.simek@petalogix.com, john.williams@petalogix.com

> -----Original Message-----
> From: Peter Korsgaard [mailto:jacmet@gmail.com] On Behalf Of Peter
Korsgaard
> Sent: Thursday, January 21, 2010 1:26 AM
> To: John Linn
> Cc: linux-serial@vger.kernel.org; grant.likely@secretlab.ca;
michal.simek@petalogix.com;
> john.williams@petalogix.com
> Subject: Re: [PATCH] [V2] uartlite: move from byte accesses to word
accesses
> 
> >>>>> "John" == John Linn <john.linn@xilinx.com> writes:
> 
>  John> Byte accesses for I/O devices in Xilinx IP are going to be less
>  John> desired in the future such that the driver is being changed to
>  John> use 32 bit accesses.
> 
>  John> This change facilitates using the uartlite IP over a PCIe bus
>  John> which only allows 32 bit accesses.
> 
>  John> Signed-off-by: John Linn <john.linn@xilinx.com>
>  John> ---
>  John>  drivers/serial/uartlite.c |   36
++++++++++++++++++------------------
>  John>  1 files changed, 18 insertions(+), 18 deletions(-)
> 
>  John> diff --git a/drivers/serial/uartlite.c
b/drivers/serial/uartlite.c
>  John> index 377f271..9f83949 100644
>  John> --- a/drivers/serial/uartlite.c
>  John> +++ b/drivers/serial/uartlite.c
>  John> @@ -86,7 +86,7 @@ static int ulite_receive(struct uart_port
*port, int stat)
>  John>  	/* stats */
>  John>  	if (stat & ULITE_STATUS_RXVALID) {
>  port-> icount.rx++;
>  John> -		ch = readb(port->membase + ULITE_RX);
>  John> +		ch = (u8)in_be32(port->membase + ULITE_RX);
> 
> 
> I don't believe all those (u8) casts are needed (and they could
> potentially mask away other problems in the future).
> 

I'll send out a V3 for the patch.  Sorry I dropped the ball and didn't
get this taken care of.

Thanks,
John

> Other than that,
> 
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> --
> Bye, Peter Korsgaard


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.


