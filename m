From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: bfin-sport-uart: Add tty ASYNC_CTS_FLOW flag to
 do CTS flow control.
Date: Tue, 6 Dec 2011 11:37:41 +0000
Message-ID: <20111206113741.6f375673@lxorguk.ukuu.org.uk>
References: <1323159754-15687-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49557 "EHLO
	earthlight.etchedpixels.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933207Ab1LFLgw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 6 Dec 2011 06:36:52 -0500
In-Reply-To: <1323159754-15687-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Tue, 6 Dec 2011 16:22:34 +0800
Sonic Zhang <sonic.adi@gmail.com> wrote:

> From: Sonic Zhang <sonic.zhang@analog.com>
> 
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
>  drivers/tty/serial/bfin_sport_uart.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
> index f650526..7fbc3a0 100644
> --- a/drivers/tty/serial/bfin_sport_uart.c
> +++ b/drivers/tty/serial/bfin_sport_uart.c
> @@ -810,8 +810,10 @@ static int __devinit sport_uart_probe(struct platform_device *pdev)
>  		res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>  		if (res == NULL)
>  			sport->cts_pin = -1;
> -		else
> +		else {
>  			sport->cts_pin = res->start;
> +			sport->port.flags |= ASYNC_CTS_FLOW;
> +		}
>  
>  		res = platform_get_resource(pdev, IORESOURCE_IO, 1);
>  		if (res == NULLA

Acked-by: Alan Cox <alan@linux.intel.com>
