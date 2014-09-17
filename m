From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/1] Xilinx uartlite serial driver: Add lock in isr to
 avoid SMP race condition
Date: Wed, 17 Sep 2014 07:29:17 -0400
Message-ID: <5419708D.9030403@hurleysoftware.com>
References: <BLU437-SMTP67D906D4C290ABD3B6CC31D2B60@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:34647 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753107AbaIQL32 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Sep 2014 07:29:28 -0400
In-Reply-To: <BLU437-SMTP67D906D4C290ABD3B6CC31D2B60@phx.gbl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kris Modrak <krismodrak@hotmail.com>, Peter Korsgaard <jacmet@sunsite.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org

Hi Kris,

On 09/16/2014 08:18 PM, Kris Modrak wrote:
> Trasmitted characters could be lost or written twice due to a missing lock
> in the critical section of the isr. The missing lock causes a race condition
> on SMP systems between ulite_transmit when called from the isr and
> ulite_start_tx as they can execute simultaneously on separate cores. The call
> from ulite_start_tx is made from serial_core.c with the lock taken.
> 
> Signed-off-by: Kris Modrak <krismodrak@hotmail.com>
> ---
>  drivers/tty/serial/uartlite.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index 9fc22f4..ee151a2 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -196,9 +196,13 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
>  	int busy, n = 0;
>  
>  	do {
> -		int stat = uart_in32(ULITE_STATUS, port);
> +		int stat;
> +
> +		spin_lock(&port->lock);
> +		stat = uart_in32(ULITE_STATUS, port);
>  		busy  = ulite_receive(port, stat);
>  		busy |= ulite_transmit(port, stat);
> +		spin_unlock(&port->lock);
>  		n++;
>  	} while (busy);

Might as well take the spinlock for the entire loop.
A nice upgrade here would be to limit the loop to a fixed number of
iterations as well (in a separate patch).

Regards,
Peter Hurley

PS - That ISR has some odd logic; if data was only transmitted but not
     received, it still submits input work even though there is no work
     to perform (ie., tty_flip_buffer_push() should only be called if
     ulite_receive() returned non-zero).

