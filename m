Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED9224AF9;
	Mon, 11 May 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512656; cv=none; b=ReMRfcoQ8lL3bO1OZvV8+/rkgJhhkIYIawObwv2/2nHfkWfhhtx2QUyw8VuTjXTJGlxmL584Hs2qcc0F9jX1smQLjZU939hF3AyT6i53T0M1wFsf/90mZ2hmkkTjhY+aFuPQ1Ty/NWkjMA8aDTTetMRgl8T4zyhx+dmtsXiOhMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512656; c=relaxed/simple;
	bh=zKCinbLF9/05nHgJe6u1v8NNbt/3+lyqIdxHn57Fxl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bADRCUNmDVPbxecU8URcAUHLNf+2E7KMBYeUxSH98IzAN92T/gZoKOUMLKo4e4Xi4RTEcIpb7siyp/4oPMU95yPZsYIYATcUwEtjUZT9XVOz46znlYuvC1C8zpoibkmGaZkH2trz7t/gMg82dY7Gk+x5aNPXlMsvlUn3XQSuVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kt7VAMP3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kt7VAMP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2B0C2BCB0;
	Mon, 11 May 2026 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778512655;
	bh=zKCinbLF9/05nHgJe6u1v8NNbt/3+lyqIdxHn57Fxl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kt7VAMP3kzbLjcFr2teD2id+M1aaRCGt3pkp8WVcTHRySSI123F6ze2k7FSchRQ5c
	 nIQ/bntnyF8nz9ZHmIpCgI72BsGxp5tPVmC5R8GAr1F2BUtR20nufrOJleKPRt4A+i
	 KruGtYRaeLzKy8xxAzlE3yT0Hu21stop9xyjVY2k=
Date: Mon, 11 May 2026 17:17:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rakesh Alasyam <alasyamrakesh77@gmail.com>
Cc: richard.genoud@bootlin.com, jirislaby@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] serial: atmel: honor CREAD in atmel_set_termios
Message-ID: <2026051106-obliged-dismount-d85f@gregkh>
References: <20260501081317.15477-1-alasyamrakesh77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501081317.15477-1-alasyamrakesh77@gmail.com>

On Fri, May 01, 2026 at 01:43:17PM +0530, Rakesh Alasyam wrote:
> Ignore received characters when CREAD is cleared by adding RXRDY
> to ignore_status_mask.
> 
> This replaces an existing TODO in the driver.
> 
> Signed-off-by: Rakesh Alasyam <alasyamrakesh77@gmail.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 5d8c1cfc1c60..5b062d8ccabe 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2184,8 +2184,8 @@ static void atmel_set_termios(struct uart_port *port,
>  		if (termios->c_iflag & IGNPAR)
>  			port->ignore_status_mask |= ATMEL_US_OVRE;
>  	}
> -	/* TODO: Ignore all characters if CREAD is set.*/
> -
> +	if (!(termios->c_cflag & CREAD))
> +		port->ignore_status_mask |= ATMEL_US_RXRDY;
>  	/* update the per-port timeout */
>  	uart_update_timeout(port, termios->c_cflag, baud);
>  
> -- 
> 2.43.0
> 
> 

Cool, was this tested to work properly?

And a blank line is needed before the comment, right?

thanks,

greg k-h
