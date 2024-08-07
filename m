Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B901B9B43;
	Wed,  7 Aug 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028555; cv=none; b=VWbneNFmQHyKZfRaRgsipy0dQ9iCRPg7UflFh21obt2N8j5mPouvO5MPcEX3rElPbjGSYaYPNtQUaHXz5f9Mo6nR4IO0dfq6+FcZLKFfkDpiWmjMG4+FEUuAhmbpasFTfpWfSnXWSzZz9fYtJNlJ7otJcPSq/77vpZf0+ZZLBbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028555; c=relaxed/simple;
	bh=JGaYVXcmke/FqccR7Pl41a9dvtm7gGOWJRb6FODhymA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eow1ciUC9jVQVecnusUYFziAWkuQY5SoGxiNQEP2a76uJjE7FvGvL5sze2px/2hyfEPk6ngA6Xz0Vq4p1WtuEmu89huQ1YISlTYb0TQgH/6RjogPGhhmQLCSr9wW/VGjeqCg3C07AkI97TeJ2Z9BiU0PXuzrEwlKFISZFNN8KJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T+DTIU8O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T+DTIU8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9AFC32782;
	Wed,  7 Aug 2024 11:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723028554;
	bh=JGaYVXcmke/FqccR7Pl41a9dvtm7gGOWJRb6FODhymA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+DTIU8Ow199lo7i2s5UEWSFpk4yBfM3WeYP3b4PYpNtBIo23iAZ0m7YxrAaatCtb
	 9PYfbtKyq8CQckzuGd8J9Wli9xbTDF5bqWAfhrTs0dgTEKoSf2FPR6XChIEAuLUbst
	 DDTeWraeBtT1rHcTlI0t7llLY7O3/Nb4e2uUriAs=
Date: Wed, 7 Aug 2024 13:02:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] serial: 8250_platform: Fix structure initialization
 warning
Message-ID: <2024080718-overlaid-junkie-4ee9@gregkh>
References: <20240807042210.1608026-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807042210.1608026-1-sunilvl@ventanamicro.com>

On Wed, Aug 07, 2024 at 09:52:10AM +0530, Sunil V L wrote:
> Use memset to initialize the uart structure instead of universal zero
> initializer to fix the below warning.
> 
> drivers/tty/serial/8250/8250_platform.c: In function 'serial8250_platform_probe':
> drivers/tty/serial/8250/8250_platform.c:111:40: warning: excess elements in struct initializer
>   111 |         struct uart_8250_port uart = { 0 };
>       |                                        ^
> drivers/tty/serial/8250/8250_platform.c:111:40: note: (near initialization for 'uart.port.lock.<anonymous>.rlock.raw_lock')
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407310023.h0JgJG1C-lkp@intel.com/
> Fixes: d9e5a0ce2f16 ("serial: 8250_platform: Enable generic 16550A platform devices")
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/tty/serial/8250/8250_platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_platform.c b/drivers/tty/serial/8250/8250_platform.c
> index bdfb16bed4f2..d8c3c169a620 100644
> --- a/drivers/tty/serial/8250/8250_platform.c
> +++ b/drivers/tty/serial/8250/8250_platform.c
> @@ -108,11 +108,12 @@ void __init serial8250_isa_init_ports(void)
>  static int serial8250_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct uart_8250_port uart = { 0 };
> +	struct uart_8250_port uart;

{ } should be correct instead.

thanks,

greg k-h
