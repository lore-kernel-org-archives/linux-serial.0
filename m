From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: 8250_hp300: trivial: fix symbol name in #warning
 message
Date: Fri, 8 Aug 2014 08:29:38 -0700
Message-ID: <20140808152938.GA16594@kroah.com>
References: <1407510872-18057-1-git-send-email-dforsi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:54696 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbaHHP3j (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Aug 2014 11:29:39 -0400
Content-Disposition: inline
In-Reply-To: <1407510872-18057-1-git-send-email-dforsi@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Daniele Forsi <dforsi@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Jiri Kosina <trivial@kernel.org>, linux-serial@vger.kernel.org

On Fri, Aug 08, 2014 at 05:14:32PM +0200, Daniele Forsi wrote:
> The symbol is defined in drivers/tty/serial/8250/Kconfig as
> "SERIAL_8250", not just "8250".
> 
> Signed-off-by: Daniele Forsi <dforsi@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_hp300.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_hp300.c b/drivers/tty/serial/8250/8250_hp300.c
> index 5bdaf27..f155328 100644
> --- a/drivers/tty/serial/8250/8250_hp300.c
> +++ b/drivers/tty/serial/8250/8250_hp300.c
> @@ -24,6 +24,10 @@
>  #warning CONFIG_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
>  #endif
>  
> +#if !defined(CONFIG_HPDCA) && !defined(CONFIG_HPAPCI)
> +#warning CONFIG_SERIAL_8250 defined but neither CONFIG_HPDCA nor CONFIG_HPAPCI defined, are you sure?
> +#endif

Shouldn't you just change the line before this one with the proper
config option?

thanks,

greg k-h
