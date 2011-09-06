From: Ning Jiang <njiang1@marvell.com>
Subject: RE: [PATCH] serial-core: power up uart port early before we do
 set_termios when resuming
Date: Mon, 5 Sep 2011 19:23:22 -0700
Message-ID: <F766E4F80769BD478052FB6533FA745D1A113CA816@SC-VEXCH4.marvell.com>
References: <1315211298-17318-1-git-send-email-ning.jiang@marvell.com>
 <4E6493A5.50807@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:45225 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751380Ab1IFCXU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Sep 2011 22:23:20 -0400
In-Reply-To: <4E6493A5.50807@codeaurora.org>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mayank Rana <mrana@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Yin Kangkai <kangkai.yin@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

-----Original Message-----
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 5c04cb9..4f75918 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1981,6 +1981,8 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
>   		if (port->tty&&  port->tty->termios&&  termios.c_cflag == 0)
>   			termios = *(port->tty->termios);
>
> +		if (console_suspend_enabled)
> +			uart_change_pm(state, 0);
>   		uport->ops->set_termios(uport,&termios, NULL);
>   		if (console_suspend_enabled)
>   			console_start(uport->cons);
I just found the same issue. Looks good to me.

Feel free to add,
Tested-by: Mayank Rana <mrana@codeaurora.org>

-----

Thanks, Mayank. I've only tested it on pxa platform. More testing on other platforms is welcome.

Sincerely Yours,
Ning Jiang


