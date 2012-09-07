From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] 8250: blacklist IR ports
Date: Fri, 7 Sep 2012 01:01:35 +0100
Message-ID: <20120907010135.6a4d0a20@pyramind.ukuu.org.uk>
References: <cover.1346969721.git.sean@mess.org>
	<a9565dd624c186917c71a4e431e6bcab712dbf08.1346969721.git.sean@mess.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:47465 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2IFX5D (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 19:57:03 -0400
In-Reply-To: <a9565dd624c186917c71a4e431e6bcab712dbf08.1346969721.git.sean@mess.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, David =?UTF-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>

On Thu,  6 Sep 2012 23:20:32 +0100
Sean Young <sean@mess.org> wrote:

> These ports should not be probed, but we need to keep track of them so we
> can prevent the legacy (non-PNP) probe of serial ports from touching them
> too.

I want to have a think about getting the ordering right so we don't
shuffle the ports on existing boxes for the first half. For the second
part

> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/tty/serial/8250/8250.c     | 16 ++++++++++++++--
>  drivers/tty/serial/8250/8250_pnp.c | 23 ++++++++++++++++++-----
>  include/linux/serial_core.h        |  3 ++-
>  3 files changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
> index bc25874..ea9166b 100644
> --- a/drivers/tty/serial/8250/8250.c
> +++ b/drivers/tty/serial/8250/8250.c
> @@ -290,6 +290,9 @@ static const struct serial8250_config uart_config[] = {
>  				  UART_FCR_R_TRIG_00 | UART_FCR_T_TRIG_00,
>  		.flags		= UART_CAP_FIFO,
>  	},
> +	[PORT_IR] = {
> +		.name		= "IR port"

Please use "CIR port". We have SIR and FIR serial ports (IrDA) too that we
do drive via tty. PORT_8250_CIR for the type might be best too - it means
the tools know what they are looking at and can report it sensibly.

Alan
