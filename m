From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 8250_early for big-endian
Date: Thu, 25 Oct 2012 12:18:15 +0100
Message-ID: <20121025121815.0689c196@pyramind.ukuu.org.uk>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
	<20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>
	<20121014133216.686277e1@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC300184F@ezexch.ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53454 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422669Ab2JYLNN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Oct 2012 07:13:13 -0400
In-Reply-To: <264C179F799EF24AB26D5319053335E80CC300184F@ezexch.ezchip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Noam Camus <noamc@ezchip.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Gilad Ben Yossef <giladb@ezchip.com>

On Thu, 25 Oct 2012 09:08:53 +0200
Noam Camus <noamc@ezchip.com> wrote:

> ________________________________________
> From: Alan Cox [alan@lxorguk.ukuu.org.uk]
> Sent: Sunday, October 14, 2012 2:32 PM
> 
> >For 8250_early it may well be the right thing is to support similar
> serial_in/serial_out methods.
> 
> Hello Alan,
> Below is my proposed patch could you apply it?
> 
> >From e819fbbf9690b72620c54a62fa34545c7b035f91 Mon Sep 17 00:00:00 2001
> From: Noam Camus <noamc@ezchip.com>
> Date: Wed, 3 Oct 2012 09:40:36 +0200
> Subject: [PATCH] tty/8250_early: Make serial_in/serial_out be over-ridden
> 
> Now one can replace default methods with similar fit to its needs.
> e.g. choose other regshift, register offset...
> 
> Signed-off-by: Noam Camus <noamc@ezchip.com>
> CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
>  drivers/tty/serial/8250/8250_early.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index eaafb98..ac31b0c 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -48,7 +48,7 @@ struct early_serial8250_device {
>  
>  static struct early_serial8250_device early_device;
>  
> -static unsigned int __init serial_in(struct uart_port *port, int offset)
> +unsigned int __weak __init serial_in(struct uart_port *port, int offset)

If you make the symbols global then they need a prefix to avoid clashes -
just rename them something like serial8250_early_in/serial8250_early_out

and of course they ought to be in the header files somewhere...

Alan
