Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C092EDD7E;
	Fri, 22 Aug 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852357; cv=none; b=nBbLjARQac2WLsspOya1EpJvYhbph3IhWF1L6R5WF7lTtQVUnyiaAFe9vyq3EKSyAFJwjfcBDxr+olN3zbAa2TtDHXJA3/FFgpKKx+NQdspvC+xSyl5FkIoUL8Z3HJz/alO2UcLZnzAhHTCXVLZYLZUO/Mquaxhl1AvM8jfT4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852357; c=relaxed/simple;
	bh=ZM+WLVaxURr8F7hf8mGnfn05FHhtyvOcaXkQKkM9s8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbPx7tTSAQkuUoexoPMs7UuZdqD3OtYBnIynyjTmBWjmbcb0uIVxkJcgH8Gyu6ne5PL3Q2UXIFrUGaFfwAW0CJCXT1mo4zVM/B28uNjMHG2gFnU5VlD/s47/HHyYBmZAYaDO9CNJ6jdM0WKMj2lns0KQYq1m25kJmBI1nvvZ6Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UDINbROl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UDINbROl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C71C16AAE;
	Fri, 22 Aug 2025 08:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755852357;
	bh=ZM+WLVaxURr8F7hf8mGnfn05FHhtyvOcaXkQKkM9s8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDINbROl7jy9YNt2jNgZWd4lQduqIcOFGOqBWnRUuWtNlg8tkGFkWvngV3vjPpC9Z
	 o0e22DTV/tVhc/IBnJTgZo3EQ1DzpkMv9GRoQBUZ1Yv0mGRgSL6EmUwqSPTiQx5Zej
	 GipUYiYMQnXslRrxS0mqex27A1fWimjZTPxo10/c=
Date: Fri, 22 Aug 2025 10:45:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, mingo@kernel.org,
	john.ogness@linutronix.de, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_core: fix coding style issue
Message-ID: <2025082235-wriggly-wildcat-0477@gregkh>
References: <20250822082311.16501-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822082311.16501-1-osama.abdelkader@gmail.com>

On Fri, Aug 22, 2025 at 10:23:10AM +0200, Osama Abdelkader wrote:
> Fix a coding style issue in 8250_core.c:
> 
> - Remove redundant NULL initialization of a global pointer
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index feb920c5b2e8..225bb7e4b89c 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -307,7 +307,7 @@ static void univ8250_release_irq(struct uart_8250_port *up)
>  		serial_unlink_irq_chain(up);
>  }
>  
> -const struct uart_ops *univ8250_port_base_ops = NULL;
> +const struct uart_ops *univ8250_port_base_ops;
>  struct uart_ops univ8250_port_ops;
>  
>  static const struct uart_8250_ops univ8250_driver_ops = {
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
