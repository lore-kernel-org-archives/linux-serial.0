From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: ce4100 does no longer boots with CONFIG_EARLY_PRINTK enabled
Date: Fri, 17 Jun 2011 09:46:39 +0200
Message-ID: <4DFB065F.3020208@linutronix.de>
References: <20110616191128.GA32006@linutronix.de> <74CDBE0F657A3D45AFBB94109FB122FF04992C07EB@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47751 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab1FQHqp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Jun 2011 03:46:45 -0400
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04992C07EB@HQMAIL01.nvidia.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Alan Cox <alan@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Dirk Brandewie <dirk.brandewie@gmail.com>, "x86@kernel.org" <x86@kernel.org>

Stephen Warren wrote:

  > Just guessing here, but is the solution to add this patch to ToT?:
> 
> diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
> index b40f7b9..bca2232 100644
> --- a/drivers/tty/serial/8250.c
> +++ b/drivers/tty/serial/8250.c
> @@ -1107,7 +1107,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
>                          */
>                         DEBUG_AUTOCONF("Xscale ");
>                         up->port.type = PORT_XSCALE;
> -                       up->capabilities |= UART_CAP_UUE;
> +                       up->capabilities |= UART_CAP_UUE | UART_CAP_RTOIE;
>                         return;
>                 }
>         } else {

With that patch I have a working serial again.

> I added a new flag used for both XSCALE and TEGRA port types, and
> modified the XSCALE port type to define the new flag, thinking that all
> code would take the capabilities from that port type table entry, but
> perhaps the auto-detection logic needs an equivalent change for XSCALE.
> 
>> I'm little worried that it seems somehow that I have two uarts at
>> 0xdffe0200 and IRQ4 which is evil.
> 
> That does sound odd. It's very unclear to me how my change would cause
> that...

Seems unrelated to your change.

Sebastian
