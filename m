Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000481B29D9;
	Thu, 20 Jun 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902705; cv=none; b=gokbAHeQymC4lt/7GxpVhkvzYRs0hFax9IS2ZVj4zJdWvq2E/o99eaXjxf9WROVmJCpAAx4qheAvPX1vvmdcmhODn3pwURzGeFBeY82T/HQys46nD4/sr8qTkzIX1bLfkzc5Az7jfUBjxfviPuEZYLAxK9QMTdeeNQ/QdZT6TaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902705; c=relaxed/simple;
	bh=qZqI00dgEFB+d6vsEcDd7juPjDQiu90fW9KnfdwVRy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXF+uaCC7HoolSSYpY20mgX8i113QAgSBR8FofaG0uy0ZxCfyXdszaZsMpwj4ztoAgN21h9o0hvUyxByv3PlQgQhsZ10xiWdNfRgQhh4L+i5oV5mIjTnx2oPxZRXsVKNVYf7mhgWCLgzoNQdiDmuavomcXU8gH5aimmfq3AXOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pnh/A8Sb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pnh/A8Sb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B23CC2BD10;
	Thu, 20 Jun 2024 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718902704;
	bh=qZqI00dgEFB+d6vsEcDd7juPjDQiu90fW9KnfdwVRy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pnh/A8SbX4d2c5fs0fHM8gKhbZzvmtvsuw3Qd6BeYQKONJoUxPrp+0GzRg1JR8IwZ
	 Nr2qdSH9ooCW4Zp0MoSKWJHRLRBlrAKBDshutbSyCOfo8GB6eGNLDk6+YwGvkmCkVd
	 BECSvBdwivkAjP39rLDS6LVX9mVOD5fIvRv4Qo78=
Date: Thu, 20 Jun 2024 18:58:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] tty: mcf: MCF54418 has 10 UARTS
Message-ID: <2024062006-squeezing-traffic-cecb@gregkh>
References: <20240620-upstream-uart-v1-1-a9d0d95fb19e@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-upstream-uart-v1-1-a9d0d95fb19e@yoseli.org>

On Thu, Jun 20, 2024 at 06:29:59PM +0200, Jean-Michel Hautbois wrote:
> Most of the colfires have up to 5 UARTs but MCF54418 has up-to 10 !
> Change the maximum value authorized.
> 
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  drivers/tty/serial/mcf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
> index b0604d6da025..58858dd352c5 100644
> --- a/drivers/tty/serial/mcf.c
> +++ b/drivers/tty/serial/mcf.c
> @@ -462,7 +462,7 @@ static const struct uart_ops mcf_uart_ops = {
>  	.verify_port	= mcf_verify_port,
>  };
>  
> -static struct mcf_uart mcf_ports[4];
> +static struct mcf_uart mcf_ports[10];

What commit id does this fix?

thanks,

greg k-h
