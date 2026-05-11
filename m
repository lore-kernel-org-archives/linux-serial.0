Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DE42EEC7;
	Mon, 11 May 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518468; cv=none; b=ZxKQhVvu7FOAMHgcZxlpq0QCU2ue2E7o0vdQOCS38vTz///tsmete5D913JjkyqejHbR7PeZLlqHQ5KvCcg25Gu91txD96LOX+GitQ6J1FMrEJezYKfTNvHUd4yyHsVfjmp8TUEDPvChpQrbyXGcsyQ4WuSIz56831MQDALDGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518468; c=relaxed/simple;
	bh=DxNKfAPo28kAoeTgWlEme9aKX+ABVoG+bB/6QcbEC/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApEvpR10f4nZKwgb7mRG4dm4/z42cTZdECjzUyfgpHUtyiQPng1SuXkMKN3RafGbKxLeOjUV5uw64VXDJ1KTDDbXKYQxqVKzno1OWLNIUtg6kxdbayJ8CF5DWK0tZH/VM0R+6m5Cd5OvGkpToLIKyOeblnOuVTfYREDarq8dNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBkaG16R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBkaG16R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203F0C2BCC9;
	Mon, 11 May 2026 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778518468;
	bh=DxNKfAPo28kAoeTgWlEme9aKX+ABVoG+bB/6QcbEC/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TBkaG16RS6MPU2g5ll8ABLwrZomJWWpWlFXhsFEOK7pic0yGJiv6pPTTDr6TzWU1A
	 T+3RGnm3hF40+9G/54ye9/0ew0dxe6kpfZGTGYi+83GTLqQKKxY70qYbZ/9W9YQmvh
	 AcXwea1WKhrLlnIqTWdt2fQX6Um9KY1S4gmqbLfY=
Date: Mon, 11 May 2026 18:54:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rakesh Alasyam <alasyamrakesh77@gmail.com>
Cc: richard.genoud@gmail.com, jirislaby@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: atmel: Ignore chars when CREAD is cleared
Message-ID: <2026051113-embezzle-pastrami-8a6f@gregkh>
References: <2026051106-obliged-dismount-d85f@gregkh>
 <20260511155655.26435-1-alasyamrakesh77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511155655.26435-1-alasyamrakesh77@gmail.com>

On Mon, May 11, 2026 at 09:26:55PM +0530, Rakesh Alasyam wrote:
> Ignore received characters when CREAD is cleared by adding RXRDY
> to ignore_status_mask.
> 
> This replaces an existing TODO in the driver.
> 
> Tested on hardware.
> 
> Signed-off-by: Rakesh Alasyam <alasyamrakesh77@gmail.com>
> 
> ---
> 
> v2:
> - Add blank line before comment
> - Tested on hardware
> ---
>  drivers/tty/serial/atmel_serial.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 5d8c1cfc1c60..5c756dc904b0 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2184,7 +2184,8 @@ static void atmel_set_termios(struct uart_port *port,
>  		if (termios->c_iflag & IGNPAR)
>  			port->ignore_status_mask |= ATMEL_US_OVRE;
>  	}
> -	/* TODO: Ignore all characters if CREAD is set.*/
> +	if (!(termios->c_cflag & CREAD))
> +		port->ignore_status_mask |= ATMEL_US_RXRDY;
>  
>  	/* update the per-port timeout */
>  	uart_update_timeout(port, termios->c_cflag, baud);
> -- 
> 2.43.0
> 

No v2 in the subject line :(
