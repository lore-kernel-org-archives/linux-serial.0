Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CCE441027;
	Thu, 24 Sep 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240932; cv=none; b=pAZgZNN6B6ugs2EvnluegN9oTirfcjAUPKykDD4ZOqp4ydgTTyaGaQut7uT+35fGEmPbcN7amKSqw89qiWhvd/n9amMD6NsxmcZCwIlvUsFH1Xn5OzmxNwsqnahOizG5+S9/tac+zJH0sE2keouSGJRIDp8lS23D1UiOslot2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240932; c=relaxed/simple;
	bh=903anojqqM2pdzEa9uiMMZh41KL1D4UgSxuRDd+fY5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=pVzQJ74mG0LIqh0zcnxIrBLctuqUFJEuCf0XoA2MQqe+gaYdiZ9OQMv3n2Fmjnt54m4higOesSJN3cS2VLV/JvHzuJDu+aJsruwJmp+LfrcfDrS6s1SPG8etAF6iy7QGhruzIBuawnQfEmWkO/lGOysxD3mJtrrGJLbDGuNZOpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 24 Sep 2026 18:07:39 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
	by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id A9FBD20914A4;
	Thu, 24 Sep 2026 18:07:39 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with ESMTP; Thu, 24 Sep 2026 18:07:39 +0900
Received: from [192.168.1.135] (unknown [10.213.44.71])
	by iyokan3.css.socionext.com (Postfix) with ESMTP id 81E0110A019;
	Thu, 24 Sep 2026 18:07:38 +0900 (JST)
Message-ID: <97e4ab26-b147-4cf4-97f9-307903f14e61@socionext.com>
Date: Thu, 24 Sep 2026 18:07:37 +0900
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] serial: 8250_uniphier: Use devm_clk_get_enabled()
To: Malathi A <malathi.a2000@gmail.com>
References: <20260917040511.103232-1-malathi.a2000@gmail.com>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260917040511.103232-1-malathi.a2000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Malathi,

On 2026/09/17 13:05, Malathi A wrote:
> uniphier_uart_probe() enables priv->clk by hand and is then responsible
> for disabling it again on every error path. It misses one: when
> uart_read_port_properties() fails the function returns directly, leaving
> the clock prepared and enabled. The neighbouring path, taken when
> serial8250_register_8250_port() fails, does call clk_disable_unprepare(),
> which shows the leak is an oversight rather than intent.
> 
> Rather than adding another manual unwind, switch to
> devm_clk_get_enabled() so the clock is released by devres. That removes
> the error path entirely, along with the explicit disables in the
> register failure path and in uniphier_uart_remove().
> 
> The clock is still disabled and re-enabled by hand across system sleep,
> which stays balanced: only SET_SYSTEM_SLEEP_PM_OPS is used, so the
> device cannot be unbound while suspended and devres always sees an
> enabled clock at detach.
> 
> Found by smatch:
> 
>    drivers/tty/serial/8250/8250_uniphier.c:232 uniphier_uart_probe() warn:
> 'priv->clk' from clk_prepare_enable() not released on lines: 205.
> 
> Fixes: 26e8349c0d76 ("serial: 8250_uniphier: Switch to use
> uart_read_port_properties()")
> Signed-off-by: Malathi A <malathi.a2000@gmail.com>
> ---
> Changes in v2:
> - Use devm_clk_get_enabled() instead of adding a clk_disable_unprepare()
>    to the failing path, as suggested in review. This also lets the
>    explicit disables in the serial8250_register_8250_port() error path and
>    in uniphier_uart_remove() go away.
> - Reworded the commit message accordingly.
> 
>   drivers/tty/serial/8250/8250_uniphier.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_uniphier.c
> b/drivers/tty/serial/8250/8250_uniphier.c
> index e3db60bf50c9..6fffac12277a 100644
> --- a/drivers/tty/serial/8250/8250_uniphier.c
> +++ b/drivers/tty/serial/8250/8250_uniphier.c
> @@ -180,16 +180,12 @@ static int uniphier_uart_probe(struct
> platform_device *pdev)
>   
>   	memset(&up, 0, sizeof(up));
>   
> -	priv->clk = devm_clk_get(dev, NULL);
> +	priv->clk = devm_clk_get_enabled(dev, NULL);
>   	if (IS_ERR(priv->clk)) {
> -		dev_err(dev, "failed to get clock\n");
> +		dev_err(dev, "failed to get and enable clock\n");
>   		return PTR_ERR(priv->clk);
>   	}
>   
> -	ret = clk_prepare_enable(priv->clk);
> -	if (ret)
> -		return ret;
> -
>   	up.port.uartclk = clk_get_rate(priv->clk);
>   
>   	spin_lock_init(&priv->atomic_write_lock);
> @@ -222,7 +218,6 @@ static int uniphier_uart_probe(struct platform_device
> *pdev)
>   	ret = serial8250_register_8250_port(&up);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to register 8250 port\n");
> -		clk_disable_unprepare(priv->clk);
>   		return ret;
>   	}
>   	priv->line = ret;
> @@ -237,7 +232,6 @@ static void uniphier_uart_remove(struct
> platform_device *pdev)
>   	struct uniphier8250_priv *priv = platform_get_drvdata(pdev);
>   
>   	serial8250_unregister_port(priv->line);
> -	clk_disable_unprepare(priv->clk);
>   }
>   
>   static int __maybe_unused uniphier_uart_suspend(struct device *dev)

I'm a bit concerned about the error path in uniphier_uart_resume().
The clock may have been disabled in uniphier_uart_suspend(), and
clk_prepare_enable() can fail when trying to enable it again.

In that case, wouldn't devres try to disable an already disabled
clock on detach?

Thank you,

---
Best Regards
Kunihiko Hayashi
