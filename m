Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940751FCA9;
	Wed, 23 Sep 2026 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168041; cv=none; b=M8Uvf1kbZUgiwVW9v6fBj28XWkQMbB7rqNdJz3lqKWmw+iTIErtZiL6K5zdYkAOe5MagrIqoUnX4Lye9bDOSHExNNv/01AD4o4cMmZG/YiJYRUeaVmrqyPrNxiyBd4uHoAAy/oyWgQnJuKkbneKi53Z46Dj1G8Dinnj2qKr4n1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168041; c=relaxed/simple;
	bh=lu2KEldYMIdJTY5gnGXrBRBbFD5hcsupirC5fYEC6Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLRYND+LyP8N8JDAA0Z5RGPPYJXZIlWRyNiRw1GAVJQu+7VEFoACPvzfrGSXFIHPsfF5MUZ3zw3I8ES1eyrutuUGogbEWi55SFzvIOtGgYolXOc7OzoGfXyIvpvObsYPU1+uGE2sZuLngEtbp1g0evR0BkyYfR4V4kdLuEfgIwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VMepWDPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VMepWDPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEEE1F00898;
	Wed, 23 Sep 2026 12:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790168030;
	bh=ZVEp2JvfuWHOXzAbrzSivpd316nYEBNph4i0Xb5Vdlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VMepWDPvZu/ik3daLuc0FSklE+OTbuVfCYzqYoNySa2nQ7Fx93ZSCSqzi/4F5TDqD
	 lM5XxJFf2Ud3zXQoolVuS6w4WxII/7xpvxOOjMoj/Y+CkJQsbURHvX+UiG67ZXUGsB
	 Rt4ktykr3Zyb1HerdpCGsw75Ea74KSn+Rx9ZvShA=
Date: Wed, 23 Sep 2026 14:53:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Sherry Sun <sherry.sun@nxp.com>,
	Frank Li <frank.li@nxp.com>, Alexander Dahl <ada@thorsis.com>,
	linux-serial@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: fsl_lpuart: add support for GPIO-controlled
 modem lines
Message-ID: <2026092313-snare-goggles-ed1c@gregkh>
References: <20260819144458.253967-1-joaofl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819144458.253967-1-joaofl@gmail.com>

On Wed, Aug 19, 2026 at 04:44:53PM +0200, João Loureiro wrote:
> LPUART has no register bit to drive RTS to a chosen level: UARTMODIR only
> offers receiver-driven auto-RTS (RXRTSE) and RTS-during-transmit (TXRTSE).
> Consequently lpuart_set_mctrl() and lpuart32_set_mctrl() ignore TIOCM_RTS,
> and their get_mctrl() counterparts report a hardcoded
> TIOCM_CAR | TIOCM_DSR | TIOCM_CTS.
> 
> That makes it impossible to talk to a peripheral which is driven by a
> software controlled RTS strobe and answers on CTS.  TIOCMBIS/TIOCMBIC
> silently do nothing, and because CTS always reads back as asserted, a
> userspace handshake that waits for CTS to follow RTS can never complete:
> de-asserting RTS and waiting for CTS to drop times out every time.  Boards
> that route the two pins to plain GPIOs cannot work around it either, since
> the driver never looks at rts-gpios/cts-gpios.
> 
> Wire the driver up to the serial_mctrl_gpio helpers, as imx.c and
> atmel_serial.c already do.  set_mctrl() forwards the state to
> mctrl_gpio_set(), and get_mctrl() runs the flags through mctrl_gpio_get()
> so that a described cts-gpios overrides the assumed-asserted default.
> Boards without such a description keep the previous behaviour.  Modem
> status interrupts are enabled from startup() and disabled from shutdown(),
> with a .enable_ms callback for the serial core.
> 
> The same limitation was reported for an i.MX 8XLite board that needs RS-485
> with a GPIO RTS [1].  This change was developed and tested on an i.MX95
> board whose barcode scanner is driven over LPUART with a manual RTS strobe;
> with it, RTS toggles as requested and CTS is reported from the real pin.
> 
> [1] https://lore.kernel.org/all/20260210-rearview-hungrily-536a95fc3385@thorsis.com/
> 
> Signed-off-by: João Loureiro <joaofl@gmail.com>
> ---
>  drivers/tty/serial/Kconfig      |  1 +
>  drivers/tty/serial/fsl_lpuart.c | 35 +++++++++++++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4f57833e3ec7..a173eaf769ff 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1301,6 +1301,7 @@ config SERIAL_FSL_LPUART
>  	tristate "Freescale lpuart serial port support"
>  	depends on HAS_DMA
>  	select SERIAL_CORE
> +	select SERIAL_MCTRL_GPIO if GPIOLIB

Why not depends?

thanks,

greg k-h
