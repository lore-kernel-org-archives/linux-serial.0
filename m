Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5892147F3;
	Wed,  9 Apr 2025 21:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744235032; cv=none; b=oliogwJUAFMkApT3akHE69zprCLM4Qgt1voLrqs/NtNwfqNv1J088Xw1B4QFORTTZfm3P/gu4MAHDJ69+2HWmUdvtW3B+YHbdESpqFCbHw/LKv9ynTWVdsq23AVRYuqJsH3y3hBx0Qia3pr+lus7GuZkGzDzA10ZpXTM6JEtp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744235032; c=relaxed/simple;
	bh=eesypCNmz5sJKsF5KpZG/L0WnupeOJYtqoN4SCn0pyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOaHYYQtTX/tA+L/PulcOVbwTCkLSygHjU2kEIigO7T8mvveJjuZ6kRWkU7s7HBvIpiP2SasaihNXMUR3SutqEfI/AZCiUJK5eaN34Bgt1GLoyq35NsF9ky3J525ZRMqU/dMHT9nNTSJAB7jBdrvMe1x0fFeaF+Zd/dBNKg4ypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 426CB343183;
	Wed, 09 Apr 2025 21:43:48 +0000 (UTC)
Date: Wed, 9 Apr 2025 21:43:45 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250_of: add support for an optional bus
 clock
Message-ID: <20250409214345-GYA19066@gentoo>
References: <20250409192213.1130181-1-elder@riscstar.com>
 <20250409192213.1130181-3-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409192213.1130181-3-elder@riscstar.com>

Hi Alex,

On 14:22 Wed 09 Apr     , Alex Elder wrote:
> The SpacemiT UART requires a bus clock to be enabled, in addition to
> it's "normal" core clock.  Look up the optional bus clock by name,
> and if that's found, look up the core clock using the name "core".
> 
> Supplying a bus clock is optional.  If no bus clock is needed, the
> the first/only clock is used for the core clock.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: Update logic to more check for the optional bus clock first
> 
>  drivers/tty/serial/8250/8250_of.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 11c860ea80f60..a90a5462aa72a 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -123,7 +123,16 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  
>  	/* Get clk rate through clk driver if present */
>  	if (!port->uartclk) {
> -		info->clk = devm_clk_get_enabled(dev, NULL);
> +		struct clk *bus_clk;
we also need to handle clk in suspend/resume procedure, so
I think you need to put bus_clk inside struct of_serial_info..

> +
> +		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
for the 'optional', we can interpret it's optional for other vendor 
UART, but a must required clk for SpacemiT's k1 UART controller

would it better to guard this inside a compatible test or even introduce
a flag in compatible data?

	if (of_device_is_compatible(pdev->dev.of_node, "spacemit,k1-uart")) {
		bus_clk = devm_clk_get_enabled(dev, "bus");
		..
	}

}
> +		if (IS_ERR(bus_clk)) {
> +			ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
> +			goto err_pmruntime;
> +		}
> +
> +		/* If the bus clock is required, core clock must be named */
> +		info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
>  		if (IS_ERR(info->clk)) {
>  			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
>  			goto err_pmruntime;
> -- 
> 2.45.2
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
