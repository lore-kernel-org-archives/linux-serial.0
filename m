From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 4/5] serial: pch_uart: remove reference to .set_wake()
Date: Tue, 15 Oct 2013 08:31:47 -0700
Message-ID: <1381851107.23041.35.camel@dvhart-mobl4.amr.corp.intel.com>
References: <1381821643-19528-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8573 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932822Ab3JOPcf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Oct 2013 11:32:35 -0400
In-Reply-To: <1381821643-19528-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Johan Hovold <jhovold@gmail.com>

On Tue, 2013-10-15 at 09:20 +0200, Linus Walleij wrote:
> This callback is gone and not coming back, so will not be
> supported later.
> 
> Cc: Johan Hovold <jhovold@gmail.com>
> Cc: Darren Hart <dvhart@linux.intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Linus,

No objection here, however...


> ---
>  drivers/tty/serial/pch_uart.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 44077c0..10472b7 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -1614,7 +1614,6 @@ static struct uart_ops pch_uart_ops = {
>  	.shutdown = pch_uart_shutdown,
>  	.set_termios = pch_uart_set_termios,
>  /*	.pm		= pch_uart_pm,		Not supported yet */
> -/*	.set_wake	= pch_uart_set_wake,	Not supported yet */

>From what I can tell with "git log -S", this callback never existed for
this driver. I am curious what prompted the removal of this comment
(since the set_wake field still exists in the structure) and .pm was
left alone, which seems to have the same history within this driver
as .set_wake.

>  	.type = pch_uart_type,
>  	.release_port = pch_uart_release_port,
>  	.request_port = pch_uart_request_port,

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel


