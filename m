Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9571422A8;
	Tue,  8 Oct 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728376682; cv=none; b=F7vpF2nRGk2kaL1hTIZfrnemCTZkoI2FIEXwUd8c1oukLgnUQHQJ8OU+2xIYLgP5fSzWHwRoXu6pYHgYUdrVedvqE+6xDuRGyiq6XVo+IoNKOotdWw/cDOGVhF1L/EUTpkqRo1yv2PAhLdLB6Owlom77bED50gBv59EtNh+Nc3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728376682; c=relaxed/simple;
	bh=6eDVLcMow972i4aZcmm3VEJCEQO7PY9kXFSk28hSIF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFA1DXlSPhOCowuGALEGo/ZzzWS4a5wNTOZk0pbBXl4KgUe4BBuSs2vkldas3CTpA3w2DTvLI/2vSbqXcejx7cGzFL+uLf4z9BffQPUKwIG4ip3HEPNyuJs7FAnLkIZEAqUZ70FDvDV3dQVQaiMVx/35sbDBu2pBpSks6xDIzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qat6nI5x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qat6nI5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021C2C4CEC7;
	Tue,  8 Oct 2024 08:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728376681;
	bh=6eDVLcMow972i4aZcmm3VEJCEQO7PY9kXFSk28hSIF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qat6nI5xfIlWrewKaqWx+n6UttT1ryoMQ0w0EgzjP6cQVfi1nqBbIFk+MZ1DJ1iQV
	 3mYE1HMndtI9xwTy18FbAXbqeDX1du1t8G1UhIQF4eI8UlKgcbPy4Gjse8FphTg+UB
	 KW4A/W4y7vjSsTNZ08C+Vm7+HKvZwGFXM7InfldA=
Date: Tue, 8 Oct 2024 10:37:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: richard.genoud@bootlin.com, jirislaby@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] tty: atmel_serial: print the controller version
Message-ID: <2024100842-luncheon-severity-afc0@gregkh>
References: <20241008083459.51249-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008083459.51249-1-mihai.sain@microchip.com>

On Tue, Oct 08, 2024 at 11:34:59AM +0300, Mihai Sain wrote:
> Add support to print the controller version similar
> to other at91 drivers like spi and twi.
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 09b246c9e389..5f93974918c0 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2970,6 +2970,8 @@ static int atmel_serial_probe(struct platform_device *pdev)
>  	 */
>  	clk_disable_unprepare(atmel_port->clk);
>  
> +	dev_info(&pdev->dev, "AT91 USART Controller version %#x",
> +		 atmel_uart_readl(&atmel_port->uart, ATMEL_US_VERSION));

No, the other drivers need to be fixed up, when drivers are working
properly, they are quiet.  This driver is correct by being quiet, please
send patches for the other ones to remove these types of lines.

thanks,

greg k-h
