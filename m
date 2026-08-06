Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9241129AB05;
	Thu,  6 Aug 2026 06:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997130; cv=none; b=J2qQv/7Pbl2+nrDdYefh57/Jh1cV8WXkfSHkromdD8RLgJvVKvUt+2JFXDB3XGqw3jy/97S21D3G1YUYkn/aHey+qJSwEcCFIQ65bEqFHVE9SXOkcRpYYj713f4uWYtOwKAq6VIuDpEF4RYNoSBKNhzpUuPJoirjujOz2mLfMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997130; c=relaxed/simple;
	bh=4sxfQyzX9vG6o1/mwv+zDuiykdAZQxNmf1SuEqD5Qpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBIfwABJBBUDekU4oDDuDl2buS2zNM/rNtBjuFIXSOHUhabkgTa4eFQVdvjFO4ohYB841evfGRoaRJWgqyo45HvvpyXmeK4GgpI0j2/jH9nZXbP36TCXmrOewujFBHToEnKV5aqtguPJUsPAYWoor2oAJ4NaescFhg9uddAbJ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i98De6xy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i98De6xy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A74A1F000E9;
	Thu,  6 Aug 2026 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785997123;
	bh=bo+QPG8t0xtis9vcTqGxs5GykQltdRoRyRHyM1YK+O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i98De6xyAkmBVHozb2vXDVRqnYOIdCq1h1etWr9xI6iRr8k749Sk5JDujYf5SfTBD
	 CIM1J2Du8H452STEFaLvGww/kow54i/cvES7h0+YTVQWZLrW6zOPiTc69OVdCRkRMf
	 +VK1E6DmCGTB8R22vg9FQpDHoK5hBi9aBpuRq3xI=
Date: Thu, 6 Aug 2026 08:17:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiaochun Li <lixiaochun@open-hieco.net>
Cc: jirislaby@kernel.org, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix a NULL pointer dereference in
 uart_parse_earlycon()
Message-ID: <2026080605-ambulance-cathedral-b39f@gregkh>
References: <20260806061011.9007-1-lixiaochun@open-hieco.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806061011.9007-1-lixiaochun@open-hieco.net>

On Thu, Aug 06, 2026 at 02:10:11PM +0800, Xiaochun Li wrote:
> console=uart and console=pl011 can reach the preferred console matching
> path without an options field when a comma is absent from the command
> line. In that case uart_parse_earlycon() receives a NULL pointer and
> immediately passes it to strncmp(), which triggers a NULL pointer
> dereference during console matching.
> 
> Address this by returning -EINVAL when the options pointer is missing,
> ensuring incomplete console arguments are cleanly rejected while
> preserving the behavior of all valid earlycon-style command lines.
> 
> Fixes: 73abaf87f01b ("serial: earlycon: Refactor parse_options into serial core")
> Signed-off-by: Xiaochun Li <lixiaochun@open-hieco.net>
> ---
>  drivers/tty/serial/serial_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index a530ad372b43..02e770bf8bf6 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2084,7 +2084,8 @@ EXPORT_SYMBOL_GPL(uart_console_write);
>  
>  /**
>   * uart_parse_earlycon - Parse earlycon options
> - * @p:	     ptr to 2nd field (ie., just beyond '<name>,')
> + * @p:	     ptr to 2nd field (ie., just beyond '<name>,'); %NULL if
> + *	     no console options were supplied
>   * @iotype:  ptr for decoded iotype (out)
>   * @addr:    ptr for decoded mapbase/iobase (out)
>   * @options: ptr for <options> field; %NULL if not present (out)
> @@ -2104,6 +2105,9 @@ EXPORT_SYMBOL_GPL(uart_console_write);
>  int uart_parse_earlycon(char *p, enum uart_iotype *iotype,
>  			resource_size_t *addr, char **options)
>  {
> +	if (!p)
> +		return -EINVAL;
> +
>  	if (strncmp(p, "mmio,", 5) == 0) {
>  		*iotype = UPIO_MEM;
>  		p += 5;
> -- 
> 2.52.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
