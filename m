Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412591F948;
	Thu, 21 Aug 2025 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799404; cv=none; b=gj7dNA84UBhYiGdjcMsGq2HYreMWh/EsCiNLJbAlvI1veTScW4fSbHxa+rOtwoPit3uGyyMR6NicU5ogxlcWHG8EQlAOBnlzKnxCaoYbABjC6hDqolbNLPwY4UZCIi6nqzhNUs0OnHrhZQTK2rZw38vh9tSel9LQtQQQJhMft78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799404; c=relaxed/simple;
	bh=si6l+b+8X75s+zBbjreCcMbaWSOqsaqxvlaFcF8cxPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN7VAU0OFX9cb7yECabvxZBKuX98E8j4n9+DuU29hJq55K0buS30PCEWINCqUKNa9/AIAem5wwzRzedkuq2Q2kgJjda/QtXyb7Us/f1vrSg0R/2sGcPjeOkufqk3av+rUO58ffAbnpDsvq9NBvBtCXnnmuXXmyC4tWXRyqv0Ky4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ecwwh5pf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ecwwh5pf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79799C4CEEB;
	Thu, 21 Aug 2025 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755799403;
	bh=si6l+b+8X75s+zBbjreCcMbaWSOqsaqxvlaFcF8cxPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ecwwh5pfw7ipUw24rVh12W4rwyAftJ67VwJ+Wr9LRu9GJkYxSoSEFJaSFTsgC2Urr
	 llyDhH2BwBsq0N0wvYC/uwsewmn25RbwHnJHhFh3yGI59E1CPz7gK9P5O5k8X2jC7E
	 L2uM4SAtwq9zf8VzGFpWqBiZrRUMIt1LT46TG9pg=
Date: Thu, 21 Aug 2025 20:03:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com, mingo@kernel.org,
	john.ogness@linutronix.de, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_core: fix coding style issues
Message-ID: <2025082105-maturely-lapped-58ec@gregkh>
References: <20250821175856.22957-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821175856.22957-1-osama.abdelkader@gmail.com>

On Thu, Aug 21, 2025 at 07:58:56PM +0200, Osama Abdelkader wrote:
> Fix a few coding style issues in 8250_core.c:
> 
> - Remove redundant NULL initialization of a global pointer
> - Add missing blank line after a variable declaration
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index feb920c5b2e8..0d1d2eed2a5c 100644
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
> @@ -773,6 +773,7 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
>  	 */
>  	if (!has_acpi_companion(uart->port.dev)) {
>  		struct mctrl_gpios *gpios = mctrl_gpio_init(&uart->port, 0);
> +
>  		if (IS_ERR(gpios)) {
>  			ret = PTR_ERR(gpios);
>  			goto err;
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
