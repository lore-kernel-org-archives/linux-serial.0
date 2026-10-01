Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A14ABBC6;
	Thu,  1 Oct 2026 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845471; cv=none; b=f19/CW/+QknPHwNvD6iudOyl3shf9k+ovRKtdcxC4ByeY0db2u72VqDpHCF8PFbDCZ+9GdWNDKK6jr7AcdCEXT/kDJRWrtxbR3yS0mlQ0sR6CBzSdczD8H8/Z3OdeabZW67q/0mG+b02AnMOrQnukCvllLKQlla8kQF+ZRMsnb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845471; c=relaxed/simple;
	bh=6MCFSC1KUj53TuQmhb0CWstMdtyRxMhe6lgOArPRSg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdeCPCfmhjH27EJwirfBv+/j0PWXKUCqegpVWLUUcM+6L2GiPwnZjjXMioTOcgviEE0cmUXltRvki1UcpQjalqe2odzoUYAzA0qa1fJi+bDDPs36dyW8wjHO2awJYBlGqm6rCa00j9d3GLBs75utUIh919Ny9udXkmzRM9/kI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=axTw4JcN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="axTw4JcN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E651F000FF;
	Thu,  1 Oct 2026 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790845469;
	bh=4YpYHezwgxoGTHIlsA6DaEdtkLqqNTjbmua5P/Qzizs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=axTw4JcNr7YbJcImoqAFXHrte8nS6wZcYZe3lSRpBpNRjUemdYeEECsFrSOQ6GwHj
	 1zrCwczsjZOvQw5rj317IOJXzV/DgRx/MafewZLV8/Tf323xIJdx0qnlXWskWvNd8B
	 1sJb1maucR54Kjk1yKLePDJt3xSAyQBbfBVgQTU8=
Date: Thu, 1 Oct 2026 11:04:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Fuzzey <martin.fuzzey@flowbird.group>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: fix data corruption due to unexpected
 xon/xoff
Message-ID: <2026100117-plywood-earthlike-cb03@gregkh>
References: <20260923140116.340406-1-martin.fuzzey@flowbird.group>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923140116.340406-1-martin.fuzzey@flowbird.group>

On Wed, Sep 23, 2026 at 02:01:17PM +0000, Martin Fuzzey wrote:
> The hardware supports automatically sending XON/OFF based on the
> FIFO status and that is already implemented by the driver.
> However that capability was not announced with the UPF_SOFT_FLOW bit.
> 
> When the port is opened with the default of XON enabled the driver
> configures that in the hardware.
> If userspace does not want XON/OFF (which is normally the case) it will
> use TCSETS to disactivate it. However the serial core optimises this
> to only notify the driver if someting imporant has changed, and for
> XON/XOFF thit is only if the  driver declares UPF_SOFT_FLOW.
> 
> So we end up with unwanted XON/XOFF in the data stream.
> 
> The problem only occurs if nothing else needed to be set by termios,
> ie if the user space requested values are the same as the default values,
> except for XON/XOFF.
> Since the default speed is 9600 this means that the problem only occurs
> when requesting 9600, otherwise the call to the driver will be made to
> change the speed, and that will also clear the XON/XOFF.
> As 9600 is quite rare these days that probably explains why this hasn't
> already been seen.
> 
> It also only occurs on the first port open after boot since the subsequent
> opens will use the "logical state" set by TCSETS but not communicated to
> the driver the first time.
> 
> Signed-off-by: Martin Fuzzey <martin.fuzzey@arrive.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/tty/serial/sc16is7xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 9b152ead050f..f0a9a3dcd0e4 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1485,7 +1485,7 @@ static int sc16is7xx_setup_channel(struct sc16is7xx_one *one, int i,
>  	/* Initialize port data */
>  	port->type	= PORT_SC16IS7XX;
>  	port->fifosize	= SC16IS7XX_FIFO_SIZE;
> -	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
> +	port->flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY | UPF_SOFT_FLOW;
>  	port->iobase	= i;
>  	/*
>  	 * Use all ones as membase to make sure uart_configure_port() in
> -- 
> 2.25.1
> 

Does not apply to the tty-linus branch :(
