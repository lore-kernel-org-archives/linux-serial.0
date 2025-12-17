Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B3337118;
	Wed, 17 Dec 2025 13:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979786; cv=none; b=G2scG1NJa0JstSnFHxyaTSuA+nP9GSIxQyixwDaZVfZboL5bNl0GOUKat8/zQZkt3eprskZXMm+z2cC3F+Wecjzc1+6QvrwFAla0dLzCPB5YKmwH4xuLptYLwU2hPFBb3p7Gky2siK3swZOgcfq4BKtYpC075WRfGTsHdDIa/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979786; c=relaxed/simple;
	bh=cZqykFQOznjwTz/OusoHy8zpyp9EHoXH1lzz/xgvQxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3GBuE5up6p7395dnbCDJJUYSIbmCWzK51kuTh0ZqW1TDEizQlMv4a5ekM57YR048bs3JxdZ6xliOVGy79vn57nmNdKLQv+3RtUFy0SqemhC9783Uqkx4J5M4jhdKi+PnTSGjVgA2GOwv5m4dy1bzp9Bw8L2jgApLdVjCqhu8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rYgB+6Z3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rYgB+6Z3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03A5C4CEF5;
	Wed, 17 Dec 2025 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765979785;
	bh=cZqykFQOznjwTz/OusoHy8zpyp9EHoXH1lzz/xgvQxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYgB+6Z31L7iamda9DEUpKZL3bQzh5PCOy99z79CkrwVw8oR0RCVu1cDnHOj6E0Xu
	 1Ha8mtsEwaYuVQywQVrsyb+3wFZdIg54Vhnz1r4XhJmaqQhILqL2lVv2C3N4ljoqHY
	 Hr7U9JujstJ7qksZvL/Nl66JdOMgaNrNIjphJOCI=
Date: Wed, 17 Dec 2025 14:56:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harikrishna Srinivasan <harikrs0905@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: pxa: Fix comment typo
Message-ID: <2025121710-engulf-feminism-f536@gregkh>
References: <20251215072846.11603-1-harikrs0905@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215072846.11603-1-harikrs0905@gmail.com>

On Mon, Dec 15, 2025 at 12:28:46AM -0700, Harikrishna Srinivasan wrote:
> Fix a spelling mistake in a driver comment.
> 
> Signed-off-by: Harikrishna Srinivasan <harikrs0905@gmail.com>
> ---
>  drivers/tty/serial/pxa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> index e395ff29c1a2..19d85398e394 100644
> --- a/drivers/tty/serial/pxa.c
> +++ b/drivers/tty/serial/pxa.c
> @@ -99,7 +99,7 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
>  		 * Specification Update (May 2005)
>  		 *
>  		 * Step 2
> -		 * Disable the Reciever Time Out Interrupt via IER[RTOEI]
> +		 * Disable the receiver timeout interrupt via IER[RTOEI]
>  		 */
>  		up->ier &= ~UART_IER_RTOIE;
>  		serial_out(up, UART_IER, up->ier);
> -- 
> 2.43.0
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
