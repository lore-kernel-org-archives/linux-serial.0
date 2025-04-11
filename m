Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F126658F;
	Fri, 11 Apr 2025 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409081; cv=none; b=F0fxVBJR571BC+99uGbtsEZxCNnY+j67FVkOWsEYBzcUCQhz/mRNELkfp3EWrBYzIUUfU7n9BCd5hQlBY3grrWrPDNKhVqvM5YUahiTGwuZxTvk87qg06IZZF8fVlXDa9KWMI+ZRGNKFJudEoQyRH6OYCbFcUhRCFfqZyKfuEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409081; c=relaxed/simple;
	bh=1/jvI+7IxssVFKwkR/nVTeszMiAniorxW/pBqjjU/B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUfx8h8qA0a2RGwFo0qlNoYLRZRXK0kgHMQ1jk6BrV7+u/ZQ/AANmuLQmwz5+GpI6xUzFCTX7/bjsLNyHR9zifitTkEE99iuow1v7TY9CNMYZBbcn5/qnTBcwZzfXPIj4Nr8Hc0tqK7wUXKmOH4JLHCLAh5M8QGJ32WeW6DGQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4E1A7343859;
	Fri, 11 Apr 2025 22:04:37 +0000 (UTC)
Date: Fri, 11 Apr 2025 22:04:25 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andy.shevchenko@gmail.com,
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] serial: 8250_of: manage bus clock in
 suspend/resume
Message-ID: <20250411220425-GYA22939@gentoo>
References: <20250411203828.1491595-1-elder@riscstar.com>
 <20250411203828.1491595-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411203828.1491595-4-elder@riscstar.com>

hi Alex,

Glad to see first 2 patches already accepted
This version is better than v3, thanks

On 15:38 Fri 11 Apr     , Alex Elder wrote:
> Save the bus clock pointer in the of_serial_info structure, and use
> that to disable the bus clock on suspend and re-enable it on resume.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
Reviewed-by: Yixun Lan <dlan@gentoo.org>

> ---
>  drivers/tty/serial/8250/8250_of.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index a90a5462aa72a..d178b6c54ea18 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -24,6 +24,7 @@
>  
>  struct of_serial_info {
>  	struct clk *clk;
> +	struct clk *bus_clk;
>  	struct reset_control *rst;
>  	int type;
>  	int line;
> @@ -138,6 +139,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
>  			goto err_pmruntime;
>  		}
>  
> +		info->bus_clk = bus_clk;
>  		port->uartclk = clk_get_rate(info->clk);
>  	}
>  	/* If current-speed was set, then try not to change it. */
> @@ -299,6 +301,7 @@ static int of_serial_suspend(struct device *dev)
>  	if (!uart_console(port) || console_suspend_enabled) {
>  		pm_runtime_put_sync(dev);
>  		clk_disable_unprepare(info->clk);
> +		clk_disable_unprepare(info->bus_clk);
>  	}
>  	return 0;
>  }
> @@ -311,6 +314,7 @@ static int of_serial_resume(struct device *dev)
>  
>  	if (!uart_console(port) || console_suspend_enabled) {
>  		pm_runtime_get_sync(dev);
> +		clk_prepare_enable(info->bus_clk);
>  		clk_prepare_enable(info->clk);
>  	}
>  
> -- 
> 2.45.2
> 
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55
