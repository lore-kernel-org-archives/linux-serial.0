Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6D3D9DAA;
	Thu,  6 Aug 2026 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997108; cv=none; b=MDbsRONeSK/AVYoYsxlL4KEMscpz2NIJ3a9UKTelCE+uKh6SqamEYrh3UoYUwvYCv5GsaJRhXFXhGXQJCJLUqE6XQyL5nrer/TYsiKKiqcngzPnKv+HvY2RlcWWMXSGKP4mNF/SFweUkroD7i2NYYTOCuG02WXQTv96wY13xa9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997108; c=relaxed/simple;
	bh=4/mIMdNYBp0C6O5JC88RWrpnZS+0s7vKreLUGNOyfZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRN7yiovaOp+CrvAWUQYyViVQRKhKgbrSG1uKWjHdTXerdTZW10XPn2GsuCFOnfnZdnMaV57fl2rnS11ivvUpVRSbCpUJuU/ldvaonTLFPLYgk1N9JKX/w+VEAXyYsFDTKp41LizxZII6/YZTJbrMD6ab3IqTA5uSg2FlK2ruGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=InK+bEFY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="InK+bEFY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC8C1F000E9;
	Thu,  6 Aug 2026 06:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785997104;
	bh=58qRJApXG31vkDUz7i1n1FkqR8EV+rCCfycq8BhjbwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=InK+bEFYd2ra0zrTk15GGGiUfaQ1rxOSZ5em27hC53kRM5h2YoMy8tz9VEC2MUac+
	 c/mXSRvzZvhcI9ba6BjSF/c3eBg9izOscHO/GyQ2kXqOwCRSVr7DjnTNmAG+xnNdtX
	 1IXjppOlXWRuTCtkli63Z3pCQsUeNlkFNiN1td/s=
Date: Thu, 6 Aug 2026 08:16:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiaochun Li <lixiaochun@open-hieco.net>
Cc: jirislaby@kernel.org, john.ogness@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: core: Fix a NULL pointer dereference in
 uart_parse_earlycon()
Message-ID: <2026080638-waged-tactical-005d@gregkh>
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

How was this tested?
