From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] serial: sccnxp: Improve verify_port
Date: Tue, 14 May 2013 12:09:31 -0400
Message-ID: <20130514160931.GA2695@kroah.com>
References: <1368547151-7384-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:38036 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab3ENQJT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 May 2013 12:09:19 -0400
Received: by mail-ve0-f174.google.com with SMTP id db10so826390veb.19
        for <linux-serial@vger.kernel.org>; Tue, 14 May 2013 09:09:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368547151-7384-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

On Tue, May 14, 2013 at 07:59:11PM +0400, Alexander Shiyan wrote:
> The patch improves verify_port procedure by comparing the type of
> port and IRQ numbers simultaneously. This can be important in the
> case of multiple drivers SCCNXP in the system that are different IRQs.

So this fixes a bug?  Really?

> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/tty/serial/sccnxp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
> index c773041..92e6195 100644
> --- a/drivers/tty/serial/sccnxp.c
> +++ b/drivers/tty/serial/sccnxp.c
> @@ -713,8 +713,8 @@ static void sccnxp_config_port(struct uart_port *port, int flags)
>  
>  static int sccnxp_verify_port(struct uart_port *port, struct serial_struct *s)
>  {
> -	if ((s->type == PORT_UNKNOWN) || (s->type == PORT_SC26XX))
> -		return 0;
> +	if ((s->type != PORT_UNKNOWN) && (s->type != PORT_SC26XX))
> +		return -EINVAL;

Why are you now returning a different value?

thanks,

greg k-h
