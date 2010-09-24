From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH RESEND 1/2] 8250: pm callback for platform uarts
Date: Fri, 24 Sep 2010 18:22:58 +0100
Message-ID: <20100924182258.34a76623@lxorguk.ukuu.org.uk>
References: <1285344809-16839-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53175 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757125Ab0IXRAU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Sep 2010 13:00:20 -0400
In-Reply-To: <1285344809-16839-1-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-serial@vger.kernel.org, Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>

> This patch adds a new pm field to the plat_8250_port and uart_port
> structures and modifies the 8250 pm callback to call the platform
> method before powering up and after powering down (if the platform
> is capable of cutting power/clks to the block).

This doesn't entirely make sense. Any hook in uart_port would be one to
apply outside of 8250.c

You also don't want platform specific stuff in the core 8250 code or to
go removing stuff without being very careful about who or what uses it.


> +	if ((p->port.pm) && (state != 0))	/* power down */

Excess brackets

> +		p->port.pm(port, state, oldstate);
>  }
>  

> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index 7638dea..ce3af06 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -35,6 +35,8 @@ struct plat_serial8250_port {
>  	void		(*set_termios)(struct uart_port *,
>  			               struct ktermios *new,
>  			               struct ktermios *old);
> +	void		(*pm)(struct uart_port *, unsigned int state,
> +			      unsigned old);
>  };

This bit makes sense - but why can't you simply propogate it to the
existing uart_8250_port callback when registering ?
