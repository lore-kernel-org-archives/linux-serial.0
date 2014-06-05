From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] serial: samsung: fix typo in debug code
Date: Wed, 04 Jun 2014 18:20:41 -0700
Message-ID: <1401931241.26329.16.camel@joe-AO725>
References: <10455941.RzodM59Z3O@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:36747 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753334AbaFEBUp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Jun 2014 21:20:45 -0400
In-Reply-To: <10455941.RzodM59Z3O@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Kukjin Kim <kgene.kim@samsung.com>

On Tue, 2014-06-03 at 11:53 +0200, Arnd Bergmann wrote:
> commit e4ac92df2791 ("serial: samsung: Neaten dbg uses") introduced
> a regression in the conversion from vsprintf to vsnprintf.
> 
> This fixes the build error by passing the correct variable name.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Joe Perches <joe@perches.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 3293377..c1d3ebd 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -66,7 +66,7 @@ static void dbg(const char *fmt, ...)
>  	char buff[256];
>  
>  	va_start(va, fmt);
> -	vscnprintf(buff, sizeof(buf), fmt, va);
> +	vscnprintf(buff, sizeof(buff), fmt, va);
>  	va_end(va);
>  
>  	printascii(buff);

Greg?

The original has ended up in Linus' -next branch.

Can you please apply this sooner rather than later?

Sorry for the bother.  Dunno how it happened.

I thought I compiled it with the appropriate CONFIG
settings.


